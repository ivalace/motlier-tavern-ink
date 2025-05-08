// Global Variables

VAR sawNotice = false          // checks for informatio they have
VAR observe = false            
VAR coins = 0                  // value is in silver (sp)
VAR race = ""
VAR char_class = ""
VAR char_origin = ""
VAR rep_town = 0
VAR rep_Azer = 0
VAR rep_Tib = 0
VAR rep_Alice = 0
VAR rep_Borris = 0
VAR observed = false

// Data Tables
LIST menu = 
    Roasted_Boar = 7,
    Vegetable_Stew = 4,
    Herb_Potatoes = 3,
    Honey_Cake = 2,
    Ale = 5,
    Mead = 5

-> Intro

=== function pay(cost) ===
    ~ coins -= cost
    ~ return coins
    
=== function repChange( ref r, amount) ===
    ~ r += amount
    ~ return repChange

// Intro Blurb
=== Intro ===
Motlier is a small village which acts as the lumber supplier to the surrounding area. Founded many generations ago, the town is now run by descendants of the same families upon which the town was built. Despite it's humble looks, Motlier’s success rests upon the enchanted forest to the east. Blessed by the Mother, every tree cut down regrows under the light of the full moon. Being very practical folk, the townspeople use the magic to their advantage and have been supplying lumber to the entire region for generations.
-> BuildCharacter
// Character builder
== BuildCharacter ==

What visage shall you present to the townsfolk?

+ [Dragonborn] Your scales shimmer { ~ jade | ruby | bronze | emerald | sapphire } in the moonlight.
    ~ race = "Dragonborn"
    -> Class
+ [Dwarf] Your thick beard is { ~ a startling shade of red | woven with wooden beads | braided with bits of bone }
    ~ race = "Dwarf"
    -> Class
+ [Elf] Your gaze is heavy with the weight of time.
    ~ race = "Elf"
    -> Class
+ [Human] You walk tall, { ~ with an air of self-importance | your hair braided down your back | bright eyes full of curiosity. }
    ~ race = "Human"
    -> Class

== Class ==

And what kind of profession do you practice?

+ [Barbarian] You prefer to do negotiations the old-fashion way: with { ~ your bare hands | fists | the maul at your back. }
    ~ char_class = "Barbarian"
    -> Origin
+ [Druid] Life is about balance, and nothing is more important than protecting it.
    ~ char_class = "Druid"
    -> Origin
+ [Rogue] Life is more fun when it's lived on someone else's coin.
    ~ char_class = "Rogue"
    -> Origin
+ [Wizard] You blow up ONE lab and they relegate you to field research...
    ~ char_class = "Wizard"
    -> Origin

== Origin ==

What of your origins?

+ [Acolyte] Would you care to hear about our lord and savior, Orcus?
    ~ char_origin = "Acolyte"
    ~ coins = 80
    -> Start
+ [Criminal] If crimes not a job, why does it pay so well?
    ~ char_origin = "Criminal"
    ~ coins = 160
    -> Start
+ [Sage] Wisdom is it's own reward. The coin is just a bonus.
    ~ char_origin = "Sage"
    ~ coins = 60
    -> Start
+ [Soldier] A good soldier doesn't stoop to gate bribes. They shake down criminals instead.
    ~ char_origin = "Soldier"
    ~ coins = 140
    -> Start

// Main Story
== Start ==

You arrive in Motlier just before sunset on the night of the full moon. Weary from a day of hard travel, your first sight is the warm light of the Ram's Horn Tavern and Inn. A noticeboard stands just outside the entrance, littered with parchment.

+ [Head inside]
    -> Tavern
 
+ [Inspect the noticeboard]
    ~ sawNotice = true
    -> Noticeboard

= Noticeboard

The most prominent flyer on the board offers a reward for helping the town deal with vermin. It says to see Azer for more details and has a seal stamped at the bottom with a flaming tree. Another, written in an angry looking scrawl, offers 50 copper pieces for undamaged goblin hide brought to Tib. The third offers a special at the tavern: 1 honeycake made with Bristleberry honey from the town nearby added to any meal for only 2 silver extra. Below is a drawing of a small cake drizzled with honey and topped with purple berries.

+ [Head inside]
    -> Tavern

// Tavern Stitches
== Tavern ==

{ once: Inside the tavern, it seems the entire town is gathered, drinking and laughing together merrily. An old woman sits on a small stage towards the back playing happily on her lute, her silver hair tied back in an intricate braid. A half-orc is behind the bar, refilling tankards with a practiced ease. Everyone here is very close, and only a few heads turn as the players enter. The first person to greet you is Madelina, a barmaid with a perpetually harried look. She hastily informs you that the only available seating they have is at the bar. }
-> Seated

= Seated
{ once: The half-orc sets down a tankard before a { race == "Dwarf": fellow } dwarf with stones braided into his beard before hurrying over to you with a jovial smile. "Good evening, friend! Welcome to Ram's Horn Tavern and Inn. Name's Borris Grizzlespark. Hungry? Thirsty?" }
~ temp choice_done = false
{ choice_done:
    -> Seated
- else: 
    * "I would kill for some food." -> Menu
    * [Look around] -> Observe
    ~ observe = true
    * "I'm worn from my travels. A bed is all I ask." -> Bed
    * { sawNotice } [Ask about noticeboard]
     -> Jobs
    -> Tavern
~ choice_done = true
}

= Menu
{ coins > 0:
    "We've got a quite the spread this time of year. Me and Robert, he's the butcher over at Blade and Twine, we hunt the boars ourselves. The vegetables are grown fresh at Fairhaven Farms, just down the road. And not to brag, but my ale beat Gredga's brew two years running!"
    
        You’ve got {coins} coins clinking in your pouch.

    + { coins >= LIST_VALUE(menu.Roasted_Boar) } Roasted Boar (7sp)
        ~ pay(LIST_VALUE(menu.Roasted_Boar))
        The boar is seasoned with local spices, roasted to juicy perfection. The Hazelnut Bread is warm and nutty, with just a touch of sweetness.
    -> Menu
    
    + { coins >= LIST_VALUE(menu.Vegetable_Stew) } Vegetable Stew (4sp)
        ~ pay(LIST_VALUE(menu.Vegetable_Stew))
        The stew is full of seasonal vegetables, softened slightly and mixed in a thick, hearty broth.
    -> Menu

    + { coins >= LIST_VALUE(menu.Herb_Potatoes) } Herb Roasted Potatoes (3sp)
        ~ pay(LIST_VALUE(menu.Herb_Potatoes))
        Steaming potatoes, with crispy outsides and crusted with caramelized butter and savory herbs.
   -> Menu

    { sawNotice && LIST_VALUE(menu.Honey_Cake) }
    + Honey Cake Special (2sp)
            ~ pay(LIST_VALUE(menu.Honey_Cake))
        The sweet honeycakes are springy and moist, drizzled with fresh honey and topped with juicy, slightly tart bristleberries.
            -> Menu
    
    + { coins >= LIST_VALUE(menu.Ale) } Borris' Special Ale (5sp)
        ~ pay(LIST_VALUE(menu.Ale))
        The frothy brew is a pale gold, crisp with the faint hint of cloves among the malty taste.
    -> Menu
    
    + { coins >= LIST_VALUE(menu.Mead) } Bristleberry Mead (5sp)
        ~ pay(LIST_VALUE(menu.Mead))
        The mead is sweet with a deep purple color, with the sharp tartness of Bristleberries to cut through the sweetness.
    -> Menu
    
* Stop eating.
    -> Seated
- else:
    Looks like you're fresh out of coins. Guess it's time to stop eating.
    -> Seated
}

= Observe
~ observed = true
{ 
- char_class == "Wizard":
    Traces of the arcane linger along the wood of the bar. You can almost feel the touch of the Moonshadow realm. How did a half-orc come across something like this?
    -> Borris
- char_class == "Rogue":
    The patrons of the inn don't seem to mind that their pockets hang open, coins glittering within. Are they naive, or is there a reason for their lax security?
    -> Borris
- char_class == "Druid": 
    The bar at the counter is made of an unusual wood- black as obsidian and swirled with faint silver grain lines. What kind of tree was felled to craft such a bar?
    -> Borris
- char_class == "Barbarian":
    You notice the halfling has stopped playing on the stage and is now armwrestling a man with hawkish features. Though he is twice her height and well built, she slams his hand upon the table with ease. Borris catches your gaze and chuckles under his breath. "Azer never learns. Maybe Alice should run the local militia..."
        -> ArmWrestling
- else == You notice nothing in particular.
    }
    -> Seated
    
= Borris
{
- char_class == "Wizard":
    "How did you get your hands on wood from the Moonshadow Realm?"
    ~ repChange(rep_Borris, 1)
    -> Borris_Counter
- char_class == "Rogue":
    * "You all seem a bit trusting with your coins. Are you not concerned with theft?"
    ~ repChange(rep_Borris, -1)
    -> Motlier_Crime
    * "You seem like friendly folk. Do you get a lot of crime here?"
    ~ repChange(rep_Borris, 1)
    -> Motlier_Crime
    - char_class == "Druid": 
    "This bar is most unusual. May I inquire to the wood's origin?"
    ~ repChange(rep_Borris, 2)
    -> Borris_Counter
}

= Borris_Counter

{ 
- char_class == "Wizard": "Moonshadow? Oh, the bar! She's a beauty, isn't she?" he pats the surface with a fond smile. "Was a gift from my mum when I opened. Not sure where she got it. Never got the chance to ask."
    -> Seated
- char_class == "Druid": "She's something special, isn't she?" He smiles with pride, rapping his knuckles on the surface. "Not sure what kind of tree she's from. Was a gift from my mum. Take good care of it, though. Lot of respect for trees here."
    -> Seated
}

= Motlier_Crime
"We don't really get a lot of crime. Azer has eyes like a hawk and is an expert tracker. Anyone trying to steal from us wouldn't get very far."
    -> Seated
    
= Bed

"You'd like a room?" The half-orc grins, his lips pulling back from his small tusks. "Excellent, glad you'll be staying with us a while longer. The wooden frames of our beds are carved by the blacksmith, if you can believe it! Futhar may be a smith by trade, but his woodworking skills truly are the best in the region. Sorry, I shouldn't keep a sleepy traveler waiting. Beds are 10 silver a night. That fine by you?"
* { coins >= 10 } "A room sounds wonderful."
    ~ pay(10)
-> Room
* "Ten silver! That's a bit pricey, isn't it?"
    ~ repChange(rep_town, -1)
    ~ repChange(rep_Borris, -2)
-> Outside

= Jobs
* [ Tibs Notice] "Can you tell me about Tib's notice?" 
    -> TibNotice
* [Azer's Notice] "Which one is the fellow named Azer?"
    -> AzerNotice

= TibNotice

"Oh, Tib is a little... out there these days. He's got it in for the goblins. Makes shoes and bags out of their hides. Bit morbid, but can't say they aren't solid..." Borris frowns, his thick brow creasing with worry. "Azer won't let him on hunts anymore. Says he endangers everyone with his obsession."
* "Which one is Tib?" -> TibCharDes
    -> Jobs
    
= AzerNotice

"Azer is in charge of the local militia," Borris shakes his head a little, his smile falling. "Don't like fighting. Don't care much for soldiers, either. But with all the kobolds and goblins popping up, he and the Mayor decided to outsource a little help. He's the tall one, with the sharp nose sitting with the halfling."
    -> SpeakWithAzer
    -> Seated

//Azer Dialogue
= SpeakWithAzer
Azer turns towards you as you approach, his hawkish features making you wonder if there isn't some Arakocra in his family history. "Yes? What is it?" he asks in a brusque manner.
    * { sawNotice } "I saw your flyer...[]and was wondering about the job."
    -> AzerJob
    * { observed == true && char_class == "Barbarian" }
    -> ArmWrestling

= AzerJob
~ temp azerQuest = false
{ sawNotice == true: "What can you tell me about the job on the flyer?" }
"Simple enough. Lots of goblins and kobolds popping up in the region lately. Don't have enough men to deal with them all. Why, you looking for work?"
// Interested
* { char_class == "Barbarian" } "Any chance to {~ bash|smash|butcher} some goblins!"
    ~ repChange(rep_Azer, 1)
    ~ azerQuest = true
    -> QuestAccepted
* { char_class == "Druid" } "As nature demands, I serve the balance. I would aid you, if you would have me."
    ~ repChange(rep_Azer, 2)
    ~ azerQuest = true
    -> QuestAccepted
* { char_class == "Rogue" } "I would prefer some more... *interesting* work, but goblins will do."
    ~ repChange(rep_Azer, -2)
    ~ repChange(rep_town, -1)
    -> Rejected
* { char_class == "Wizard" } "As long as you don't mind there being nothing left of them. {~ Magic|Fireball|Spells} can be a bit... destructive."
    ~ repChange(rep_Azer, -1)
    ~ repChange(rep_town, -2)
    -> Rejected
// Not Interested
* { char_class == "Barbarian" } "Goblins are a bit small, aren't they? Not really worth bloodying my hammer over."
    -> QuestRejected
* { char_class == "Druid" } "I do not take life, only give it."
    -> QuestRejected
* { char_class == "Rogue" } "My victims tend to be a bit taller than a goblin, if you know what I mean."
    -> QuestRejected
* { char_class == "Wizard" } "Kill? I thought you meant to study them!"
    -> QuestRejected
// More Info
* { char_class == "Barbarian" } "Just how many vermin are we talking about here?"
    ~ repChange(rep_Azer, 2)
    ~repChange(rep_town, 1)
    -> MoreInformation
* { char_class == "Druid" } "I must have more information in order to ensure I am not killing unnecessarily."
    ~repChange(rep_Azer, 1)
    ~repChange(rep_town, 2)
    -> MoreInformation
* {char_class == "Rogue" } "Let's talk about that coin. How much is it worth this town to see these pests not just cleared out, but dealt with more permanently."
    ~ repChange(rep_Azer, -2)
    ~ repChange(rep_town, -2)
    -> MoreInformation
* { char_class == "Wizard" } "That depends, what kind of help are you looking for exactly?"
    ~ repChange(rep_Azer, 1)
    ~ repChange(rep_town, 1)
    -> MoreInformation

= ArmWrestling //Option for character personality building.
* [Patronize Azer] "Saw you lose to the halfling here. Aren't you supposed to be leading the militia?"
        "Careful, traveler. Alice is stronger than she looks."
            * * [Challenge Alice] "That so? Well, how about it then, Alice?"
                The halfling grins in response, offering her short arm on the table.
                ~ repChange(rep_Alice, 2)
                -> ChallengeAlice
            * * [Challenge Azer] "Or you're just the brains behind the militia. Let's find out?" You take a seat beside the halfling, resting one { race == "Dragonborn": scaly} { race == "Dwarf": short, beefy } { race == "Elf": slender } { race == "Human": thick, muscular } arm on the table with a grin.
                "Hmph, a wager then. If I beat you, I've got some work you'll do for free. If you beat me, you get half the purse, no strings attached. Still want to challenge me?
                -> ChallengeAzer
* [Flatter Azer] "Smart of you to not waste your strength like that."
        "Hmph, yes well. It is important for me to not waste too much of my strength on silly games. What brings you to our town, traveler? Are you looking for work?
        * * Always!
        --> AzerJob
        * * No, I'm just passing through.
        -> QuestRejected
        
= ChallengeAzer
~ temp roll = RANDOM(1, 20)
You roll a { roll }.
{ roll > 12: 
He puts up a bit of a fight, but he's no match for your seasoned muscles. You beat him with minimal effort. "I see you aren't all talk. Very well, a deal's a deal. Take your gold and go." You make your way back to the bar, the extra coin jingling in your pouch.
Boris greets you with a smile. "What can I do for you, friend?"
    ~ coins += 200
- else: Either he was bluffing or the old halfling truly was stronger than she looked. "Ha! Not so strong, are you? I'll see you tomorrow morning. Sunrise, and don't be late."
You make your way back to the bar, your ego a little bruised.
Boris greets you with a smile. "What can I do for you, friend?"
} -> Seated
= ChallengeAlice
~ temp roll = RANDOM(1, 20)
You roll a { roll }.
    { roll > 16: 
The grey haired halfling puts up a surprisingly good fight, managing to resist you and even start to tip your hands before you slam hers down on the table. "Ha! A strong one! That was a good challenge. Though if I was a good twenty years younger, I might have had you." You bid her a pleasent night and head back to the bar.
Boris greets you with a smile. "What can I do for you, friend?"

    ~ repChange(rep_Alice, 2)
- else: It would appear Azer was correct: despite her age, Alice resists you, tipping your arm slowly and with gritted teeth slams it onto the table. She smiles jovially at you and shakes out her hand. "Amazing, you put up quite the fight! Good challenge, traveler." You make your way back to the bar and rethink your career.
Boris greets you with a smile. "What can I do for you, friend?"
    ~ repChange(rep_Alice, 1)
} -> Seated

        
= MoreInformation
{
- char_class == "Barbarian": "The closest den is of kobolds, about 20 by our count. There's only five of us capable of fighting right now, and only myself and two others have seen actual battle. Think you can be of some assistance?"
- char_class == "Druid": "A pack of twenty kobolds ambushed and killed a merchant and his assistant who were on their way to town. How's that for your precious balance?"
- char_class == "Rogue": "Payments 75 gold, 100 with no casualties. That enough incentive for you?"
- char_class == "Wizard": "The killing kind. You got any spells like that, wizard? Or are you all parchment and ink?"
}
* I would be happy to 
    { char_class == "Rogue": take your gold off your hands. } 
    {char_class == "Barbarian": fight alongside you. } 
    {char_class == "Druid" or char_class == "Wizard": assist you.} 
    -> QuestAccepted

* That sounds like a lot of work.
    ~ repChange(rep_Azer, -5)
    ~ repChange(rep_town, -5)
    -> QuestRejected
    
= Rejected
{ char_class == "Wizard": "I don't need someone whose going to destroy the town just to stop a few goblins." } -> Seated
{ char_class == "Rogue": "I don't need a cutthroat working along my men. Maybe you should find work elsewhere." } -> Seated

// Tib Dialogue
= TibCharDes
"Tibs the fellow over there standing aside. Think he gets lonely in that house by himself, though he never seems too happy to be here." A short human slumps against the wall opposite the bar, glaring down into his tankard in silence. His boots, belt and pants are all made of a greenish brown leather.
-> SpeakWithTib
-> Seated

= SpeakWithTib
You get up from your spot at the bar and make your way to where the man is standing. He eyes you warily, noting the <>
{ 
- char_class == "Barbarian": muscles corded beneath your skin and the massive maul you carry. "Finally, someone with some meat on their bones. You looking for work? And maybe a new pair of boots?"
    ~ repChange(rep_Tib, 2)
- char_class == "Druid": muck on your boots and the bow at your back. "A druid, eh? Not many of your kind wondering these parts. Which kind are you? You eat meat?"
    ~ repChange(rep_Tib, 1)
- char_class == "Rogue": dark coloring of your cloak and the dagger at your hip. "Not sure if an assassin is useful when dealing with hordes of goblins."
    ~ repChange(rep_Tib, 1)
- char_class == "Wizard": the lack of weapons and the ink stains on your hands. "Not going to be much good to me, are you?" he mumbles under his breath.
    ~ repChange(rep_Tib, 1)
- else == tankard in your hand.
}
* { char_class == "Barbarian" } "Work would be welcome! I can live without shoes though."
-> TibJobOffer
{ char_class == "Druid":
    * [Of course] "Of course I eat meat. Nature is about balance."
    ~ repChange(rep_Tib, 2)
    -> TibJobOffer
    * [Never] "Eat meat? You know animals are intelligent creatures, right?"
    ~ repChange(rep_Tib, -2)
    -> TibNoJob
}
{ char_class == "Rogue": 
    * "You'd be surprised how useful a dagger in the back can be."
    ~ repChange(rep_Tib, 1)
    -> TibJobOffer
    * "Suit yourself. You don't look like you can afford my skills anyway."
    ~ repChange(rep_Tib, -3)
    -> TibNoJob
}
{ char_class == "Wizard":
    * "Don't let the ink fool you. I can {~ burn the whole tavern down | hurl gobs of acid | shatter walls of stone } with some words and a wave of my hand."
    ~ repChange(rep_Tib, 1)
    -> TibJobOffer
    * "If you say so. I'll stick to my books."
    ~ repChange(rep_Tib, -1)
    -> TibNoJob
}

= TibJobOffer
{ char_class == "Barbarian": "Good to hear. I have use for you, and some coin as well."} {char_class == "Rogue" or char_class == "Wizard": "If you insist. But I'm not dragging your body back to town if things go south, got it?} Meet me at the edge of the woods in the morning. Not too early, mind you. I'm not one for sunrises, and neither are goblins."
-> QuestAccepted

= TibNoJob
He snorts derisively at you. { char_class == "Barbarian": "Why don't you do me a favor then and leave off? You smell like something that crawled out of Azer's backside."} {char_class == "Druid": "Some adventurer you are. Can't stomach a deer, can't stomach a goblin."} {char_class == "Rogue": "Like I thought, useless in a real fight."} {char_class == "Wizard": "Good idea. People like you don't belong out there in the wilds."}
-> Seated

= Room
The room is clean, with four empty beds to choose from. Each bed has a small chest at the foot, a nightstand with two drawers and a  vase with a single daisy. It's kept comfortably warm with a low burning fire in the hearth.
    -> Sleep

= Outside
Borris looks hurt, a frown creasing his face. "Got to make money, don't I? You can sleep outside if you like. There's hay in the stables."
Looks like you've hurt his feelings. As he said, the stable beside the tavern has a pile of hay in the corner. You also spot some thick grass around the back of the inn. If you're really not picky, you could sleep on the packed earth in the town center.
    * Stable
        The stable is dry and a little warm, but doesn't provide you with a view of the moon. However, you've got a picture-perfect view of the lumber yard. If you can stay awake, perhaps you can watch the trees grow.
        -> Sleep
    * Grass
        The grass is soft and fragrant, a little damp with late night dew. Unfortunately the tavern blocks both the moonlight and the view of the lumber yard, but the ground is soft and it's easy to sleep.
        -> Sleep
    * Town Center
        The hard earth in the town center isn't particularly comfortable, but it does give you a really nice view of the beautiful, full moon.
        -> Sleep


= QuestAccepted
You got a quest! You make your way back to the bar, looking forward to the next day.
Boris greets you with a smile. "What can I do for you, friend?"
~ repChange(rep_town, 2)
-> Seated

= QuestRejected
This quest wasn't for you. You make your way back to the bar, where Boris greets you with a smile.
~ repChange(rep_town, -2)
-> Seated
// End
= Sleep
End of day summary:
You have { coins } silver left.
{ 
- rep_town == 0:
    The town is indifferent to you.
- rep_town == 1:
The town thinks positively of you.
- rep_town > 1:
The town thinks highly of you.
- rep_town == -1:
The town is distrustful of you.
- rep_town <= -2:
The town dislikes you.
}
{ 
- rep_Azer == 0:
    Azer is indifferent to you.
- rep_Azer == 1:
    Azer thinks positively of you.
- rep_Azer > 1:
    Azer thinks highly of you.
- rep_Azer == -1:
    Azer is distrustful of you.
- rep_Azer <= -2:
    Azer dislikes you.
}
{ 
- rep_Tib == 0:
    Tib is indifferent to you.
- rep_Tib == 1:
    Tib thinks positively of you.
- rep_Tib > 1:
    Tib thinks highly of you.
- rep_Tib == -1:
    Tib is distrustful of you.
- rep_Tib <= -2:
    Tib dislikes you.
}
{ 
- rep_Alice == 0:
    Alice is indifferent to you.
- rep_Alice == 1:
    Alice thinks positively of you.
- rep_Alice > 1:
    Alice thinks highly of you.
- rep_Alice == -1:
    Alice is distrustful of you.
- rep_Alice <= -2:
    Alice dislikes you.
}
{ 
- rep_Borris == 0:
    Borris is indifferent to you.
- rep_Borris == 1:
    Borris thinks positively of you.
- rep_Borris > 1:
    Borris thinks highly of you.
- rep_Borris == -1:
    Borris is distrustful of you.
- rep_Borris <= -2:
    Borris dislikes you.
}
-> END
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
    
=== function repChange(varName, amount) ===
    ~ varName += amount
    ~ return varName

// Intro Blurb
=== Intro ===
Motlier is a small village which acts as the lumber supplier to the surrounding area. Founded many generations ago, the town is now run by descendants of the same families upon which the town was built. Despite its humble looks, Motlier’s success rests upon the enchanted forest to the east. Blessed by the Mother, every tree cut down regrows under the light of the full moon. Being very practical folk, the townspeople use the magic to their advantage and have been supplying lumber to the entire region for generations.
-> BuildCharacter
// Character builder
== BuildCharacter ==

Choose a race

+ [Dragonborn]
    ~ race = "Dragonborn"
    -> Class
+ [Dwarf]
    ~ race = "Dwarf"
    -> Class
+ [Elf]
    ~ race = "Elf"
    -> Class
+ [Human]
    ~ race = "Human"
    -> Class

== Class ==

Choose a class

+ [Barbarian]
    ~ char_class = "Barbarian"
    -> Origin
+ [Druid]
    ~ char_class = "Druid"
    -> Origin
+ [Rogue] 
    ~ char_class = "Rogue"
    -> Origin
+ [Wizard]
    ~ char_class = "Wizard"
    -> Origin

== Origin ==

Choose an origin

+ [Acolyte]
    ~ char_origin = "Acolyte"
    ~ coins = 80
    -> Start
+ [Criminal]
    ~ char_origin = "Criminal"
    ~ coins = 160
    -> Start
+ [Sage]
    ~ char_origin = "Sage"
    ~ coins = 80
    -> Start
+ [Soldier]
    ~ char_origin = "Soldier"
    ~ coins = 140
    -> Start

// Main Story
== Start ==

You arrive in Motlier just before sunset on the night of the full moon. Weary from a day of hard travel, your first sight is the warm light of the Ram's Horn Tavern and Inn. A noticeboard stands just outside the entrance, littered with parchment.

+ Head inside
    -> Tavern
 
+ Inspect the noticeboard
    ~ sawNotice = true
    -> Noticeboard

= Noticeboard

The most prominent flyer on the board offers a reward for helping the town deal with vermin. It says to see Azer for more details and has a seal stamped in the bottom with a flaming tree. Another, written in an angry looking scrawl, offers 50 copper pieces for undamaged goblin hide brought to Tib. The third offers a special at the tavern: 1 honeycake made with Bristleberry honey from the town nearby added to any meal for only 2 silver extra. Below is a drawing of a small cake drizzled with honey and topped with purple berries.

+ Head inside
    -> Tavern

// Tavern Stitches
== Tavern ==

{ once: Inside the tavern, it seems the entire town is gathered, drinking and laughing together merrily. An old woman sits on a small stage towards the back playing happily on her lute, her silver hair tied back in an intricate braid. A half-orc is behind the bar, refilling tankards with a practiced ease. Everyone here is very close, and only a few heads turn as the players enter. The first person to greet you is Madelina, a barmaid with a perpetually harried look. She hastily informs you that the only available seating they have is at the bar. }
-> Seated

= Seated

~ temp choice_done = false
{ choice_done:
    -> Seated
- else: 
    * Order a drink -> Menu
    * Look around -> Observe
    ~ observe = true
    * Get a room -> Bed
    * { sawNotice } Ask about noticeboard 
     -> Jobs
    -> Tavern
~ choice_done = true
}

= Menu
{ coins > 0:
    You’ve got {coins} coins jingling in your purse.

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
    
* Stop eating
    -> Seated
- else:
    Your purse is empty—time to move on.
    -> Seated
}

= Observe
~ observed = true
{ 
- char_class == "Wizard":
    Traces of the arcane linger along the wood of the bar. You can almost feel the touch of the Moonshadow realm. How did a half-orc come across something like this? 
- char_class == "Rogue":
    The patrons of the inn don't seem to mind that their pockets hang open, coins glittering within. Are they naive, or is there a reason for their lax security?
- char_class == "Druid": 
    The bar at the counter is made of an unusual wood- black as obsidian and swirled with faint silver grain lines. What kind of tree was felled to craft such a bar?
- char_class == "Barbarian":
    You notice the halfling has stopped playing on the stage and is now armwrestling a man with hawkish features. Though he is twice her height and well built, she slams his hand upon the table with ease. Perhaps she would be up to a challenge?
        -> SpeakWithAzer
- else == You notice nothing in particular.
    }
    -> Seated

= Bed

Rooms are 10 silver piece a night.
* Rent a room
    { coins >= 10 }
    ~ pay(-10)
-> Room
* Sleep outside
-> Outside

= Jobs
* Ask about Tib
    -> TibNotice
* Ask about Azer -> AzerNotice

= TibNotice

"Oh, Tib is a little... out there these days. He's got it in for the goblins. Makes shoes and bags out of their hides. Bit morbid, but can't say they aren't solid..."
* Whose Tib? -> TibCharDes
    -> Jobs
    
= AzerNotice

"Azer is in charge of the local militia. Between him and Percy in Motlier, we rarely have need for the Caidour's soldiers. Him and the Mayor decided to outsource a little help after a sudden resurgence of kobolds and goblins in the area. He's over there with Alice, the halfling, if you're curious. The tall one, with a bit of a sharp angle to his nose."
    -> SpeakWithAzer
    -> Seated

//Azer Dialogue
= SpeakWithAzer
Azer turns towards you as you approach, his hawkish features making you wonder if there isn't some Arakocra in his family history. "Yes? What is it?" he asks in a brusque manner.
    * { sawNotice } Ask about flyer
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
* [Comment on his loss] "Saw you lose to the halfling here. Aren't you supposed to be leading the militia?"
        "Careful, traveler. Alice is stronger than she looks."
            * * [Challenge Alice] "That so? Well, how about it then, Alice?"
                The halfling grins in response, offering her short arm on the table.
                ~ repChange(rep_Alice, 2)
                -> ChallengeAlice
            * * [Challenge Azer] "Or you're just the brains behind the militia. Let's find out?" You take a seat beside the halfling, resting one { race == "Dragonborn": scaly} { race == "Dwarf": short, beefy } { race == "Elf": slender } { race == "Human": thick, muscular } arm on the table with a grin.
                "Hmph, a wager then. If I beat you, I've got some work you'll do for free. If you beat me, you get half the purse, no strings attached. Still want to challenge me?
                -> ChallengeAzer
* [Compliment him] "Smart of you to not waste your strength like that. Especially when you have a pest control problem."
        "Hmph, yes well. It is important for me to not waste too much of my strength on silly games. What brings you to our town, traveler? Are you looking for work?
        * * Always!
        --> AzerJob
        * * No, I'm just passing through.
        -> QuestRejected
        
= ChallengeAzer
~ temp roll = RANDOM(1, 20)
You roll a { roll }.
{ roll > 12: 
He puts up a bit of a fight, but he's no match for your seasoned muscles. You beat him with minimal effort. "I see you aren't all talk. Very well, a deal's a deal. Take your gold and go."
    ~ coins += 200
- else: Either he was bluffing or the old halfling truly was stronger than she looked. "Ha! Not so strong, are you? I'll see you tomorrow morning. Sunrise, and don't be late."
} -> Seated
= ChallengeAlice
~ temp roll = RANDOM(1, 20)
You roll a { roll }.
    { roll > 16: 
The grey haired halfling puts up a surprisingly good fight, managing to resist you and even start to tip your hands before you slam hers down on the table. "Ha! A strong one! That was a good challenge. Though if I was a good twenty years younger, I might have had you."
    ~ repChange(rep_Alice, 2)
- else: It would appear Azer was correct: despite her age, Alice resists you, tipping your arm slowly and with gritted teeth slams it onto the table. She smiles jovially at you and shakes out her hand. "Amazing, you put up quite the fight! Good challenge, traveler."
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
You get up from your spot at the bar and make your way to where the man is standing. He eyes you warily, noting the 
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
Seems like you've got a choice of where to sleep. A stable beside the tavern has a pile of hay and no horses. There's also some grass that's slightly overgrown around the back of the inn. If you're really not picky, you could definitely just sleep on the packed earth in the town center.
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
You got a quest!
-> Seated

= QuestRejected
This quest wasn't for you.
-> Seated
// End
= Sleep
You have { coins } left.
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
The town is openly hostile towards you.
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
    Azer is openly hostile towards you.
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
    Tib is openly hostile towards you.
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
    Alice is openly hostile towards you.
}
-> END

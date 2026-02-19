#set document(
  title: [Syllabus of Irish Dances as danced at the Starry Plough in Berkeley,
    California],
)

// Definitions

#let space = [ ].func()

#let ref-targets(it) = if it.has("children") {
  it.children.map(ref-targets).flatten()
} else if it.func() == ref {
  (it.target,)
} else if it.func() == space {
  ()
} else {
  assert(false, message: "Expected only refs")
}

#let match-content(content, pattern) = if content.has("children") {
  content.children.any(child => match-content(child, pattern))
} else {
  content.func() == text and content.text.match(pattern) != none
}

#let dots = box(width: 1fr, repeat([.], gap: .15em))

#let dance-def(it, tags) = [#metadata((name: it, tags: tags))<dance>#it]

#let dance-name(m) = {
  let dance-labels = ref-targets(m.value.tags)
  if (
    dance-labels.contains(<time:reel>)
      and not match-content(m.value.name, regex("\\bReel\\b"))
  ) {
    [#m.value.name (R)]
  } else if (
    dance-labels.contains(<time:jig>)
      and not match-content(m.value.name, regex("\\bJig\\b"))
  ) {
    [#m.value.name (J)]
  } else if (
    dance-labels.contains(<time:hornpipe>)
      and not match-content(m.value.name, regex("\\bHornpipe\\b"))
  ) {
    [#m.value.name (H)]
  } else {
    m.value.name
  }
}

#let dance-list(tags) = {
  let labels = ref-targets(tags)
  context query(<dance>)
    .filter(m => {
      let dance-labels = ref-targets(m.value.tags)
      labels.all(label => dance-labels.contains(label))
    })
    .map(m => {
      let name = if labels.any(label => str(label).starts-with("time:")) {
        m.value.name
      } else {
        dance-name(m)
      }
      link(m.location(), [#name #dots #m.location().page()])
    })
    .join(linebreak())
}

#let figure-def(name: auto, it) = [#metadata((
    name: if name == auto { it } else { name },
  ))<figure>#it];

#let bars(it) = {
  show terms: it => {
    let beats-width = measure([(99)] + terms.separator + sym.zws).width
    list(
      tight: it.tight,
      marker: [],
      indent: it.indent,
      body-indent: beats-width,
      spacing: it.spacing,
      ..it.children.map(item => {
        let term = [(#item.term)] + terms.separator
        h(calc.max(-beats-width, -measure(term + sym.zws).width))
        term
        item.description
      }),
    )
  }
  it
}

// Global setup

#set math.frac(style: "skewed")
#set page("us-letter", margin: .75in)
#set par(leading: .48em)

// Title page

#align(center + horizon)[
  #set text(size: 20pt)

  #title[
    #par(leading: 1.4em)[
      #box(
        image("title-letters/s.svg", alt: "S", width: 500in / 600),
        inset: (right: -10pt, top: -40pt, bottom: -19pt),
      )yllabus of\
      #box(
        image("title-letters/i.svg", alt: "I", width: 325in / 600),
        inset: (left: -12pt, right: -11pt, top: -36pt, bottom: -48pt),
      )rish #box(
        image("title-letters/d.svg", alt: "D", width: 525in / 600),
        inset: (left: -1pt, top: -33pt, bottom: -31pt),
      )ances\
      as danced at the\
      #box(
        image("title-letters/st.svg", alt: "St", width: 725in / 600),
        inset: (left: -11pt, right: -3pt, top: -36pt, bottom: -25pt),
      )arry #box(
        image("title-letters/p.svg", alt: "P", width: 825in / 600),
        inset: (right: -43pt, top: -38pt, bottom: -25pt),
      )lough\
      in Berkeley, California
    ]
  ]

  #set text(size: 16pt)

  #v(3em)

  Notated, renotated and published by Terry Clyde F. O'Neal II\
  Edited and copy read many times by Lee Thompson-Herbert, 1996\
  Converted and republished by Anders Kaseorg, 2026\
  Updated by the Starry Plough Irish dancers, #datetime.today().display()\
  Distributed under the #link(
    "https://creativecommons.org/licenses/by-sa/4.0/",
    [CC BY-SA 4.0 license],
  )
]

#pagebreak()
#set page(
  footer: context {
    set text(size: 12pt)
    set align(center)
    counter(page).display()
  },
  numbering: "1",
)
#set text(size: 12pt)

= About this syllabus

If you don't know how to do Irish dancing, this "tome" will not teach you. Nor
is it my intention to describe the steps here in detail. The purpose here is to
remind intermediate and advanced Irish dancers of some of the details of dances
they already know and to teach them some dances that they may not know. These
are the Starry Plough variants of the dances; they differ from the most current
books. Don't use these descriptions as sources for competition! Sorry. Many of
these dances were taken from descriptions published in the 20s and 30s. One
source was published in 1904. Some variants of some figures are known only at
the Starry Plough. PLEASE do not impose our way of doing the dances anywhere
else. EVERY group that does Irish dancing does it differently. This is a great
strength of Irish dancing, not a weakness. Anywhere you go in the world, the
Scots dancers try to dance the same. Anywhere you go in the world, the Irish
dancers don't try to dance the same and end up dancing differently. Let it be;
each has its strength.

I have notated these dances in about 5 waves. I have changed most dances to the
5th wave. Still, 3 of the previous waves are apparent, and I just may leave them
be because it takes as long to rewrite them as to write diem, and that is about
4 hours per dance.

= A brief history of the Monday night session at the Starry Plough

In 1976, Simon Spaulding, then a music student at UC Berkeley, got permission
from Bob Heaney, then the owner of the Starry Plough, to have a band he started
called "The Nearly Gaelic Céilí Band" play on Monday evenings. An Irish dance
performance group called "Rinnce Mór" used to dance to their music. I joined
Rinnce Mór in 1978 in time to perform at the De Young museum in San Francisco
for the Irish Exhibition. In 1980, a man named Donovan from the Celtic Institute
convinced me to teach a class on Irish dancing. I approached Bob Heaney about
doing it early on Monday evenings. He agreed, and we are going still. Many
thanks to Mehdad and Rose, the current owners for allowing us to continue.

= Acknowledgements

- D. Karl Davis. He read the first draft and gave me copious notes and
  suggestions on every part.
- Erica Lynn Frank. She bugged me till I wrote this syllabus and then read it
  several times and gave me many suggestions.
- Lee Thompson-Herbert. She read it many times and helped clarify many parts and
  did the artwork on the title page.
- Jenna Chalmers
- Cathleen O'Connell
- Dancers at the Starry Plough

== A note on the use of this syllabus

When you see this instruction:

#bars[
  #set text(size: 16pt)
  / 8: Repeat with...
]

You do again the indicated number of bars but with the differences noted.

#pagebreak()

= Table of contents

#columns(2)[

  #outline(
    title: none,
    depth: 1,
    target: selector(heading).before(<dances-start>),
  )

  == All the dances

  #dance-list[]

  == Dances composed, decomposed or recomposed by Terry O'Neal <composer:terry>

  #dance-list[@composer:terry]

  #colbreak()

  == 4-Hand dances in squares <shape:4-hand>

  #dance-list[@shape:4-hand]

  == 8-Hand dances in squares <shape:8-hand>

  #dance-list[@shape:8-hand]

  == 6-Hand dances <shape:6-hand>

  #dance-list[@shape:6-hand]

  == Longways progressive proper (men face the ladies) <shape:proper>

  #dance-list[@shape:proper]

  == Longways progressive, couples face couples <shape:improper>

  #dance-list[@shape:improper]

  #colbreak()

  == Longways progressive, trio face trio <shape:trios>

  #dance-list[@shape:trios]

  == Dances for circles of couples <shape:circle>

  #dance-list[@shape:circle]

  == Other dances <shape:other>

  #dance-list[@shape:other]

  == Dances for absolutely everyone <level:everyone>

  #dance-list[@level:everyone]

  #colbreak()

  == All the reels <time:reel>

  #dance-list[@time:reel]

  #colbreak()

  == All the jigs <time:jig>

  #dance-list[@time:jig]

  == All the hornpipes <time:hornpipe>

  #dance-list[@time:hornpipe]
]

#pagebreak()

= Bibliography

1. #underline[Rinnce na Eirann. National Dances of Ireland]. Collected by J. M.
  Laing and edited and described by Elizabeth Burchenal. Published by A. S.
  Barnes, New York, 1924.
<source:rne>
2. #underline[The Irish Folk Dance Book], books one and two. Written and edited
  by Peadar O'Rafferty. Published by Paterson's Publications Ltd., London G.
  B., 1934.
<source:ifd>
3. #underline[Ar Rinncidhe Fóirne]. 3 volumes of "Official Handbooks" of the
  Coimisiún le Rincí Gaelacha. Mine were published between 1967 and 1971.
<source:arf>
4. #underline[A handbook of Irish Dances]. By J. G. O'Keefe and Art O'Brien.
  Published by M. H. Gill & son Ltd., Dublin, circa 1904
<source:hid>
5. Newly composed by various people.
<source:new>
6. Other sources (e.g., friends at a party).
<source:other>

= The sources of the dances

#columns(2)[
  #context (
    query(<dance>)
      .map(m => [#link(m.location(), [#dance-name(m) #dots]) #(
          ref-targets(m.value.tags)
            .filter(t => str(t).starts-with("source:"))
            .map(t => link(t, [#query(t).first().number]))
            .join(", ")
        )])
      .join(linebreak())
  )
]

#pagebreak()

= A few definitions

== Dance steps and moves

/ Around the House: To swing while traveling around in a circle, often around
  one or several other couples.
/ Cast; Cast Off: One turns the long way around to start the figure. This is
  bigger than turning in place. One turns while dancing in a circle.
/ Courtesy Turn: After swinging, turning etc., to help the one facing out of the
  set to face in. Usually, the person giving the courtesy turn does so by
  holding a firm arm to guide the one taking the courtesy turn into place.
/ Set: Setting steps done in place, e.g., the Rise & Grind, 3s in place, the
  Sink & Grind, Shuffles, etc.
/ Sidestep: 7s to either side.
/ Reverse Swing: To swing pulling back the Left shoulder.
/ Swing: To turn with another, often in place, both pull back their own Right
  shoulder.

== The people who are dancing

/ Contra corner: The person of the same dancing gender as your partner, but next
  beyond your partner. The partner of your partner's corner. In an 8-hand square
  set your contra corner is approximately opposite your corner.
/ Corner: When your partner is next to you, your corner is also next to you but
  on your other side. A man's corner is on his Left; a lady's corner is on her
  Right.
/ Couple: You and your partner. The person dancing as a man stands to the left
  of the person dancing as a lady or opposite her.
/ First corners:
  1. In an 8-hand square set like the Berkeley Set, the first corners are the
    head men with their corners, the side ladies.
  2. In a longways dance like the Haymaker's Jig, the first corners are the head
    man and the last lady.
/ Opposite: The person of the opposite dancing gender standing directly across
  from you. Does not apply in a longways set of a line of men facing a line of
  ladies; in that case you are facing your partner.
/ Partner: The person with whom you are flirting the most. The lady usually
  stands on the Right of the man.
/ Second corners:
  1. In an 8-hand square set like the Berkeley set, the second corners are the
    side men with their corners, the head ladies.
  2. In a longways dance like the Haymaker Jig, the second corners are the head
    lady and the last man.
/ Set: The group of people dancing together, e.g., the four people in the 4-Hand
  Reel, the eight people in the 8-Hand Jig, the line of men and the line of
  women facing each other in the Haymaker Jig.

== The formations of the dances

/ Couple face couple: This longways set is composed of a line of couples, each
  couple facing one other couple and standing back to back with still another
  couple. The couples at the very top and bottom don't have a couple at their
  back. The couple at the bottom may not even have a couple to face until the
  2nd iteration of the dance.
/ Trio face Trio: This longways set is composed of a line of trios, each trio
  facing one other trio and standing back to back with still another trio. The
  trios at the very top and bottom don't have a trio at their back. The trio at
  the bottom may not even have a trio to face until the 2nd iteration of the
  dance.
/ Longways dance: The sets of people dancing are long instead of square or
  circular. There are many minor arrangements of this major form: a line of men
  face a line of ladies, couple face couple, trio face trio, two couples face
  two couples, to name a few.

== Miscellaneous

/ Set: A group of dances always danced together usually with one figure each,
  e.g., a Kerry Polka Set.

#pagebreak()

= Teaching

== Beginners

I like to teach figures before steps for several reasons:
- Most people learn figures faster than steps.
- Timing of figures is far more important than stepping; stepping can destroy
  timing.
- If people know the figures, they can dance, flirt, have fun, and raise hell.

When teaching figures, encourage advanced beginners to use steps, but insist
that rank beginners walk! Thereby you can teach the timing...teach the
timing...teach the timing...teach the timing...teach the timing.

Teach only shape, track and timing. Leave stepping for later.

Here is a list of figures I like to teach beginners:

=== In a circle

- Circle (Ring).
- Forward & Back (Advance & Retire).
- Turn corner (or opposite) by Left and partner by Right. (4 bars each).
- Link Arms: Right to comer, Left to partner. (2 bars each).
- Grand Chain: Emphasize 2 bars per hand.

=== In sets of 4 dancers

- Chains: Scots, Irish, Ladies', Men's.
- Star (Hands Across). Show how to take hands.
- Irish Square.
- Telescope.
- Swing (Around the House).

=== In lines

- Hey for 3.
- Hey for 4.

Here is how I teach Stepping:

=== Phase 1: sidesteps & 7s

Arrange the students into a circle holding hands. Get their weight on one foot
and put the other foot behind. Start stepping this way until it gets better.
Then go the other way. Teach them to stand straight; suggest that Irish is
danced a bit as if you were in a body corset but still relaxed; the torso is
upright but the arms are relaxed at your side.

Several things that are being accomplished:

- They are learning to dance together.
- They are learning to take direction.
- They are learning to move sideways in a manner which is unique to Irish
  dancing.

Several things to look at:

- Make sure their feet are turned out; they may harm their ankles otherwise.
- While moving sideways, ask the dancers to place their feet so that when the
  trailing foot catches up to the leading foot they are neither too over-crossed
  nor too far apart. The trailing foot should just catch up to the leading foot,
  not pass it or leave a big gap.
- Get the more advanced ones to place their toe under their raised heel.

Increase the speed in each direction up to dance tempo.

Building on the foregoing and starting very slowly, start doing 7s back and
forth. Increase the speed to near dance tempo.

=== Phase 2: "the piston"

Still holding hands in a circle and dancing in place, teach them to put one foot
behind and go down on it and raise up on the front foot. ALL the lift is done
with the front foot; the back foot only keeps them from falling. However, the
balance is on the back and NOT the front foot. Increase the speed to faster than
dance tempo. Emphasize that the main part of Irish style is contained in this
move. Teach that their body is a piston going straight up and down; it does NOT
go fore and aft.

=== Phase 3

Teach 7s in place. Teach them to do 7s continuously from one foot to the other.
While doing still doing 7s, change it to 5s! Then change it to 3s. When the 3s
fall apart, stop. Start phase 3 over. Repeat until they can do 3s. Start slowly
and build speed.

=== Phase 4

Repeat phase 3, but move to the side on 7s. Teach the more advanced ones to leap
into 3s.

At the Starry Plough, those who can do 7s & 3s become intermediate dancers.

== Intermediates

Teach the 4-hand dances, especially The 4-Hand Reel and the Humors of Bandon.
Work on timing and precision in the figures. Work a lot on stepping. Teach
"low-clean style" and discourage attempts at "high style" until their style is
"clean". Teach people how to leap into 3s and how to cut into 7s with one foot
while hopping on the other foot. Teach the Belfast Hop (moving jig 3s), jig 3s
in place, and the Rise and Grind. Teach the evenness of reels and the dottedness
of jigs. Integrate the steps with the dances. Teach the Around the House in both
jig and reel times.

== Advanced

Teach all the dances, especially the 8- and 16-Hand dances. Again, work on
timing, precision, and dancing together in the figures. Now that the dancers can
leap into 3s, teach them how to replace into 3s. Teach them how to leap into 7s
both in front and behind. Improve the style of cutting into 7s (the pointed foot
approaches the knee of the hopping leg, the knee of the leg in the air is
straight forward). Teach "high style". Teach them to put their toes under their
heels where appropriate in 7s and in 3s (where the trailing foot closes up to
the lead foot). Teach more setting steps such as the Sink and Grind, shuffles
etc.

#pagebreak()
#set text(size: 20pt)

== To use while teaching beginners

=== In a circle

- Circle (Ring).
- Forward & Back (Advance & Retire).
- Turn corner (or opposite) by Left and partner by Right. (4 bars each).
- Link Arms: Right to corner, Left to partner. (2 bars each).
- Grand Chain: Emphasize 2 bars per hand.

=== In sets of 4 dancers

- Chains: Scots, Irish, Ladies', Men's.
- Star (Hands Across). Show how to take hands.
- Irish Square.
- Telescope.
- Swing (Around the House).

=== In lines

- Hey for 3.
- Hey for 4.

#pagebreak()
#set text(size: 16pt)

= Common figures

These figures are discussed briefly:

#context (
  query(<figure>)
    .map(f => link(f.location(), [#f.value.name #dots #f.location().page()]))
    .join(linebreak())
)

There are far more figures than these in Irish dances, but either they are
unique to one dance or they are danced differently at each occurrence.

Here is how we count the sets at the Starry Plough:

#figure[
  Music \
  1\
  3 #h(2em) 4\
  2
]

- Couple 1 is the "Top" or the "Leading Head"
- Couple 2 is the "Bottom" or the "Trailing Head"
- Couple 3 is the "Side" or the "Leading Side"
- Couple 4 is the "Side" or the "Trailing Side"

#bars[
  / 4: *#figure-def[Advance & Retire]* or *Forward & Back:* Stepping: 3s. Line
    face line, couple face couple, circle of couples.
    / 2: Dance forward to meet the opposite person or couple.
    / 2: Dance backward to place.

  / 16: *#figure-def[Angle-Saxon Hey]:* (Yes, that is Angle and not Anglo.)
    Stepping: 7s. 4 Hands, couple face couple. Invented by Terry O'Neal.
    / 2: Sides with partner (on the side of the set). Men turn 45° Right, ladies
      turn 45° Left and
    / 2: Sides diagonally across the center, face to face and ladies barely
      before the men. Ladies be quick.
    / 2: Sides with opposite (on the side of the set). Men turn 45° Right,
      ladies turn 45° Left and
    / 2: Sides diagonally across the center, face to face and ladies barely
      before the men. Ladies be quick.
    / 8: Repeat to place.

  / 8: *#figure-def[Around the House]:* Stepping: 3s. 4 Hands, couple face
    couple.\
    To swing while traveling around in a circle, often around one or several
    other couples; to swing with partner in a counter-clockwise circle or
    half-circle around the other couple to place or to progressed place.
    Alternate stepping behind with the Right foot with leaping or reaching
    around your partner with the Left foot.

  / 8 or 4: *$1/2$ Around the House:* Stepping: 3s. 4 Hands, couple face
    couple.\
    As above, but only a half-circle around the other couple to place or to
    progressed place.

  / 32: *#figure-def[Bend the Ring & Circle]:* Couples in a circle.
    / 8: Advance & Retire twice holding hands in a circle, raising hands as you
      advance and lowering them as you retire.
    / 8: Circle Right and then Left to place.
    / 16: Repeat, but Circle Left first.

  / 16: *#figure-def[Celtic Cross]:* Stepping: 3s. 4 Hands, couple face couple.\
    Everybody dances to the center, passes Right shoulder with the other person
    of the same dancing gender, and turns 90° Right and then dances to the next
    corner to the Right and turns around to the Right to start in again. Ladies
    start this at the same time, followed 2 bars later by the men.\
    Stolen from Hugh Foss by Terry O'Neal.
    / 2: Men cast Right in place, ladies pass Right shoulder and turn 90° Right
      in center.
    / 2: Men, following their partner, pass opposite lady by Right shoulder into
      center and follow partner but one corner behind.
    / 12: Continue till the end of the 2nd phrase of music.

  / 16: *#figure-def[Diamond]:* Stepping: 7s & 3s. (Usually done as *Squares &
    Diamonds*)\
    6 Hands, trio faces trio. The dancers on the outside of the trios form a
    square. The diamond points are at the midpoint of each side of the square.
    The middles are already on a diamond point.
    / 4: Middles of the trios dance 7s to the next diamond point to their Right.
      Set in place.
    / 12: Repeat 3 more times to place.

  / ?: *#figure-def[Dip & Dive]:* see *Tonnai Thoraigh*

  / 8: *#figure-def[Fancy Men's Chain]:*
    / 3: Men turn $1 1/2$ in the center by the Right hand.
    / 3: Men turn opposite lady by the Left hand.
    / 2: Men dance straight to place.

    OR
    / 2: Men link arms in center by the Right & turn $1 1/2$.
    / 2: Men link with their opposites by the Left.
    / 2: Men pass Right shoulder.
    / 2: Men link with their partners by the Right.

    OR
    / 2: Men Right link Right arms.
    / 2: Then they turn the other lady by the Left hand.
    / 2: Men pass Right shoulder and
    / 2: Turn partner by the Right hand to place.

  / Couples × 4: *#figure-def[Grand Chain]:* Stepping: 3s. Couples in a circle.\
    Start by giving Right hand to partner, Left hand to the next one around the
    set. Keep going to place. 2 bars per hand.

  / Couples × 2: *Fast Grand Chain:* Stepping: 3s. Couples in a circle.\
    Start by giving Right hand to partner, Left hand to the next one around the
    set. Keep going to place. 1 bar per hand.

  / 8: *#figure-def[Grand Ladies' Chain]:* 4 couples in a circle (or square).
    / 2: Ladies $1/2$ Right Hand Star to meet opposite,
    / 2: Ladies turn opposite by Left,
    / 2: Ladies pass Right shoulders in the center _without_ hands,
    / 2: Ladies turn partner by Right.

    This is always followed by a Grand Around the House.

  / 8: *#figure-def[Hey for 3]:* Stepping: 3s.\
    Weave a simple figure 8.

    Start in a line of 3 people. The middle starts forward and Right. (The ends
    may cast out.) Everybody follows someone but lets the 3rd one go between
    themselves and the one they are following when passing through the center.

    Think of a figure 8 as 4 "c's" or loops. Each loop gets 2 bars. Make the
    loops wide; don't let the figure get long and narrow.

  / 8: *#figure-def[Hey for 4]:* Stepping: 3s.\
    Weaving a figure 8 with a 3rd loop.

    Start in a line of 4 people. The middles start facing out and the ends start
    facing in. All start by passing Right shoulders. Pass Left shoulders _only
    in the middle_. Pass Right shoulders twice in a row on the ends. Make wide
    loop on each end with a small loop in the middle.

  / 8: *#figure-def[Irish Chain]:* Stepping: 3s. 4 Hands, couple face couple.\
    This is like a "Grand Chain," but for only 2 couples. Start by giving Right
    hand to Partner; 2 bars per hand.

  / 16: *#figure-def[Irish Square]:* Stepping: 7s & 3s. 4 Hands, couple face
    couple.
    / 2: Slipside (7s) to change places with partner.
    / 1: Set (3s).
    / 1: Set (3s) and turn 90° to face into the square.
    / 4: Slipside to change places with opposite and then turn 90° to
    / 8: Repeat 2 more times, siding each time in the same direction (Right for
      men and Left for women; each dancer travels around the whole square back
      to home place).

  / 8: *#figure-def[Ladies' Chain]:* Stepping: 3s. 4 Hands, couple face couple.
    / 2: Ladies change places by the Right hand.
    / 2: Turn opposite man by the Left.
    / 2: Pass the other lady by the Right shoulder.
    / 2: Turn partner by the Right hand.

    This is usually followed by an Around the House for the active couples.

  / 16: *#figure-def[Ladies' Interlace]:* Stepping: 3s. 8 hand square set.
    / 8: Women dance in front of partner, behind and around the next man, behind
      partner, and into center.
    / 4: Right Hand Star $3/4$.
    / 4: Turn corner by the Left, partner by the Right.

  / 8: *#figure-def[Lead Around]:* Stepping: 3s. 4 or 8 hand square set.\
    Take partner's near hand and dance counter-clockwise around the set to
    place. Men should be shoulder to shoulder in the center of the set.

  / 16: *Lead Around & Back:* Stepping: 3s. 4 or 8 hand square set.
    / 6: Take partner's near hand and dance counter-clockwise around the set to
      place. Men should be shoulder to shoulder in the center of the set.
    / 1: Drop partner's hand.
    / 1: Both turn in toward each other to face back the other way.
    / 6: Take partner's near hand and dance clockwise around the set into place
      facing out of the set. Again, men should be shoulder to shoulder in the
      center of the set.
    / 1: Drop partner's hand.
    / 1: Both turn toward each other to face back into the set.

  / 8: *#figure-def[Link Arms]:* see Uillinn in Uillinn

  / 8: *#figure-def[Men's Chain]:* Stepping: 3s. 4 Hands, couple face couple.
    / 4: Men dance forward to and turn opposite lady by the Right.
    / 4: Men pass Left shoulders to home and turn partner by the Left.

    This is usually followed by an Around the House for the active couples.

  / 8: *#figure-def[Men Go Back to Back]:* Stepping: 7s & 3s. 4 Hands, couple
    face couple.
    / 2: _ALL_ dancers do 7s to their own left: Men, holding their partner's
      Right hand, pass the other man back to back and take the Left hand of the
      other man's partner forming a circle of 4 with the men facing out and the
      ladies facing in.
    / 2: All set.
    / 4: Men turn the other lady by the Left then turn partner by the Right to
      place. 2 bars each.

  / 16: *#figure-def[Men's Interlace]:* Stepping: 3s. 8 hand square set.
    / 8: Men dance in front of partner, behind and around the next lady, behind
      partner, and into center.
    / 4: Left Hand Star $3/4$ around the square.
    / 4: Turn corner by the Right, partner by the Left.

  / 8: *#figure-def[Quick Square]:* Stepping: 7s. 4 Hands, couple face couple.\
    Irish Square without setting. Invented by Terry O'Neal.

    / 2: Slipside with partner and then turn 90° to
    / 2: Slipside with opposite and then turn 90° to
    / 4: Repeat, slipsiding each time in the same direction (Right or Left).

  / 16: *#figure-def[Return Chain]:* Stepping: 3s. 4 couples in a circle.\
    Men go in front of partner and all do a Grand LEFT and Right starting with
    contra corner with the Left hand. Meet partner, turn about by the Right, and
    chain back to place.

  / 16: *#figure-def[Rights & Lefts for 6]:* Stepping: 3s. Trio face trio.
    Collected by Patrick Morris
    / 2: Middles face to their Right and change places with that person by the
      Right hand.\
      Meanwhile the end people left out change places on the diagonal by the
      Right hand also.
    / 2: All cross the set by the Left hand.
    / 8: Repeat 2 more times to home place.
    / 4: Turn opposite by the Right to place.

  / 8: *#figure-def(name: "Ring or Circle")[Ring]* or *Circle:* Stepping: 7s and
    2 bars of setting.
    / 4: Sets take hands in a circle and sidestep together (7s) and then set
      (3s) twice.
    / 4: Repeat to place.

    OR: 3s around circle for 3 bars, turn on 4th bar and repeat to place.

  / 8: *#figure-def[Scots' Chain]:* Stepping: 3s. 4 Hands, couple face couple.\
    This is like a "Grand Chain," but for only 2 couples. Start by giving Right
    hand to opposite and Left to partner. 2 bars per hand. Continue till home.
    Take or give a courtesy turn at home.

  / 16: *#figure-def[See Saw]:* Stepping: 3s. 8 hands in a circle.
    / 8: Around the House with _uncrossed_ hands to place.
    / 8: Reverse Around the House to place, same hands.

  / 8: *#figure-def[Set All Around]:* (8-hand jigs.) Stepping: Jig 3s, Rise &
    Grind. 4 couples in a circle.
    / 2: Turn partner by the Right $1/2$ so that the men face out and the ladies
      in. Take contra corner's Left hand to make one 8-hand circle.
    / 2: Rise & Grind.
    / 2: Turn contra corner by the Left.
    / 2: Turn partner by the Right to place.

  / 16: *#figure-def[Skip Across]:* (8-hand jigs.) Stepping: 3s. 4 couples in a
    square.
    / 2: All 4 men at once: skip across passing Right shoulder. Let the man on
      your Left go before you.
    / 2: Turn opposite lady by the _Left_ $1 1/4$ around.
    / 4: Turn contra corner $1 1/2$ by the Right to her partner's place.
    / 2: All 4 men at once: skip across passing Right shoulder.
    / 2: Turn opposite (original corner) lady by the Left $3/4$ around.
    / 4: Turn partner by the Right.

  / 8: *#figure-def[Slipsides]:* Stepping: 7s & 3s.
    - *Slipsides with partner* or *Single Slipsides:* Change places with
      partner, set, and go back. Person dancing to their own Right dances
      behind.
    - *Couples Slipsides* or *Double Slipsides:* Couples change places and set
      (e.g., the Siege of Ennis).\
      In an 8-hand set, the heads start Right, sides Left. Couples dancing to
      their own Right dance behind.

  / 16: *#figure-def[Squares & Diamonds]:*\
    An *Irish Square* and *Diamonds* danced simultaneously. The ends do the
    *Irish Square* and the middles do the *Diamonds*.

  / 8: *#figure-def(name: "Star or Hands Across")[Star]* or *Hands Across:*
    Stepping: 3s. 4 Hands, couple face couple.
    / 3: Dancers take diagonally opposite's hand and dance around the center of
      the set. Drop hands at end.
    / 1: Turn around by first facing into the center.
    / 3: Dancers take diagonally opposite's other hand and dance back around
      set. Drop hands at end.
    / 1: Dance to place.

  / 8: *#figure-def[Star-Pull-Through]:* Stepping: 3s & 7s. 4 Hands, couple face
    couple. Invented by Terry O'Neal.
    / 2: Star by the Right hand exactly $1/2$ the way around the set. Stepping:
      3s.
    / 2: All 4: Slipsides through the center all at once going back-to-back with
      the person whose hand you held. Leave room for the others. You are now
      near where you started, but you are facing the same compass direction as
      when you started the slipsides. Turn your head to face the center, but
      don't turn your body.
    / 4: Repeat, other hand to place.

  / 16: *#figure-def[Swing Into Line]:* (8-hand jigs.) Stepping: 3s. 4 couples
    in a circle.
    / 2: Swing partner with crossed hands to form a single file of couples
      facing up. The order of couples is: 1, 4, 3, 2.
    / 2: Leaders cast down on own side, others follow.
    / 4: Leaders lead up to place followed by the others.
    / 4: Lines of men face lines of ladies and all Rise & Grind twice.
    / 4: Swing partner to reform Square Set in home place.

  / 8: *#figure-def[Telescope]:* Stepping: 7s & 3s. 4 Hands, couple face couple.
    / 2: 1st couple face each other, take Right hands, and dance 7s down between
      the 2nd couple. Meanwhile: 2nd couple face each other, and dance 7s up the
      outside.
    / 2: Couples set or Couples change places with partner turning $1/2$ by the
      Right hand.
    / 4: Repeat to place. 2nd couple leads down the middle.

  / 8: *#figure-def[Telescope-Star]:* Stepping: 7s & 3s. 4 Hands, couple face
    couple. Invented by Terry O'Neal.
    / 2: 1st couple leads a $1/2$ telescope.
    / 2: Star Right $1/2$ way around the set to your partner's home.
    / 2: 2nd couple leads a $1/2$ telescope.
    / 2: Star Left $1/2$ way around the set to home place.

  / ?: *#figure-def[Tonnai Thoraigh]* (aka *Waves* or *Dip & Dive*)*:* Stepping:
    3s.\
    The 1st couple faces down and takes inside hands and dances an arch _over_
    the next couple and then dances under an arch made by the next couple. Wait
    for the 1st couple to reach you before starting. At the end of the set, turn
    in towards partner, take inside hands again, and continue until every couple
    is home before proceeding. Each couple, when reaching the top, turns singly
    and starts back into the set by arching _over_ the next couple (over at the
    top).

  / 8: *#figure-def[Uillinn in Uillinn]* (aka *Link Arms*)*:* Stepping: 3s.\
    This is the classic "elbow turn." Each person grips behind the other's
    elbow. The thumb DOES NOT enclose the other dancer's arm. Usually it's 4
    bars by the Right and back by the Left. Sometimes it's done in 2 bar
    fragments.

  / ?: *#figure-def[Waves]*: see *Tonnai Thoraigh*
]

#pagebreak()<dances-start>

= #dance-def[Antrim Reel][
  @time:reel @shape:improper @level:everyone @source:arf @source:rne
], Cor Aontroma

A 64 bar reel, longways progressive for as many as will. Couple faces couple.

#bars[
  / 8: *Advance, Back and Turn partner.*
    / 2: Advance & turn back.
    / 2: Advance back to place and face partner.
    / 4: Right and Left $1/2$ turn.
      / 2: Change place with your partner by the Right.
      / 2: Back by the Left.

  / 16: *Sidestep and Heys.*
    / 4: Sidestep with partner (7s & 3s).
    / 2: Ladies, change places passing left shoulders (3s).
    / 2: Men, change places passing left shoulders (3s).
    / 8: Repeat to place.

  / 32: *Telescope and Star.*
    / 8: Telescope, heads lead, no crossover.
    / 8: Star Right & Left.
    / 8: Telescope, head man and second lady lead.
    / 8: Star Left & Right.

  / 8: *$1/2$ Around the House* to progress
]

== Caller's notes for Antrim Reel

#block(breakable: false, bars[
  / 8: *Advance, Back and Turn partner* (Right first).
  / 16: *Sidestep and Heys.*
  / 32: *Telescope and Star.*
  / 8: *$1/2$ Around the House* to progress.
])

#pagebreak()

= #dance-def[Barry Smiler's Birthday Jig][
  @time:jig @shape:improper @level:everyone @source:new @composer:terry
]

A 48 bar jig for couple facing couple, longways progressive for as many as will.
Composed 1980 by Terry O'Neal.

#bars[
  / 16: *Advance & Retire* and *Star* to place (Right first).
    / 4: Forward & Back.
    / 4: Right Hand Star to place.
    / 4: Forward & Back.
    / 4: Left Hand Star to place.

  / 8: *Irish Chain.* Keep opposite's Left hand for a

  / 8: *Reverse Swing.* Swing opposite in reverse in place.\
    (This is like a regular swing except that the dancers pull their Left
    shoulder back to swing in reverse.)

  / 8: *Around the House* with your partner. (Or swing in place if dancers are
    inexperienced.)

  / 8: *Slipsides* (as couples) to progress.
    / 2: All couples, holding inside hands, sidestep out to their own Right and
      forward.
    / 2: Set (Rise & Grind if you know it).
    / 2: All couples sidestep back to their own Left, finishing back-to-back
      with the couple they just danced with. Each couple finishes facing a new
      couple.
    / 2: Set (Rise & Grind if you know it).
]

== Caller's notes for Barry Smiler's Birthday Jig

#block(breakable: false, bars[
  / 16: *Advance & Retire* and *Star* to place (Right first).
  / 8: *Irish Chain.*
  / 8: *Reverse Swing opposite.*
  / 8: *Around the House.*
  / 8: *Slipsides* to progress.
])

#pagebreak()

= #dance-def[Berkeley Set (or Polka Set)][
  @shape:8-hand @source:new @composer:terry
]

Polkas and reels; 8-hand square sets, composed by Terry O'Neal.

#bars[
  / 16: Opening: *Lead Around & Back.*
  / 16: Body: *Polka.*
    / 1: All polka in to the center.
    / 1: All polka out to place.
    / 2: All polka around to the next position to the Right.
    / 12: Repeat 3 more times to place.
  / ??: *Any figure you know.*
  / 16: *Polka.*
  / ??: *Any figure you know.*
  / 16: *Polka.*\
    etc.
  / 16: *Polka.*
  / 16: Closing: *Lead Around & Back.*
]

These figures are popular:

== Figures for 4-hands

The order is:
- Heads (They have their backs or faces to the music),
- Sides,
- 1st corners (each head man and his corner),
- 2nd corners (each side man and his corner),
- Heads and 1st sides (heads turn Right, sides turn Left),
- Heads and 2nd sides (heads turn Left, sides turn Right),
- Men then Ladies or
- Ladies then Men.

Be sensible; some of these combinations don't work for some figures or some
dancers.

- *Circle, Star.* Alternate direction or hand.
- *Star-Pull Through.* Right hand first always.
- *Irish Chain, Scots Chain.* Alternate.
- *Men's Chain, Ladies' Chain.*
- *Hey for 4.* Start by men passing Left shoulder in the center; Ladies casting
  right into their partner's place.
- *Telescope-Star.* Right hand first always.
- *Quick Square*.
- *Angle-Saxon Hey.* (Not on the corners!)
- *Telescope.*
- *Irish Square.*
- *Men Go Back-to-Back.* Followed by an *Around the House.*
- *Celtic Cross.*

== Figures for 8-hands

- *Couple Slipsides* as in the High Caul Cap or the Morris Reel.
- *Ladies'* and then *Men's Interlace* as in the High Caul Cap.
- *Circular Sheepskin Hey:* 1st man cast and weave the set, followed by each
  dancer he has weaved in turn. Each dancer starts by casting Left and behind
  the dancer on their Right. Then he/she dances into the center when it's next
  possible and out of the set through the next hole; etc to place. Try 2 bars
  per start and move fast, or 4 bars per start and move easily.
- *Return Chain.*
- *Thread the Needle* as in the Sweets of May.
- *The Rose* as in the Bonfire Dance.

== Some "Grand" figures

- *Grand Celtic Cross* (Celtic Crash):
  #bars[
    / 1: All men pass right shoulders in the center.
    / 1: Turn Right, and dance out to the place of the next lady on their Right.
      Meanwhile the ladies cast Right into their partner's place.
    / 14: Repeat, alternating men and women through the center. Ladies dash for
      place at the end.
  ]
- *Grand Ladies' Chain.*
- *Grand Heys for 4:*
  #bars[
    / 8: Ladies $1/2$ Right-Hand Star. Ladies full Left Hand Star back to face
      opposite and give him your Right shoulder.
    / 8: All Hey at once, all passing Left shoulders in the center at once.
  ]
- *Grand Scots-Irish Chain:* Heads do Scots; Sides do Irish. Other way back!
- *Grand Quick Square:* Heads start it in reverse, sides do a regular quick
  square. Dance small on the sides and _big_ across the center. Other way back!\
  The faint of heart do a Grand Irish square followed by a Grand Quick Square
  back.

#pagebreak()

= The #dance-def[Bonfire Dance][
  @time:reel @shape:circle @level:everyone @source:arf @source:rne
], Rince Mór na Tine

A $2 3/4 times 32$ bar reel for as many couples as will in a circle.

#bars[
  / 32: *Advance, Retire,* and *Circle.*
    / 8: Advance & Retire once.
    / 8: Ring Right and Left.
    / 8: Advance & Retire once.
    / 8: Ring Left and Right. Face partner at end.

  / 16: *Sidestep* and *Uillinn in Uillinn.*
    / 4: Sidestep: Ladies in and men out and return (7s).
    / 4: Uillinn in Uillinn: $1/2$ turn partner by Right, back by Left.
    / 8: Repeat, but men in and turn by Left first. Finish facing center.

  / 32: *The Rose.*
    / 4: Ladies, no hands, advance slowly toward the center.
    / 2: Ring Right.
    / 2: Turn around to face out.
    / 4: Ring Right and Set.
    / 4: Turn partner by Right to place.
    / 16: Men Repeat.

  / 8: *Swing and Change partners.*
    / 4: Swing partner 2 hands in place $1 1/2$ to change places.
    / 1: Bow to partner.
    / 1: Turn around to face new partner.
    / 1: Bow to new partner.
    / 1: Face center.
]

Repeat whole dance as desired.

== Caller's notes for The Bonfire Dance

#block(breakable: false, bars[
  / 32: *Advance, Retire,* and *Circle* (Right first).
  / 16: *Sidestep* and *Uillinn in Uillinn* (Right first).
  / 32: *The Rose.*
  / 8: *Swing and Change partners.*
])

#pagebreak()

= #dance-def[Carin's Hornpipe][
  @time:hornpipe @shape:improper @source:new @composer:terry
], Cornphiopa na Cárinne

Longways progressive for as many as will, couple facing couple up & down the
hall.\
Composed November 1988 for Karin Coulon by Terry O'Neal.

Steps: Hopbacks & Rocks as in "Siamsa Bierta" and either a plain schottish step
or an elaborate hornpipe step to move on. One simple schottishe step is:
Step-step-step-hop etc. (Count it as "1,2,3,4"). The elaborate Hornpipe step
"tips" into the steps of the schottishe step, e.g.,
tap-step-tap-step---tap-step-hop. (Count it as "&1,&2,&3,4"). Trebles and other
ornaments can be added ad libitim. If the dancers fall behind the music, replace
the hopbacks & rocks with the moving step done in place.

#bars[
  / 8: *Advance & Retire.*
    / 4: Advance for 2 moving steps and retire for 2.
    / 2: Advance for 1 moving step and retire for 1.
    / 2: Hopbacks & rocks in place facing your opposite.

  / 8: *Right Hands Across* (with hopbacks).
    / 6: Right Hand Star twice around.
    / 2: Hopbacks & Rocks in place facing your partner.

  / 8: *Convoluted Ladies' Chain.*
    / 1: Turn your partner quickly by the Right elbow.
    / 1: Ladies turn Left elbows in the center.
    / 1: Turn your opposite quickly by the Right elbow.
    / 1: Ladies turn Left elbows in the center.
    / 2: Turn your partner quickly by the Right elbow to place.
    / 2: Hopbacks & Rocks in place facing your opposite.

  / 8: *$1/2$ Around the House* to progress.
    / 6: $1/2$ Around the House to progress.
    / 2: Hopbacks & Rocks in place facing the next couple ready to start again.
]

== Caller's notes for Carin's Hornpipe

#block(breakable: false, bars[
  / 8: *Advance & Retire.*
  / 8: *Right Hand Star* (Twice round, end with Hopbacks to place).
  / 8: *Convoluted Ladies' Chain.*
  / 8: *$1/2$ Around the House* to progress.
])

#pagebreak()

= The #dance-def[Castle Bridge Reel][
  @time:reel @shape:4-hand @source:hid
]

A $7 times 32$ bar 4-hand reel (2 couples facing).

#bars[
  / 24: Opening: *Lead Around, Advance & Retire,* and *Pass Through.*
    / 8: Lead Around once to place.
    / 16: Advance, Retire, and Change Places:
      / 4: Advance & Retire.
      / 2: Advance.
      / 2: 1s dance between 2s; all finish in opposite's place facing the other
        couple.
      / 8: Repeat to home place, 2s between 1s.

  / 24: Body: *Lead Around* and *Irish Square.*
    / 8: Lead Around once to place.
    / 16: Irish Square.

  / 24: 1st Figure: *Advance & Retire* and *Swing.*
    / 4: Advance & Retire.
    / 4: $1/2$ Around the House with partner to the other side of the dance.
    / 8: Advance & Retire then $1/2$ Around the House with opposite to place.
    / 8: Advance & Retire then Swing partner in place.

  / 24: Body: *Lead Around* and *Irish Square.*

  / 24: 2nd Figure: *Ones Track.*
    / 2: 1st lady dance through 2s and turn around to the Left (2s dance forward
      a little).
    / 4: 1st lady dance 7s Left and then Right. Meanwhile, all others circle
      Left and then Right quickly and without setting.
    / 2: 1st lady dance home through the 2s.
    / 8: Repeat, but 1st man goes through the 2s, turns Right, and circles Right
      first.
    / 8: Around the House.

  / 24: Body: *Lead Around* and *Irish Square.*

  / 24: 3rd Figure: *Twos Track.* Repeat 2nd figure but the 2s lead.

  / 24: Body: *Lead Around* and *Irish Square.*

  / 32: Closing: *Bend the Ring, Irish Chain, Around the House,* and *Lead
    Around.*
    / 8: Bend the Ring (Forward & Back twice).
    / 8: Irish Chain.
    / 8: Around the House.
    / 8: Lead Around.
]

== Caller's notes for The Castle Bridge Reel

#block(breakable: false, bars[
  / 24: Opening: *Lead Around* and *Advance & Retire,* and *Pass Through.*
  / 24: Body: *Lead Around* and *Irish Square.*
  / 24: 1st Figure: *Advance & Retire* and *Swing.*
  / 24: Body: *Lead Around* and *Irish Square.*
  / 24: 2nd Figure: *Ones Track.*
  / 24: Body: *Lead Around* and *Irish Square.*
  / 24: 3rd Figure: *Twos Track.*
  / 24: Body: *Lead Around* and *Irish Square.*
  / 32: Closing: *Bend the Ring, Irish Chain, Around the House,* and *Lead
    Around.*
])

#pagebreak()

= #dance-def[Dashing White Sergeant][
  @time:reel @shape:trios @level:everyone @source:other
]

A 32 bar reel for trio facing trio longways progressive.

#bars[
  / 8: Each set of 6 *Ring Right & Left.*

  / 8: *Middles' solo.*
    / 2: Middles turn and set to the dancer on your Right.
    / 2: Middles turn that dancer by the Right.
    / 2: Middles set to the dancer on your Left.
    / 2: Middles turn that dancer by the Left into:

  / 8: *Hey for 3.*\
    Middles give Right shoulder to the dancer on your Right. (Outside dancers
    cast out to start.)

  / 8: *Advance & Retire, Advance & Pass Through* and face the next trio to
    progress.
]

== Caller's notes for Dashing White Sergeant

#block(breakable: false, bars[
  / 8: *Ring Right & Left.*
  / 8: *Middles' solo.*
  / 8: *Hey for 3.*
  / 8: *Advance, Retire,* and *Pass Through.*
])

#pagebreak()

= #dance-def[Dennis Murphy's Reel][
  @time:reel @shape:improper @level:everyone @source:new @composer:terry
]

A 40 bar reel for couple facing couple longways progressive.\
Composed by Terry O'Neal for Dennis Murphy.

#bars[
  / 8: *Advance & Retire* twice.

  / 16: *Irish Square.*

  / 8: *Telescope.*

  / 8: *Circle Left and Turn Partner.*
    / 4: Circle Left & Set (progression).
    / 4: Turn Partner by the Right to face a new couple. (Face original
      direction).
]

#pagebreak()

= The #dance-def[Duke Reel][
  @time:reel @shape:6-hand @shape:circle @level:everyone @source:other
  @source:arf @source:rne
], Cor an Diúic

A round dance for 3 or 4 couples; 104, 120, or 48 bar reel.

#bars[
  / 8: *Ring Right & Left.*

  / 16: *Slipsides.*
    / 8: Slipsides with partner.
    / 8: Slipsides with corner.

  / 8: *Link Arms (Uillinn in Uillinn).*
    / 2: Link Right arms with partner and turn about.
    / 2: Link Left arms with corner and turn about.
    / 4: Repeat, end face partner.

  / 8: *First Interlace.*\
    Grand Chain but without hands. End up facing partner. (Can make it a mixer
    by passing partner last time if there are 3 couples.)

  / 48: *Second Interlace.*\
    First couple dance with the couple on their Left, then they with the couple
    on their left etc. around the the ring.
    / 8: Lady does the *Lady's Interlace* as in the *4-Hand Reel* while the Man
      mirrors her.
    / 4: All 4 *Circle Right* and set.
    / 4: All 4 *Around the House* home, hands not crossed.

  / 8: *Advance & Retire* in the circle twice.

  / 8: *Around the House.*
]

Another version:

#bars[
  / 8: *Ring Right & Left.*
  / 16: *Turn* and *Link Arms.*
    / 8: Turn Corner then Partner both hands.
    / 8: Link Right arms with corner then Left with partner.
  / 8: *First Interlace* (as above).
  / 8: *Advance & Retire* in the circle twice.
  / 8: *Around the House.*
]

#pagebreak()

= The #dance-def[Eight-Hand Jig][
  @time:jig @shape:8-hand @source:arf
], Port Ochtair

An $11 1/4 times 32$ bar jig for a square set of 4 couples.

(First make people aware of their partner, corner, centra-corner, and opposite).

#bars[
  / 16: Opening: *Lead Around & Back.*

  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Around
    the House.*
    / 8: Slipsides:
      / 2: Slipsides with partner to reform set on diagonals with contra
        corners.
      / 2: Rise & Grind.
      / 4: Repeat to place.
    / 16: Skip Across.
    / 16: Swing Into Line. (1,4,3,2).
    / 8: Set All Around.
    / 8: Around the House:\
      Heads and the sides on their Right swing around each other.

  / 32: 1st Figure: *Advance & Retire* and *Around the House.*\
    First heads, then sides.

  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Around
    the House.*

  / 64: 2nd Figure: *Scots' Chain, Men's Chain, Fancy Men's Chain, Around the
    House.*\
    Heads then Sides.
    / 8: Scots' Chain.
    / 8: Men's Chain.
    / 8: Fancy Men's Chain.
      / 3: Men turn $1 1/2$ in center by the Right hand.
      / 3: Men turn opposite lady by the Left hand.
      / 2: Men dance straight to place.
    / 8: Around the House.

  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Around
    the House.*

  / 32: 3rd Figure: *Arches.*
    / 2: Heads turn once around (crossed hands) to center, leading heads make an
      arch with their Right hands.
    / 2: Bottom lady through the arch quickly, meanwhile leading heads turn
      $1/2$.
    / 2: Bottom man through the arch.
    / 2: All turn partner both hands to contrary places.
    / 8: Repeat to original places; bottoms make the arches.
    / 16: Sides repeat. The leading sides are the couple to the Right of leading
      heads.

  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Around
    the House.*

  / 40: Closing:
    / 32: *Bend the Ring & Circle.*
    / 8: *Lead Around* to place.
]

== Caller's notes for The Eight-hand Jig

#block(breakable: false, bars[
  / 16: Opening: *Lead Around & Back.*
  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Around
    the House.*
  / 32: 1st Figure: *Advance & Retire* and *Around the House.*
  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Around
    the House.*
  / 64: 2nd Figure: *Scots' Chain, Men's Chain, Fancy Men's Chain, Around the
    House.*
  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Around
    the House.*
  / 32: 3rd Figure: *Arches.*
  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Around
    the House.*
  / 40: Closing: *Bend the Ring & Circle, Lead Around* to place.
])

#pagebreak()

= The #dance-def[Eight-Hand Reel][
  @time:reel @shape:8-hand @source:arf @source:rne
], Cor Ochtair

An $11 1/4 times 32$ bar reel for a square set of 4 couples.

(First make people aware of their partner, corner, contra-corner, and opposite.)

#bars[
  / 16: Opening: *Lead Around & Back.*

  / 80: Body: *Slipsides, Chain Home, Side Across, Return Chain, Men Go Back to
    Back, Around the House.*
    / 8: Slipsides to change places with your partner and the next dancer (your
      contra corner). Finish a quarter of the way around the set, (men have
      moved Right, ladies Left).
    / 8: Chain home:
      / 2: Men turn the lady on your Right (your opposite) and face back home.
      / 4: Chain home.
      / 2: Turn partner in place.
    / 32: Side Across: 7s & 3s.
      / 4: Head men face Right and change places with a sidestep. Pass face to
        face. Set. (You are now next to your opposite.)
      / 4: Side men the same.
      / 8: Men turn the lady on your Right (who is your original opposite)
        $1 1/2$ by the Right and then your original corner by the Left. Men
        finish one place Left of home. Ladies need to anchor themselves at home.
      / 16: Repeat but turn the lady on your Right once by the Left hand then
        turn your partner to by the Right to finish (she is in the other
        direction around the set).
    / 16: Return Chain: Give _LEFT_ hand to your contra corner to start.
    / 8: Men Go Back to Back: Heads with sides on their Right.
    / 8: Around the House with the couple _not_ danced with.

  / 32: 1st Figure: *Advance & Retire* twice and *Around the House.*\
    First heads, then sides.

  / 80: Body: *Slipsides, Chain Home, Side Across, Return Chain, Men Go Back to
    Back, Around the House.*

  / 32: 2nd Figure: *Ladies' Chain* and *Around the House.*\
    Heads, then sides.

  / 80: Body: *Slipsides, Chain Home, Side Across, Return Chain, Men Go Back to
    Back, Around the House.*

  / 40: Closing:
    / 32: *Bend the Ring & Circle.*
    / 8: *Lead Around* to place.
]

== Caller's notes for The Eight-Hand Reel

#block(breakable: false, bars[
  / 16: Opening: *Lead Around & Back.*
  / 80: Body: *Slipsides, Chain Home, Side Across, Return Chain, Men Go Back to
    Back, Around the House.*
  / 32: 1st Figure: *Advance & Retire* and *Around the House.*
  / 80: Body: *Slipsides, Chain Home, Side Across, Return Chain, Men Go Back to
    Back, Around the House.*
  / 32: 2nd Figure: *Ladies Chain, Around the House.*
  / 80: Body: *Slipsides, Chain Home, Side Across, Return Chain, Men Go Back to
    Back, Around the House.*
  / 40: Closing: *Bend the Ring & Circle, Lead Around* to place.
])

#pagebreak()

= The #dance-def[Fairy Reel][
  @time:reel @shape:trios @level:everyone @source:arf @source:ifd @source:rne
], Cor na Síóg

A $3 times 32$ bar reel for trio facing too longways progressive for as many as
will.

#bars[
  / 32: *Advance, Retire & Ring* all twice.
    / 8: Advance & Retire twice; take hands in a circle the 2nd time.
    / 8: Ring Right, Set, Ring Left, Retire into lines, setting.
    / 16: Repeat, but Ring Left first.

  / 16: *Slipsides.*
    / 4: Middles face person on their right, take their Right hand, and sidestep
      to Middle's Left across the set, while the person on the middle's Left
      sidesteps Right. (Dance on your own side!) Set.
    / 4: Repeat back to place.
    / 8: Repeat with other partner, other directions.

  / 16: *Uillinn in Uillinn.*
    / 8: Middles turn by Right elbows in center and back by the Left.
    / 8: Middles turn Right-hand partner by the Right elbow, then their
      Left-hand partner by the Left, and then their Right-hand partner by the
      Right.

  / 16: *Squares & Diamonds.*\
    Middles dance a Diamond, starting Right, while the outside people dance an
    Irish Square (starting on their own side as usual).

  / 8: *Arches.*
    / 2: Each middle takes both partners' nearer hand. Middle raises the Right
      hand and guides the Left-hand partner around and under the arch. Middle
      follows under the arch.
    / 2: Repeat, Left hand up, other partner under arch.
    / 2: Repeat first arch.
    / 2: Fall back into place.

  / 8: *Advance, Retire* and *Pass Through.*
    / 4: Advance & Retire.
    / 4: Advance & Pass Through and face the next trio.
]

== Caller's notes for The Fairy Reel

#block(breakable: false, bars[
  / 32: *Advance, Retire* and *Ring* all twice.
  / 16: *Slipsides.*
  / 16: *Uillinn in Uillinn.*
  / 16: *Squares & Diamonds.*
  / 8: *Arches.*
  / 8: *Advance, Retire* and *Pass Through.*
])

#pagebreak()

= The #dance-def[Five-Hand Reel][
  @time:reel @shape:other @source:new
]

An $8 1/4 times 32$ bar reel for two men facing three women composed by Erica
Lynn Frank, 1995.

#bars[
  / 8: *Advance & Turn Back,* with *Arches.*
    / 4: Forward; ladies make arches while men go under; all turn back by Right;
      lines end facing each other.
    / 4: Repeat.

  / 24: *Circle & Swing.*
    / 8: 1st trio (Left man, Right & middle ladies) Circle Right and Left; other
      couple swings in place (long swing).
    / 8: 2nd trio (Right man, Left & middle ladies) repeat; other couple swings
      in place.
    / 8: 3rd trio (Middle lady & both men) repeat; other ladies Slipsides.

  / 24: *Men's Chain, Around the House.*
    / 4: Men turn lady on their Left by Right hand and return home.
    / 4: Men turn lady on their Right by Left hand and return home.
    / 8: 1st trio & other couple Around the House.
    / 8: 2nd trio & other couple Around the House.

  / 24: *Heys for 3.*
    / 8: 1st trio: Middle lady gives Left shoulder to Left man to start a Hey on
      one side of the dance; other couple Slipsides.
    / 8: 2nd trio: Middle lady gives Right shoulder to Right man to start a Hey
      on other side of the dance; other couple Slipsides.
    / 8: 3rd trio: Middle lady goes between both men and turns Right to start
      the Hey; other ladies Uillinn in Uillinn by Right, back by Left.

  / 8: *Switch* and *Advance & Retire.*
    / 2: Middle lady & Right lady $1/2$ turn by Right. Men Uillinn in Uillinn by
      Right.
    / 2: Right lady & Left lady $1/2$ turn by Right. Men Uillinn in Uillinn back
      by Left. Ladies are in new positions.
    / 4: All Advance & Retire.

  / 176: *Repeat whole dance twice more.*
]

== Caller's notes for The Five-Hand Reel

#block(breakable: false, bars[
  / 8: *Advance & Turn Back,* with *Arches.*
  / 24: *Circle & Swing.*
  / 24: *Men's Chain, Around the House.*
  / 24: *Heys for 3.*
  / 8: *Switch* and *Advance & Retire.*
  / 176: *Repeat whole dance twice more.*
])

#pagebreak()

= The #dance-def[Four-Hand Reel][
  @time:reel @shape:4-hand @source:arf @source:hid
] (Kerry Half Set)

An $8 times 32$ bar 4-hand reel (2 couples facing).

#bars[
  / 16: Opening: *Lead Around & Back.*

  / 48: Body: *Irish Square, Quick 7s, Stars, Telescope, Scots' Chain.*
    / 16: Irish Square.
    / 8: Quick 7s with partner:
      / 2: Sidestep, changing places with your partner.
      / 2: Sidestep, changing places with your partner to place.
      / 4: Repeat.
    / 8: Star Right & Left home.
    / 8: Telescope with crossover ($1/2$ turn by the Right).
    / 8: Scots' Chain.

  / 64: 1st Figure: *Ladies' Interlaces.*
    / 32: 1st Lady's Interlace:
      / 8: 1st lady dances between the 2s, around 2nd lady, between the 2s
        again, around 2nd man and collect her partner and 2nd lady into a
        circle.\
        A Starry Plough variant: the 1st man does a mirror image of the 1st
        lady's track at the same time.
      / 16: Rings & Arches:
        / 8: 1st couple and 2nd lady circle Right, set, and circle Left. While
          setting, 2nd lady is guided under arch to 1st lady's place.\
          Meanwhile 2nd man sides Right and then Left on his own side of the
          set.
        / 8: 1st couple and 2nd man circle Left, set, and circle Right. While
          setting, 2nd man is guided under arch to 1st man's place.\
          Meanwhile 2nd lady sides Left and then Right on her own side of the
          set.
      / 8: $1/2$ Around the House to place.
    / 32: 2nd Lady's Interlace. 2nd lady leads and does as 1st lady did.

  / 48: Body: *Irish Square, Quick 7s, Stars, Telescope, Scots' Chain.*

  / 16: 2nd Figure:
    / 8: *Ladies' Chain.*
    / 8: *Around the House* to place.

  / 48: Body: *Irish Square, Quick 7s, Stars, Telescope, Scots' Chain.*

  / 16: Closing: *Lead Around & Back.*
]

== Caller's notes for The Four-Hand Reel

#block(breakable: false, bars[
  / 16: Opening: *Lead Around & Back.*
  / 48: Body: *Irish Square, Quick 7s, Stars, Telescope, Scots' Chain.*
  / 64: 1st Figure: *Ladies' Interlaces.*
  / 48: Body: *Irish Square, Quick 7s, Stars, Telescope, Scots' Chain.*
  / 16: 2nd Figure: *Ladies' Chain.*
  / 48: Body: *Irish Square, Quick 7s, Stars, Telescope, Scots' Chain.*
  / 16: Closing: *Lead Around & Back.*
])

#pagebreak()

= #dance-def[Frazier's Fool Jig][
  @time:jig @shape:improper @source:new @composer:terry
]

A 48 bar jig for couple facing couple, longways progressive.\
Composed 1 April 1981 by Terry O'Neal for Frazier Worth.

#bars[
  / 16: *Whirlygig.*
    / 4: Holding inside hands, 1s pass between the 2s and turn them with their
      free hands. All dance home.
    / 4: 1st man and 2nd lady take near hands and dance between 2nd man and 1st
      lady. Turn them with free hands and all dance home.
    / 8: Repeat, 2nd man leading.

  / 8: *Telescope & $1/2$ Turn* with your partner by the Right hand.

  / 8: *Irish Chain* into a

  / 8: *Double Irish Hey.*
    / 2: Ladies come out of the chain facing out of the set and cast Left, while
      the men trade places passing Left shoulders.
    / 2: Ladies trade places passing Right shoulders while the men cast Right.
    / 2: Ladies cast Left while the men cross to place passing Left shoulders.
    / 2: Ladies trade places passing Right shoulders and loop Right while the
      men loop Left.
    Men dance on the men's diagonal and the ladies dance on the ladies'
    diagonal.

  / 8: *Around the House (Swing & Change)* $1/2$ or $1 1/2$ to face a new
    couple. Both couples need to do the same.
]

== Caller's notes for Frazier's Fool Jig

#block(breakable: false, bars[
  / 16: *Whirlygig.*
  / 8: *Telescope.*
  / 8: *Irish Chain.*
  / 8: *Double Irish Hey.*
  / 8: *Around the House (Swing & Change)* to progress.
])

#pagebreak()

= The #dance-def[Galway Reel][
  @time:reel @shape:other @source:rne
], Cor na Gaillimhe (The 3-Hand Reel)

A $1 3/4 times 32$ bar reel for 3 people side by side in a line.\
Traditional version

#bars[
  / 8: *Advance & Turn Back.*
    / 2: Forward.
    / 2: Each turns back by moving around to the Right in a small individual
      circle.
    / 4: Repeat to place.

  / 8: All *Slipside* together to the Right and back to the Left.

  / 8: *Arches.*
    / 2: Outer 2 face and change places by the Right hand and then make an arch.
    / 2: Middle passes under the arch and turns around to the Right.
    / 4: Repeat to place.

  / 8: *Hey for 3.*\
    Middle start forward and Right, the outer 2 turn out and back. (The middle
    person has now turned around \~200°.

  / 16: *Circles & Arches.*
    / 2: Circle Right.
    / 2: Middle raise Right arm and lead the person on the Left under.
    / 2: Reform and Circle Left.
    / 2: Middle raise Right arm and lead the person on the Left under.
    / 2: Reform and Circle Right.
    / 2: Outer 2 make an arch and the Middle go under.
    / 2: Reform and Circle Left.
    / 2: Reform the Line, (the outer 2 are switched).

  (Repeat whole dance as desired)

  / 8: *Advance & Turn Back* to end the dance.
]

== Caller's notes for The Galway Reel

#block(breakable: false, bars[
  / 8: *Advance & Turn Back.*
  / 8: *Slipsides.*
  / 8: *Arches.*
  / 8: *Hey for 3.*
  / 16: *Circles & Arches.*
  / 8: *Advance & Turn Back.*

  (Repeat the whole dance as desired)
])

#pagebreak()

= The #dance-def[Galway Reel for 6][
  @time:reel @shape:6-hand @source:new @composer:terry
]

A $1 3/4 times 32$ bar reel for 6 people side by side in a line.\
Conceived by Trish ni Gobhan, worked out by Terry O'Neal. 2 trios in one line.

#bars[
  / 8: *Advance & Turn Back.*

  / 8: Trios as trios switch places and back with *Slipsides.*

  / 8: *Arches* within the trios.

  / 8: *Hey for 6.*\
    The Ends face in, the Middles of each trio face out turning Right, and the
    Middles of the whole set turn Right to pass each other's Right shoulder to
    start the Hey. The set ends up mirrored.

  / 16: *Circles & Arches* in trios.

  / 8: *Advance & Turn Back* to end the dance.
]

#pagebreak()

= The #dance-def[Galway Reel (Progressive)][
  @time:reel @shape:trios @source:new @composer:terry
]

A $2 times 32$ bar reel for trio facing trio longways progressive.\
Redevised by Terry O'Neal

#bars[
  / 8: *Advance & Turn Back.*
    / 4: Advance, Pass Through and Turn Back.
    / 4: Repeat to place.

  / 8: *All 6 Circle* Left and back to the Right.

  / 8: *Arches:* As in the traditional dance except that after the middles pass
    under the arch they dance around each other by the Right shoulder. (If
    convenient, they may dance through the opposite arch too.)

  / 16: *Heys for 3.*
    / 8: Hey for 3 on your own side.
    / 8: Hey for 3 across the set.\
      Middles out to their Right, ends turn out and around to start. Middles
      give a Left shoulder to their 1st corner. Their partner on their Right
      follows them in the hey.
  / 16: *Circles & Arches* in trios.
  / 8: *Advance & Retire, Advance & Pass Through* (progression).
]

== Caller's notes for The Galway Reel (Progressive)

#block(breakable: false, bars[
  / 8: *Advance & Turn Back.*
  / 8: *Circle.*
  / 8: *Arches.*
  / 16: *Heys for 3.*
  / 16: *Circles & Arches.*
  / 8: *Advance & Retire, Advance & Pass Through* (progression).
])

#pagebreak()

= The #dance-def[Glenbeigh Jig][
  @time:jig @shape:8-hand @source:other
], Port Glannbheithe

A $12 1/2 times 32$ bar Jig for a square 8 hand set.

#bars[
  / 16: Opening: *Lead Around & Back.*

  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Double
    Irish Hey.*
    / 8: Slipsides:
      / 2: Slipsides with partner to reform set on diagonals.
      / 2: Men Rise & Grind, ladies Shuffle.
      / 4: Repeat to place, men Shuffle, ladies Rise & Grind.
    / 16: Skip Across.
    / 16: Swing Into Line. (1,4,3,2).
    / 8: Set All Around.
    / 8: Double Irish Hey (2 separate but crossing Heys for four).
      / 2: Head men with the side men on their Right change places passing Left
        shoulders while the ladies cast to the Right out of the set and back
        into their places.
      / 2: Head ladies with the side ladies on their Right change places passing
        Left shoulders while the men cast to the Right out of the set and back
        into the other men's places.
      / 2: Men return to place passing Left shoulders while the ladies cast to
        the Right out of the set and back into the other ladies' place.
      / 2: Ladies return to place passing Right shoulder and face partner while
        the men turn Left to face partner.

  / 64: 1st Figure: *Turn & Cross.* 1st then 2nd, 3rd & 4th couples.
    / 8: Turn & Cross:
      / 2: Active Couple turns by the LEFT in place.
      / 2: Active Couple crosses and dances behind their opposites. Opposites
        move forward.
      / 4: Active Couple turns by the Left behind their opposite couple and
        faces home.
    / 8: Cross & Turn:
      / 4: Active Couple dances into the middle of the set and crosses to place.
      / 4: Active Couple turns by the Left in place while the next active couple
        joins the turning. All couples join the turn at the very end.

  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Double
    Irish Hey.*

  / 48: 2nd Figure: *Men's Chains.* Couples 1 & 2 then couples 3 & 4.
    / 8: Men's Chain (plain).
    / 8: Fancy Men's Chain
      / 3: Men turn $1 1/2$ in center by the Right hand.
      / 3: Men turn opposite lady by the Left hand.
      / 2: Men dance straight to place.
    / 8: Active couples Around the House.

  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Double
    Irish Hey.*

  / 16: 3rd Figure: *Grand Ladies' Chain, Grand Around the House.*

  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Double
    Irish Hey.*

  / 32: Closing: *Bend the Ring & Circle.*
]

== Caller's notes for The Glenbeigh Jig

#block(breakable: false, bars[
  / 16: Opening: *Lead Around & back.*
  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Double
    Irish Hey.*
  / 64: 1st Figure: *Turn & Cross.*
  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Double
    Irish Hey.*
  / 48: 2nd Figure: *Men's chain, Fancy Men's Chain, Around the House.*
  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Double
    Irish Hey.*
  / 16: 3rd Figure: *Grand Ladies Chain, Grand Around the House.*
  / 56: Body: *Slipsides, Skip Across, Swing Into Line, Set All Around, Double
    Irish Hey.*
  / 32: Closing: *Bend the Ring & Circle.*
])

#pagebreak()

= The #dance-def[Glencar Reel][
  @time:reel @shape:6-hand @source:arf @source:ifd
]

A $2 times 32$ bar reel for 3 couples longways ALL improper, i.e., 1st man's
Right shoulder is nearest the music.\
Do 3 times.

#bars[
  / 8: *Advance & Retire* twice.\
    Men take hands, ladies take hands.

  / 8: All *Ring* Left & then Right to place.

  / 8: *Slipsides.*\
    All turn $1/4$ Left (men down, ladies up) and change places with partner
    face to face. Return face to face.

  / 8: *Heys for 3.*\
    2s face up, 1s & 3s face 2s; (or Starry Plough way: remain facing up or
    down). Men and ladies Hey separately but parallel, 1st & 2nd couples cast
    right. 3rd couple casts Left.

  / 8: *Couples Hey for 3.*\
    Couples take crossed hands; 2nd & 3rd couples face up & 1st couple face
    down. 1st couple pass 2nd couple by the Right shoulder.

  / 8: *Waves.* (Dip & Dive)\
    Arch over at the top of the set.

  / 8: *Chain.* (Nonesuch Hey).\
    1st couple face partner; others face up. 1st couple start Grand Chain;
    others wait for 1st couple to arrive. _1 bar per hand!_

  / 8: *Swing Partner* in place.
]

== Caller's notes for The Glencar Reel

#block(breakable: false, bars[
  / 8: *Advance & Retire.*
  / 8: *Ring* Left & then Right.
  / 8: *Slipsides.*
  / 8: *Heys for 3.*
  / (8: Could do a hey across the dance here.)
  / 8: *Couples Hey for 3.*
  / 8: *Waves* (Dip & Dive), (over at the top).
  / 8: *Chain* (Nonesuch Hey).
  / 8: *Swing Partner* in place.
])

Another version of the dance was taught by Robert Reed.\
All are proper (1st man's Left shoulder is toward the Music).\
Do all the dance but don't swing partner in place, instead, start the dance
over.

#pagebreak()

= The #dance-def[Harvest Time Jig][
  @time:jig @shape:trios @level:everyone @source:arf @source:ifd @source:rne
]

A 64 bar jig, longways progressive, trio facing trio.

#bars[
  / 8: *Advance & Retire* twice.

  / 8: *Slipsides Right.*
    / 4: Each trio sidesteps together to its own Right and sets.
    / 4: Repeat Left, back to place.

  / 8: *Star Right* and *Left.*

  / 16: *Slipsides* and *Stars,* but both start Left.

  / 16: *Set to & Turn Partners.*\
    Centers face their Right hand partner.
    / 4: Both set twice (Sink & Grind) on the Right foot.
    / 4: Turn by the Right.
    / 8: Repeat with partner on the Left. Same foot, same hand. Those who are
      left out on the diagonals can Set to & Turn with each other also.

  / 8: *Advance & Retire, Advance & Pass Through.*\
    Pass by the Right shoulder. Each trio faces a new trio to start the dance
    again.
]

== Caller's notes for The Harvest Time Jig

#block(breakable: false, bars[
  / 8: *Advance & Retire.*
  / 16: *Slipsides Right-Left, Star Right-Left.*
  / 16: *Slipsides Left-Right, Star Left-Right.*
  / 16: *Set to & Turn Partners.*
  / 8: *Advance & Retire, Advance & Pass Through.*
])

#pagebreak()

= #dance-def[Haste to the Wedding][
  @time:jig @shape:proper @level:everyone @source:arf @source:rne
], Deifir na Bainise

40 bar jig, longways progressive. Duple minor proper (men face ladies); _even_
couples lead.

#bars[
  / 16: *Set* and *Star.*
    / 4: Rise & Grind twice (start Right, as usual).
    / 4: Star Right.
    / 8: Repeat but with the Left foot and hand.

  / 8: *Sidesteps.*
    / 4: Even couples take hands and Sidestep up the set to a point just between
      their odds. Odd couples wait.
    / 4: Even couples repeat back to place. Take lady of odd couple into a
      circle on last bar. Odd lady takes the Left hand of even man and the Right
      hand of the even lady.

  / 8: *Rings* and *Arches.* Done well below first couple.
    / 4: 1st ring:
      / 2: The 3 Ring Right. (The even man's partner is on his Right.)
      / 2: Evens make an arch and let the odd lady go to her original place.
    / 4: 2nd ring:
      / 2: Evens Ring Left with the odd man.
      / 2: Evens make an arch and let the odd man go to his original place.

  / 8: *$1/2$ Around the House* to progress.
]

== Caller's notes for Haste to the Wedding

#block(breakable: false, bars[
  / 16: *Set* and *Star* (Right then Left).
  / 8: *Sidesteps.*
  / 8: *Rings* and *Arches.*
  / 8: *$1/2$ Around the House* to progress.
])

#pagebreak()

= The #dance-def[Haymaker's Jig][
  @time:jig @shape:proper @level:everyone @source:arf
], Baint an Fhéir

6 (5--8) couples, proper, longways progressive, \~$18 times 32$ bars, double jig

#bars[
  / 24: *Forward, Back, Pass Through, Set.*
    / 4: Everybody go Forward & Back.
    / 4: Forward again and Pass Through passing Right shoulders.
    / 4: Set twice.
    / 4: Everybody go Forward & Back.
    / 4: Forward again and Pass Through.
    / 4: Set twice.

  / 16: *1st* and then *2nd corners turn Right* and then *Left.*
    / 4: 1st man and last lady turn by the Right elbow.
    / 4: 1st lady and last man turn by the Right elbow.
    / 4: 1st man and last lady turn by the Left elbow.
    / 4: 1st lady and last man turn by the Left elbow.

  / 16: *1st* and then *2nd corners swing.*
    / 8: 1st man and last lady swing (long swing).
    / 8: 1st lady and last man swing.

  / \~24: *1st couple Reel the Set* (look at your partner; give her your Right
    elbow).
    / 4: Turn your partner $1 1/2$ times around (elbow grip).
    / 20: Reel the Set:
      / 2: Then turn the next dancer of the opposite dancing gender by the Left
        elbow once around.
      / 2: Turn your partner once around by the Right elbow.
      / \~16: Etc. to the bottom of the set.

  / \~4: *1st Couple to the top.*\
    1st couple returns up the center to the top (swing or Promenade).

  / \~12: *Cast Off* and *Arch.*\
    1st couple, followed by everyone in line, casts off at the top each on their
    own side. 1st couple makes an arch at the bottom and every other couple goes
    under it. There is now a new top couple; the previous top couple is now at
    the bottom.

  Keep repeating the dance from progressed positions until everyone is in their
  original place.
]

== Caller's notes for The Haymaker's Jig

#block(breakable: false, bars[
  / 24: *Forward, Back, Pass Through, Set. Done twice*
  / 16: *1st* and then *2nd corners turn Right* and then *Left.*
  / 16: *1st* and then *2nd corners swing.*
  / \~24: *1st couple Reel the Set.*
  / \~16: *1st couple to top, Cast Off, Arch, all follow.*
])

#pagebreak()

= The #dance-def[High Caul Cap][
  @time:reel @shape:8-hand @source:arf @source:ifd
]

A $17 1/4 times 32$ Bar Reel for a square 8 hand set.

#bars[
  / 16: Opening: *Lead Around & Back.*

  / 80: Body: *Slipsides, Double Quarter Chain, Interlaces, Stamp & Clap.*
    / 16: Couples Slipsides: All the way around to place. Head couples go Right,
      side couples go Left.
    / 16: Double Quarter Chain:
      / 2: Turn partner by the Right hand.
      / 2: Turn corner by the Left hand.
      / 4: Turn partner by the Right hand $1 1/2$.
      / 4: Turn contra corner by the Left hand slowly.
      / 4: Turn partner by the Right hand $1 1/2$ to place.
    / 16: Ladies' Interlace.
    / 16: Men's Interlace.
    / 16: Stamp & Clap (Stamp, stamp, clap, clap, clap).
      / 4: Stamp & Clap twice with partner.
      / 4: Slipsides with partner, reforming the set on the corners.
      / 8: Repeat to place, but Stamp & Clap with contra corner.

  / 64: 1st Figure: *Slipsides into the center.*\
    1st then 2nd, 3rd and 4th couples.
    / 8: Couple Slipsides into the center and back.
      / 4: Active couple faces each other, take Right hands and sidestep into
        the center of the set. Set.
      / 4: Repeat back to place.
    / 4: Active couple turns by the Right once around, separate, go around their
      own corners and return home.
    / 4: Active couple turns once in place, meanwhile the next couple joins the
      turn. All join the turn the last time as the 4s turn.

  / 80: Body: *Slipsides, Double Quarter Chain, Interlaces, Stamp & Clap.*

  / 96: 2nd Figure: *MF* (most fun): 1st then 2nd, 3rd and 4th couples lead.
    / 2: Leading couple splits opposite couple and rolls around them (man around
      the lady, lady around the man). Quick!\
      Meanwhile the opposite couple separates, comes forward, comes together
      sideways and backs up. Quick!\
      Both couples dance forward just barely enough to pass. Any more slows down
      the figure too much.
    / 4: All 4 do a Right Hand Star once around (take partner's hand)
    / 2: and turn partner to home place.
    / 8: Men's Chain.
    / 8: Around the House.

  / 80: Body: *Slipsides, Double Quarter Chain, Interlaces, Stamp & Clap.*

  / 16: 3rd Figure: *Grand Ladies' Chain, Grand Around the House.*

  / 80: Body: *Slipsides, Double Quarter Chain, Interlaces, Stamp & Clap.*

  / 40: Closing: *Bend the Ring & Circle, Lead Around* to place.
]

== Caller's notes for The High Caul Cap

#block(breakable: false, bars[
  / 16: Opening: *Lead Around & Back.*
  / 80: Body: *Slipsides, Double Quarter Chain, Interlaces, Stamp & Clap.*
  / 64: 1st Figure: *Slipsides into the center.*
  / 80: Body: *Slipsides, Double Quarter Chain, Interlaces, Stamp & Clap.*
  / 96: 2nd Figure: *MF* (Most fun).
  / 80: Body: *Slipsides, Double Quarter Chain, Interlaces, Stamp & Clap.*
  / 16: 3rd Figure: *Grand Ladies' Chain, Grand Around the House.*
  / 80: Body: *Slipsides, Double Quarter Chain, Interlaces, Stamp & Clap.*
  / 40: Closing: *Bend the Ring & Circle, Lead Around to place.*
])

#pagebreak()

= The #dance-def[Humors of Bandon][
  @time:jig @shape:4-hand @source:ifd @source:rne
] (The Four Hand Jig), Plearaca Bandon

A $9 3/4 times 32$ bar jig for 2 couples.

#bars[
  / 16: Opening: *Lead Around & Back.*
  / 32: Body: *Slipsides* and *Crossover.*
    / 8: Slipsides with Partner: 7s, Rise & Grind. Repeat to place.
    / 2: $1/2$ turn partner.
    / 2: Cross to other side, ladies inside.
    / 4: Turn partner to place on the other side of the set.
    / 16: Repeat to place.

  / 64: 1st Figure: *Whirlygig, Men's Chain.*
    / 4: 1st couple takes inside hands and dances between the standing 2s.
    / 4: 1s turn back and dance between the 2s and take their outside hands and
      turn them once around and meet partner.
    / 4: While 2s continue to dance in a circle to turn around, 1s turn back
      again and take inside hands of 2s and turn them $3/4$ around and all dance
      home.
    / 4: All turn partner in place.
    / 8: Men's Chain.
    / 8: Around the House to place.
    / 32: Repeat, 2s lead.

  / 32: Body: *Slipsides* and *Crossover.*

  / 32: 2nd Figure: 7s Across the Center.
    / 2: 1st Man, 2nd Lady take Right hands and dance 7s across the center
      between and beyond their partners.
    / 2: They face back the way they came and Set (Rise & Grind).
    / 4: Turn partner (1st Man, 2nd Lady start inside with outside hand). All
      finish in partner's place.
    / 8: Repeat to place, same people, other direction.
    / 16: Repeat, 2nd Man, 1st Lady lead.

  / 32: Body: *Slipsides* and *Crossover.*

  / 16: 3rd Figure: *Ladies' Chain, Around the House.*

  / 32: Body: *Slipsides* and *Crossover.*

  / 16: Closing: *Lead Around & Back.*
]

== Caller's notes for The Humors of Bandon

#block(breakable: false, bars[
  / 16: Opening: *Lead Around & Back.*
  / 32: Body: *Slipsides* and *Crossover.*
  / 64: 1st Figure: *Whirlygig, Men's Chain, Around the House.*
  / 32: Body: *Slipsides* and *Crossover.*
  / 32: 2nd Figure: *7s Across the Center.*
  / 32: Body: *Slipsides* and *Crossover.*
  / 16: 3rd Figure: *Ladies' Chain, Around the House.*
  / 32: Body: *Slipsides* and *Crossover.*
  / 16: Closing: *Lead Around & Back.*
])

#pagebreak()

= The #dance-def[Iron Hand's Fancy][
  @time:reel @shape:4-hand @source:new @composer:terry
], Plearaca na Láinihe Iarann

A $3 times 32$ bar 4-hand reel composed in 1981 for Simon Spaulding by Terry
O'Neal.

#bars[
  / 32: Body: *Quick Square, Telescope-Star, Pull Through-Star, Slipside Partner
    & Turn Opposite.*
    / 8: Quick Square.
    / 4: 1st couple lead $1/2$ Telescope--$1/2$ Right Hand Star to partner's
      place.
    / 4: 2nd couple lead $1/2$ Telescope--$1/2$ Left Hand Star home.
    / 2: Keeping Left hands, all Pull Through to the diagonally opposite place
      into
    / 2: Right Hand Star home.
    / 4: Keeping Right hands, all Pull Through to the diagonally opposite place
      and Left Hand Star home.
    / 2: Slipsides with partner.
    / 2: Turn opposite $1/2$ by Right to change places.
    / 4: Repeat to place.

  / 32: Figure: *Heys for 4* on the diagonals and *Around the House.*
    / 8: Hey on the ladies' diagonal:
      / 2: Turn partner $2/3$ by Right,
      / 4: Ladies pass Left shoulder in the center, men loop Right through
        partner's place and follow the ladies in the Hey.
      / 2: Ladies complete the Hey to place, while men loop out to the other
        man's place.
    / 8: Men take the lady on their Right (their opposite) with crossed hands
      and Around the House with her until _both_ are at home; _keep_ her Right
      hand.
    / 8: Hey on the men's diagonal:\
      Men pull their opposites to the men's places and men pass Left shoulders
      to begin the Hey. Men complete the Hey while the ladies loop out to the
      other lady's place.
    / 8: Men take the lady across from you (your partner) with crossed hands and
      Around the House with her till _both_ are at home.

  / 32: Body: *Quick Square, Telescope-Star, Pull Through-Star, Slipside Partner
    & Turn Opposite.*
]

Bow to your friends, compliment the band, and kiss the composer.

== Caller's notes for The Iron Hand's Fancy

#block(breakable: false, bars[
  / 32: Body: *Quick Square, Telescope-Star, Pull Through-Star, Slipside Partner
    & Turn Opposite.*
  / 16: *Hey for 4* on ladies' diagonal, *Around the House* with opposite.
  / 16: *Hey for 4* on men's diagonal, *Around the House* with partner.
  / 32: Body: *Quick Square, Telescope-Star, Pull Through-Star, Slipside Partner
    & Turn Opposite.*
])

#pagebreak()

= #dance-def[Jocelyn Bronnwyn's Fancy][
  @time:reel @shape:4-hand @source:new @composer:terry
], Plearaca na Jocelyn Bronnwyn

A $6 times 32$ bar 4 Hand Reel composed April 1982 for Jocelyn Bronnwyn Reynolds
by Terry O'Neal.

#bars[
  / 8: Opening: *Forward & Kiss.*
    / 2: Advance to and kiss opposite. (Forward, Kiss)
    / 2: Retire to place and turn to face partner. (Back, Turn)
    / 2: Advance to and kiss partner. (Forward, Kiss)
    / 2: Retire to place and turn to face opposite. (Back, Turn)
    (Forward, kiss, back, turn, Forward, kiss, back, turn)

  / 48: Body: *Angle-Saxon Hey, Celtic Cross, Hey for 4, Irish Chain.*
    / 16: Angle-Saxon Hey.
    / 16: Celtic cross.
    / 8: Men pass LEFT shoulders and all Hey for 4 to place (this is on the
      ladies' diagonal).
    / 8: Irish Chain.

  / 16: 1st Figure: *Heys for 3.*
    / 8: Hey for 3: 1st man splits 1st lady & 2nd man and does Hey for 3 with
      them. 1st man gives 2nd man his Left shoulder, 2nd man casts Left and 1st
      lady casts Right to start the Hey.\
      Meanwhile 2nd lady does small solo: she faces the other dancers and dances
      7s & 3s to her Right and then back.
    / 8: Hey for 3: 1st lady splits 1st man & 2nd lady and does Hey for 3 with
      them. 1st lady gives 2nd lady her Right shoulder, 1st man casts Left and
      2nd lady casts Right to start the Hey.\
      Meanwhile 2nd man does small solo: he faces the other dancers and dances
      7s & 3s to his Left and then back.

  / 48: Body: *Angle-Saxon Hey, Celtic Cross, Hey for 4, Irish Chain.*

  / 16: 2nd Figure: *Telescope & Kiss.*
    / 4: 1st couple lead the telescope (7s) and kiss partner (2 × 3s). (Kiss on
      the 2nd 3).
    / 4: 2nd couple lead back (as usual). Kiss partner again and turn to your
      opposite.
    / 8: Repeat, 2nd man & 1st lady leading (kiss opposite twice).

  / 48: Body: *Angle-Saxon Hey, Celtic Cross, Hey for 4, Irish Chain.*

  / 8: Closing: *Circle & Kiss.*
    / 4: All circle Right _one_ place and kiss your opposite.
    / 4: All circle Left to place and kiss your partner.
]

Bow to your friends, compliment the band, and kiss the composer.

== Caller's notes for Jocelyn Bronnwyn's Fancy

#block(breakable: false, bars[
  / 8: Opening: *Forward & Kiss.*
  / 48: Body: *Angle-Saxon Hey, Celtic Cross, Hey for 4, Irish Chain.*
  / 16: 1st Figure: *Heys for 3.*
  / 48: Body: *Angle-Saxon Hey, Celtic Cross, Hey for 4, Irish Chain.*
  / 16: 2nd Figure: *Telescope & Kiss.*
  / 48: Body: *Angle-Saxon Hey, Celtic Cross, Hey for 4, Irish Chain.*
  / 8: Closing: *Circle & Kiss.*
])

#pagebreak()

= #dance-def[Jocelyn's Chutney][
  @time:jig @shape:4-hand @source:new @composer:terry
]

A $9 1/2 times 32$ bar 4 hand jig, composed in 1983 for Jocelyn Bronnwyn
Reynolds.

#bars[
  / 16: Opening: *$1/2$ Lead Around & $1/2$ Around the House* to place; repeat
    in reverse to home place.
    / 2: Lead Around $1/2$ way around the set; men pass Left shoulders in the
      center as usual.
    / 1: Drop hands.
    / 1: Turn to face your partner; all are now in a straight line up and down
      the set.
    / 4: $1/2$ Around the House home.
    / 8: Repeat above, but ladies pass Right shoulders in the center for a
      reverse $1/2$ Lead Around.\
      Both $1/2$ Around the Houses are _normal_: the Right shoulder pulls back.
      However, the $1/2$ Around the Houses continue in the direction began in
      the $1/2$ Lead Around.

  / 48: Body: *Men's Chain, Ladies' Chain, Around the House, $1/2$ Telescope
    with Rights & Lefts, Skip Across.*
    / 8: Men's Chain.
    / 8: Ladies' Chain (men keep dancing in a circle as the ladies chain over
      and back).
    / 8: Around the House, end facing partner.
    / 8: $1/2$ Telescope with Rights & Lefts home, 1st couple lead.
      / 2: $1/2$ Telescope with partner with Right hands joined, then
      / 6: Right & Lefts home starting with your partner's Right.
    / 8: Repeat, 2nd couple leads, same hands.
    / 8: Skip Across:
      / 2: All skip diagonally across the set passing Right shoulders
        simultaneously in the center.
      / 2: Men loop Right and turn partner $1/2$ by the Right on the opposite
        side of the set.
      / 4: $1/2$ Around the House with your partner to place.

  / 32: 1st Figure: *Slip Across the set with your opposite & turn.*
    / 2: 1st man & 2nd lady take _Right_ hands and Slipsides across the set (as
      in the Humors of Bandon) and then
    / 2: 1st man & 2nd lady turn once around by the Left elbow.
    / 4: Turn partner by the Right elbow, to your partner's place.
    / 8: Same people repeat back across the set but use the other hand each
      time.
    / 8: 2nd man & 1st lady repeat as above, same hands.

  / 48: Body: *Men's Chain, Ladies' Chain, Around the House, $1/2$ Telescope
    with Rights & Lefts, Skip Across.*

  / 32: 2nd Figure: *Slow Heys for 4.*
    / 16: Slow Hey for 4 on the ladies' diagonal.
      / 2: Turn partner \~$1/2$ by the Right hand, men end up in their partner's
        place facing their own home place and the ladies meet in the center
      / 2: taking Left hands and turning $1/2$ around to face the other man who
        is doing a Rise & Grind step in the lady's place.
      / 2: Ladies turn opposite man by the Right \~$1/2$ around,
      / 2: Men meet in the center and turn $1/2$ by the Left hand while the
        ladies Rise & Grind in the other ladies place facing the opposite man's
        place.
      / 6: Continue the Hey as above.
      / 2: Men touch Left hands and dance to home place; they face to the Right
        of their partner and offer her their Left hand.\
        They continue right into:
    / 16: Slow Hey for 4 on the men's diagonal. Repeat but with opposite hand
      and opposite gender.
      / 2: Turn partner \~$1/2$ by the Left hand, ladies end up facing their own
        home place and the men meet in the center.
      / 2: Men take Right hands and turn $1/2$ around to face the other lady who
        is doing a Rise & Grind step in the man's place.
      / 12: Continue till home.

  / 48: Body: *Men's Chain, Ladies' Chain, Around the House, $1/2$ Telescope
    with Rights & Lefts, Skip Across.*

  / 16: 3rd Figure: *Hey All 4* done twice:\
    Men, when taking a lady's hand, reach across their own body with their
    further (outside) hand to take the lady's nearer (inside) hand. This is done
    so that the men can assist the ladies to pass in front of them. Hands are
    taken as soon as possible but only when crossing.
    / 2: 1s cross down the center while the 2s dance up the outside to their
      opposite's place.
    / 2: 1s dance up the outside while the 2s cross down the center.
    / 4: Continue till home.
    / 8: 2nd man turns Right at home, takes 1st lady's Right hand and leads a
      Hey All 4 rotated 90° to the 1st one.

  / 48: Body: *Men's Chain, Ladies' Chain, Around the House, $1/2$ Telescope
    with Rights & Lefts, Skip Across.*

  / 16: Closing: *$1/2$ reverse Lead Around & $1/2$ Around the House* to place;
    repeat the normal way.\
    Both $1/2$ Around the Houses are _normal_: the Right shoulder pulls back.
    However, the $1/2$ Around the Houses continue in the direction began in the
    $1/2$ Lead Around.
]

== Caller's notes for Jocelyn's Chutney

#block(breakable: false, bars[
  / 16: Opening: *$1/2$ Lead Around, $1/2$ Around the House & Back.*
  / 48: Body: *Men's Chain, Ladies' Chain, Around the House, $1/2$ Telescope
    with Rights & Lefts, Skip Across.*
  / 32: 1st Figure: *Slipsides with Opposite & Turn.*
  / 48: Body: *Men's Chain, Ladies' Chain, Around the House, $1/2$ Telescope
    with Rights & Lefts, Skip Across.*
  / 32: 2nd Figure: *Slow Heys for 4.*
  / 48: Body: *Men's Chain, Ladies' Chain, Around the House, $1/2$ Telescope
    with Rights & Lefts, Skip Across.*
  / 16: 3rd Figure: *Hey All 4* done twice.
  / 48: Body: *Men's Chain, Ladies' Chain, Around the House, $1/2$ Telescope
    with Rights & Lefts, Skip Across.*
  / 16: Closing: *Reverse $1/2$ Lead Around & $1/2$ Around the House.*
])

#pagebreak()

= #dance-def[Laura's Jig][
  @time:jig @shape:6-hand @source:new @composer:terry
]

A $6 times 32$ Bar Jig for 3 couples, proper, longways progressive.\
Composed for Laura Evensen by Terry O'Neal.

#bars[
  / 8: *Advance, Retire, Star.*
    / 4: Advance & Retire.
    / 4: 6 Hands Across (Right Hand Star) once to place.

  / 16: *Turn & Wander.*
    / 4: 1st corners (1st man & 3rd lady) retain Right hands and turn $1 1/2$
      times.
    / 4: 1st man casts Right out of the bottom of the set while 3rd lady casts
      Right out of the top of the set. Both dance around behind their own lines
      to place.\
      Meanwhile, 2nd corners (1st lady & 3rd man) turn by the Left $1 1/2$
      times.
    / 4: 2nd corners each casts Left out the other end of the set and dance
      around to place.\
      Meanwhile, 3rd corners (2nd couple) take Right hands and turn $1 1/2$
      times.
    / 4: 3rd corners (middles) cast Right out the other side of the dance and
      dance around to place.

  / 48: *Sheepskin Heys.*
    / 24: Men's Sheepskin Hey:
      / \~6: 1st Man leads behind the ladies' line and weaves the line followed
        by 2nd & 3rd men.
      / \~12: Last (3rd) man in line turns back around the center lady and leads
        the weave followed by 1st & 2nd men. 2nd man is now at the rear, so he
        is the next to turn back around the center. They continue in this
        fashion until 1st man is again in the lead.
      / \~6: 1st man leads the men around behind the ladies and to place.
    / 24: Ladies' Sheepskin Hey: As above.

  / 8: *Around the House* to progress.\
    1st couple swings down the men's side to the bottom. 2nd & 3rd couples swing
    up the ladies' side 1 place (they must stay in order).
]

== Caller's notes for Laura's Jig

#block(breakable: false, bars[
  / 8: *Advance, Retire, Star.*
  / 16: *Turn & Wander.*
  / 48: *Sheepskin Heys.*
  / 8: *Around the House* to progress.
])

#pagebreak()

= #dance-def[Lee's Demand][
  @time:jig @shape:6-hand @source:new @composer:terry
]

or: The Four-Hand Reel for Six in Jig Time

An $8 times 32$ bar jig for a man between 2 ladies facing a lady between 2 men.

#bars[
  / 16: Opening: *Lead Around & Back.* Men take their Right-hand lady.

  / 56: Body: *Irish Square & Celtic Cross, Quick 7s, Stars on own side,
    Telescope & Shuttle, Grand Chain.*
    / 16: Irish Square & Celtic Cross: Stepping: 7s and Rise & Grind.\
      Middles do Celtic Cross while others do the Irish Square. The Celtic Cross
      is done to the same places as "Diamonds". Middles Rise & Grind at the
      "Diamond" points while turning around.
    / 8: Quick 7s for the corners; corners dance on your own sides:\
      Middles do 7s to their right in the center of the set to start, and
      continue back and forth as the corners, all finish in place.
    / 8: Right & Left Stars for the 3 on your own side.
    / 16: Telescope & Shuttle:
      / 2: Middle man and his opposite (middle) woman lead the Telescope with
        the couple on his Left. The couple left out casts to the bottom (other
        end) of the set.
      / 2: All dance $1/2$ turn by the Right with this same person.
      / 4: Repeat to place, same couples do the Telescope, but the other couple
        leads the Telescope.
      / 8: Middles lead another Telescope but with the other couple; the couple
        on the man's Right; again the odd couple out casts.
    / 8: Grand Chain to place: Men face Right. (2-1-1-1-1-2 bars)

  / 40: 1st Figure: *Heys, Rings, Around the House.*
    / 8: Heys for 3 on the sides: Middles pass each other's Left shoulders, pass
      through the other middle's place, and turn Left to start a Left shoulder
      Hey. The outside dancers cast inward to start Hey. All finish in place.
    / 24: Rings for 3 on your own side:
      / 8: 3-Hand Rings to the Right then to the Left and put the dancer on the
        middle's Right through the arch into the other ring.
      / 8: Repeat, but start Left and again put the dancer on the middle's Right
        through the arch.
      / 8: Repeat, but start Right; put the middle under the arch.
    / 8: Around the House to place with the person you lead around with.

  / 56: Body: *Irish Square & Celtic Cross, Quick 7s, Stars on own side,
    Telescope & Shuttle, Grand Chain.*

  / 16: 2nd Figure: *Grand Ladies' Chain.*
    / 8: Ladies Chain: Ladies Right Hands Across, pass 1 man and turn the next
      one by the Left. Ladies all pass Right shoulder in the middle and turn
      partner by the Right.
    / 8: Around the House to place.

  / 56: Body: *Irish Square & Celtic Cross, Quick 7s, Stars on own side,
    Telescope & Shuttle, Grand Chain.*

  / 16: Closing: *Lead Around & Back.* Same as opening.
]

== Caller's notes for Lee's Demand

#block(breakable: false)[
  or: The Four-Hand Reel for Six in Jig Time

  #bars[
    / 16: Opening: *Lead Around & Back.*
    / 56: Body: *Irish Square & Celtic Cross, Quick 7s, Stars on own side,
      Telescope & Shuttle, Grand Chain.*
    / 40: 1st Figure: *Heys for 3, Rings for 3, Around the House.*
    / 56: Body: *Irish Square & Celtic Cross, Quick 7s, Stars on own side,
      Telescope & Shuttle, Grand Chain.*
    / 16: 2nd Figure: *Grand Ladies' Chain, Around the House.*
    / 56: Body: *Irish Square & Celtic Cross, Quick 7s, Stars on own side,
      Telescope & Shuttle, Grand Chain.*
    / 16: Closing: *Lead Around & Back.*
  ]]

#pagebreak()

= #dance-def[Maureen's Hornpipe][
  @time:hornpipe @shape:improper @level:everyone @source:new @composer:terry
], Cornphiopa na Mhaiéin

A 32 bar Hornpipe for couple facing couple, longways progressive. Hornpipe
slipsides is similar to the Scots' Strathspey setting step. Composed for Maureen
Roddy by Terry O'Neal.

#bars[
  / 8: *Slipsides Forward* and *Hopbacks.*
    / 2: Slipsides diagonally forward with partner:
      / 1: Side step forward and to the Right.
      / 1: Side step forward and to the Left, meeting the other couple.
    / 2: Hop back out to the sides of the set with your opposite.
    / 4: Repeat all above, but hopping back to place with your partner.

  / 8: *Slipsides* and *Turn by the Left with Partner.*
    / 4: With partner, Slipsides Right, Left, Right, Left.
    / 4: On the last beat of the last sides, men cast Left & turn partner by the
      Left. This is done hopping (Step-Hop, Step-Hop). End figure facing your
      partner.

  / 8: *Slipsides* and *Turn by the Right with Opposite.*
    / 4: Take hands up and down the whole set and do Slipsides Right, Left,
      Right, Left.
    / 4: On the last beat of the last sides, men cast Right and turn opposite by
      the Right, all finish in place.

  / 8: *Slipsides, 4 in Line, Hopbacks & Rocks.*
    / 2: Slipsides forward and to the Right with partner, then forward and to
      the left with partner, meet the other couple, separate, & take hands 4 in
      line. Each couple is facing its original direction, the women in the
      center. You do not have your partner's hand.
    / 1: Hopbacks (2).
    / 1: Rocks (3).
    / 2: Slipsides forward and to the Left meeting partner, then forward and to
      the Right to progress.
    / 2: Hopbacks & Rocks.
]

== Caller's notes for Maureen's Hornpipe

#block(breakable: false, bars[
  / 8: *Slipsides Forward & Hopbacks.*
  / 8: *Slipsides & Turn by the Left with Partner.*
  / 8: *Slipsides & Turn by the Right with Opposite.*
  / 8: *Slipsides, 4 in Line, Hopbacks & Rocks, Progress.*
])

#pagebreak()

= The #dance-def[Morris Reel][
  @time:reel @shape:8-hand @source:arf
]

An $11 1/4 times 32$ Bar Reel for a square 8 hand set.

#bars[
  / 16: Opening: *Lead Around & Back.*

  / 80: Body: *Slipsides, Stars* (Ladies' then Men's), *Return Chain, Men Go
    Back to Back, Around the House.*
    / 16: Couples Slipsides: Heads go Right, Left to place, Left, Right to
      place. Sides go Left, Right, Right, Left.
    / 8: Ladies' Right Hand Star & Left Hand Back.
    / 6: Ladies _retain Left hands_ and pick up partner, Right in Right, and
      Lead Around.
    / 2: Turn partner to place.
    / 16: Men the same as the ladies. _Same hands._
    / 16: Return Chain: Give _Left_ hand to your contra corner to start.
    / 8: Men Go Back to Back: Heads with sides on their Right.
    / 8: Around the House with the couple NOT danced with.\
      (1s with 4s, and 2s with 3s.)

  / 32: 1st Figure: *Advance & Retire* twice, *Around the House.*\
    First heads, then sides.

  / 80: Body: *Slipsides, Stars* (Ladies' then Men's), *Return Chain, Men Go
    Back to Back, Around the House.*

  / 32: 2nd Figure: *Ladies' Chain, Around the House.*\
    Heads, then sides.

  / 80: Body: *Slipsides, Stars* (Ladies' then Men's), *Return Chain, Men Go
    Back to Back, Around the House.*

  / 40: Closing:
    / 32: *Bend the Ring & Circle.*
    / 8: *Lead Around* to place.
]

== Caller's notes for The Morris Reel

#block(breakable: false, bars[
  / 16: Opening: *Lead Around & Back.*
  / 80: Body: *Slipsides, Stars* (Ladies' then Men's), *Return Chain, Men Go
    Back to Back, Around the House.*
  / 32: 1st Figure: *Advance & Retire, Around the House.*
  / 80: Body: *Slipsides, Stars* (Ladies' then Men's), *Return Chain, Men Go
    Back to Back, Around the House.*
  / 32: 2nd Figure: *Ladies' Chain, Around the House.*
  / 80: Body: *Slipsides, Stars* (Ladies' then Men's), *Return Chain, Men Go
    Back to Back, Around the House.*
  / 40: Closing: *Bend the Ring & Circle, Lead Around* to place.
])

#pagebreak()

= #dance-def[O'Lannigan's Ball][
  @time:jig @shape:circle @source:arf @source:ifd
], Bainéis Uí Lonagáin

A 3 or $4 times 32$ bar jig for couples in a circle (6 couples is good).

#bars[
  / 16: *Rings.*
    / 8: Circle Left with a Promenade step.
    / 8: Circle Right with a Promenade step.

  / 8: *Uillinn in Uillinn.* Corner-partner-corner-partner, face corner. Start
    with the Right elbow to your corner.

  / 16: *Rise & Grind Sequence.*
    / 4: Rise & Grind Right then Left.
    / 2: Rise Right & then Left.
    / 2: Rise & Grind Right, turning to face partner on last grind.
    / 8: Repeat starting Left. The "Rise" is the 1st bar of the Rise & Grind.

  / 16: *Circles in Center.*
    / 3: Ladies Circle Left in the center with a Promenade step (3s).
    / 1: Ladies turn back.
    / 2: Ladies Circle Right in center with Promenade step.
    / 2: Turn partner by the Right hand leaving the men in the center.
    / 8: Men repeat, but start Right, and turn partner by the Right.

  / Couples × 4: *Flirtation.*
    / 2: Men turn partner clockwise (normal) with both hands, uncrossed.
    / 2: Men pass on to the next lady to their Right.
    / ??: Repeat until you meet your partner. Swing partner if there's music
      left over but regardless,\
      Men finish in the middle facing their partners.

  / 16: *Dance Around the Outside.*
    / 6: Ladies dance around the men starting Left.
    / 2: Turn partner with uncrossed hands to change places. Ladies finish
      inside the ring facing partners.
    / 8: Men repeat, but start Right and finish in Lead Around position.
    / 8: Lead Around to place.

  / 16: *Rings:* Circle Left and back to the Right with Promenade step.
]

== Caller's notes for O'Lannigan's Ball

#block(breakable: false, bars[
  / 16: *Ring* Left & Right. Promenade step.
  / 8: *Uillinn in Uillinn.*
  / 16: *Rise & Grind Sequence.*
  / 16: *Circles in Center* (Ladies Left, Men Right).
  / Couples × 4: *Flirtation.*
  / 16: *Dance Around the Outside.*
  / 16: *Rings* Left & Right. Promenade step.
])

#pagebreak()

= #dance-def[O'Rafferty's 16-Hand Reel][
  @time:reel @shape:other @source:ifd
]

A $12 1/2$ × 32 bar reel for 8 couples in a square, 2 couples per side.

#bars[
  / 16: Opening: *Lead Around & Turn Partner.*
    / 14: Lead Around once.
    / 2: Turn Partner 2-hands in place.

  / 96: Body: *Slipsides, Corner Rings* (Left), *Couple Slipsides, Line Rings*
    (Left), *Slipsides, Corner Link Arms, Couple Slipsides, Line Link Arms,
    Grand Chain, Men Go Back to Back.*
    / 8: Slipsides changing places with your Partner and back.
    / 8: Corner Rings with couple around your closest corner.
      / 4: Circle Left using promenade 3s.
      / 4: Swing partner 2 hands to place (Around the House).
    / 8: Couples Slipsides with the other couple in your line.
    / 8: Line Rings with the other couple in your line.
      / 4: Circle Left using promenade 3s.
      / 4: Swing partner 2 hands to place (Around the House).
    / 8: Slipsides with Partner.
    / 8: Corner Link Arms with couple around your closest corner:
      / 8: Fancy Men's Chain
        / 2: Men link arms in center by the Right, turn $1/2$.
        / 2: Men link with their opposites by the Left.
        / 2: Men pass Right shoulder.
        / 2: Men link with their partners by the Right.
    / 8: Couples Slipsides with the other couple in your line.
    / 8: Line Link Arms: with the other couple in line with you.
    / 16: Fast Grand Chain: Start facing your partner.
    / 16: Men go Back to Back: 1st with nearest corners, then in line.

  / 32: 1st Figure: *Advance, Retire, Turn,* and *Around the House.*
    / 4: All 4 head couples go Forward & Back.
    / 4: Turn (swing) partner with both hands in place.
    / 8: Around the House with the couple opposite.
    / 16: Side couples repeat.

  / 96: Body: *Slipsides, Corner Rings* (Left), *Couple Slipsides, Line Rings*
    (Left), *Slipsides, Corner Link Arms, Couple Slipsides, Line Link Arms, Fast
    Grand Chain, Men Go Back to Back.*

  / 32: 2nd Figure: *Arches.*
    / 2: All 4 head couples advance to center and each leading head couple makes
      an arch with their partners with both hands.
    / 1: Bottom ladies through the arches.
    / 1: Leading heads turn $1/2$.
    / 1: Bottom men through the arches.
    / 3: All turn partner with both hands to contrary places.
    / 8: Repeat to original places. Bottoms make the arches.
    / 16: Sides Repeat. The sides to the Right of heads lead.

  / 96: Body: *Slipsides, Corner Rings* (Left), *Couple Slipsides, Line Rings*
    (Left), *Slipsides, Corner Link Arms, Couple Slipsides, Line Link Arms, Fast
    Grand Chain, Men Go Back to Back.*

  / 32: Closing: *Bend the Ring & Circle.*
]

== Caller's notes for O'Rafferty's 16-Hand Reel

#block(breakable: false, bars[
  / 16: Opening: *Lead Around & Turn Partner.*
  / 96: Body: *Slipsides, Corner Rings* (Left), *Couple Slipsides, Line Rings*
    (Left), *Slipsides, Corner Link Arms, Couple Slipsides, Line Link Arms, Fast
    Grand Chain, Men Go Back to Back.*
  / 32: 1st Figure: *Advance, Retire, Turn,* and *Around the House.*
  / 96: Body: *Slipsides, Corner Rings* (Left), *Couple Slipsides, Line Rings*
    (Left), *Slipsides, Corner Link Arms, Couple Slipsides, Line Link Arms, Fast
    Grand Chain, Men Go Back to Back.*
  / 32: 2nd Figure: *Arches.*
  / 96: Body: *Slipsides, Corner Rings* (Left), *Couple Slipsides, Line Rings*
    (Left), *Slipsides, Corner Link Arms, Couple Slipsides, Line Link Arms, Fast
    Grand Chain, Men Go Back to Back.*
  / 32: Closing: *Bend the Ring & Circle.*
])

#pagebreak()

= #dance-def[Petronella][
  @time:reel @shape:proper @level:everyone @source:other
], Scots--Irish version

A 32 bar reel, longways progressive, duple minor, proper.\
Reset from a Scots' dance to an Irish dance by Terry O'Neal.

#bars[
  / 16: *Petronella.* (Make a diamond).
    / 2: 1s, turning around to their Right while doing 3s, go to the middle line
      of the set, man facing up, lady facing down. (1s are facing each other.)\
      Meanwhile, the 2s dance 7s just a little way up the sides almost to the
      1st couples' home place.\
      We now have a diamond of 4, all facing in.
    / 2: All set (3s).
    / 12: All turn Right around to the next place to the Right in the diamond
      and Set. Do this 3 more times. However, 2s go home on the last 2 bars of
      the 2nd phrase by turning around to the Right toward their home place.

  / 8: *1s Down the Middle and Back.*\
    Face your partner and dance 7s twice down the middle and twice back to place
    (no setting).\
    2s don't move; they mark the set.

  / 8: All *$1/2$ Around the House* to progress.
]

== Caller's notes for Petronella

#block(breakable: false, bars[
  / 16: *Petronella.*
  / 8: *1s Down the Middle & Back.*
  / 8: *Around the House.*
])

#pagebreak()

= The #dance-def[Piper's Dance][
  @time:jig @shape:circle @level:everyone @source:rne
], Rinnce an Phiobaire

A 64 bar jig for 6 (or any even \# of) couples in a circle\
Count off as 1st or 2nd couples

#bars[
  / 8: *Lead Around & back* (short).\
    Men finish Right shoulder into the center.

  / 8: *Rise & Grind* and *Turn.* Face your partner, Right foot and hand.
    / 4: Rise & Grind Right and then Left (ladies are on the outside facing in).
    / 4: Turn by the Right $1/2$ or $1 1/2$ (ladies are on the inside facing
      out).

  / 8: *Reverse Lead Around & Back* (short).\
    Men finish Left shoulder into the center.

  / 8: *Rise & Grind* and *Turn.* Face your partner, Left foot and hand.
    / 4: Rise & Grind Left and then Right (ladies are on the inside facing out).
    / 4: Turn by the Left $1/2$ or $1 1/2$ (ladies are on the outside facing
      in).

  / 16: *$1/2$ Telescope, Star.*
    / 4: 1s with their 2s do a $1/2$ Telescope ending with a Rise & Grind.
    / 4: Full Right Hand Star to this new place.
    / 8: Repeat, 2s lead, Left Hand Star to original place.

  / 12: *Double Chain* in couples to place (if 6 couples, pass each couple
    twice). Do not take hands.
    / 2: 1s & 2s face each other. 1s split the 2s; 2s go outside the 1s.
    / 2: 1s go outside the next 2s; 2s split the next 1s.
    / 8: etc. to place.

  / 4: *Swing* with crossed hands in place ready to begin again.
]

== Caller's notes for The Piper's Dance

#block(breakable: false, bars[
  / 8: *Lead Around & Back.*
  / 8: *Rise & Grind* and *Turn* (Right foot and hand).
  / 8: *Reverse Lead Around & Back.*
  / 8: *Rise & Grind* and *Turn* (Left foot and hand).
  / 16: *$1/2$ Telescope, Star.*
  / 12: *Double Chain.*
  / 4: *Swing.*
])

#pagebreak()

= The #dance-def[Rakes of Mallow][
  @time:reel @shape:trios @level:everyone @source:arf
], Reící Mhala

A 40 bar reel for trio facing trio longways progressive.\
Each man has 2 ladies both on his right.

#bars[
  / 8: *Advance & Retire* twice.

  / 8: *Man swings opposite lady* in place (with crossed hands).

  / 8: *Repeat with lady on the man's Right* (the lady in the middle).

  / 8: *Men Uillinn in Uillinn* (Right & then Left) in the center and back to
    place.

  / 8: *Trios $1/2$ Around the House* to face a new trio (progression).\
    One grip is for all 3 to cross their hands and take the hand of the one next
    to them. Another grip is for all Three to take Right hands above, and Left
    hands below.
]

#pagebreak()

= The #dance-def[Reel of the 4 Immortals][
  @time:reel @shape:4-hand @source:new @composer:terry
], Cor na Ceithre Síóga

A $9 times 32$ bar 4-hand reel; The Fairy Reel for 4.\
Composed by Terry O'Neal in 1979

#bars[
  / 32: Opening: *Advance, Retire,* and *Ring.*
    / 8: Advance & Retire: Take hands in a circle the 2nd time.
    / 8: Ring Right, Set, Ring Left, Set.
    / 16: Repeat, but Ring Left first.

  / 48: Body: *Slipsides, Uillinn in Uillinn, Reverse Square, Arches.*
    / 16: Slipsides: (partner, home, opposite, home.)
      / 2: Face partner and sidestep to the men's Left across the set (men pass
        back to back).
      / 2: Set.
      / 4: Repeat to the Right to place.
      / 8: Repeat with opposite, start to men's Right (ladies pass back to
        back).
    / 8: Uillinn in Uillinn: Men, Women, Men, Partner.
      / 2: Men by the Right in the center.
      / 2: Women by the Right in the center.
      / 2: Men by the Right in the center into
      / 2: Partner by the Left.
    / 16: Reverse Irish Square.
    / 8: Arches: (hold inside hands)
      / 2: 1s and 2s change places, 1s arch, 2s go under.
      / 2: Both couples turn to face other couple.
      / 4: Repeat to place. 2s make the arch.

  / 40: 1st Figure: *Heys for 4* (Back-to-Back and Belly-to-Belly) and *Around
    the House.*
    / 4: 1st couple take inside hands and sidestep to the middle facing out
      (back-to-back).\
      Meanwhile 2nd couple sidestep to the middle facing in with the 1s between
      them. All 4 are in line across the set.
    / 8: Hey for 4 _(crosses the musical phrase)_. 1s stop just before passing
      their partner's left shoulder. 1s are in the middle facing in, 2s are on
      the ends also facing in where they started.
    / 4: All sidestep to the other couple's place and 2s half turn.
    / 16: Repeat, 2s lead, 1s do the half turn. Everyone is in place.
    / 8: Full Around the House to place.

  / 48: Body: *Slipsides, Uillinn in Uillinn, Reverse Square, Arches.*

  / 64: 2nd Figure: *Heys for 3* and *Rings & Arches.*
    / 8: 2nd couple casts inward and 1st lady gives Left shoulder to 2nd lady to
      start Hey. 1st man does solo as in 4-Hand Reel (2nd lady casts Left; 2nd
      man Right).
    / 16: Rings & Arches as in the 4-Hand Reel.
    / 8: $1/2$ Around the House to place.
    / 32: Repeat, 2nd lady lead.

  / 48: Body: *Slipsides, Uillinn in Uillinn, Reverse Square, Arches.*

  / 8: Closing:
    / 4: *Advance & Retire.*
    / 4: *Advance & Pass Through, $1/2$ turn* by the Right to face the other
      couple, & bow.
]

== Caller's notes for The Reel of the 4 Immortals

#block(breakable: false, bars[
  / 32: Opening: *Advance, Retire,* and *Ring, twice.*
  / 48: Body: *Slipsides, Uillinn in Uillinn, Reverse Square, Arches.*
  / 40: 1st Figure: *Heys for 4* (Back-to-back and Belly-to-belly), *Around the
    House.*
  / 48: Body: *Slipsides, Uillinn in Uillinn, Reverse Square, Arches.*
  / 64: 2nd Figure: *Heys for 3, Rings & Arches.*
  / 48: Body: *Slipsides, Uillinn in Uillinn, Reverse Square, Arches.*
  / 8: Closing: *Advance & Retire, Advance & Pass Through.*
])

#pagebreak()

= #dance-def[Rinnce Mór][
  @time:reel @shape:circle @level:everyone @source:other @source:arf
]

Round dance for as many as will; Couples in a circle, 40 or 48 bar reel.\
(I saw a reference to this dance from about 1510.)

#bars[
  / 8: *Ring* Left & Right.

  / 8: *Swing corner.*

  / 8: *Swing partner.*

  / 8: *Link Arms:* Right to corner, Left to partner, Right to Corner; Face
    partner.

  / 8: *Lead Around.*

    OR

  / 16: *Grand Chain* till you reach your partner and swing her

    OR

  / 16 or 8: *Grand Chain & Take new partner.*
]

#pagebreak()

= #dance-def[Saint Bridgit's Cross][
  @time:jig @shape:improper @source:new @composer:terry
]

A 48 bar jig for couple facing couple longways progressive.\
Composed by Terry O'Neal.

#bars[
  / 8: *Men's Chain.*

  / 8: *Ladies' Chain.* Men keep dancing in a circle as the ladies chain over
    and back.

  / 8: *Around the House.* End facing partner.

  / 16: *$1/2$ Telescope* with *Rights & Lefts.*
    / 8: $1/2$ Telescope with Rights & Lefts home; 1st couple leads.
      / 2: $1/2$ Telescope with partner with Right hands joined, then
      / 6: Right & Lefts home starting with your partner's Right.
    / 8: Repeat, 2nd couple leads the Telescope.

  / 8: *Skip Across, Turn,* and *Swing* in new place.
    / 2: All skip diagonally across the set passing Right shoulders
      simultaneously with everyone in the center.
    / 2: Men loop Right and turn partner by the Right $1/2$ around on the other
      side of the dance.
    / 4: Swing in place with your partner to face a new couple.
]

== Caller's notes for Saint Bridgit's Cross

#block(breakable: false, bars[
  / 24: *Men's Chain, Ladies' Chain, Around the House.*
  / 16: *$1/2$ Telescope* with *Rights & Lefts.*
  / 8: *Skip Across, Turn,* and *Swing* in new place.
])

#pagebreak()

= #dance-def[Séamus Brennan's Revelry][
  @time:reel @shape:8-hand @source:new @composer:terry
], Plearaca na Séamus Uí Brennan

A $16 1/2 times 32$ bar reel for a square set of 4 couples. Composed 17 July
1994 by Terry O'Neal\
Teach the Star-Pull Through first.

#bars[
  / 32: Opening: *Lead Around* and *Grand Chain.*
    / 16: Lead Around & Back.
    / 16: Grand Chain (2 bars per hand)

  / 64: Body: *Single & Double Slipsides, Quick Single & Double Slipsides, See
    Saw.*\
    The basic idea of Single & Double Slipsides is that you dance a Single
    Slipsides with someone and then men take the lady on their Right to dance
    Double Slipsides. Head men always start Double Slipsides back toward their
    own home place.
    / 16: Single & Double Slipsides with partner and contra corner.
      / 2: Single Slipsides with partner and meet contra corner. Reform the set
        on the diagonals.
      / 2: Set.
      / 4: Double Slipsides with contra corner; head men go Left, side men
        Right. Reform the set on the diagonals.
      / 4: Double Slipsides back.
      / 4: Single Slipsides with partner to place.
    / 16: Single & Double Slipsides with your corner (repeat, but start with
      your corner. Then head men start Right with corner).
      / 2: Single Slipsides with corner. Reform the set on the diagonals.
      / 2: Set.
      / 4: Double Slipsides with corner; head men go Right, side men Left.
        Reform the set on the diagonals.
      / 4: Double Slipsides back.
      / 4: Single Slipsides with corner to place.
    / 16: Quick Single & Double Slipsides: Repeat above 32 bars but without
      setting.
    / 16: See Saw.

  / 64: 1st Figure: *Slipsides Across Center* and *Around the House.*\
    (Somewhat like a Pull Through but without hands).
    / 8: Heads slipsides across center and turn opposite: 7s & 3s.
      / 2: Heads turn $1/4$ Left putting their Right shoulders into the center,
        and Slipside diagonally across the set passing back-to-back in the
        center. Let the dancer in front and to the Right of you whom you can see
        go first.
      / 2: $1/2$ Turn your opposite by the Left hand to your partner's home
        place.
      / 4: Repeat, but turn $1/4$ Right and turn by the Right to home place.
    / 8: Around the House with your opposite.
    / 16: Slipsides across center and turn partner and Around the House with
      your partner: as above, but with your partner; same turnings and hands.
    / 32: Sides the same.

  / 64: Body: *Single & Double Slipsides, Quick Single & Double Slipsides, See
    Saw.*

  / 80: 2nd Figure: Heads then sides.
    / 16: *Angle-Saxon Hey.*
    / 8: *Star-Pull Through;* Right hands across first.
    / 8: *Quick Square.*
    / 8: *Around the House.*

  / 64: Body: *Single & Double Slipsides, Quick Single & Double Slipsides, See
    Saw.*

  / 64: 3rd Figure: *Back to Back* then *Stamp & Clap.*
    / 8: Head Men go Back to Back, but when you turn your partner, use both
      hands. Drop Right hands.
    / 8: Head Ladies go Back to Back: Start to the Right with Left in Left.
    / 16: All Stamp & Clap as in the High Caul Cap.
    / 32: Sides the same.

  / 64: Body: *Single & Double Slipsides, Quick Single & Double Slipsides, See
    Saw.*

  / 32: Closing: *Grand Chain* and *Lead Around.*
    / 16: Grand Chain.
    / 16: Lead Around & Back.
]

== Caller's notes for Séamus Brennan's Revelry

#block(breakable: false, bars[
  / 32: Opening: *Lead Around* and *Grand Chain.*
  / 64: Body: *Single & Double Slipsides, Quick Single & Double Slipsides, See
    Saw.*
  / 64: 1st Figure: *Slipsides Across Center* and *Around the House.*
  / 64: Body: *Single & Double Slipsides, Quick Single & Double Slipsides, See
    Saw.*
  / 80: 2nd Figure: *Angle-Saxon Hey, Star-Pull Through, Quick Square, Around
    the House.*
  / 64: Body: *Single & Double Slipsides, Quick Single & Double Slipsides, See
    Saw.*
  / 64: 3rd Figure: *Back to Back* then *Stamp & Clap.*
  / 64: Body: *Single & Double Slipsides, Quick Single & Double Slipsides, See
    Saw.*
  / 32: Closing: *Grand Chain* and *Lead Around.*
])

#pagebreak()

= The #dance-def[Seven Cuckolds][
  @time:reel @shape:other @source:new
]

A $12 times 32$ bar reel for 4 ladies & 3 men; arranged as two couples (called
heads & seconds) facing each other, and a trio (wmw) between them facing the
head couple composed by Erica Lynn Frank, 1995. For brevity, the lady on the
man's Right is his "wife" and the lady on the man's Left is his "mistress."

#bars[
  / 8: Opening: *Advance & Retire with Sidestep.*
    / 4: Heads & seconds advance & retire while center trio sidesteps Right &
      Left to place.
    / 4: Repeat, middles start Left.

  / 56: Body: *Irish Square & Circles, Ladies Rights & Lefts, Men's Hey for 3,
    Fountain, Thread the Needle.*
    / 16: Heads & seconds do Irish Square while center trio circles Right, Left
      back, then circles Left, Right back.
    / 8: Ladies do Rights & Lefts around center man; Head lady starts to her
      Right. (Center wife casts Right to start.)
    / 8: Men's hey: Center man gives Right shoulder to head man to start Hey for
      3 on the men's diagonal. (Head man casts Right, second casts Left to
      start.)
    / 8: Fountain: Ladies Circle Right & back around center man while center man
      raises both hands to make arches with outer men, who Circle Left (using
      3s) _all the way around_ the ladies.
    / 16: Thread the Needle: Center man takes his wife with his Right, & second
      lady with his Left—set forms a circle open between his mistress & head
      lady. Head couple makes an arch, and mistress leads all through & to
      place, then mistress & second man make arch, and head lady leads all
      through. On last 2 bars, everyone goes back to place.

  / 24: 1st Figure: *Double Men's Chain, Long Swing.*
    / 4: Head & second man each turn center lady in front of them; center man
      turns head lady.
    / 4: Head & second men turn partners; center man turns wife.
    / 4: Head & second man each turn other center lady, center man crosses in
      front of second man to turn second lady.
    / 4: Head & second men turn partners; center man turns mistress.
    / 8: Long Swing in place; center trio uses Around the House hold.

  / 56: Body: *Irish Square & Circles, Ladies Rights & Lefts, Men's Hey for 3,
    Ladies' Circles, Thread the Needle.*

  / 24: 2nd Figure: *Arch & Telescope.*
    / 4: Center trio makes arches, advance; heads go through.
    / 4: Heads & seconds do $1/2$ Telescope with $1/2$ turn while center man
      turns wife by Right elbow & mistress by Left elbow.
    / 2: Center trio makes arches, advance; seconds go through.
    / 2: Heads & seconds do $1/2$ turn by Right.
    / 4: Center trio makes arches, advance; heads go through; all set
    / 4: Heads & seconds do other $1/2$ Telescope with $1/2$ turn while center
      man turns Right lady by Right elbow & Left lady by Left elbow.
    / 2: Center trio makes arches, advance; heads go through to home place.
    / 2: Heads & seconds do $1/2$ turn by Right.

  / 56: *Body: Irish Square & Circles, Ladies Rights & Lefts, Men's Hey for 3,
    Fountain, Thread the Needle.*

  / 24: 3rd Figure: *Circular Sheepskin Hey.*\
    Head lady casts Right behind head man to begin.

  / 56: Body: *Irish Square & Circles, Ladies Rights & Lefts, Men's Hey for 3,
    Fountain, Thread the Needle.*

  / 32: Closing: *Bend the Ring & Circle.*
]

== Caller's notes for the Seven Cuckolds

#block(breakable: false, bars[
  / 8: Opening: *Advance & Retire with Sidestep.*
  / 56: Body: *Irish Square & Circles, Ladies Rights & Lefts, Men's Hey for 3,
    Fountain, Thread the Needle.*
  / 24: 1st Figure: *Double Men's Chain, Long Swing.*
  / 56: Body: *Irish Square & Circles, Ladies Rights & Lefts, Men's Hey for 3,
    Fountain, Thread the Needle.*
  / 24: 2nd Figure: *Arch & Telescope.*
  / 56: Body: *Irish Square & Circles, Ladies Rights & Lefts, Men's Hey for 3,
    Fountain, Thread the Needle.*
  / 24: 3rd Figure: *Circular Sheepskin Hey.*
  / 56: Body: *Irish Square & Circles, Ladies Rights & Lefts, Men's Hey for 3,
    Fountain, Thread the Needle.*
  / 32: Closing: *Bend the Ring & Circle.*
])

#pagebreak()

= #dance-def[Siamsa Beirte][
  @time:hornpipe @shape:other @source:other
]

A 16 bar hornpipe for couples. Face partner & hold Right Hands.

#bars[
  / 8: *Sides, Hopbacks & Rocks.*
    / 1: Dance 1 hornpipe step to the man's Left.
    / 1: Repeat to the man's Right.
    / 2: Hop-backs & Rocks (a hornpipe setting step.)
    / 4: Repeat, starting to the man's Right.

  / 4: *Sides & Crossover.*
    / 1: Dance 1 hornpipe step to the man's Left.
    / 1: Change places with partner with a hornpipe step starting on the man's
      Right and the lady's Left.
    / 2: Repeat; Same feet.

  / 4: *Swing Around the House.*\
    Use a schottische step. Both hands are held as normal (Right over Left) and
    then are wrapped around, man's Right under Left.
]

#pagebreak()

= The #dance-def[Siege of Carrick][
  @time:jig @shape:improper @level:everyone @source:arf @source:ifd
], Briseadh na Carraige

32 bar jig, longways progressive for as many as will, couple facing couple.\
(The tune "Haste to the Wedding" works well.)

#bars[
  / 8: *Circle Left* and then *Right.*

  / 8: *Star Right* and then *Left.*

  / 8: *Down the Center* and *Turn partner.*
    / 2: Top couple dance down the center through the 2s and then separate while
      the bottoms dance up the outside and then come together.
    / 2: All back up to place and turn to face their partner.\
      All face their original directions up or down the set during these 4 bars.
    / 1: Clap twice (on the beat).
    / 3: Turn partner by the Right elbow to place.

  / 8: *Repeat,* bottoms lead and the Right elbow Turn is used to swing around
    each other and progress to the next couple.
]

#pagebreak()

= The #dance-def[Siege of Ennis][
  @time:jig @shape:improper @level:everyone @source:arf @source:ifd @source:rne
]

A 32 bar jig, longways progressive for as many as will, 2 couples in a line
facing same.

#bars[
  / 8: *Advance & Retire* twice.

  / 8: *Slipsides as couple (Double Slipsides).*\
    Couples Slipsides in their original lines and back.

  / 8: Various things (varies locally).\
    - Center 4 *Star Right & Left* while the ends turn their opposites by the
      Right & then Left.\
      OR\
    - *All swing opposite.*

  / 8: *Advance, Retire & Pass Through.*\
    Those facing the music raise hands and let the other pass under. Pass by the
    Right shoulder.
]

#pagebreak()

= The #dance-def[Sixteen- or Twelve-Hand Reel][
  @time:reel @shape:circle @source:rne
]

An $18 1/2 times 32$ bar reel for 8 or 6 couples in a circle.

#bars[
  / 16: Opening: *Lead Around & Back.*

  / 64: Body: *Slipsides, Ring Right, Slipsides, Ring Left, Grand Chain, Link
    Arms, Swing.*
    / 8: Slipsides past partner and back.
    / 4: 1s with the couple on their Right (etc. around the circle) Circle
      Right.
    / 4: Around the House to place with the same couple.
    / 8: Slipsides with partner and back.
    / 4: 1s Circle Left with the couple on their Right.
    / 4: Around the House to place.
    / 8: Fast $1/2$ Grand Chain (until you meet your partner).
    / 8: Men take their partners home (promenade). Crossed hands.
    / 8: Fancy Men's Chain.
      / 2: 1st man with the man on his Right link Right arms and turn $1 1/2$.
      / 2: Then they turn the other lady by the Left hand.
      / 2: Men pass Right shoulder and
      / 2: turn partner by the Right hand to place.
    / 8: Holding only Right hands, the 1s and the couple on their LEFT dance
      Around the House around each other (etc. around the circle). (Locally
      called "The Suicide Swing")

  / \~64: 1st Figure: *Advance & Retire & Swing.*\
    Only 2 couples at a time.
    / 6: 1s & their opposites Advance, Retire, and Advance. Take Right hand in
      Right.
    / 2: Turn partner with crossed hands.
    / 8: Around the House.
    / 16: The next couple to the Right repeats with _their_ opposite.
    / 16: Again, the next couple to the Right repeats with their opposite.
    / (16: Again, the next couple to the Right repeats with their opposite.)

  / 64: Body: *Slipsides, Ring Right, Slipsides, Ring Left, Grand Chain, Link
    Arms, Swing.*

  / 96: 2nd Figure: *Men's Chain & Link Arms:* 2 couples at a time.
    / 8: Men's Chain (no Around the House).
    / 8: Men link Right arms, turn and go to opposite lady.
    / 8: Turn her by the Left hand then partner by the Right hand.
    / 72: Repeat in the same order as in 1st Figure.

  / 64: Body: *Slipsides, Ring Right, Slipsides, Ring Left, Grand Chain, Link
    Arms, Swing.*

  / 128: 3rd Figure: *Advance & Retire, Advance & Turn, Arch.* Right hand in
    Right.
    / 6: 1s and their opposites Advance, Retire, & Advance.
    / 2: Turn partner with crossed hands.
    / 2: 1s make a Right hand arch and 2nd lady goes under.
    / 2: 1s do a $1/2$ turn by the Right and 2nd man goes under.
    / 4: All swing to opposite's place.
    / 16: Repeat to place, but the 2s make the arch.
    / 96: Repeat in the same order as in 1st Figure.

  / 64: Body: *Slipsides, Ring Right, Slipsides, Ring Left, Grand Chain, Link
    Arms, Swing.*

  / 32: Closing: *Lead Around & Back, Around the House.*
    / 16: Lead Around & Back.
    / 16: Long Around the House.
]

== Caller's notes for The Sixteen- or Twelve-Hand Reel

#block(breakable: false, bars[
  / 16: Opening: *Lead Around & Back.*
  / 64: Body: *Slipsides, Ring Right, Slipsides, Ring Left, Grand Chain, Link
    Arms, Around the House.*
  / 64: 1st Figure: *Advance & Retire, Swing.*
  / 64: Body: *Slipsides, Ring Right, Slipsides, Ring Left, Grand Chain, Link
    Arms, Around the House.*
  / 96: 2nd Figure: *Men's Chain, Link Arms.*
  / 64: Body: *Slipsides, Ring Right, Slipsides, Ring Left, Grand Chain, Link
    Arms, Around the House.*
  / 128: 3rd Figure: *Advance & Retire, Advance & Turn, Arch.*
  / 64: Body: *Slipsides, Ring Right, Slipsides, Ring Left, Grand Chain, Link
    Arms, Around the House.*
  / 32: Closing: *Lead Around & Back, Long Around the House.*
])

#pagebreak()

= The #dance-def[Spinning Wheel Dance][
  @time:jig @shape:trios @level:everyone @source:rne
], Rinnce an Tuirne

A 72 bar jig for trio facing trio longways progressive.\
Trios are a man with a lady on each side.

#bars[
  / 16: *Advance & Retire, Advance & Pass Through.*\
    Pass Right shoulders and turn around to the Right and repeat to place.

  / 16: *Thread the Needle (Arches).*
    / 4: Middle person reaches across himself with his Left hand and takes the
      Left hand of the lady on his Right and escorts her to his Left while the
      lady on the Left dances under their arch. The ladies have changed places.
    / 4: Same people with the same hands dance back to place.
    / 8: Repeat but with the Right hand and the Lefthand lady.

  / 8: *Right Hand Star, Left back.*

  / 16: *Advance, Retire and Circle.* All 6 take hands in a circle.
    / 4: Advance & Retire.
    / 4: Circle Right & Set.
    / 8: Repeat back the way you came from to place.

    Note: This is $1/2$ of a "Bend the Ring & Circle".

  / 8: *Around the House.*\
    Head middles (with their backs to the music) face Right and swing that
    person. Bottom middles swing dancer on their Left. Person on the Left of
    head middle swing the person across the set. All swing to place.

  / 8: *Advance & Retire, Advance & Pass Through.*\
    Face a new trio.
]

== Caller's notes for The Spinning Wheel Dance

#block(breakable: false, bars[
  / 16: *Advance & Retire, Advance & Pass Through* (Repeat).
  / 16: *Thread the Needle (Arches).*
  / 8: *Right Hand Star, Left back.*
  / 16: *Advance, Retire* and *Circle.*
  / 8: *Around the House.*
  / 8: *Advance & Retire, Advance & Pass Through.*
])

#pagebreak()

= The #dance-def[Starry Plough][
  @time:reel @shape:6-hand @source:new
]

A $4 3/4 times 32$ bar reel for three couples, men facing women but centers
reversed; composed by Patrick Morris, 1995

#figure[
  m-w-m\
  w-m-w
]

#bars[
  / 8: Opening: *Right Hand Star, Left hand back.*

  / 24: Body: *The Starry Plough.*
    / 2: Ladies go in for a Right Hand Star.
    / 2: Turn the next man by the Left (center turn his own).
    / 2: Right shoulders in center.
    / 2: Turn the man on her Left by the Right.
    / 8: Men repeat, but with the other hand and shoulder:\
      Men dance a Left Hand Star. Turn the next lady by the Right (center turn
      his opposite). Left shoulders in the center. Men turn the lady on their
      Right by the Left.
    / 8: Around the house with that person.

  / 48: 1st Figure: *Processional.*
    / 8: 1st man and the lady opposite Slipside down the center (no farther than
      the third couple). Kiss while setting. Slipsides back.
    / 8: 1st and second couple set at the bottom, kissing while setting, and
      Slipside up and back.
    / 8: The third time all three couples kiss while setting, Slipside up the
      set and back.
    / 24: Repeat, starting with the bottom couple.

  / 24: Body: *The Starry Plough.*

  / 16: 2nd Figure: *Rights and lefts for 6.*
    / 2: Centers change place with their Right-hand partner by the Right hand.\
      At the same time those left out (top woman, bottom man) change diagonally
      across the set by the Right hand.
    / 2: Change with the Left hand to the person opposite you.
    / 8: Repeat twice more to place.
    / 4: Turn opposite with two hands until home.

  / 24: Body: *The Starry Plough.*

  / 8: Closing: *Left Hand Star. Right hand back.*
]

== Caller's notes for the Starry Plough

#block(breakable: false, bars[
  / 8: Opening: *Right Hand Star, Left hand back.*
  / 24: Body: *The Starry Plough.*
  / 48: 1st Figure: *Processional.*
  / 24: Body: *The Starry Plough.*
  / 16: 2nd Figure: *Rights and lefts for 6.*
  / 24: Body: *The Starry Plough.*
  / 8: Closing: *Left Hand Star, Right hand back.*
])

#pagebreak()

= #dance-def[Sweet Carol's Fancy][
  @time:reel @shape:6-hand @source:new @composer:terry
], Plearaca Carol Roisín

A $3 times 32$ bar reel for a man & 2 ladies facing a lady & 2 men. The lady on
a man's right is his normal partner. Composed for Carol Goodman by Terry O'Neal.

#bars[
  / 32: Body: *Forward & Kiss, Angle-Saxon Hey & Celtic Cross, Fast Grand
    Chain.*
    / 8: Forward & Kiss:
      / 1: Lines dance forward and meet.
      / 1: Kiss opposite.
      / 1: Lines retire to place.
      / 1: Middles turn to face normal partner who faces back.
      / 1: Kiss normal Partner.
      / 1: Middles turn to face other partner who faces back.
      / 1: Kiss other Partner.
      / 1: All turn to face opposite.
    / 16: Angle-Saxon Hey & Celtic Cross:\
      Outside dancers do an Angle-Saxon Hey, those who start on the Right go
      through the center first. (Same as Jocelyn Bronnwyn's Fancy.)\
      Meanwhile, middles do a Celtic Cross to the "Diamond points" of the set.
      Dance through the center in 2 bars, set turning for 2 bars.
    / 8: Fast Grand Chain: Men face Right, Ladies Left to start.\
      (2, 1, 1, 1, 1, 2)

  / 32: Figure: *Heys for 3* and *Slipsides.*
    / 8: Heys for 3 on your own side. Middles start by turning Right while the
      outsides cast out to start.
    / 8: Heys for 3 across the set. Middles start by dancing out of the set to
      the Right and turning Left while the outsides cast out again.
    / 16: Slipsides (as in the Fairy Reel) with Kisses:
      / 2: Middles slipsides across the set with the dancer on their Right, the
        dancers left out dance on their own side.
      / 2: Those with a partner kiss, those without, set.
      / 2: Middles and their partners slipsides home, the dancers left out dance
        home.
      / 2: Those holding hands kiss and turn, others set.
      / 8: Repeat, middles take the dancer on their Left.

  / 32: Body: *Forward & Kiss, Angle-Saxon Hey & Celtic Cross, Fast Grand
    Chain.*
]

== Caller's notes for Sweet Carol's Fancy

#block(breakable: false, bars[
  / 32: Body: *Forward & Kiss, Angle-Saxon Hey & Celtic Cross, Fast Grand
    Chain.*
  / 32: Figure: *Heys for 3* and *Slipsides.*
  / 32: Body: *Forward & Kiss, Angle-Saxon Hey & Celtic Cross, Fast Grand
    Chain.*
])

#pagebreak()

= The #dance-def[Sweets of May][
  @time:jig @shape:8-hand @source:arf @source:ifd
], Aoibhneas na Bealtaine

An $8 times 32$ bar jig for a square 8 hand set.

#bars[
  / 16: Opening: *Rings.* Left, Right, Right, Left.

  / 32: Body: *Crossover, Advance & Retire, Ring the Bells.*
    / 8: Crossover:
      / 2: Head couples Crossover to the other head couple's place with the men
        passing Left shoulders.
      / 2: Side couples Crossover, while head couples turn to the Left into
        their opposites' places.
      / 2: Head couples cross back, while side couples turn to the Left into
        their opposites' places.
      / 2: Side couples cross back, head couples turn to the Left into their
        proper places.
    / 8: Advance & Retire:
      / 2: Head couples advance while the side couples turn to the Left into
        their proper places.
      / 2: Head couples retire while the side couples advance.
      / 2: Head couples advance while the side couples retire.
      / 2: Head couples retire while the side couples dance in place.
    / 16: Ring the Bells:
      / 1: Clap hands on thighs 4 times: (1 & a 2).
      / 1: Clap hands in air twice: (3 4).
      / 2: Repeat clapping.
      / 4: Sides with partner. Reform set on corners.
      / 8: Repeat Clapping and Siding to place.

  / 16: 1st Figure: *Lead Around & Back.*

  / 32: Body: *Crossover, Advance & Retire, Ring the Bells.*

  / 16: 2nd Figure: *See Saw.* All 4 couples.

  / 32: Body: *Crossover, Advance & Retire, Ring the Bells.*

  / 16: 3rd Figure: *Arches.*
    / 2: Couples take inside hands; heads go out to the Right and sides to the
      Left; Heads arch over sides.
    / 2: Release hands and turn about.
    / 4: Repeat to place, except that the side couples arch over.
    / 8: Repeat to the other side.

  / 32: Body: *Crossover, Advance & Retire, Ring the Bells.*

  / 16: 4th Figure: *Thread the Needle.*
    / 8: Make an 8-hand circle; 1st man drops his left hand and 4th lady leads
      the rest of the set under the arch made by the 1st couple.
    / 8: 1st Man Threads the Needle under the arch made by 4th couple.

  / 32: Body: *Crossover, Advance & Retire, Ring the Bells.*

  / 16: Closing: *Rings.* Left, Right, Right, Left.
]

== Caller's notes for The Sweets of May

#block(breakable: false, bars[
  / 16: Opening: *Rings:* Left, Right, Right, Left.
  / 32: Body: *Crossover, Advance & Retire, Ring the Bells.*
  / 16: 1st Figure: *Lead Around & Back.*
  / 32: Body: *Crossover, Advance & Retire, Ring the Bells.*
  / 16: 2nd Figure: *See Saw.*
  / 32: Body: *Crossover, Advance & Retire, Ring the Bells.*
  / 16: 3rd Figure: *Arches.*
  / 32: Body: *Crossover, Advance & Retire, Ring the Bells.*
  / 16: 4th Figure: *Thread the Needle.*
  / 32: Body: *Crossover, Advance & Retire, Ring the Bells.*
  / 16: Closing: *Rings.* Left, Right, Right, Left.
])

#pagebreak()

= #dance-def[Triangle Dance][
  @time:reel @shape:other @source:new
]

A $2 times 32$ bar reel for 3 arranged in a triangle composed by Erica Lynn
Frank, 1995.\
(Done three times)

#figure[
  1\
  2 #h(2em) 3
]

#bars[
  / 8: *Circle Right & back.*

  / 16: *Slow Triangle.*
    / 4: 1 & 2 slipsides & set; 3 casts Right in place and sets.
    / 4: 2 & 3 slipsides & set; 1 casts Right in place and sets.
    / 4: 3 & 1 slipsides & set; 2 casts Right in place and sets.
    / 4: 2 & 3 slipsides & set; 1 casts Right in place and sets.

  / 8: *Circle Left & back.*

  / 24: *Interlaces & Turns.*
    / 8: 1 dances between 2 & 3, turns Left around 3, then turns 2 by Right
      elbow to place.
    / 8: 2 dances between 1 & 3, turns Left around 1, then turns 3 by Right
      elbow to place.
    / 8: 3 dances between 1 & 2, turns Left around 2, then turns 1 by Right
      elbow to place.

  / 8: *$1/2$ Turns.*
    / 2: 1 & 2 do $1/2$ turn by right to trade places.
    / 2: 2 & 3 do $1/2$ turn by right to trade places.
    / 2: 3 & 1 do $1/2$ turn by right to trade places.
    / 2: 2 & 3 do $1/2$ turn by right to trade places.

  OR (advanced version):

  / 8: *$1/2$ Turns to change places.*
    / 2: 1 & 2 do $1/2$ turn by right to trade places.
    / 2: 2 & 3 do $1/2$ turn by right to trade places.
    / 2: All set.
    / 2: All cast right in place.

  / 64: *Repeat* dance from new positions.\
    (1 is now 2; 2 is now 3; 3 is now 1.)
]

== Caller's notes for the Triangle Dance

#block(breakable: false, bars[
  / 8: *Circle Right & back.*
  / 16: *Slow Triangle.*
  / 8: *Circle Left & back.*
  / 24: *Interlaces & Turns.*
  / 8: *$1/2$ Turns.*
  / 64: *Repeat* dance from new positions.
])

#pagebreak()

= The #dance-def[Trip to the Cottage][
  @time:jig @shape:8-hand @source:arf
], Turas na Tighe

A $10 1/2 times 32$ bar jig for 4 couples in a square set.

#bars[
  / 32: Opening: *Crossover & Lead Around.*
    / 2: Heads crossover, men passing Left shoulders.
    / 2: Sides same, while the heads turn as a couple.
    / 4: Heads cross back, and turn as a couple.
    / 4: All $1/2$ Lead Around (heads are now in opposite places).
    / 4: Heads crossover, and turn as a couple. All couples are home.
    / 16: Repeat, side couples 1st.

  / 48: Body: *Trios & Rings* (Left first).
    / 8: Head men with their partners and corners Advance & Retire toward each
      other twice.
    / 4: Each trio Rings Left and then picks up corner's partner between the
      ladies.
    / 4: Each foursome Rings Right.
    / 8: Around the House around this couple.
    / 24: Side men now lead the Trios & Rings.

  / 96: 1st Figure: *Arches & Ring out the Dishrag.*
    / 8: Arches:
      / 2: 2nd lady takes 1st man's Left hand in her Right hand and dances
        Arches as in the Fairy Reel. 1st man leads 2nd lady under an arch made
        by himself and 1st lady. 1st man follows under the arch.
      / 2: Repeat, Left hand up, 1st lady under arch.
      / 2: Repeat first arch.
      / 2: Fall back into place.
    / 4: They ring Right with 2nd man.
    / 4: Ring out the Dishrag (without releasing hands): 1s arch, 2s pass under
      dancing forward. All turn out under the arm held that they hold in common
      with their own partner. 2s arch, 1s back under.
    / 4: Ring Left.
    / 4: Swing to place.
    / 24: Repeat, 1st lady leads.
    / 24: Repeat, 4th lady leads.
    / 24: Repeat, 3rd lady leads.

  / 48: Body: *Trios & Rings* (Left first).

  / 32: 2nd Figure: *Forward & Back, Track.*
    / 8: Heads Advance & Retire twice.
    / 8: Track: Ladies always go in front of the men.
      / 2: Head men dance between the sides on their Right while ladies dance
        between the sides on their Left.
      / 2: Dance around the opposite gender (your contra-corner),
      / 2: Cross the set and pass between the other sides,
      / 2: Dance directly back to place.
    / 16: Sides Repeat.

  / 48: Body: *Trios & Rings* (Left first).

  / 32: Closing: *Crossover & Lead Around;* same as the Opening.
]

== Caller's notes for The Trip to the Cottage

#block(breakable: false, bars[
  / 32: Opening: *Crossover & Lead Around.*
  / 48: Body: *Trios & Rings* (Left first).
  / 96: 1st Figure: *Arches & Ring out the Dishrag.*
  / 48: Body: *Trios & Rings* (Left first).
  / 32: 2nd Figure: *Forward & Back, Track.*
  / 48: Body: *Trios & Rings* (Left first).
  / 32: Closing: *Crossover & Lead Around.*
])

#pagebreak()

= The #dance-def[Two-Hand Jig][
  @time:jig @shape:other @source:other
]

A 32 bar jig for couples.

#bars[
  / 8: Opening: *Forward & Turn Back.*
    / 3: Forward: Use the over the shoulder hand hold; Right hand in Right, Left
      in Left.
    / 1: Turn Back: Both turn Right.
    / 4: Repeat to place; both turn Left.

  / 16: *Slipsides.* Keep the over the shoulder hand hold.
    / 4: Slipside Right and Rise & Grind.
    / 4: Change Places: man Right, lady Left and Rise & Grind.
    / 4: Slipside Left and Rise & Grind.
    / 4: Slipside Right, man turning to face lady and Rise & Grind. Change Left
      hand to below the Right.

  / 8: *Around the House.*
]

#pagebreak()

= The #dance-def[Walls of Limerick][
  @time:reel @shape:improper @level:everyone @source:arf @source:ifd @source:rne
]

A 32 bar reel, longways progressive for as many as will, couple facing couple.

#bars[
  / 8: *Advance & Retire* twice.

  / 8: *Sides across the dance.*
    / 4: Ladies sidestep Left face to face across the set to trade places.
    / 4: Men repeat, but to their Right.

  / 8: *Slipsides with opposite,* away from center and back.
    / 4: Take opposite's Right hand and Slipside away from center. Set.
    / 4: Repeat to place.

  / 8: *Around the House.*\
    Around the House to this progressed place. Face original direction and
    therefore a new couple.
]

#pagebreak()

= The #dance-def[Waves of Tory][
  @time:reel @shape:proper @level:everyone @source:arf @source:ifd @source:rne
], Tonnai Thoraigh

\~$2 1/2 times 32$ reel, longways progressive proper

The Formation: About 8 men in a line face the same number of women per set. The
left shoulder of 1st man is toward the music. Divide them into groups of 2
couples. Any single couple left over at the end dances as if it were 2 couples.

#bars[
  / 8: *Advance & Retire* twice.
  / 8: *Right Hand Star & Left Hand Back* in each group of 2 couples.
  / 16: *Advance & Retire* twice, *Star Left, Star Right.*
  / 16 or 24: *Promenade.*\
    Couples lead up to the top, cast off as a couple to the right at the top.
    Dance outside and down the set behind the ladies' line to the bottom and
    back up to place.
  / \~32: *Tonnai Thoraigh* (Dip & Dive, Waves).\
    Couple at the top arches over.
  / 16--24: *Cast off & Arch* (Progression).\
    Everyone faces up, takes the inside hand of their partner and leads up and
    casts off at the top on their own side and dances to the bottom followed by
    everyone in turn. At the bottom, the 1st couple makes a two handed arch and
    the 2nd couple dances under the arch and immediately makes a second arch.
    Everyone else follows under the arches and dances up the set.
]

The foursome which started the dance in 2nd place is now at the top and the
dance is repeated. Do until every set of 2 couples has been to the top at least
once.

== Caller's notes for The Waves of Tory

#block(breakable: false, bars[
  / 16: *Advance, Retire* (twice), and *Star Right.*
  / 16: *Advance, Retire* (twice), and *Star Left.*
  / \~24: *Promenade.*
  / \~32: *Tonnai Thoraigh* (Dip & Dive, Waves) (over at the top).
  / \~24: *Cast off & Arch.*
])

#pagebreak()

= #dance-def[Wives and Mistresses][
  @time:reel @shape:other @source:new
]

A reel for a square set of four trios. Each trio is a man with a lady on either
side of him. The lady to his right is his "wife" and the lady to the left is his
"mistress." Composed 30 October 1995 by the Starry Plough advanced class.

#bars[
  / 32: Opening: *Bend the Ring and Circle.*

  / 56: Body: *Slipsides, Stars and Sevens, Turn the Ladies, Squares & Diamonds,
    Arches.*
    / 8: Slipsides: as in the Fairy Reel, the Men take their Wives and do 7s
      across the set while the Mistresses do 7s on their own side.
    / 8: Repeat, but the Men take their Mistresses this time.
    / 8: Stars and Sevens:
      / 4: Men do a Right Hand Star.\
        Meanwhile, the ladies do quick 7s with their co-partners.
      / 4: Men do a Left Hand Star.\
        Meanwhile, the ladies do quick 7s with their corners.
    / 8: Turn the Ladies: Men turn their Wife by the Right, their Mistress by
      the Left, and their Wife again by the Right.
    / 16: Squares and Diamonds: Head trios turn to face the trios on their
      right. Each set of six now does Squares and Diamonds as in the Fairy Reel.
      The men must keep their Diamond small and tight!
    / 8: Arches: Each Trio, as in the Fairy Reel. Mistress leads.

  / 32: 1st Figure: *Advance & Retire* and *Around the House.* Heads, then
    Sides. The hold for a trio Around the House is for all three to hold Right
    hands on top, and all hold left hands below.

  / 56: Body: *Slipsides, Stars and Sevens, Turn the Ladies, Squares & Diamonds,
    Arches.*

  / 32: 2nd Figure: *Ladies' Celtic Cross.*\
    Heads, then Sides. Wives start into the center, mistresses cast in place.
    Men rest and admire.

  / 56: Body: *Slipsides, Stars and Sevens, Turn the Ladies, Squares & Diamonds,
    Arches.*

  / 32: 3rd Figure: *Men's Chain* (in trios, and with Around the House).\
    Heads, then Sides. The men turn both ladies each time. Right hands with both
    opposite ladies and Left to his own two ladies.

  / 56: Body: *Slipsides, Stars and Sevens, Turn the Ladies, Squares & Diamonds,
    Arches.*

  / 16: Closing: *Lead Around & Back.*\
    Mistresses on the inside. Everyone drops hands and turns to their own right
    to lead back.
]

== Caller's notes for Wives and Mistresses

#block(breakable: false, bars[
  / 32: Opening: *Bend the Ring and Circle.*
  / 56: Body: *Slipsides, Stars and Sevens, Turn the Ladies, Squares & Diamonds,
    Arches.*
  / 32: 1st Figure: *Advance & Retire* and *Around the House.*
  / 56: Body: *Slipsides, Stars and Sevens, Turn the Ladies, Squares & Diamonds,
    Arches.*
  / 32: 2nd Figure: *Ladies' Celtic Cross.*
  / 56: Body: *Slipsides, Stars and Sevens, Turn the Ladies, Squares & Diamonds,
    Arches.*
  / 32: 3rd Figure: *Men's Chain.*
  / 56: Body: *Slipsides, Stars and Sevens, Turn the Ladies, Squares & Diamonds,
    Arches.*
  / 16: Closing: *Lead Around & Back.*
])

\version "2.20.0"

\paper {
  #(set-paper-size "a5")
}

\bookpart {
  \paper {
    print-all-headers = ##t
    print-page-number = ##t
    print-first-page-number = ##t

    % put page numbers on the bottom
    oddHeaderMarkup = \markup ""
    evenHeaderMarkup = \markup ""
    oddFooterMarkup = \markup
    \fill-line {
      ""
      \on-the-fly #print-page-number-check-first \fromproperty #'page:page-number-string
    }
    evenFooterMarkup = \markup
    \fill-line {
      \on-the-fly #print-page-number-check-first \fromproperty #'page:page-number-string
      ""
    }

    left-margin = 1.5\cm
    right-margin = 1.5\cm
    top-margin = 1.6\cm
    bottom-margin = 1.2\cm
    ragged-bottom = ##t % do not spread the staves to fill the whole vertical space

    % change lyrics and titles font (affects notes also)
    fonts =
    #(make-pango-font-tree
      "Times New Roman"
      "DejaVu Sans"
      "DejaVu Sans Mono"
      (/ (* staff-height pt) 3.6))

    % change distance between staves
    system-system-spacing =
    #'((basic-distance . 12)
       (minimum-distance . 6)
       (padding . 1)
       (stretchability . 12))
  }

  \header {
    tagline = ##f
  }

  \score{
    \layout {
      indent = 0.0\cm % remove first line indentation
      %ragged-last = ##t % do not spread last line to fill the whole space
      \context {
        \Score
        \omit BarNumber %remove bar numbers
      } % context

      \context {
        % change staff size
        \Staff
        fontSize = #+0 % affects notes size only
        \override StaffSymbol #'staff-space = #(magstep -3)
        \override StaffSymbol #'thickness = #0.5
        \override BarLine #'hair-thickness = #1
        %\override StaffSymbol #'ledger-line-thickness = #'(0 . 0)
      }

      \context {
        % adjust space between staff and lyrics and between the two lyric lines
        \Lyrics
        \override VerticalAxisGroup.nonstaff-relatedstaff-spacing = #'((basic-distance . 4.5))
        \override VerticalAxisGroup.nonstaff-nonstaff-spacing = #'((minimum-distance . 2))
      }
    } % layout

    \new Voice \absolute {
      \clef treble
      \key d \minor
      \time 7/16
      \tempo \markup {
        % make tempo note smaller
        \concat {
          "Moderato " \normal-text { "(" }
          \teeny \general-align #Y #DOWN \note #"4" #0.8
          \normal-text { " = 69)" }
        }
      }
      \autoBeamOff
      g''8 _\f  a''8  a''8  a''16
      | % 2
      a''8  a''8  a''8  g''16 | % 3
      g''8 (  a''8 )  f''8. | \break % 4
      e''8  g''8  g''8  g''16 | % 5
      g''8  g''8  g''8  f''16 | % 6
      g''8 ( [  a''8 ) ]  f''8. \break | % 7
      d''8  f''8  f''8  f''16 | % 8
      f''8  f''8  f''8  e''16 | % 9
      f''8  g''8  e''8  c''16 |

      d''4. (  e''16 ) | \break  % 11
      f''8  g''8  f''8  e''16 | % 12
      f''8  e''8  d''8  c''16
       | % 13
      d''4 ~  d''8.  | % 14
      c''8  d''8  d''8  c''16 | % 15
      d''4 ^\>  d''8.
      \repeat volta 2 {
        | % 16
        \mark \markup { \box { 2 } } \break  | % 16
        d''8 _\! ^\mf  d''8  cis''8
        d''16 | % 17
        e''8  d''8  cis''8  bes'16
        | % 18
        a'8  g'8  g'8  a'16 \break | % 19
        bes'8  bes'8  d''8  d''16 |

        cis''8  bes'8  a'8  g'16 | % 21
        fis'8  g'8  a'8 ^\<  bes'16 \break  | % 22
        cis''8  d''8  e''8 ^\!  e''16
        | % 23
        e''8  e''8  e''8  e''16
         | % 24
        g''8 _\f  f''8  e''8  d''16
        | % 25
        e''4 ~  e''8.  | % 26
        g'8 ^\mf  f'8  e'8  d'16 | % 27
        e'4 ~  e'8. \break  | % 28
        e'8  f'8 ^\<  g'8  a'16 | % 29
        bes'8  cis''8  d''8  e''16
         |
        f''8 ^\!  e''8  d''8  cis''16
        | % 31
        d''4. ( ^\>  a'16 )
       |
      } % 32
      d''8 _\!  d''8  d''8.  \break  \bar "||"
      \mark \markup { \box { 3 } } |
      % 33
      d''8 ^\mf  d''8  d''16 ( [  c''16
      ) ]  bes'16 | % 34
      a'8  g'8  g'8. | % 35
      c''8  c''8  c''16 ( [  bes'16 )
      ]  a'16  | % 36
      g'8  f'8  f'8. \break | % 37
      bes'8  bes'8  bes'16 ( [  a'16 ) ]
      g'16 | % 38
      f'8  e'8  e'8. | % 39
      e'8  f'8  g'8  a'16 |
      f'8  e'8  f'8  g'16 | % 41
      e'8  d'8  d'8  a'16 \break | % 42
      d'8  d'8  d'8. | % 43
      a'8  d''8  d''16 ( [  c''16 ) ]
      bes'16 | % 44
      a'8  g'8  g'8. \break  | % 45
      g'8  c''8  c''16 ( [  bes'16 ) ]
      a'16 | % 46
      g'8  f'8  f'8.  | % 47
      f'8  bes'8  bes'16 ( [  a'16 ) ]
      g'16 | % 48
      f'8  e'8  e'8. \break | % 49
      e'8  f'8  g'8  a'16 | \barNumberCheck
      #50
      f'8  e'8  f'8  g'16 | % 51
      e'8  d'8  d'8  a'16  | % 52
      d'8  d'8  d'8. \break \repeat volta 2 {
        | % 53
        \key bes \major | % 53
        \mark \markup { \musicglyph #"scripts.segno" } \mark \markup {
          \box { 4 }
        }
        | % 53
        d'8   d''8 -.  d''8. -.  | % 54
        d'8   c''8 -. c''8. -.  | % 55
        d'8   bes'8 -.  bes'8. -.  | % 56
        a'8  g'8  g'8  g'16  | % 57
        g'4 ~  g'8. \break | % 58
        d'8   d''8 -.  d''8. -.  | % 59
        d'8   c''8 -.  c''8. -. |
        d'8   bes'8 -.  bes'8. -.  | % 61
        a'8   g'8  g'8  g'16  | % 62
        g'4. (  f'16 )


      }


      \repeat volta 2 {
        | \break  % 63
        a'8   a'8  a'8  c''16
        | % 64
        bes'4. (  a'16 ) | % 65
        a'8   g'8  g'8  g'16
      }

      \alternative {
        {
          % 66
          | g'4. (  f'16 )  |
        }
        {
          % 67
          \mark \markup { \musicglyph #"scripts.segno" } | % 67
          g'4 ~  g'8. \break |
        }  % 68
      }

      \mark \markup { \box { 5 } } | % 68
      c''8  d''8  d''8  d''16 | % 69
      d''4. (  g''16 ) |
      f''8   es''8  d''8  c''16
      \break | % 71
      c''8   d''8  bes'8  a'16
      | % 72
      g'8   g'8  g'8  a'16  | % 73
      \acciaccatura {  c''8 ( }  bes'8 )
      a'8 \acciaccatura {  c''8 ( }  bes'8 )
      a'16 \break  | % 74
      g'4 ~  g'8. | % 75
      c''8   d''8   bes'8 (  a'16
      )  | % 76
      g'8   g'8  g'8  a'16   | % 77
      \acciaccatura {  c''8 ( }  bes'8 )
      a'8 \acciaccatura {  c''8 ( }  bes'8 )
      a'16 \break  | % 78
      g'4 ~  g'8. | % 79
      f'8   g'8  g'8  f'16  |

      g'4 ~  g'8. \repeat volta 2 {
        | % 81
        \mark \markup { \box { 6 } } | % 81
        d'8   d''8  d''8.  | % 82
        d'8   c''8  c''8.  | % 83
        d'8   bes'8  bes'8.  \break | % 84
        a'8   g'8  g'8  g'16  | % 85
      }
      % 86

      \alternative {
        {g'4 ~  g'16. |  }
        { g'4 ~  f'8. | }
      } \break
      \repeat volta 2 {
        a'8   a'8  a'8  c''16  | % 96
        bes'4 ( bes'8. )  | % 97
        a'8   g'8   g'8  g'16  | % 98
      }

      \alternative {
        { g'4 ~  g'16.}
        {g'4 ~  (f'16.)}
      }
      \break


    }

    \addlyrics {
      Зо -- ра се е чуд -- на за -- зо --
      ри -- ла, тя жи -- во -- та нов
      е про -- я -- ви -- ла. Слън --
      чев та -- нец в'пла -- ни -- на --
      та за -- и -- гра -- ва -- ме  и
      за -- друж -- но ний за -- пя -- ва
      -- ме  слън -- че -- ви -- те пес
      -- ни. Те сър -- ца -- та ни раз --
      тва -- рят за лъ -- чи -- те, Слън
      -- це -- то ни про -- го -- ва -- ря
      чрез и -- гри -- те. Нов жи -- вот
      ни то да -- ря -- ва, но -- ва
      свет -- ли -- на,  но -- ва свет
      -- ли -- на.  Скър -- би зем -- ни
      раз -- то -- пя -- ва с'свой -- та
      топ -- ли -- на.     " " " " " " Вяр
      -- на стъп -- ка ти взе -- ми,
      свет -- ла ми -- съл при -- е --
      ми; тя жи -- вот  ще ти да --
      ри, ра -- дост но -- ва и кра --
      си -- ви бъд -- ни -- ни ще из --
      гра -- ди. Вяр -- на стъп -- ка
      ти взе -- ми, свет -- ла ми --
      съл при -- е -- ми; тя жи -- вот
      ще ти да -- ри, ра -- дост но
      -- ва и кра -- си -- ви бъд -- ни --
      ни ще из -- гра -- ди. Все на --
      пред, в'стро -- ен ред сме -- ло
      ний тръг -- ва -- ме на -- пред.
      Към жи -- вот чист и нов мо --
      щен зов пра -- ща -- ме на -- вред.
      И -- де веч в'све -- та
      брат -- ство и лю -- бов.  бов.
      В'на -- ша -- та зе -- мя
      нов жи -- вот ко -- га из -- гре --
      е всич -- ко жи -- во  ще за
      --  е за  Слън -- це -- то,
      в'зна -- ни -- е, лю -- бов и
      сво бо -- да  все -- ки ще
      жи -- вей.  "" Пъ -- тя нов е го --
      тов, от кръ -- га те -- сен из --
      лез -- ни.  "" Го -- ре
      те зо -- ват  свет -- ли ви --
      си -- ни;   ми
      Ти     си  ме,
      ма --  мо,   чо -- век
      кра -- сив ро -- ди --  ла,
      у --   мен да ста -- на,
      доб -- ре да ми -- сля,
      до --     бре да лю
      -- бя. Туй жи -- во -- та е на
      ра --  я. Рай, рай, рай, рай,
      рай, рай, рай, рай, рай, рай,
      рай, рай, рай, рай, рай, рай,
      рай, рай,   рай,   рай, рай,  рай, рай, рай, рай,
      рай, рай, рай, рай,   рай,
      рай, рай.  Туй е рай,
      рай, рай. Ка -- жи ми, ка -- жи
      ми, ка -- жи ми слад -- ки ду --
      ми две.  две.  Твой -- те ду
      -- ми две,  слад -- ки ду -- ми
      две.  Твой -- те ду -- ми две,
      слад -- ки ду -- ми две.
      Туй е рай, туй е рай, туй е
      рай, туй е рай, рай.
    }
    \addlyrics {}

    \header {
      title = \markup \column \normal-text \fontsize #2.5 {
        \center-align
        \line { Слъчеви лъчи }
        \vspace #-0.6
        \center-align
        \line \fontsize #-3 { Zaglavie }
        \vspace #-0.8
        \center-align
        \line \fontsize #-3 { " " }
      }
    }

    \midi{}

  } % score

  \pageBreak




  % include foreign translation(s) of the song
  %\include "lyrics_de/lyrics_de_file_name.ly"

} % bookpart

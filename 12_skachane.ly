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
      \key c \major
      \time 3/4
      \tempo \markup {
        % make tempo note smaller
        \concat {
          "Moderato " \normal-text { "(" }
          \teeny \general-align #Y #DOWN \note #"4" #0.8
          \normal-text { " = 69)" }
        }
      }
      \autoBeamOff
      g'4 ^\markup{ \bold {} }  a'4  g'4 | % 2
      e'4  g'4..  e''16 | % 3
      c''2. | % 4
      g'4  a'4  g'4 | % 5
      e'4  g'4..  e''16 | % 6
      c''2. |\break % 7
      g'4  a'4  c''4  | % 8
      b'4  a'4..  g'16 | % 9
      b'2. |
      d''4  b'4  a'4 | \break % 11
      g'4  b'4..  d''16 | % 12
      f''2. | % 13
      a'4  b'4  g'4 | % 14
      e''4  d''4..  g''16 | % 15
      c''2. \bar "|."
    }

    \addlyrics {
      На -- го -- ре да по -- ле -- тим.
      Към не -- бес -- ни -- я про --
      стор. С'мир, лю -- бов и све --
      тли -- на всич -- ко ра -- сте
      в'кра -- со -- та и ни но -- си мъ
      -- дрост -- та.}
      \addlyrics {
        Na -- go -- re da po -- le -- tim.
        Kam ne -- bes -- ni -- ya pro --
        stor. S'mir, lyu -- bov i sve --
        tli -- na vsich -- ko ra -- ste
        v'kra -- so -- ta i ni no -- si ma
        -- drost -- ta}

        \header {
          title = \markup \column \normal-text \fontsize #2.5 {
            \center-align
            \line { Скачане }
            \vspace #-0.6
            \center-align
            \line \fontsize #-3 { Skachane}
            \vspace #-0.8
            \center-align
            \line \fontsize #-3 { " " }
          }
        }

        \midi{}

      } % score



      % include foreign translation(s) of the song
      \include "lyrics_de/12_skachane_lyrics_de.ly"

    } % bookpart

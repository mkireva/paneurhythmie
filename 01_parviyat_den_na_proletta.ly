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

    \new Voice \relative c' {
      \clef treble
      \key a \minor
      \time 3/4
      \tempo \markup {
        % make tempo note smaller
        \concat {
          "Allegro moderato  " \normal-text { "(" }
          \teeny \general-align #Y #DOWN \note #"4" #0.8
          \normal-text { " = 69)" }
        }
      }
      \autoBeamOff
      \repeat volta 2 {
        a2 a8 b8 | c2 d4 | e2 e4 | e2. | f2 e8 dis |e2 c'4 | \break

        b2 gis4 | a2. | a2 g8 f8 | e2 d4 | c2 d4 | e2. | a,2 a8 [ b8 ] | \break

        c2 b4 | c2 b4| a2. | a2 a8 [ b8 ] |   c2 b4 | c2 b4| a2. |\break
      }
    }

    \addlyrics {
      Пър -- ви -- ят ден на про -- лет -- та,

      пър -- ви -- ят ден на ра -- дост -- та,

      пър -- ви -- ят ден на лю -- бов  -- та

      но -- сят си -- ла и жи -- вот,

      но -- сят си -- ла и жи -- вот.}
      \addlyrics {  Par -- vi -- yat den na pro -- let -- ta,

      par -- vi -- yat den na ra -- dost -- ta,

      par -- vi -- yat den na lyu -- bov  -- ta

      no -- syat si -- la i zhi -- vot,

      no -- syat si -- la i zhi -- vot.}

      \header {
        title = \markup \column \normal-text \fontsize #2.5 {
          \center-align
          \line { Първият ден на пролетта}
          \vspace #-0.6
          \center-align
          \line \fontsize #-3 { Parviya den na proletta }
          \vspace #-0.8
          \center-align
          \line \fontsize #-3 { " " }
        }
      }

      \midi{}

    } % score


    % include foreign translation(s) of the song
    \include "lyrics_de/01_probuzhdane_lyrics_de.ly"

  } % bookpart

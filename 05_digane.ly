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
      \key a \major
      \time 3/4
      \autoBeamOff

      cis'4.( b8a[ gis] )| a2 (fis4) | b4.( a8gis8[fis8] )| gis2 (e4 )| a4. ( gis8 fis [e8] )\break |

      fis2 (d4) | b2 cis8 [d8] | fis2 (fis4) | gis2 (gis4) | cis2 (b4 )| fis2 (gis4) | a2. (| a2.) | \break


    }

    \addlyrics {
      ????-????_?? ???? -- ????????,
      ??????-????????_?? ??-??????
      ????????-????_???? ???? -- ????
      ?? ???????? -- ???? -- ???? -- ????,
      ?? ?????? -- ???????? -- ???? ?? ?????? -- ???? -- ????.}
      \addlyrics {}

      \header {
        title = \markup \column \normal-text \fontsize #2.5 {
          \center-align
          \line {  ????????????}
          \vspace #-0.6
          \center-align
          \line \fontsize #-3 { Digane }
          \vspace #-0.8
          \center-align
          \line \fontsize #-3 { " " }
        }
      }

      \midi{}

    } % score


    % include foreign translation(s) of the song
    \include "lyrics_de/05_digane_lyrics_de.ly"

  } % bookpart

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


      cis2 e4 | a2 gis4 | a2  \grace { fis16 ([gis16] } fis4 )
      | fis2 d4 | b2 cis8 [e8] | fis2   \grace { e16 ([fis16] } e4 ) \break

      e2 cis4 | cis2. | cis'2 cis4| d2  cis4 |   \grace {cis16 ([d16] } cis2 ) b4 | \grace {b16 ([cis16] } b2 ) a4 \break

      a2 gis4 | gis2 fis4 | fis2 e4 | e2. | fis2 e4 | b'2 cis4 | \break

      a2.(|a2.)| fis2 fis4 | fis2 gis4 | cis2 b4 | fis2 gis4 | a2.(| a2.) | \break


    }

    \addlyrics {
      ???????? -- ???? -- ???? ???????? -- ???? -- ?????? -- ?????? -- ????
      ???????? -- ????_?????? -- ???? -- ???? -- ?? ?????? -- ??????.
      ?????? -- ?? ?????? -- ???? -- ???? ???? -- ????,
      ?????? -- ???????? ???? -- ???? ???? ?????? -- ?? ??????
      ???? ???? -- ?????? -- ???? ??????.
      ?? ?????? -- ???? ???????? -- ???? -- ???? ???????? ?????? -- ????.
    }
    \addlyrics {

          Bljas -- ka -- vi sves -- di -- bri -- ljan -- ti
      svet -- li_ska -- sa -- ni -- ja mal -- vjat.
      Gre -- e tschis -- ta -- ta lu -- na,
      bes -- spir le -- ti po svo -- ja pat
      po ne -- bes -- na schir.
      I den -- jat pris -- ti -- ga sled nost -- ta.
    }



    \header {
      title = \markup \column \normal-text \fontsize #2.5 {
        \center-align
        \line { 4. ??????????????????}
        \vspace #-0.6
        \center-align
        \line \fontsize #-3 { 4. Vaslizane }
        \vspace #-0.8
        \center-align
        \line \fontsize #-3 { " " }
      }
    }


    \midi{}

  } % score

 

  % include foreign translation(s) of the song
  \include "lyrics_de/4_vaslizane_lyrics_de.ly"

} % bookpart

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
          "Allegro moderato " \normal-text { "(" }
          \teeny \general-align #Y #DOWN \note #"4" #0.8
          \normal-text { " = 69)" }
        }
      }
      \autoBeamOff
      g'2 g8 g8 | a2 f4 | f2 e8 [ (f8)] | g2 e4 | e2 c8( [d8] )| e2. | a,2 a8 [(b8)] | \break

      c2 b4 | c2 b4 a2. | a2 a8 [(b8)] | c2 b4 | c2 b4 a2. \break

      a'2 a4 | c2 b4 | b2 a4 | a2 g4 | f2 e8 [(f8)] g2 e4 | e2 c8 [(d8)] e2. | \break

      a,2 a8 b8 | c2 b4 | c2 b4 | a2. |   a2 a8 ( [b8] )| c2 b4 | c2 b4 | a2. | \bar "|." \break


    }

    \addlyrics {
      И о -- жи -- вя -- ва, и ни бу -- ди със лю -- бов.

      Ста -- вай -- те от сън, де -- ца!

      Про -- лет ми -- ла веч дой -- де.

      Ця -- ла -- та при -- ро -- да пе -- е;

      Слън -- це топ -- ло ве -- че грей.

      Но -- си цве -- тя и пло -- до -- ве,

      но -- си пес -- ни и иг -- ри.}
      \addlyrics {
        I o -- zhi -- vya -- va, i ni bu -- di sas lyu -- bov.

        Sta -- vay -- te ot san, de -- tsa!

        Pro -- let mi -- la vech doy -- de.

        Tsya -- la -- ta pri -- ro -- da pe -- e;

        Slan -- tse top -- lo ve -- che grey.

        No -- si tsve -- tya i plo -- do -- ve,

        no -- si pes -- ni i ig -- ri.}

        \header {
          title = \markup \column \normal-text \fontsize #2.5 {
            \center-align
            \line { Примирение}
            \vspace #-0.6
            \center-align
            \line \fontsize #-3 { Primirenie }
            \vspace #-0.8
            \center-align
            \line \fontsize #-3 { " " }
          }
        }

        \midi{}

      } % score



      % include foreign translation(s) of the song
      \include "lyrics_de/02_primirenie_lyrics_de.ly"

    } % bookpart

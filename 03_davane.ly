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
          "Allegro Moderato " \normal-text { "(" }
          \teeny \general-align #Y #DOWN \note #"4" #0.8
          \normal-text { " = 69)" }
        }
      }
      \autoBeamOff
      e2 e4 | a2 g4 | g2 f8 [(e8)] f2. | d2 d4 | g2 f4 |\break

      f2 e8 ( [ dis8] ) |e2. | b4 c d | e2 (d4) | c2 b4 | c2 b4 | a2. (| a2.) | \break

      c2 c4 | c2. | b4 c d | e2 f4 | e2 (dis4) | e2. (|e2.) |\break

      f4 g a | a2 g4 | f2 e4 | f2 d4 | d2. (|d2.) \break

      b4 c4 e4 | e2 d4 | c2 b4 | a2 gis4 | a2 b4 | a2. (| a2.) | \bar "|." \break


    }

    \addlyrics {
      Пъл -- ни вся  -- ка твар с'жи -- вот,

      бу -- ди ра -- дост във ду -- ха,

      раз -- ве -- се -- ля -- ва сър -- ца -- та ни.

      Гре -- е, грей Слън -- це -- то бла -- го -- дат -- но,

      це -- лу -- ва неж -- но ця -- ла -- та Зе -- мя

      и я о -- кич -- ва с'пре -- лест -- ни, без -- брой цве -- тя.}
      \addlyrics {
        Pal -- ni vsya  -- ka tvar s'zhi -- vot,

        bu -- di ra -- dost vav du -- ha,

        raz -- ve -- se -- lya -- va sar -- tsa -- ta ni.

        Gre -- e, grey Slan -- tse -- to bla -- go -- dat -- no,

        tse -- lu -- va nezh -- no tsya -- la -- ta Ze -- mya

        i ya o -- kich -- va s'pre -- lest -- ni, bez -- broy tsve -- tya.}

        \header {
          title = \markup \column \normal-text \fontsize #2.5 {
            \center-align
            \line { Даване }
            \vspace #-0.6
            \center-align
            \line \fontsize #-3 { Davane }
            \vspace #-0.8
            \center-align
            \line \fontsize #-3 { " " }
          }
        }

        \midi{}

      } % score


      % include foreign translation(s) of the song
      \include "lyrics_de/03_geben_lyrics_de.ly"

    } % bookpart

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

    \new Voice \absolute{
      \clef treble
      \key f \major
      \time 3/8
      \tempo \markup {
        % make tempo note smaller
        \concat {
          "Allegretto" \normal-text { " (" }
          \teeny \general-align #Y #DOWN \note #"4" #0.8
          \normal-text { " = 60)" }
        }
      }
      \autoBeamOff

      c'8  d'8  e'8 | % 2
      f'4. | % 3
      \grace {  f'16 ( [  g'16 ] }  f'8 )  e'8
      f'8 | % 4
      a'4  g'8 | % 5
      g'4  f'8 | % 6
      f'4  d'8 \break | % 7
      d'4  c'8 | % 8
      c'4. | % 9
      c'8  d'8  e'8 |
      f'4  a'8 | % 11
      bes'4. ~ | % 12
      bes'4  a'8 \break | % 13
      a'4  g'8 | % 14
      g'8 ( [  d'8 ) ]  e'8 | % 15
      f'4. ~ | % 16
      f'4. | % 17
      f'4  a'8 | % 18
      d''4 c''8 | % 19
      c''4. ~ |
      c''4. \break \repeat volta 2 {
        | % 21
        a'4 c''8 | % 22
        f''4 e''8 | % 23
        e''4 d''8 | % 24
        d''4 c''8 | % 25
        c''4. ~ | % 26
        c''4. \break | % 27
        a'8 c''8 e''8 | % 28
        g''4 f''8 | % 29
        f''4 e''8 |
        e''4 d''8 | % 31
        d''4 c''8 \break | % 32
        c''4. ~ | % 33
        c''4. | % 34
        a'8 bes'8 c''8 | % 35
        d''4 c''8 | % 36
        c''4 bes'8 | % 37
        bes'4  a'8 | % 38
        bes'4. ~ \break | % 39
        bes'4. |
        a'8  g'8  a'8 | % 41
        bes'4  e'8 | % 42
        g'4  f'8 | % 43
        f'4. ~ | % 44
        f'4.
      }
    }

    \addlyrics {
      Слън -- це -- то грей,   га --
      ли с'лъ -- чи цве -- тен -- ца и
      тре -- ви и нас. На ра ни --
      на въз -- тор -- же -- но иг --
      ра -- ем ний.  Въз -- дух
      бла -- го -- дат,  птич -- ки
      хвър -- кат ве -- се -- ло над нас.
      При -- ро -- да -- та си -- я -- е
      ця -- ла в'кра -- со -- та.  Рос --
      на тре -- ви -- ца блес -- на -- ла
      в'ел -- маз. Цве -- тя -- та ле --
      ят а -- ро -- мат.
    }
    \addlyrics {
        Slan -- tse -- to grei,   ga --
      li s'la -- tschi tsve -- ten -- tsa i
      tre -- vi i nas. Na ra ni --
      na vas -- tor -- je -- no ig --
      ra -- em nii.  Vas -- duh
      bla -- go -- dat,  ptitsch -- ki
      hvar -- kat ve -- se -- lo nad nas.
      Pri -- ro -- da -- ta si -- ja -- e
      tsja -- la v'kra -- so -- ta.  Ros --
      na tre -- vi -- tsa bles -- na -- la
      v'el -- mas. Tsve -- tja -- ta le --
      jat a -- ro -- mat.}

      \header {
        title = \markup \column \normal-text \fontsize #2.5 {
          \center-align
          \line { Евера }
          \vspace #-0.6
          \center-align
          \line \fontsize #-3 { Evera}
          \vspace #-0.8
          \center-align
          \line \fontsize #-3 { " " }
        }
      }

      \midi{}

    } % score
    \pageBreak

    % include foreign translation(s) of the song
    \include "lyrics_de/11_evera_lyrics_de.ly"

  } % bookpart

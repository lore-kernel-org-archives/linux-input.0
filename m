From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [RFC] Infrared Keycode standardization
Date: Fri, 28 Aug 2009 11:05:53 -0300
Message-ID: <20090828110553.674b97fc@pedra.chehab.org>
References: <20090827045710.2d8a7010@pedra.chehab.org>
	<20090827185853.0aa2de76@pedra.chehab.org>
	<829197380908271506i251b47caoe8c08d483e78e938@mail.gmail.com>
	<200908280000.54986.jarod@wilsonet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <200908280000.54986.jarod@wilsonet.com>
Sender: linux-media-owner@vger.kernel.org
To: Jarod Wilson <jarod@wilsonet.com>
Cc: Devin Heitmueller <dheitmueller@kernellabs.com>, Ville =?ISO-8859-1?B?U3lyauRs5A==?= <syrjala@sci.fi>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Em Fri, 28 Aug 2009 00:00:54 -0400
Jarod Wilson <jarod@wilsonet.com> escreveu:

> On Thursday 27 August 2009 18:06:51 Devin Heitmueller wrote:
> > On Thu, Aug 27, 2009 at 5:58 PM, Mauro Carvalho
> > Chehab<mchehab@infradead.org> wrote:
> > > Em Thu, 27 Aug 2009 21:36:36 +0300
> > > Ville Syrj=E4l=E4 <syrjala@sci.fi> escreveu:
> > >
> > >
> > >> I welcome this effort. It would be nice to have some kind of con=
sistent
> > >> behaviour between devices. But just limiting the effort to IR de=
vices
> > >> doesn't make sense. It shouldn't matter how the device is connec=
ted.
> > >
> > > Agreed.
> > >
> > >>
> > >> FASTWORWARD,REWIND,FORWARD and BACK aren't very clear. To me it =
would
> > >> make most sense if FASTFORWARD and REWIND were paired and FORWAR=
D and
> > >> BACK were paired. I actually have those two a bit confused in
> > >> ati_remote2 too where I used FASTFORWARD and BACK. I suppose it =
should
> > >> be REWIND instead.
> > >
> > > Makes sense. I updated it at the wiki. I also tried to group the =
keycodes by
> > > function there.
> > >
> > >> Also I should probably use ZOOM for the maximize/restore button =
(it's
> > >> FRONT now), and maybe SETUP instead of ENTER for another. It has=
 a
> > >> picture of a checkbox, Windows software apparently shows a setup=
 menu
> > >> when it's pressed.
> > >>
> > >> There are also a couple of buttons where no keycode really seems=
 to
> > >> match. One is the mouse button drag. I suppose I could implement=
 the
> > >> drag lock feature in the driver but I'm not sure if that's a goo=
d idea.
> > >> It would make that button special and unmappable. Currently I ha=
ve that
> > >> mapped to EDIT IIRC.
> > >
> > > I'm not sure what we should do with those buttons.
> > >
> > > Probably, the most complete IR spec is the RC5 codes:
> > >        http://c6000.spectrumdigital.com/davincievm/revf/files/msp=
430/rc5_codes.pdf
> > > (not sure if this table is complete or accurate, but on a search =
I did
> > > today, this is the one that gave me a better documentation)
> > >
> > > I suspect that, after solving the most used cases, we'll need to =
take a better look on it,
> > > identifying the missing cases of the real implementations and add=
 them to input.h.
> > >
> > >> The other oddball button has a picture of a stopwatch (I think, =
it's
> > >> not very clear). Currently it uses COFFEE, but maybe TIMER or so=
mething
> > >> like that should be added. The Windows software's manual just sa=
y it
> > >> toggles TV-on-demand, but I have no idea what that actually is.
> > >
> > > Hmm... Maybe TV-on-demand is another name for pay-per-view?
> > >
> > >
> > >
> > > Cheers,
> > > Mauro
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-m=
edia" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> > >
> >=20
> > Since we're on the topic of IR support, there are probably a couple=
 of
> > other things we may want to be thinking about if we plan on
> > refactoring the API at all:
> >=20
> > 1.  The fact that for RC5 remote controls, the tables in ir-keymaps=
=2Ec
> > only have the second byte.  In theory, they should have both bytes
> > since the vendor byte helps prevents receiving spurious commands fr=
om
> > unrelated remote controls.  We should include the ability to "ignor=
e
> > the vendor byte" so we can continue to support all the remotes
> > currently in the ir-keymaps.c where we don't know what the vendor b=
yte
> > should contain.
> >=20
> > 2..  The fact that the current API provides no real way to change t=
he
> > mode of operation for the IR receiver, for those receivers that
> > support multiple modes (NEC/RC5/RC6).  While you have the ability t=
o
> > change the mapping table from userland via the keytable program, th=
ere
> > is currently no way to tell the IR receiver which mode to operate i=
n.
> >=20
> > One would argue that the above keymaps structure should include new
> > fields to indicate what type of remote it is (NEC/RC5/RC6 etc), as
> > well as field to indicate that the vendor codes are absent from the
> > key mapping for that remote).  Given this, I can change the dib0700
> > and em28xx IR receivers to automatically set the IR capture mode
> > appropriate based on which remote is in the device profile.
>=20
> Jon Smirl actually wrote some fully functional proof-of-concept IR
> handling code about a year ago, that included auto-detection and auto
> decoding of several protocols. Perhaps some of that is relevant and
> reusable here? (I still have a copy of the tree here somewhere...)

Yes, it seems interesting. We may try to merge his code at ir-functions=
=2E

> I've been toying with the notion of extending the input device suppor=
t
> that was added to the lirc_imon driver a bit ago, and add a full key
> map that delivers events (we already do this for mouse functionality)=
,
> but include the ability to also use the remote and/or receiver in a
> raw IR mode with lircd. Wouldn't be terribly difficult I think to do
> something similar for the standard MCE remotes and receivers... Just
> a simple matter of some time and some code. Unfortunately, I'm a bit
> short on the time part right now...

Interesting. This could work fine with the IR's that are directly conne=
cted to
a GPIO pin at the MCE receivers.



Cheers,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

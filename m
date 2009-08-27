From: Devin Heitmueller <dheitmueller@kernellabs.com>
Subject: Re: [RFC] Infrared Keycode standardization
Date: Thu, 27 Aug 2009 18:06:51 -0400
Message-ID: <829197380908271506i251b47caoe8c08d483e78e938@mail.gmail.com>
References: <20090827045710.2d8a7010@pedra.chehab.org>
	 <20090827183636.GG26702@sci.fi>
	 <20090827185853.0aa2de76@pedra.chehab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20090827185853.0aa2de76@pedra.chehab.org>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 27, 2009 at 5:58 PM, Mauro Carvalho
Chehab<mchehab@infradead.org> wrote:
> Em Thu, 27 Aug 2009 21:36:36 +0300
> Ville Syrj=E4l=E4 <syrjala@sci.fi> escreveu:
>
>
>> I welcome this effort. It would be nice to have some kind of consist=
ent
>> behaviour between devices. But just limiting the effort to IR device=
s
>> doesn't make sense. It shouldn't matter how the device is connected.
>
> Agreed.
>
>>
>> FASTWORWARD,REWIND,FORWARD and BACK aren't very clear. To me it woul=
d
>> make most sense if FASTFORWARD and REWIND were paired and FORWARD an=
d
>> BACK were paired. I actually have those two a bit confused in
>> ati_remote2 too where I used FASTFORWARD and BACK. I suppose it shou=
ld
>> be REWIND instead.
>
> Makes sense. I updated it at the wiki. I also tried to group the keyc=
odes by
> function there.
>
>> Also I should probably use ZOOM for the maximize/restore button (it'=
s
>> FRONT now), and maybe SETUP instead of ENTER for another. It has a
>> picture of a checkbox, Windows software apparently shows a setup men=
u
>> when it's pressed.
>>
>> There are also a couple of buttons where no keycode really seems to
>> match. One is the mouse button drag. I suppose I could implement the
>> drag lock feature in the driver but I'm not sure if that's a good id=
ea.
>> It would make that button special and unmappable. Currently I have t=
hat
>> mapped to EDIT IIRC.
>
> I'm not sure what we should do with those buttons.
>
> Probably, the most complete IR spec is the RC5 codes:
> =A0 =A0 =A0 =A0http://c6000.spectrumdigital.com/davincievm/revf/files=
/msp430/rc5_codes.pdf
> (not sure if this table is complete or accurate, but on a search I di=
d
> today, this is the one that gave me a better documentation)
>
> I suspect that, after solving the most used cases, we'll need to take=
 a better look on it,
> identifying the missing cases of the real implementations and add the=
m to input.h.
>
>> The other oddball button has a picture of a stopwatch (I think, it's
>> not very clear). Currently it uses COFFEE, but maybe TIMER or someth=
ing
>> like that should be added. The Windows software's manual just say it
>> toggles TV-on-demand, but I have no idea what that actually is.
>
> Hmm... Maybe TV-on-demand is another name for pay-per-view?
>
>
>
> Cheers,
> Mauro
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Since we're on the topic of IR support, there are probably a couple of
other things we may want to be thinking about if we plan on
refactoring the API at all:

1.  The fact that for RC5 remote controls, the tables in ir-keymaps.c
only have the second byte.  In theory, they should have both bytes
since the vendor byte helps prevents receiving spurious commands from
unrelated remote controls.  We should include the ability to "ignore
the vendor byte" so we can continue to support all the remotes
currently in the ir-keymaps.c where we don't know what the vendor byte
should contain.

2..  The fact that the current API provides no real way to change the
mode of operation for the IR receiver, for those receivers that
support multiple modes (NEC/RC5/RC6).  While you have the ability to
change the mapping table from userland via the keytable program, there
is currently no way to tell the IR receiver which mode to operate in.

One would argue that the above keymaps structure should include new
fields to indicate what type of remote it is (NEC/RC5/RC6 etc), as
well as field to indicate that the vendor codes are absent from the
key mapping for that remote).  Given this, I can change the dib0700
and em28xx IR receivers to automatically set the IR capture mode
appropriate based on which remote is in the device profile.

Devin

--=20
Devin J. Heitmueller - Kernel Labs
http://www.kernellabs.com
--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

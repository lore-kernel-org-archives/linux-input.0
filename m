From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH v2 2/6] hid: add framebuffer support to PicoLCD device
Date: Sun, 21 Mar 2010 17:11:28 +0100
Message-ID: <20100321171128.324a606f@neptune.home>
References: <20100320170014.440959a8@neptune.home>
 <20100320170415.6ee219c8@neptune.home>
 <45a44e481003210024l2c66938fp9436d34f6473f811@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <45a44e481003210024l2c66938fp9436d34f6473f811@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>
List-Id: linux-input@vger.kernel.org

On Sun, 21 March 2010 Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> > Add framebuffer support to PicoLCD device with use of deferred-io.
> >
> > Only changed areas of framebuffer get sent to device in order to
> > save USB bandwidth and especially resources on PicoLCD device or
> > allow higher refresh rate for a small area.
>=20
> Interesting work. One minor comment, defio doesn't currently guarante=
e
> that it is "changed areas". Just that it is "written" pages which
> typically equates to "changed" but does not guarantee this.

When copying from framebuffer to shadow buffer I check if any given til=
e
has changed and only send that tile to the device if it has effectively
changed. So this check is done independently of defio.
(though I have to force-fully transfer the whole framebuffer at probe
or after reset - which is missing)

> > Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> > ---
> > =C2=A0drivers/hid/Kconfig =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A07 +-
> > =C2=A0drivers/hid/hid-picolcd.c | =C2=A0454 +++++++++++++++++++++++=
++++++++++++++++++++++
> > =C2=A02 files changed, 460 insertions(+), 1 deletions(-)
>=20
> It is customary for framebuffer drivers to live in drivers/video. Thi=
s
> is the first one I've reviewed that is outside of it. Is there a good
> reason for this one to be outside of it? If so, could you put it in
> the comments.

I've kept all the pieces of PicoLCD driver together under hid,
as it's a HID based device. Framebuffer is just one of its features and
keeping pieces together makes it easier to handle.

> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 7097f0a..a474bcd 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -230,6 +230,11 @@ config HID_PETALYNX
> > =C2=A0config HID_PICOLCD
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "PicoLCD (graphic version)"
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on USB_HID
> > + =C2=A0 =C2=A0 =C2=A0 select FB_DEFERRED_IO if FB
> > + =C2=A0 =C2=A0 =C2=A0 select FB_SYS_FILLRECT if FB
> > + =C2=A0 =C2=A0 =C2=A0 select FB_SYS_COPYAREA if FB
> > + =C2=A0 =C2=A0 =C2=A0 select FB_SYS_IMAGEBLIT if FB
> > + =C2=A0 =C2=A0 =C2=A0 select FB_SYS_FOPS if FB
>=20
> I think all of that "if FB" stuff looks odd, it would disappear if it
> were in the right Kconfig.

In the initial patch I did select FB as well though for v2 I decided
to make all the dependencies of non-input features optional. For the FB
case the various helper entries are needed, for the rest it's sufficien=
t
to have #ifdef's for their device class.

Another option would be to distribute the Kconfig entries over the
various device class's Kconfig files though I don't think that would
make things easier to understand...

> > +/* Framebuffer visual structures */
> > +static const struct fb_fix_screeninfo picolcdfb_fix =3D {
> > + =C2=A0 =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D PI=
COLCDFB_NAME,
> > + =C2=A0 =C2=A0 =C2=A0 .type =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D FB_TYPE=
_PACKED_PIXELS,
> > + =C2=A0 =C2=A0 =C2=A0 .visual =C2=A0 =C2=A0 =C2=A0=3D FB_VISUAL_MO=
NO01,
>=20
> Interesting choice. Out of curiosity, which fb client application are
> you testing/using this with?

=46or now I've just been testing with manual read/write to /dev/fb. I'v=
e
not yet played with fb applications.


I've had a look at fb applications, seems that none wants to play with
individual bits, they all bail out requesting 8 or more bpp (some
fail politely, others just exit/segfault and don't undo changes they di=
d)

So I guess I will have to add support for translating 8bpp to device's
1bpp to be able to use any existing fb application and switching betwee=
n
1bpp and 8bpp framebuffer...

> > + =C2=A0 =C2=A0 =C2=A0 /*
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Translate the XBM format screen_base=
 into the format needed by the
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* PicoLCD. See display layout above.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Do this one tile after the other and=
 push those tiles that changed.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>=20
> I think screen_base is in standard fb format, which you've specified
> as MONO01 above. When you say, XBM format, in the above comment is it
> exactly the same?

It should be the same (from what I read MONO01 versus MONO10 is just
whether 0 or 1 is "black" or "white") and in combination with
PACKED_PIXELS it makes 8 pixels per bytes.

Thanks for the review,
Bruno

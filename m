From: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Subject: Re: [PATCH] Logitech G13 driver (fixed cc list --- ignore others)
Date: Thu, 7 Jan 2010 08:59:53 -0700
Message-ID: <635ab1237a6a988656a2bf28e488f656.squirrel@intranet.cs.nmsu.edu>
References: <200912142122.nBELMW7d001243@mustang.cs.nmsu.edu>
    <45a44e481001041557t1f87f8d4i959abbbee0c4346@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753174Ab0AGQAI@vger.kernel.org>
In-Reply-To: <45a44e481001041557t1f87f8d4i959abbbee0c4346@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-usb@vger.kernel.org, oliver@neukum.org, linux-input@vger.kernel.org, jkosina@suse.cz, linux-fbdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Jaya Kumar wrote:
> On Tue, Dec 15, 2009 at 5:22 AM, Rick L. Vinyard Jr.
> <rvinyard@cs.nmsu.edu> wrote:
>> Additionally, this device contains a 160x43 monochrome LCD display.
>> A registered framebuffer device manages this display. The design
>> of this portion of the driver was based on the design of the
>> hecubafb driver with deferred framebuffer I/O since there is
>> no real memory to map.
>
> Hi Rick,
>
> Interesting work. I recommend CCing linux-fbdev@vger.kernel.org too
> since it contains a fbdev interface.
>

Thanks. Added.

>> +config LOGITECH_G13
>> + =A0 =A0 =A0 tristate "Logitech G13 gameboard support"
>> + =A0 =A0 =A0 depends on HID_LOGITECH
>> + =A0 =A0 =A0 depends on FB
>> + =A0 =A0 =A0 select FB_SYS_FILLRECT
>> + =A0 =A0 =A0 select FB_SYS_COPYAREA
>> + =A0 =A0 =A0 select FB_SYS_IMAGEBLIT
>> + =A0 =A0 =A0 select FB_SYS_FOPS
>
> Does this need to select FB_DEFERRED_IO?
>

Added.

>> --- /dev/null
>> +++ b/drivers/hid/hid-g13-logo.xbm
>> @@ -0,0 +1,75 @@
>> +#define g13_lcd_width 160
>> +#define g13_lcd_height 43
>> +static unsigned char g13_lcd_bits[] =3D {
>> + =A0 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x=
00,
>> 0x00,
>
> Was there a reason for having a new logo file? If so, you might want
> to put it in the comments and also put it together with the standard
> kernel logo.
>

There really isn't a need for a separate file since it's pretty small. =
I
only separated it out to make it more visible.

I moved it inline, and resized, cleaned up, and inverted the default
penguin monochrome logo down to 40x40 from 80x80.

If anyone would like to add the 40x40 version of tux I made I'd be happ=
y
to provide it.

>> +/* 160*43 rounded to nearest whole byte which is 160*48 since bytes=
 are
>> + =A0 vertical the y component must be a multiple of 8 */
>> +#define G13FB_SIZE (160*48/8)
>
> Minor nit, I think there is a macro for this, DIV_ROUND_UP, or maybe
> this could be better done in the function that uses this value.
>

It's used in several places so I'd prefer to keep the #define as I thin=
k
it makes the code more readable. As it turned out, this was a minor bug
left from an earlier iteration of the driver (before I added the
framebuffer code). The actual size need for the framebuffer is simply t=
he
line length (160/8) * height (43).

The vbitmap of vertical bits actually transmitted still needs the round=
ing
plus a 32 byte offset at the beginning, resulting in a buffer of size 9=
92.
I hard coded this into the #define and put the calculation in a comment=
=2E

>> +static ssize_t g13_set_mled(struct hid_device *hdev, unsigned mled)=
;
>
> Does this need to be here or can the code be reordered?
>

Reordered.

>> +static struct fb_var_screeninfo g13fb_var =3D {
>> + =A0 =A0 =A0 .xres =3D G13FB_WIDTH,
>> + =A0 =A0 =A0 .yres =3D G13FB_HEIGHT,
>> + =A0 =A0 =A0 .xres_virtual =3D G13FB_WIDTH,
>> + =A0 =A0 =A0 .yres_virtual =3D G13FB_HEIGHT,
>> + =A0 =A0 =A0 .bits_per_pixel =3D 1,
>> + =A0 =A0 =A0 .nonstd =3D 1,
>> +};
>
> I think the nonstd is a bug. Yes, hecubafb and metronomefb seem to
> have the same bug as well. nonstd is used if you want something like
> FB_NONSTD_HAM or FB_NONSTD_REV_PIX_IN_B, which I don't think is what
> you want.
>

Removed.

> Hope this helps.
>
> Best regards,
> jaya
>

It definitely did. Thanks.

---

Rick

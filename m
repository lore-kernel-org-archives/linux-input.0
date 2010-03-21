From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH v2 2/6] hid: add framebuffer support to PicoLCD device
Date: Sun, 21 Mar 2010 15:24:36 +0800
Message-ID: <45a44e481003210024l2c66938fp9436d34f6473f811@mail.gmail.com>
References: <20100320170014.440959a8@neptune.home>
	 <20100320170415.6ee219c8@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62877 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0CUHYh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Mar 2010 03:24:37 -0400
In-Reply-To: <20100320170415.6ee219c8@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>

Hi Bruno,

On Sun, Mar 21, 2010 at 12:04 AM, Bruno Pr=E9mont
<bonbons@linux-vserver.org> wrote:
> Add framebuffer support to PicoLCD device with use of deferred-io.
>
> Only changed areas of framebuffer get sent to device in order to
> save USB bandwidth and especially resources on PicoLCD device or
> allow higher refresh rate for a small area.

Interesting work. One minor comment, defio doesn't currently guarantee
that it is "changed areas". Just that it is "written" pages which
typically equates to "changed" but does not guarantee this.

>
> Signed-off-by: Bruno Pr=E9mont <bonbons@linux-vserver.org>
> ---
> =A0drivers/hid/Kconfig =A0 =A0 =A0 | =A0 =A07 +-
> =A0drivers/hid/hid-picolcd.c | =A0454 +++++++++++++++++++++++++++++++=
++++++++++++++
> =A02 files changed, 460 insertions(+), 1 deletions(-)

It is customary for framebuffer drivers to live in drivers/video. This
is the first one I've reviewed that is outside of it. Is there a good
reason for this one to be outside of it? If so, could you put it in
the comments.

>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 7097f0a..a474bcd 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -230,6 +230,11 @@ config HID_PETALYNX
> =A0config HID_PICOLCD
> =A0 =A0 =A0 =A0tristate "PicoLCD (graphic version)"
> =A0 =A0 =A0 =A0depends on USB_HID
> + =A0 =A0 =A0 select FB_DEFERRED_IO if FB
> + =A0 =A0 =A0 select FB_SYS_FILLRECT if FB
> + =A0 =A0 =A0 select FB_SYS_COPYAREA if FB
> + =A0 =A0 =A0 select FB_SYS_IMAGEBLIT if FB
> + =A0 =A0 =A0 select FB_SYS_FOPS if FB

I think all of that "if FB" stuff looks odd, it would disappear if it
were in the right Kconfig.

> +/* Framebuffer visual structures */
> +static const struct fb_fix_screeninfo picolcdfb_fix =3D {
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0=3D PICOLCDFB_NAME,
> + =A0 =A0 =A0 .type =A0 =A0 =A0 =A0=3D FB_TYPE_PACKED_PIXELS,
> + =A0 =A0 =A0 .visual =A0 =A0 =A0=3D FB_VISUAL_MONO01,

Interesting choice. Out of curiosity, which fb client application are
you testing/using this with?

> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Translate the XBM format screen_base into the form=
at needed by the
> + =A0 =A0 =A0 =A0* PicoLCD. See display layout above.
> + =A0 =A0 =A0 =A0* Do this one tile after the other and push those ti=
les that changed.
> + =A0 =A0 =A0 =A0*/

I think screen_base is in standard fb format, which you've specified
as MONO01 above. When you say, XBM format, in the above comment is it
exactly the same?

Thanks,
jaya
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

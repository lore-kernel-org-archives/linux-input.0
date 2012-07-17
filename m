From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v3] Input: synaptics - handle out of bounds values from
 the hardware
Date: Tue, 17 Jul 2012 10:21:51 +0800
Message-ID: <CAGS+omDkgJA_wvdsGtowjpq5AJF8q2+oVefbsozTS19kxdNJGg@mail.gmail.com>
References: <1340994138-8969-1-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:49802 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908Ab2GQCWM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jul 2012 22:22:12 -0400
Received: by ghrr11 with SMTP id r11so5703262ghr.19
        for <linux-input@vger.kernel.org>; Mon, 16 Jul 2012 19:22:11 -0700 (PDT)
In-Reply-To: <1340994138-8969-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Sat, Jun 30, 2012 at 2:22 AM, Seth Forshee
<seth.forshee@canonical.com> wrote:
> The touchpad on the Acer Aspire One D250 will report out of range values
> in the extreme lower portion of the touchpad. These appear as abrupt
> changes in the values reported by the hardware from very low values to
> very high values, which can cause unexpected vertical jumps in the
> position of the mouse pointer.
>
> What seems to be happening is that the value is wrapping to a two's
> compliment negative value of higher resolution than the 13-bit value
> reported by the hardware, with the high-order bits being truncated. The
> safest way to deal with this is to clamp any out of bounds values to the
> minimum or maximum value for the axis.
>
> Distinguishing between positive and negative is problematic, since we
> lack definitive sign information in the value reported by the hardware.
> The approach taken here is to split the difference between the maximum
> legitimate value for the axis and the maximum possible value that the
> hardware can report, treating values greater than this number as
> negative and all other values as positive. This can be tweaked later if
> hardware is found that operates outside of these parameters.
>
> BugLink: http://bugs.launchpad.net/bugs/1001251
> Cc: stable@vger.kernel.org
> Cc: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> ---
>  drivers/input/mouse/synaptics.c |   27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index c6d9869..698f1b8 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -40,6 +40,10 @@
>   * Note that newer firmware allows querying device for maximum useable
>   * coordinates.
>   */
> +#define XMIN 0
> +#define XMAX 6143
> +#define YMIN 0
> +#define YMAX 6143
>  #define XMIN_NOMINAL 1472
>  #define XMAX_NOMINAL 5472
>  #define YMIN_NOMINAL 1408
> @@ -555,6 +559,29 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
>                 hw->right = (buf[0] & 0x02) ? 1 : 0;
>         }
>
> +       /*
> +        * Some hardware is known to wrap negative on the y axis,
> +        * providing the low-order bits of a higher resolution negative
> +        * number as a 13-bit unsigned value. No hardware is known to
> +        * give out-of-bounds values on the high end, but since we're
> +        * dealing with unspecified behavior we take a conservative
> +        * approach to handling the out of bounds values.
> +        *
> +        * Clamp out of bounds values to the minimum or maximum value
> +        * for the axis. Use the midpoint between the maximum axis
> +        * value and maximum possible reported value as the dividing
> +        * line between positive and negative values.
> +        */
> +       if (hw->x > ((1 << 13) + XMAX) / 2)

These are constants too, it might be clearer to define:

/*
 * Values reported above these limits are considered "wrapped around
negative numbers",
 * and are clipped to XMIN/YMIN.
 */
#define X_MAX_POSITIVE  ((1 << 13) + XMAX) / 2)
#define Y_MAX_POSITIVE  ((1 << 13) + YMAX) / 2)

> +               hw->x = XMIN;

IMHO, though, I think it might be better to just report the negative
value rather than clamping.  Clamping like this introduces a dead zone
on the trackpad, which leads to a degraded user experience on at least
one real, known, device, whereas clamping might prevent a potential
problem on other, unknown, devices.  This doesn't seem like the best
tradeoff.

-Dan

> +       else if (hw->x > XMAX)
> +               hw->x = XMAX;
> +
> +       if (hw->y > ((1 << 13) + YMAX) / 2)
> +               hw->y = YMIN;
> +       else if (hw->y > YMAX)
> +               hw->y = YMAX;
> +
>         return 0;
>  }
>
> --
> 1.7.9.5

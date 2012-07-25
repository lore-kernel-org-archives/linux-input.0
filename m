From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v4] Input: synaptics - handle out of bounds values from
 the hardware
Date: Wed, 25 Jul 2012 10:50:15 +0800
Message-ID: <CAGS+omAJD9CH-1fbiWae6SDiXMaz+b09TG9wusNmD5Q_SGBLFg@mail.gmail.com>
References: <CAGS+omDkgJA_wvdsGtowjpq5AJF8q2+oVefbsozTS19kxdNJGg@mail.gmail.com>
 <1343158279-25308-1-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:62880 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886Ab2GYCug (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jul 2012 22:50:36 -0400
Received: by mail-qc0-f174.google.com with SMTP id o28so153309qcr.19
        for <linux-input@vger.kernel.org>; Tue, 24 Jul 2012 19:50:35 -0700 (PDT)
In-Reply-To: <1343158279-25308-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, Jul 25, 2012 at 3:31 AM, Seth Forshee
<seth.forshee@canonical.com> wrote:
> The touchpad on the Acer Aspire One D250 will report out of range values
> in the extreme lower portion of the touchpad. These appear as abrupt
> changes in the values reported by the hardware from very low values to
> very high values, which can cause unexpected vertical jumps in the
> position of the mouse pointer.
>
> What seems to be happening is that the value is wrapping to a two's
> compliment negative value of higher resolution than the 13-bit value
> reported by the hardware, with the high-order bits being truncated. This
> patch adds handling for these values by converting them to the
> appropriate negative values.
>
> The only tricky part about this is deciding when to treat a number as
> negative. It stands to reason that if out of range values can be
> reported on the low end then it could also happen on the high end, so
> not all out of range values should be treated as negative. The approach
> taken here is to split the difference between the maximum legitimate
> value for the axis and the maximum possible value that the hardware can
> report, treating values greater than this number as negative and all
> other values as positive. This can be tweaked later if hardware is found
> that operates outside of these parameters.
>
> BugLink: http://bugs.launchpad.net/bugs/1001251
> Cc: stable@vger.kernel.org
> Cc: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> ---
>  drivers/input/mouse/synaptics.c |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index c6d9869..ce345c5 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -40,11 +40,27 @@
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
>  #define YMAX_NOMINAL 4448
>
> +/* Size in bits of absolute position values reported by the hardware */
> +#define ABS_POS_BITS 13
> +
> +/*
> + * Any position values from the hardware above the following limits are
> + * treated as "wrapped around negative" values that have been truncated to
> + * the 13-bit reporting range of the hardware. These are just reasonable
> + * guesses and can be adjusted if hardware is found that operates outside
> + * of these parameters.
> + */
> +#define X_MAX_POSITIVE (((1 << ABS_POS_BITS) + XMAX) / 2)
> +#define Y_MAX_POSITIVE (((1 << ABS_POS_BITS) + YMAX) / 2)
>
>  /*****************************************************************************
>   *     Stuff we need even when we do not want native Synaptics support
> @@ -555,6 +571,12 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
>                 hw->right = (buf[0] & 0x02) ? 1 : 0;
>         }
>
> +       /* Convert wrap-around values to negative */
> +       if (hw->x > X_MAX_POSITIVE)
> +               hw->x = hw->x - (1 << ABS_POS_BITS);

Hi Seth,

Perhaps:
hw->x -= (1 << ABS_POS_BITS);

Either way, it looks good, thanks!

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>


> +       if (hw->y > Y_MAX_POSITIVE)
> +               hw->y = hw->y - (1 << ABS_POS_BITS);
> +
>         return 0;
>  }
>
> --
> 1.7.9.5

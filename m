From: "J.R. Mauro" <jrm8005@gmail.com>
Subject: Re: [PATCH] input: Add a detailed multi-touch finger data report protocol
Date: Fri, 7 Nov 2008 08:34:49 -0500
Message-ID: <3aaafc130811070534p54eebeb6q9b57d3e847ed859a@mail.gmail.com>
References: <49142351.9080805@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:24840 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbYKGNeu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Nov 2008 08:34:50 -0500
In-Reply-To: <49142351.9080805@euromail.se>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 7, 2008 at 6:15 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> In order to utilize the full power of the new multi-touch devices, a
> way to report detailed finger data to user space is needed. This patch
> adds a multi-touch (MT) protocol which allows drivers to report details
> for an arbitrary number of fingers.

This is a great idea, Henrik. How will things like X11 go about
leveraging this functionality?

>
> BTN_MT_REPORT_PACKET
>
> The driver presses this button to indicate the start of a packet of
> finger data. The button is released after the whole packet has been
> reported.
>
> BTN_MT_REPORT_FINGER
>
> The driver presses this button to indicate the start of a new
> finger. The button is released when the finger has been reported.
>
> In order to stay compatible with existing applications, the data
> reported in a finger packet must not be recognized as single-touch
> events. Therefore, a specific set of ABS_MT events is used instead.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
>  include/linux/input.h |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/input.h b/include/linux/input.h
> index b86fb55..c82dd42 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -590,6 +590,9 @@ struct input_absinfo {
>  #define KEY_NUMERIC_STAR       0x20a
>  #define KEY_NUMERIC_POUND      0x20b
>
> +#define BTN_MT_REPORT_PACKET   0x210   /* report multitouch packet data */
> +#define BTN_MT_REPORT_FINGER   0x211   /* report multitouch finger data */
> +
>  /* We avoid low common keys in module aliases so they don't get huge. */
>  #define KEY_MIN_INTERESTING    KEY_MUTE
>  #define KEY_MAX                        0x2ff
> @@ -642,6 +645,15 @@ struct input_absinfo {
>  #define ABS_TOOL_WIDTH         0x1c
>  #define ABS_VOLUME             0x20
>  #define ABS_MISC               0x28
> +#define ABS_MT_TOUCH           0x30    /* Diameter of touching circle */
> +#define ABS_MT_TOUCH_MAJOR     0x30    /* Major axis of touching ellipse */
> +#define ABS_MT_TOUCH_MINOR     0x31    /* Minor axis of touching ellipse */
> +#define ABS_MT_WIDTH           0x32    /* Diameter of approaching circle */
> +#define ABS_MT_WIDTH_MAJOR     0x32    /* Major axis of approaching ellipse */
> +#define ABS_MT_WIDTH_MINOR     0x33    /* Minor axis of approaching ellipse */
> +#define ABS_MT_ORIENTATION     0x34    /* Ellipse orientation */
> +#define ABS_MT_POSITION_X      0x35    /* Center X ellipse position */
> +#define ABS_MT_POSITION_Y      0x36    /* Center Y ellipse position */
>  #define ABS_MAX                        0x3f
>  #define ABS_CNT                        (ABS_MAX+1)
>
> --
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

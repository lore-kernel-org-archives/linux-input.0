From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] Input: synaptics - fix compile warning
Date: Mon, 23 Apr 2012 18:30:36 +0800
Message-ID: <CAGS+omCjCTBZ9M782kOV9kU8T7zZzF+uz10KfbZUDy=HWgZXxQ@mail.gmail.com>
References: <1335173474-15758-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48273 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913Ab2DWKa5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 06:30:57 -0400
Received: by iadi9 with SMTP id i9so1842670iad.19
        for <linux-input@vger.kernel.org>; Mon, 23 Apr 2012 03:30:56 -0700 (PDT)
In-Reply-To: <1335173474-15758-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, JJ Ding <dgdunix@gmail.com>

On Mon, Apr 23, 2012 at 5:31 PM, JJ Ding <jj_ding@emc.com.tw> wrote:
> From: JJ Ding <dgdunix@gmail.com>
>
> Move synaptics_invert_y() inside CONFIG_MOUSE_PS2_SYNAPTICS to get rid of
> a compile warning when we don't select synaptics support.
>
> drivers/input/mouse/synaptics.c:53:12: warning: 'synaptics_invert_y' defined but not used [-Wunused-function]
>
> Cc: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: JJ Ding <dgdunix@gmail.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>  drivers/input/mouse/synaptics.c |   20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 8081a0a..c778f27 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -45,16 +45,6 @@
>  #define YMIN_NOMINAL 1408
>  #define YMAX_NOMINAL 4448
>
> -/*
> - * Synaptics touchpads report the y coordinate from bottom to top, which is
> - * opposite from what userspace expects.
> - * This function is used to invert y before reporting.
> - */
> -static int synaptics_invert_y(int y)
> -{
> -       return YMAX_NOMINAL + YMIN_NOMINAL - y;
> -}
> -
>
>  /*****************************************************************************
>  *     Stuff we need even when we do not want native Synaptics support
> @@ -112,6 +102,16 @@ void synaptics_reset(struct psmouse *psmouse)
>  ****************************************************************************/
>
>  /*
> + * Synaptics touchpads report the y coordinate from bottom to top, which is
> + * opposite from what userspace expects.
> + * This function is used to invert y before reporting.
> + */
> +static int synaptics_invert_y(int y)
> +{
> +       return YMAX_NOMINAL + YMIN_NOMINAL - y;
> +}
> +
> +/*
>  * Send a command to the synpatics touchpad by special commands
>  */
>  static int synaptics_send_cmd(struct psmouse *psmouse, unsigned char c, unsigned char *param)
> --
> 1.7.10
>

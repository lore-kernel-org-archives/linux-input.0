From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] alps: rushmore and v7 resolution support
Date: Tue, 29 Jul 2014 12:45:27 -0700
Message-ID: <20140729194527.GA34989@core.coreip.homeip.net>
References: <1406621252-5569-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:38538 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbaG2Tpe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 15:45:34 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so150947pdi.20
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 12:45:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406621252-5569-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org

Hi Hans,

On Tue, Jul 29, 2014 at 10:07:32AM +0200, Hans de Goede wrote:
> Add support for querying the physical size from the touchpad for rushmore
> and v7 touchpads, and use that to tell userspace the device resolution.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/mouse/alps.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/input/mouse/alps.h |  2 ++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index ac9fdbd..1531387 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1783,6 +1783,45 @@ error:
>  	return -1;
>  }
>  
> +static int alps_get_v3_v7_resolution(struct psmouse *psmouse, int reg_pitch)
> +{
> +	int reg, x_pitch, y_pitch, x_electrode, y_electrode, x_phys, y_phys;
> +	struct alps_data *priv = psmouse->private;
> +
> +	reg = alps_command_mode_read_reg(psmouse, reg_pitch);
> +	if (reg < 0)
> +		return reg;
> +
> +	x_pitch = (char)(reg << 4) >> 4; /* sign extend lower 4 bits */
> +	x_pitch = 50 + 2 * x_pitch; /* In 0.1 mm units */
> +
> +	y_pitch = (char)reg >> 4; /* sign extend upper 4 bits */
> +	y_pitch = 36 + 2 * y_pitch; /* In 0.1 mm units */
> +
> +	reg = alps_command_mode_read_reg(psmouse, reg_pitch + 1);
> +	if (reg < 0)
> +		return reg;
> +
> +	x_electrode = (char)(reg << 4) >> 4; /* sign extend lower 4 bits */
> +	x_electrode = 17 + x_electrode;
> +
> +	y_electrode = (char)reg >> 4; /* sign extend upper 4 bits */
> +	y_electrode = 13 + y_electrode;
> +
> +	x_phys = x_pitch * (x_electrode - 1); /* In 0.1 mm units */
> +	y_phys = y_pitch * (y_electrode - 1); /* In 0.1 mm units */
> +
> +	priv->x_res = priv->x_max * 10 / x_phys; /* units / mm */
> +	priv->y_res = priv->y_max * 10 / y_phys; /* units / mm */
> +
> +	psmouse_info(psmouse,
> +		"alps: pitch %dx%d num-electrodes %dx%d physical size %dx%d mm res %dx%d\n",
> +		x_pitch, y_pitch, x_electrode, y_electrode,
> +		x_phys / 10, y_phys / 10, priv->x_res, priv->y_res);

I changed it to psmouse_dbg and applied.

Thanks.

-- 
Dmitry

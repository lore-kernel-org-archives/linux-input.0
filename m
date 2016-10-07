From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/01] drivers:input:byd fix greedy detection of Sentelic
 FSP by the BYD touchpad driver
Date: Fri, 7 Oct 2016 16:37:26 -0700
Message-ID: <20161007233726.GB21386@dtor-ws>
References: <20161007044148.ssgxygdvmiwjsb55@sherka.pkbd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33106 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbcJGXh3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 19:37:29 -0400
Content-Disposition: inline
In-Reply-To: <20161007044148.ssgxygdvmiwjsb55@sherka.pkbd.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christophe Tordeux <christophe@tordeux.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org

Hi Christophe,

On Fri, Oct 07, 2016 at 12:41:48PM +0800, Christophe Tordeux wrote:
> From: Christophe TORDEUX <christophe@tordeux.net>
> 
> With kernel v4.6 and later, the Sentelic touchpad STL3888_C0 and
> probably other Sentelic FSP touchpads are detected as a BYD touchpad and
> lose multitouch features.
> 
> During the BYD handshake in the byd_detect function, the BYD driver
> mistakenly interprets a standard PS/2 protocol status request answer
> from the Sentelic touchpad as a successful handshake with a BYD
> touchpad. This is clearly a bug of the BYD driver.
> 
> Description of the patch: In byd_detect function, remove positive
> detection result based on standard PS/2 protocol status request answer.
> Replace it with positive detection based on handshake answers as they
> can be inferred from the BYD touchpad datasheets found on BYD website.
> 
> Signed-off-by: Christophe TORDEUX <christophe@tordeux.net>

What devices was this tested on? Do you have both BYD and Sentelic
devices?

I am really concerned about docs on BYD side as they seem to contradict
each other... I wonder how accurate they are.

Thanks.

> 
> ---
> Resubmitting this patch because I got no feedback on my first 
> submission.
> Fixes kernel bug 175421 which is impacting multiple users.
> 
> ---
>  drivers/input/mouse/byd.c | 76 
>  ++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 62 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
> index b27aa63..b5acca0 100644
> --- a/drivers/input/mouse/byd.c
> +++ b/drivers/input/mouse/byd.c
> @@ -35,6 +35,18 @@
>   * BYD pad constants
>   */
>  
> +/* Handshake answer of BTP6034 */
> +#define BYD_MODEL_BTP6034	0x00E801
> +/* Handshake answer of BTP6740 */
> +#define BYD_MODEL_BTP6740	0x001155
> +/* Handshake answers of BTP8644, BTP10463 and BTP11484 */
> +#define BYD_MODEL_BTP8644	0x011155
> +
> +/* Handshake SETRES byte of BTP6034 and BTP6740 */
> +#define BYD_SHAKE_BYTE_A	0x00
> +/* Handshake SETRES byte of BTP8644, BTP10463 and BTP11484 */
> +#define BYD_SHAKE_BYTE_B	0x03
> +
>  /*
>   * True device resolution is unknown, however experiments show the
>   * resolution is about 111 units/mm.
> @@ -434,23 +446,59 @@ static void byd_disconnect(struct psmouse *psmouse)
>  	}
>  }
>  
> +u32 byd_try_model(u32 model)
> +{
> +	size_t i;
> +
> +	u32 byd_model[] = {
> +		BYD_MODEL_BTP6034,
> +		BYD_MODEL_BTP6740,
> +		BYD_MODEL_BTP8644
> +	};
> +
> +	for (i=0; i < ARRAY_SIZE(byd_model); i++) {
> +		if (model ==  byd_model[i])
> +			return model;
> +	}
> +
> +	return 0;
> +}
> +
>  int byd_detect(struct psmouse *psmouse, bool set_properties)
>  {
>  	struct ps2dev *ps2dev = &psmouse->ps2dev;
> -	u8 param[4] = {0x03, 0x00, 0x00, 0x00};
> -
> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> -		return -1;
> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> -		return -1;
> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> -		return -1;
> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> -		return -1;
> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
> -		return -1;
> -
> -	if (param[1] != 0x03 || param[2] != 0x64)
> +	size_t i;
> +
> +	u8 byd_shbyte[] = {
> +		BYD_SHAKE_BYTE_A,
> +		BYD_SHAKE_BYTE_B
> +	};
> +
> +	bool detect = false;
> +	for (i=0; i < ARRAY_SIZE(byd_shbyte); i++) {
> +		u32 model;
> +		u8 param[4] = {byd_shbyte[i], 0x00, 0x00, 0x00};
> +
> +		if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> +			return -1;
> +		if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> +			return -1;
> +		if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> +			return -1;
> +		if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> +			return -1;
> +		if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
> +			return -1;
> +
> +		model = param[2];
> +		model += param[1] << 8;
> +		model += param[0] << 16;
> +		model = byd_try_model(model);
> +		if (model)
> +			detect = true;
> +	}
> +
> +	if (!detect)
>  		return -ENODEV;
>  
>  	psmouse_dbg(psmouse, "BYD touchpad detected\n");



-- 
Dmitry

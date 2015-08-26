From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: psmouse - add small delay for IBM trackpoint
 pass-through mode
Date: Wed, 26 Aug 2015 13:13:20 -0700
Message-ID: <20150826201320.GA7754@dtor-ws>
References: <1439649618-3366-1-git-send-email-sassmann@kpanic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34622 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbbHZUNX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Aug 2015 16:13:23 -0400
Content-Disposition: inline
In-Reply-To: <1439649618-3366-1-git-send-email-sassmann@kpanic.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Assmann <sassmann@kpanic.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 15, 2015 at 04:40:18PM +0200, Stefan Assmann wrote:
> There are trackpoint devices that fail to respond to the PS2 command
> PSMOUSE_CMD_GETID if immediately queried after the parent device is
> deactivated. Add a small delay for the hardware to get in a sane state
> before sending any PS2 commands.
> 
> One example of such a system is:
> Lenovo ThinkPad X120e, model 30515QG
> synaptics: Touchpad model: 1, fw: 8.0, id: 0x1e2b1, caps: 0xd001a3/0x940300/0x121c00, board id: 1811, fw id: 797391
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>

Applied, thank you.

> ---
>  drivers/input/mouse/psmouse-base.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index ec347703..ad18dab 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -1540,6 +1540,10 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
>  	if (error)
>  		goto err_clear_drvdata;
>  
> +	/* give PT device some time to settle down before probing */
> +	if (serio->id.type == SERIO_PS_PSTHRU)
> +		usleep_range(10000, 15000);
> +
>  	if (psmouse_probe(psmouse) < 0) {
>  		error = -ENODEV;
>  		goto err_close_serio;
> -- 
> 2.4.3
> 

-- 
Dmitry

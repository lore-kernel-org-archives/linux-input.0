From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] serio: add support for PS2Mult multiplexer protocol
Date: Thu, 12 Aug 2010 20:33:42 -0700
Message-ID: <20100813033342.GC2661@core.coreip.homeip.net>
References: <1281605513-11586-1-git-send-email-dbaryshkov@gmail.com>
 <1281605513-11586-3-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57735 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab0HMDds (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Aug 2010 23:33:48 -0400
Received: by pzk26 with SMTP id 26so666301pzk.19
        for <linux-input@vger.kernel.org>; Thu, 12 Aug 2010 20:33:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281605513-11586-3-git-send-email-dbaryshkov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, Aug 12, 2010 at 01:31:51PM +0400, Dmitry Eremin-Solenikov wrote:
> +
> +static int ps2mult_serio_write(struct serio *serio, unsigned char data)
> +{
> +	struct ps2mult *psm = serio_get_drvdata(serio->parent);
> +	struct ps2mult_port *psmp = serio->port_data;
> +	int need_escape = 0;
> +
> +	mutex_lock(&psm->lock);

serio->write() is allowed to be called from interrupt contexts so you
should not be using mutex but a spinlock.

BTW, if anyone has time to annotate serio code with kerneldoc markups
that would be great.


> +	if (psm->cur_out_port != psmp->port) {
> +		psm->serio->write(psm->serio, psmp->sel);
> +		psm->cur_out_port = psmp->port;
> +		dev_dbg(&serio->dev, "switched to sel %02x\n", psmp->sel);
> +	}
> +	if (data == PS2MULT_ESCAPE
> +	 || data == PS2MULT_BSYNC
> +	 || data == PS2MULT_SESSION_START
> +	 || data == PS2MULT_SESSION_END
> +	 || memchr(ps2mult_selectors, data, PS2MULT_NUM_PORTS))
> +		need_escape = 1;

Use bool/true/false please. I'd also probably write

	need_escape = data == PS2MULT_ESCAPE ||
		      data == ...

> +
> +static int ps2mult_connect(struct serio *serio, struct serio_driver *drv)
> +{
> +	struct ps2mult *psm;
> +	int i;
> +	int rc;
> +
> +	if (!serio->write)
> +		return -EINVAL;
> +
> +	psm = kzalloc(sizeof(*psm), GFP_KERNEL);
> +	if (!psm)
> +		return -ENOMEM;
> +
> +	mutex_init(&psm->lock);
> +	psm->serio = serio;
> +
> +	serio_set_drvdata(serio, psm);
> +	serio_open(serio, drv);
> +

Here serio port is allowed to start sending the data. I do not believe
you are ready to receive it though. I think you need to create ports
first and then use start() to mark ports that have been regstered by
serio core as 'ready'. Probably i8042 could give you some ideas.

> index d2ae60d..1cf47e5 100644
> --- a/include/linux/serio.h
> +++ b/include/linux/serio.h
> @@ -155,6 +155,7 @@ static inline void serio_continue_rx(struct serio *serio)
>  #define SERIO_HIL_MLC	0x03
>  #define SERIO_PS_PSTHRU	0x05
>  #define SERIO_8042_XL	0x06
> +#define SERIO_PS2MULT_T	0x07

Why do you need new serio type? I'd stick with SERIO_I8042 so that you
do not need to patch atkbd/psmouse.

Thanks.

-- 
Dmitry

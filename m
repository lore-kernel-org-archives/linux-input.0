From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] serio: add support for PS2Mult multiplexer protocol
Date: Tue, 7 Sep 2010 22:35:00 -0700
Message-ID: <20100908053500.GA10400@core.coreip.homeip.net>
References: <1281957997-12959-1-git-send-email-dbaryshkov@gmail.com>
 <1281957997-12959-3-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47462 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab0IHFfI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Sep 2010 01:35:08 -0400
Received: by iwn5 with SMTP id 5so6024950iwn.19
        for <linux-input@vger.kernel.org>; Tue, 07 Sep 2010 22:35:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281957997-12959-3-git-send-email-dbaryshkov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On Mon, Aug 16, 2010 at 03:26:37PM +0400, Dmitry Eremin-Solenikov wrote:
> PS2Mult is a simple serial protocol used for multiplexing several PS/2 streams
> into one serial data stream. It's used e.g. on TQM85xx serie of boards.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/input/serio/Kconfig   |    8 ++
>  drivers/input/serio/Makefile  |    1 +
>  drivers/input/serio/ps2mult.c |  265 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/serio.h         |    2 +
>  4 files changed, 276 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/serio/ps2mult.c
> 
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index 3bfe8fa..63f4658 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -226,4 +226,12 @@ config SERIO_AMS_DELTA
>  	  To compile this driver as a module, choose M here;
>  	  the module will be called ams_delta_serio.
>  
> +config SERIO_PS2MULT
> +	tristate "TQC PS/2 multiplexer"
> +	help
> +	  Say Y here if you have the PS/2 line multiplexer like present on TQC boads
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ps2mult.
> +
>  endif
> diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
> index 84c80bf..26714c5 100644
> --- a/drivers/input/serio/Makefile
> +++ b/drivers/input/serio/Makefile
> @@ -24,3 +24,4 @@ obj-$(CONFIG_SERIO_RAW)		+= serio_raw.o
>  obj-$(CONFIG_SERIO_AMS_DELTA)	+= ams_delta_serio.o
>  obj-$(CONFIG_SERIO_XILINX_XPS_PS2)	+= xilinx_ps2.o
>  obj-$(CONFIG_SERIO_ALTERA_PS2)	+= altera_ps2.o
> +obj-$(CONFIG_SERIO_PS2MULT)	+= ps2mult.o
> diff --git a/drivers/input/serio/ps2mult.c b/drivers/input/serio/ps2mult.c
> new file mode 100644
> index 0000000..e9b7951
> --- /dev/null
> +++ b/drivers/input/serio/ps2mult.c
> @@ -0,0 +1,265 @@
> +/*
> + * TQC PS/2 Multiplexer driver
> + *
> + * Copyright (C) 2010 Dmitry Eremin-Solenikov
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/serio.h>
> +
> +MODULE_AUTHOR("Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>");
> +MODULE_DESCRIPTION("TQC PS/2 Multiplexer driver");
> +MODULE_LICENSE("GPL");
> +
> +#define PS2MULT_KB_SELECTOR		0xA0
> +#define PS2MULT_MS_SELECTOR		0xA1
> +#define PS2MULT_ESCAPE			0x7D
> +#define PS2MULT_BSYNC			0x7E
> +#define PS2MULT_SESSION_START		0x55
> +#define PS2MULT_SESSION_END		0x56
> +
> +struct ps2mult_port {
> +	struct serio *serio;
> +	unsigned char sel;
> +	unsigned char port;
> +};
> +
> +#define PS2MULT_NUM_PORTS	2
> +
> +struct ps2mult {
> +	struct serio *serio;
> +	struct ps2mult_port ports[PS2MULT_NUM_PORTS];
> +
> +	spinlock_t lock;
> +	unsigned char cur_out_port;
> +	unsigned char cur_in_port;

I wonder if instead of indices you should make them serio * pointers -
it will save a few cycles at the expense of about 14 bytes in the
structure.

> +	unsigned escape:1;

bool please.

> +};
> +
> +static unsigned char ps2mult_selectors[PS2MULT_NUM_PORTS] = {
> +	PS2MULT_KB_SELECTOR, PS2MULT_MS_SELECTOR,
> +};
> +
> +static struct serio_device_id ps2mult_serio_ids[] = {
> +	{
> +		.type	= SERIO_RS232,
> +		.proto	= SERIO_PS2MULT,
> +		.id	= SERIO_ANY,
> +		.extra	= SERIO_ANY,
> +	},
> +	{ 0 }
> +};
> +
> +MODULE_DEVICE_TABLE(serio, ps2mult_serio_ids);
> +
> +static int ps2mult_serio_write(struct serio *serio, unsigned char data)
> +{
> +	struct ps2mult *psm = serio_get_drvdata(serio->parent);
> +	struct ps2mult_port *psmp = serio->port_data;
> +	bool need_escape;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&psm->lock, flags);
> +	if (psm->cur_out_port != psmp->port) {
> +		psm->serio->write(psm->serio, psmp->sel);
> +		psm->cur_out_port = psmp->port;
> +		dev_dbg(&serio->dev, "switched to sel %02x\n", psmp->sel);
> +	}
> +
> +	need_escape = data == PS2MULT_ESCAPE
> +		   || data == PS2MULT_BSYNC
> +		   || data == PS2MULT_SESSION_START
> +		   || data == PS2MULT_SESSION_END
> +		   || memchr(ps2mult_selectors, data, PS2MULT_NUM_PORTS);

Maybe pull all commands into ps2mult_ctrl_bytes[] array and use single

	need_escape = memchr(ps2mult_ctrl_bytes, data, sizeof(ps2mult_ctrl_bytes));

?

> +
> +	dev_dbg(&serio->dev, "write: %s%02x\n",
> +			need_escape ? "ESC " : "", data);
> +
> +	if (need_escape)
> +		psm->serio->write(psm->serio, PS2MULT_ESCAPE);
> +	psm->serio->write(psm->serio, data);
> +
> +	spin_unlock_irqrestore(&psm->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int ps2mult_create_port(struct ps2mult *psm, int i)
> +{
> +	struct serio *serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
> +	if (!serio)
> +		return -ENOMEM;
> +
> +	strlcpy(serio->name, "TQC PS/2 Multiplexer", sizeof(serio->name));
> +	snprintf(serio->phys, sizeof(serio->phys),
> +			"%s/port%d", psm->serio->phys, i);
> +	serio->id.type = SERIO_PS2MULT_T;

I thought you were going to use SERIO_I8042?

> +	serio->write = ps2mult_serio_write;
> +	serio->parent = psm->serio;

You also need to define serio->stop() method that would mark appropriate
port as being dead and ensure that ps2mult_interrupt() does not try to use
ports that are being destroyed. Otherwise, during tear-down, when
children are being disconnected first, there potential to get interrupt
at a bad time.

> +
> +	serio->port_data = &psm->ports[i];
> +
> +	psm->ports[i].serio = serio;
> +	psm->ports[i].port = i;
> +	psm->ports[i].sel = ps2mult_selectors[i];
> +
> +	serio_register_port(serio);
> +	dev_info(&serio->dev, "%s port at %s\n", serio->name, psm->serio->phys);
> +
> +	return 0;
> +}
> +
> +static int ps2mult_reconnect(struct serio *serio)
> +{
> +	struct ps2mult *psm = serio_get_drvdata(serio);
> +
> +	serio->write(serio, PS2MULT_SESSION_END);
> +	serio->write(serio, PS2MULT_SESSION_START);
> +	psm->cur_out_port = 0;
> +	serio->write(serio, psm->ports[psm->cur_out_port].sel);
> +
> +	return 0;
> +}
> +
> +static void ps2mult_disconnect(struct serio *serio)
> +{
> +	struct ps2mult *psm = serio_get_drvdata(serio);
> +	int i;
> +
> +	serio->write(serio, PS2MULT_SESSION_END);
> +
> +	for (i = 0; i < PS2MULT_NUM_PORTS; i++)
> +		psm->ports[i].serio = NULL;

Meaningless since you free the structure couple of lines below.

> +
> +	serio_close(serio);
> +	serio_set_drvdata(serio, NULL);
> +
> +	kfree(psm);
> +}
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
> +	spin_lock_init(&psm->lock);
> +	psm->serio = serio;
> +
> +	serio_set_drvdata(serio, psm);
> +	serio_open(serio, drv);
> +
> +	for (i = 0; i <  PS2MULT_NUM_PORTS; i++) {
> +		rc = ps2mult_create_port(psm, i);
> +		if (rc)
> +			goto err_out;
> +	}

I'd move call to serio_open() here, just in case.

> +
> +	rc = ps2mult_reconnect(serio);
> +	if (rc)
> +		goto err_out;
> +
> +	return 0;
> +
> +err_out:
> +	ps2mult_disconnect(serio);
> +
> +	return rc;
> +}
> +
> +static void ps2mult_selector(struct ps2mult *psm, unsigned char data)
> +{
> +	int i;
> +
> +	dev_dbg(&psm->serio->dev, "Received selector %02x\n", data);
> +
> +	spin_lock(&psm->lock);

Why do you need this lock?

> +
> +	for (i = 0; i < PS2MULT_NUM_PORTS; i++)
> +		if (psm->ports[i].sel == data) {
> +			psm->cur_in_port = i;
> +			break;
> +		}
> +
> +	spin_unlock(&psm->lock);
> +}
> +
> +static irqreturn_t ps2mult_interrupt(struct serio *serio, unsigned char data,
> +		unsigned int flags)
> +{
> +	struct ps2mult *psm = serio_get_drvdata(serio);
> +
> +	dev_dbg(&serio->dev, "Received %02x flags %02x\n", data, flags);
> +	if (psm->escape) {
> +		serio_interrupt(psm->ports[psm->cur_in_port].serio,
> +				data, flags);
> +		psm->escape = 0;
> +	} else
> +	switch (data) {

Incorrect indentation.

> +	case PS2MULT_ESCAPE:
> +		dev_dbg(&serio->dev, "ESCAPE\n");
> +		psm->escape = 1;
> +		break;
> +	case PS2MULT_BSYNC:
> +		dev_dbg(&serio->dev, "BSYNC\n");
> +		psm->cur_in_port = psm->cur_out_port;
> +		break;
> +	case PS2MULT_SESSION_START:
> +		dev_dbg(&serio->dev, "SS\n");
> +		break;
> +	case PS2MULT_SESSION_END:
> +		dev_dbg(&serio->dev, "SE\n");
> +		break;
> +	case PS2MULT_KB_SELECTOR:
> +		dev_dbg(&serio->dev, "KB\n");
> +		ps2mult_selector(psm, data);
> +		break;
> +	case PS2MULT_MS_SELECTOR:
> +		dev_dbg(&serio->dev, "MS\n");
> +		ps2mult_selector(psm, data);

If there are only 2 ports why don't you do:

		psm->current_in_port = psm->ports[PSM_MOUSE_IDX].serio;

?

> +		break;
> +	default:
> +		serio_interrupt(psm->ports[psm->cur_in_port].serio,
> +				data, flags);
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static struct serio_driver ps2mult_drv = {
> +	.driver		= {
> +		.name	= "ps2mult",
> +	},
> +	.description	= "TQC PS/2 Multiplexer driver",
> +	.id_table	= ps2mult_serio_ids,
> +	.interrupt	= ps2mult_interrupt,
> +	.connect	= ps2mult_connect,
> +	.disconnect	= ps2mult_disconnect,
> +	.reconnect	= ps2mult_reconnect,
> +};
> +
> +static int __init ps2mult_init(void)
> +{
> +	return serio_register_driver(&ps2mult_drv);
> +}
> +
> +static void __exit ps2mult_exit(void)
> +{
> +	serio_unregister_driver(&ps2mult_drv);
> +}
> +
> +module_init(ps2mult_init);
> +module_exit(ps2mult_exit);
> diff --git a/include/linux/serio.h b/include/linux/serio.h
> index 861a72a..7257e6c 100644
> --- a/include/linux/serio.h
> +++ b/include/linux/serio.h
> @@ -156,6 +156,7 @@ static inline void serio_continue_rx(struct serio *serio)
>  #define SERIO_HIL_MLC	0x03
>  #define SERIO_PS_PSTHRU	0x05
>  #define SERIO_8042_XL	0x06
> +#define SERIO_PS2MULT_T	0x07
>  
>  /*
>   * Serio protocols
> @@ -200,5 +201,6 @@ static inline void serio_continue_rx(struct serio *serio)
>  #define SERIO_W8001	0x39
>  #define SERIO_DYNAPRO	0x3a
>  #define SERIO_HAMPSHIRE	0x3b
> +#define SERIO_PS2MULT	0x3c
>  
>  #endif
> -- 
> 1.7.1
> 

Still pondering your other patch...

Thanks.

-- 
Dmitry

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 1/2] Input: psmouse - add a custom serio protocol to
 send extra information
Date: Wed, 8 Feb 2017 18:51:26 +0100
Message-ID: <20170208175126.GF18493@mail.corp.redhat.com>
References: <20170206192327.GA17441@dtor-ws>
 <20170207162539.5577-1-benjamin.tissoires@redhat.com>
 <20170207162539.5577-2-benjamin.tissoires@redhat.com>
 <20170208082628.GA9231@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170208082628.GA9231@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Andrew Duggan <aduggan@synaptics.com>, Adrian Alves <aalves@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Feb 08 2017 or thereabouts, Dmitry Torokhov wrote:
> On Tue, Feb 07, 2017 at 05:25:38PM +0100, Benjamin Tissoires wrote:
> > The tracksticks on the Lenovo thinkpads have their buttons connected
> > through the touchpad device. We already fixed that in synaptics.c, but
> > when we switch the device into RMI4 mode to have proper support, the
> > pass-through functionality can't deal with them easily.
> > 
> > We add a new PS/2 flag and protocol designed for psmouse.
> > The RMI4 F03 pass-through can then emit a special set of commands
> > to notify psmouse the state of the buttons.
> > 
> > This patch implements the protocol in psmouse, while an other will
> > do the same for rmi4-f03.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Looks mostly good, but how about this one?

Thanks for the fix. There is one missing input_sync() in the OOB_DATA
case:

> 
> Thanks.
> 
> -- 
> Dmitry
> 
> 
> Input: psmouse - add a custom serio protocol to send extra information
> 
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> The tracksticks on the Lenovo thinkpads have their buttons connected
> through the touchpad device. We already fixed that in synaptics.c, but
> when we switch the device into RMI4 mode to have proper support, the
> pass-through functionality can't deal with them easily.
> 
> We add a new PS/2 flag and protocol designed for psmouse.  The RMI4 F03
> pass-through can then emit a special set of commands to notify psmouse the
> state of the buttons.
> 
> This patch implements the protocol in psmouse, while an other will
> do the same for rmi4-f03.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Patchwork-Id: 9560567
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/mouse/psmouse-base.c |   39 +++++++++++++++++++++++++++++++++---
>  drivers/input/mouse/psmouse.h      |    5 +++++
>  include/uapi/linux/serio.h         |    7 ++++--
>  3 files changed, 45 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index bee267424972..98a34105d5b0 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -127,6 +127,13 @@ struct psmouse_protocol {
>  	int (*init)(struct psmouse *);
>  };
>  
> +static void psmouse_report_standard_buttons(struct input_dev *dev, u8 buttons)
> +{
> +	input_report_key(dev, BTN_LEFT,   buttons & BIT(0));
> +	input_report_key(dev, BTN_MIDDLE, buttons & BIT(2));
> +	input_report_key(dev, BTN_RIGHT,  buttons & BIT(1));
> +}
> +
>  /*
>   * psmouse_process_byte() analyzes the PS/2 data stream and reports
>   * relevant events to the input module once full packet has arrived.
> @@ -199,9 +206,8 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
>  	}
>  
>  	/* Generic PS/2 Mouse */
> -	input_report_key(dev, BTN_LEFT,    packet[0]       & 1);
> -	input_report_key(dev, BTN_MIDDLE, (packet[0] >> 2) & 1);
> -	input_report_key(dev, BTN_RIGHT,  (packet[0] >> 1) & 1);
> +	psmouse_report_standard_buttons(dev,
> +					packet[0] | psmouse->extra_buttons);
>  
>  	input_report_rel(dev, REL_X, packet[1] ? (int) packet[1] - (int) ((packet[0] << 4) & 0x100) : 0);
>  	input_report_rel(dev, REL_Y, packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0);
> @@ -282,6 +288,28 @@ static int psmouse_handle_byte(struct psmouse *psmouse)
>  	return 0;
>  }
>  
> +static void psmouse_handle_oob_data(struct psmouse *psmouse, u8 data)
> +{
> +	switch (psmouse->oob_data_type) {
> +	case PSMOUSE_OOB_NONE:
> +		psmouse->oob_data_type = data;
> +		break;
> +
> +	case PSMOUSE_OOB_EXTRA_BTNS:
> +		psmouse_report_standard_buttons(psmouse->dev, data);

We should probably call input_sync(psmouse->dev) here or the buttons are
not forwarded until the trackstick gets touched.

With that fix:
Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

PS: I won't have the time to work on the other issues of the series this
week unfortunately :(

> +		psmouse->extra_buttons = data;
> +		psmouse->oob_data_type = PSMOUSE_OOB_NONE;
> +		break;
> +
> +	default:
> +		psmouse_warn(psmouse,
> +			     "unknown OOB_DATA type: 0x%02x\n",
> +			     psmouse->oob_data_type);
> +		psmouse->oob_data_type = PSMOUSE_OOB_NONE;
> +		break;
> +	}
> +}
> +
>  /*
>   * psmouse_interrupt() handles incoming characters, either passing them
>   * for normal processing or gathering them as command response.
> @@ -306,6 +334,11 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
>  		goto out;
>  	}
>  
> +	if (flags & SERIO_OOB_DATA) {
> +		psmouse_handle_oob_data(psmouse, data);
> +		goto out;
> +	}
> +
>  	if (unlikely(psmouse->ps2dev.flags & PS2_FLAG_ACK))
>  		if  (ps2_handle_ack(&psmouse->ps2dev, data))
>  			goto out;
> diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
> index e0ca6cda3d16..8c83b8e2505c 100644
> --- a/drivers/input/mouse/psmouse.h
> +++ b/drivers/input/mouse/psmouse.h
> @@ -1,6 +1,9 @@
>  #ifndef _PSMOUSE_H
>  #define _PSMOUSE_H
>  
> +#define PSMOUSE_OOB_NONE	0x00
> +#define PSMOUSE_OOB_EXTRA_BTNS	0x01
> +
>  #define PSMOUSE_CMD_SETSCALE11	0x00e6
>  #define PSMOUSE_CMD_SETSCALE21	0x00e7
>  #define PSMOUSE_CMD_SETRES	0x10e8
> @@ -53,6 +56,8 @@ struct psmouse {
>  	unsigned char pktcnt;
>  	unsigned char pktsize;
>  	unsigned char type;
> +	unsigned char oob_data_type;
> +	unsigned char extra_buttons;
>  	bool ignore_parity;
>  	bool acks_disable_command;
>  	unsigned int model;
> diff --git a/include/uapi/linux/serio.h b/include/uapi/linux/serio.h
> index f2447a83ac8d..ccd0ccd00f47 100644
> --- a/include/uapi/linux/serio.h
> +++ b/include/uapi/linux/serio.h
> @@ -17,9 +17,10 @@
>  /*
>   * bit masks for use in "interrupt" flags (3rd argument)
>   */
> -#define SERIO_TIMEOUT	1
> -#define SERIO_PARITY	2
> -#define SERIO_FRAME	4
> +#define SERIO_TIMEOUT	BIT(0)
> +#define SERIO_PARITY	BIT(1)
> +#define SERIO_FRAME	BIT(2)
> +#define SERIO_OOB_DATA	BIT(3)
>  
>  /*
>   * Serio types

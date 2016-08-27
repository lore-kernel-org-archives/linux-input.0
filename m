From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH 02/11] Input: serio - store the pt_buttons in the struct
 serio directly
Date: Fri, 26 Aug 2016 18:31:41 -0700
Message-ID: <6ee8236a-7632-1383-0ebb-bb08372a2db9@synaptics.com>
References: <1471512289-10648-1-git-send-email-benjamin.tissoires@redhat.com>
 <1471512289-10648-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:17214 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbcH0Bdd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Aug 2016 21:33:33 -0400
In-Reply-To: <1471512289-10648-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lyude Paul <thatslyude@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Resending as plain text

On 08/18/2016 02:24 AM, Benjamin Tissoires wrote:
> With RMI4 over SMBus, the pass-through device can be instantiated
> in a SMBus driver. However, compared to the psmouse-synaptics driver,
> this pass-through PS/2 driver has no clue whether the current
> serio_interrupt() is the beginning of the frame or not. Instead of
> adding a protocol analysis in RMI4 function F03, we can add an extra
> byte in struct serio to handle the extra data we want to append to the
> first byte.
>
> Convert the psmouse-synaptics device to use it too.
>
> Partially reverts cdd9dc1 ("Input: synaptics - re-route tracksticks
> buttons on the Lenovo 2015 series")
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Acked-by: Andrew Duggan <aduggan@synaptics.com>


> ---
>  drivers/input/mouse/psmouse-base.c |  3 +++
>  drivers/input/mouse/synaptics.c    | 19 ++++++++++---------
>  drivers/input/mouse/synaptics.h    |  1 -
>  include/linux/serio.h              |  8 ++++++++
>  4 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index 5784e20..dbc002a 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -365,6 +365,9 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
>  		goto out;
>  	}
>
> +	if (psmouse->pktcnt == 1)
> +		psmouse->packet[0] |= serio->extra_byte;
> +
>  	psmouse->last = jiffies;
>  	psmouse_handle_byte(psmouse);
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index a41d832..8781e23 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -597,15 +597,13 @@ static int synaptics_is_pt_packet(unsigned char *buf)
>  	return (buf[0] & 0xFC) == 0x84 && (buf[3] & 0xCC) == 0xC4;
>  }
>
> -static void synaptics_pass_pt_packet(struct psmouse *psmouse,
> -				     struct serio *ptport,
> +static void synaptics_pass_pt_packet(struct serio *ptport,
>  				     unsigned char *packet)
>  {
> -	struct synaptics_data *priv = psmouse->private;
>  	struct psmouse *child = serio_get_drvdata(ptport);
>
>  	if (child && child->state == PSMOUSE_ACTIVATED) {
> -		serio_interrupt(ptport, packet[1] | priv->pt_buttons, 0);
> +		serio_interrupt(ptport, packet[1], 0);
>  		serio_interrupt(ptport, packet[4], 0);
>  		serio_interrupt(ptport, packet[5], 0);
>  		if (child->pktsize == 4)
> @@ -857,6 +855,7 @@ static void synaptics_report_ext_buttons(struct psmouse *psmouse,
>  	struct synaptics_data *priv = psmouse->private;
>  	int ext_bits = (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) + 1) >> 1;
>  	char buf[6] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
> +	int pt_buttons;
>  	int i;
>
>  	if (!SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
> @@ -887,11 +886,13 @@ static void synaptics_report_ext_buttons(struct psmouse *psmouse,
>  		return;
>
>  	/* The trackstick expects at most 3 buttons */
> -	priv->pt_buttons = SYN_CAP_EXT_BUTTON_STICK_L(hw->ext_buttons)      |
> -			   SYN_CAP_EXT_BUTTON_STICK_R(hw->ext_buttons) << 1 |
> -			   SYN_CAP_EXT_BUTTON_STICK_M(hw->ext_buttons) << 2;
> +	pt_buttons = SYN_CAP_EXT_BUTTON_STICK_L(hw->ext_buttons)      |
> +		     SYN_CAP_EXT_BUTTON_STICK_R(hw->ext_buttons) << 1 |
> +		     SYN_CAP_EXT_BUTTON_STICK_M(hw->ext_buttons) << 2;
> +
> +	priv->pt_port->extra_byte = pt_buttons;
>
> -	synaptics_pass_pt_packet(psmouse, priv->pt_port, buf);
> +	synaptics_pass_pt_packet(priv->pt_port, buf);
>  }
>
>  static void synaptics_report_buttons(struct psmouse *psmouse,
> @@ -1132,7 +1133,7 @@ static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse)
>  		if (SYN_CAP_PASS_THROUGH(priv->capabilities) &&
>  		    synaptics_is_pt_packet(psmouse->packet)) {
>  			if (priv->pt_port)
> -				synaptics_pass_pt_packet(psmouse, priv->pt_port,
> +				synaptics_pass_pt_packet(priv->pt_port,
>  							 psmouse->packet);
>  		} else
>  			synaptics_process_packet(psmouse);
> diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
> index 56faa7e..116ae25 100644
> --- a/drivers/input/mouse/synaptics.h
> +++ b/drivers/input/mouse/synaptics.h
> @@ -183,7 +183,6 @@ struct synaptics_data {
>  	bool disable_gesture;			/* disable gestures */
>
>  	struct serio *pt_port;			/* Pass-through serio port */
> -	unsigned char pt_buttons;		/* Pass-through buttons */
>
>  	/*
>  	 * Last received Advanced Gesture Mode (AGM) packet. An AGM packet
> diff --git a/include/linux/serio.h b/include/linux/serio.h
> index c733cff..f3b75c8 100644
> --- a/include/linux/serio.h
> +++ b/include/linux/serio.h
> @@ -64,6 +64,14 @@ struct serio {
>  	 * may get indigestion when exposed to concurrent access (i8042).
>  	 */
>  	struct mutex *ps2_cmd_mutex;
> +
> +	/*
> +	 * For use with Synaptics devices that have the trackstick buttons
> +	 * not actually wired to the trackstick PS/2 device.
> +	 * This byte will be OR-ed with the first byte of the incoming packet
> +	 * that contains actual data (not commands).
> +	 */
> +	u8 extra_byte;
>  };
>  #define to_serio_port(d)	container_of(d, struct serio, dev)
>
>


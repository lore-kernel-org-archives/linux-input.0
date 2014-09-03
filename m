From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 1/2] input: Add INPUT_PROP_POINTING_STICK property
Date: Wed, 3 Sep 2014 13:18:07 +1000
Message-ID: <20140903031807.GA17684@jelly.redhat.com>
References: <1409661804-10489-1-git-send-email-hdegoede@redhat.com>
 <1409661804-10489-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:35581 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbaICDSV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Sep 2014 23:18:21 -0400
Content-Disposition: inline
In-Reply-To: <1409661804-10489-2-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org

On Tue, Sep 02, 2014 at 02:43:23PM +0200, Hans de Goede wrote:
> It is useful for userspace to know that there not dealing with a regular
> mouse but rather with a pointing stick (e.g. a trackpoint) so that userspace
> can e.g. automatically enable middle button scrollwheel emulation.
> 
> It is impossible to tell the difference from the evdev info without resorting
> to putting a list of device / driver names in userspace, this is undesirable.
> 
> Add a property which allows userspace to see if a device is a pointing
> stick, and set it on all the pointing stick drivers.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

> ---
>  drivers/input/mouse/alps.c          | 3 +++
>  drivers/input/mouse/elantech.c      | 3 +++
>  drivers/input/mouse/synaptics_usb.c | 1 +
>  drivers/input/mouse/trackpoint.c    | 2 ++
>  include/uapi/linux/input.h          | 1 +
>  5 files changed, 10 insertions(+)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index a59a1a6..9de3c25 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2373,6 +2373,9 @@ int alps_init(struct psmouse *psmouse)
>  	dev2->keybit[BIT_WORD(BTN_LEFT)] =
>  		BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_MIDDLE) | BIT_MASK(BTN_RIGHT);
>  
> +	if (priv->flags & ALPS_DUALPOINT)
> +		__set_bit(INPUT_PROP_POINTING_STICK, dev2->propbit);
> +
>  	if (input_register_device(priv->dev2))
>  		goto init_fail;
>  
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 63533e5..c767f7e 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1607,6 +1607,9 @@ int elantech_init(struct psmouse *psmouse)
>  		tp_dev->keybit[BIT_WORD(BTN_LEFT)] =
>  			BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_MIDDLE) |
>  			BIT_MASK(BTN_RIGHT);
> +
> +		__set_bit(INPUT_PROP_POINTING_STICK, tp_dev->propbit);
> +
>  		error = input_register_device(etd->tp_dev);
>  		if (error < 0)
>  			goto init_fail_tp_reg;
> diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
> index e122bda..db3973d 100644
> --- a/drivers/input/mouse/synaptics_usb.c
> +++ b/drivers/input/mouse/synaptics_usb.c
> @@ -387,6 +387,7 @@ static int synusb_probe(struct usb_interface *intf,
>  		__set_bit(EV_REL, input_dev->evbit);
>  		__set_bit(REL_X, input_dev->relbit);
>  		__set_bit(REL_Y, input_dev->relbit);
> +		__set_bit(INPUT_PROP_POINTING_STICK, input_dev->propbit);
>  		input_set_abs_params(input_dev, ABS_PRESSURE, 0, 127, 0, 0);
>  	} else {
>  		input_set_abs_params(input_dev, ABS_X,
> diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> index ca843b6..b377462 100644
> --- a/drivers/input/mouse/trackpoint.c
> +++ b/drivers/input/mouse/trackpoint.c
> @@ -393,6 +393,8 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
>  	if ((button_info & 0x0f) >= 3)
>  		__set_bit(BTN_MIDDLE, psmouse->dev->keybit);
>  
> +	__set_bit(INPUT_PROP_POINTING_STICK, psmouse->dev->propbit);
> +
>  	trackpoint_defaults(psmouse->private);
>  
>  	error = trackpoint_power_on_reset(&psmouse->ps2dev);
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 19df18c..1874ebe 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -165,6 +165,7 @@ struct input_keymap_entry {
>  #define INPUT_PROP_BUTTONPAD		0x02	/* has button(s) under pad */
>  #define INPUT_PROP_SEMI_MT		0x03	/* touch rectangle only */
>  #define INPUT_PROP_TOPBUTTONPAD		0x04	/* softbuttons at top of pad */
> +#define INPUT_PROP_POINTING_STICK	0x05	/* is a pointing stick */
>  
>  #define INPUT_PROP_MAX			0x1f
>  #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
> -- 
> 2.1.0

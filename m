From: Benjamin Tissoires <btissoir@redhat.com>
Subject: Re: [PATCH 2/2] input/mouse: Add missing POINTER / DIRECT properties
 to a bunch of drivers
Date: Tue, 2 Sep 2014 10:38:34 -0400
Message-ID: <20140902143834.GC25423@mail.corp.redhat.com>
References: <1409661804-10489-1-git-send-email-hdegoede@redhat.com>
 <1409661804-10489-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56942 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbaIBOij (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Sep 2014 10:38:39 -0400
Content-Disposition: inline
In-Reply-To: <1409661804-10489-3-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

On Sep 02 2014 or thereabouts, Hans de Goede wrote:
> I've not done a full audit of all mouse drivers, I noticed these ones were
> missing the POINTER property while working on the POINTING_STICK property.

I am not sure about this one. INPUT_PROP_POINTER is the default behavior
when no properties are set. The current Xorg/libinput code should
already be aware of that and uses this to be able to be backward
compatible.
Adding the info now, will not change anything in the user-space code and
we will not be able to remove the compat code before a long time.

So, really, I am not in favor, nor I will opposite my vote regarding
this patch.

Cheers,
Benjamin

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/mouse/alps.c          | 1 +
>  drivers/input/mouse/elantech.c      | 1 +
>  drivers/input/mouse/psmouse-base.c  | 2 ++
>  drivers/input/mouse/synaptics_usb.c | 5 +++++
>  drivers/input/mouse/trackpoint.c    | 1 +
>  5 files changed, 10 insertions(+)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 9de3c25..d7020ad 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2373,6 +2373,7 @@ int alps_init(struct psmouse *psmouse)
>  	dev2->keybit[BIT_WORD(BTN_LEFT)] =
>  		BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_MIDDLE) | BIT_MASK(BTN_RIGHT);
>  
> +	__set_bit(INPUT_PROP_POINTER, dev2->propbit);
>  	if (priv->flags & ALPS_DUALPOINT)
>  		__set_bit(INPUT_PROP_POINTING_STICK, dev2->propbit);
>  
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index c767f7e..daaf82f 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1608,6 +1608,7 @@ int elantech_init(struct psmouse *psmouse)
>  			BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_MIDDLE) |
>  			BIT_MASK(BTN_RIGHT);
>  
> +		__set_bit(INPUT_PROP_POINTER, tp_dev->propbit);
>  		__set_bit(INPUT_PROP_POINTING_STICK, tp_dev->propbit);
>  
>  		error = input_register_device(etd->tp_dev);
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index 5c1237d..a44d655 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -685,6 +685,8 @@ static void psmouse_apply_defaults(struct psmouse *psmouse)
>  	__set_bit(REL_X, input_dev->relbit);
>  	__set_bit(REL_Y, input_dev->relbit);
>  
> +	__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> +
>  	psmouse->set_rate = psmouse_set_rate;
>  	psmouse->set_resolution = psmouse_set_resolution;
>  	psmouse->poll = psmouse_poll;
> diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
> index db3973d..6bcc018 100644
> --- a/drivers/input/mouse/synaptics_usb.c
> +++ b/drivers/input/mouse/synaptics_usb.c
> @@ -402,6 +402,11 @@ static int synusb_probe(struct usb_interface *intf,
>  		__set_bit(BTN_TOOL_TRIPLETAP, input_dev->keybit);
>  	}
>  
> +	if (synusb->flags & SYNUSB_TOUCHSCREEN)
> +		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
> +	else
> +		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> +
>  	__set_bit(BTN_LEFT, input_dev->keybit);
>  	__set_bit(BTN_RIGHT, input_dev->keybit);
>  	__set_bit(BTN_MIDDLE, input_dev->keybit);
> diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> index b377462..30c8b69 100644
> --- a/drivers/input/mouse/trackpoint.c
> +++ b/drivers/input/mouse/trackpoint.c
> @@ -393,6 +393,7 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
>  	if ((button_info & 0x0f) >= 3)
>  		__set_bit(BTN_MIDDLE, psmouse->dev->keybit);
>  
> +	__set_bit(INPUT_PROP_POINTER, psmouse->dev->propbit);
>  	__set_bit(INPUT_PROP_POINTING_STICK, psmouse->dev->propbit);
>  
>  	trackpoint_defaults(psmouse->private);
> -- 
> 2.1.0
> 

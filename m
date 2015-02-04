From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/4] Input - synaptics: fix middle button on Lenovo 2015
 products
Date: Wed, 4 Feb 2015 14:43:32 -0500
Message-ID: <20150204194332.GC16434@mail.corp.redhat.com>
References: <1422475807-15033-1-git-send-email-benjamin.tissoires@redhat.com>
 <1422475807-15033-2-git-send-email-benjamin.tissoires@redhat.com>
 <20150202225456.GE23909@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56063 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932986AbbBDTnh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Feb 2015 14:43:37 -0500
Content-Disposition: inline
In-Reply-To: <20150202225456.GE23909@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Feb 02 2015 or thereabouts, Dmitry Torokhov wrote:
> On Wed, Jan 28, 2015 at 03:10:04PM -0500, Benjamin Tissoires wrote:
> > On the X1 Carbon 3rd gen (with a 2015 broadwell cpu), the physical middle
> > button of the trackstick (attached to the touchpad serio device, of course)
> > seems to get lost.
> > 
> > Actually, the touchpads reports 3 extra buttons, which falls in the switch
> > below to the '2' case. Let's handle the case of odd numbers also, so that
> > the middle button finds its way back.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >  drivers/input/mouse/synaptics.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> > index f89de89..0d12664 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -689,7 +689,7 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
> >  
> >  		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) &&
> >  		    ((buf[0] ^ buf[3]) & 0x02)) {
> > -			switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
> > +			switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)) {
> >  			default:
> >  				/*
> >  				 * if nExtBtn is greater than 8 it should be
> > @@ -698,15 +698,19 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
> >  				break;
> >  			case 8:
> >  				hw->ext_buttons |= ((buf[5] & 0x08)) ? 0x80 : 0;
> > +			case 7:
> >  				hw->ext_buttons |= ((buf[4] & 0x08)) ? 0x40 : 0;
> >  			case 6:
> >  				hw->ext_buttons |= ((buf[5] & 0x04)) ? 0x20 : 0;
> > +			case 5:
> >  				hw->ext_buttons |= ((buf[4] & 0x04)) ? 0x10 : 0;
> >  			case 4:
> >  				hw->ext_buttons |= ((buf[5] & 0x02)) ? 0x08 : 0;
> > +			case 3:
> >  				hw->ext_buttons |= ((buf[4] & 0x02)) ? 0x04 : 0;
> >  			case 2:
> >  				hw->ext_buttons |= ((buf[5] & 0x01)) ? 0x02 : 0;
> > +			case 1:
> >  				hw->ext_buttons |= ((buf[4] & 0x01)) ? 0x01 : 0;
> >  			}
> >  		}
> 
> Hmm, that switch has gotten unwieldy. Maybe we can do someting like
> this:

Minus a typo, it works too.

Though I must say even if the switch is ugly, it's a no brainer to
understand what is this about. Here, it requires a little bit more
skills :)

> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index a039cb7..1250a5d 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -608,6 +608,18 @@ static void synaptics_parse_agm(const unsigned char buf[],
>  	}
>  }
>  
> +static void synaptics_parse_ext_buttons(const unsigned char buf[],
> +					struct synaptics_data *priv,
> +					struct synaptics_hw_state *hw)
> +{
> +	unsigned int ext_bits =
> +		(SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) + 1) >> 1;
> +	unsigned int ext_mask = GENMASK(ext_bits - 1, 0);
> +
> +	hw->ext_buttons = buf[4] & ext_mask;
> +	hw->ext_buttons |= (buf[4] & ext_mask) << ext_bits;

typo: this should read (buf[5] & ext_mask) << ext_bits; (not buf[4])

You can add my Tested-by on this one when applying.

Cheers,
Benjamin

> +}
> +
>  static int synaptics_parse_hw_state(const unsigned char buf[],
>  				    struct synaptics_data *priv,
>  				    struct synaptics_hw_state *hw)
> @@ -692,28 +704,9 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
>  			hw->down = ((buf[0] ^ buf[3]) & 0x02) ? 1 : 0;
>  		}
>  
> -		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) &&
> +		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) > 0 &&
>  		    ((buf[0] ^ buf[3]) & 0x02)) {
> -			switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
> -			default:
> -				/*
> -				 * if nExtBtn is greater than 8 it should be
> -				 * considered invalid and treated as 0
> -				 */
> -				break;
> -			case 8:
> -				hw->ext_buttons |= ((buf[5] & 0x08)) ? 0x80 : 0;
> -				hw->ext_buttons |= ((buf[4] & 0x08)) ? 0x40 : 0;
> -			case 6:
> -				hw->ext_buttons |= ((buf[5] & 0x04)) ? 0x20 : 0;
> -				hw->ext_buttons |= ((buf[4] & 0x04)) ? 0x10 : 0;
> -			case 4:
> -				hw->ext_buttons |= ((buf[5] & 0x02)) ? 0x08 : 0;
> -				hw->ext_buttons |= ((buf[4] & 0x02)) ? 0x04 : 0;
> -			case 2:
> -				hw->ext_buttons |= ((buf[5] & 0x01)) ? 0x02 : 0;
> -				hw->ext_buttons |= ((buf[4] & 0x01)) ? 0x01 : 0;
> -			}
> +			synaptics_parse_ext_buttons(buf, priv, hw);
>  		}
>  	} else {
>  		hw->x = (((buf[1] & 0x1f) << 8) | buf[2]);
> @@ -780,6 +773,7 @@ static void synaptics_report_buttons(struct psmouse *psmouse,
>  {
>  	struct input_dev *dev = psmouse->dev;
>  	struct synaptics_data *priv = psmouse->private;
> +	int ext_bits = (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) + 1) >> 1;
>  	int i;
>  
>  	input_report_key(dev, BTN_LEFT, hw->left);
> @@ -793,8 +787,12 @@ static void synaptics_report_buttons(struct psmouse *psmouse,
>  		input_report_key(dev, BTN_BACK, hw->down);
>  	}
>  
> -	for (i = 0; i < SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap); i++)
> -		input_report_key(dev, BTN_0 + i, hw->ext_buttons & (1 << i));
> +	for (i = 0; i < ext_bits; i++) {
> +		input_report_key(dev, BTN_0 + 2 * i,
> +				 hw->ext_buttons & (1 << i));
> +		input_report_key(dev, BTN_1 + 2 * i,
> +				 hw->ext_buttons & (1 << (i + ext_bits)));
> +	}
>  }
>  
>  static void synaptics_report_mt_data(struct psmouse *psmouse,
> 
> Thanks.
> 
> -- 
> Dmitry

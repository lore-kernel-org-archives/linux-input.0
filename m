From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: sentelic: Absolute mode and multitouch
 support for Cx+ hardware.
Date: Sat, 28 Jan 2012 12:56:29 -0800
Message-ID: <20120128205629.GA23595@core.coreip.homeip.net>
References: <20120124232254.GB4905@timantti.taisia.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35714 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062Ab2A1U4f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Jan 2012 15:56:35 -0500
Received: by dadi2 with SMTP id i2so2420676dad.19
        for <linux-input@vger.kernel.org>; Sat, 28 Jan 2012 12:56:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120124232254.GB4905@timantti.taisia.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oskari Saarenmaa <os@ohmu.fi>
Cc: linux-input@vger.kernel.org, Tai-hwa Liang <avatar@sentelic.com>

Hi Oskari,

On Wed, Jan 25, 2012 at 01:22:54AM +0200, Oskari Saarenmaa wrote:
> - Implement absolute position mode and multitouch support for Cx+ revision
>   hardware based on latest documentation provided by Sentelic.
> - Supports two-finger horizontal and vertical scrolling, edge scrolling and
>   clicks on the clickpad.  Hardware click-on-tap is disabled.
> 
> The patch was developed and tested on an ASUS Zenbook UX21E.
> 
> Signed-off-by: Oskari Saarenmaa <os@ohmu.fi>

Adding Tai-hwa Liang so he has a chance to comment. Also some comments
below...

> ---
>  drivers/input/mouse/sentelic.c |  149 +++++++++++++++++++++++++++++++++++++---
>  drivers/input/mouse/sentelic.h |    8 ++
>  2 files changed, 148 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
> index 87c910d..e851cf5 100644
> --- a/drivers/input/mouse/sentelic.c
> +++ b/drivers/input/mouse/sentelic.c
> @@ -21,6 +21,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/input.h>
> +#include <linux/input/mt.h>
>  #include <linux/ctype.h>
>  #include <linux/libps2.h>
>  #include <linux/serio.h>
> @@ -37,7 +38,7 @@
>  #define	FSP_CMD_TIMEOUT2	30
>  
>  /** Driver version. */
> -static const char fsp_drv_ver[] = "1.0.0-K";
> +static const char fsp_drv_ver[] = "1.0.0-K-OS1";
>  
>  /*
>   * Make sure that the value being sent to FSP will not conflict with
> @@ -671,8 +672,11 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
>  	struct input_dev *dev = psmouse->dev;
>  	struct fsp_data *ad = psmouse->private;
>  	unsigned char *packet = psmouse->packet;
> -	unsigned char button_status = 0, lscroll = 0, rscroll = 0;
> +	unsigned short abs_x, abs_y, fingers = 0;
> +	unsigned short vscroll = 0, hscroll = 0, lscroll = 0, rscroll = 0;
> +	unsigned short l_btn, r_btn, m_btn;
>  	int rel_x, rel_y;
> +	static bool lifted;
>  
>  	if (psmouse->pktcnt < 4)
>  		return PSMOUSE_GOOD_DATA;
> @@ -684,9 +688,97 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
>  	fsp_packet_debug(psmouse, packet);
>  
>  	switch (psmouse->packet[0] >> FSP_PKT_TYPE_SHIFT) {
> +	case FSP_PKT_TYPE_NOTIFY:
> +		/* Notify packets are sent with Cx and newer
> +		 * touchpads if register 0x90 bit 1 is set.
> +		 */
> +		switch (packet[2]) {
> +		case 0x86:
> +			vscroll =  1;
> +			break;
> +		case 0x82:
> +			vscroll = -1;
> +			break;
> +		case 0x84:
> +			hscroll =  1;
> +			break;
> +		case 0x80:
> +			hscroll = -1;
> +			break;
> +		}
> +		input_report_rel(dev, REL_WHEEL, vscroll);
> +		input_report_rel(dev, REL_HWHEEL, hscroll);
> +		break;

Do we need to support the non-absolute mode if we can support absolute
mode for the device? Users expect to have true multi-touch support
nowadays, I think we should keep the driver as simple as possible and
support only absolute mode for MT devices.

> +
>  	case FSP_PKT_TYPE_ABS:
> -		dev_warn(&psmouse->ps2dev.serio->dev,
> -			 "Unexpected absolute mode packet, ignored.\n");
> +		/* Absolute packets are sent with version Cx and newer
> +		 * touchpads if register 0x90 bit 0 is set.
> +		 */
> +		abs_x = (packet[1] << 2) | ((packet[3] >> 2) & 0x03);
> +		abs_y = (packet[2] << 2) | (packet[3] & 0x03);
> +
> +		l_btn = packet[0] & BIT(0);
> +		r_btn = packet[0] & BIT(1);
> +		m_btn = packet[0] & BIT(2);
> +
> +		if (packet[1] || packet[2] || packet[3]) {
> +			/* at least one finger is down */
> +			fingers++;
> +			lifted = false;
> +		} else {
> +			if (lifted == false) {
> +				lifted = true;
> +				return PSMOUSE_FULL_PACKET;
> +			}
> +		}
> +
> +		if ((packet[0] & (BIT(4)|BIT(5))) == 0 && l_btn) {
> +			/* on pad click, let other components handle this.
> +			 * NOTE: do not filter out on-pad clicks when
> +			 * we're in multitouch mode, BIT(5), they are real
> +			 * clickpad-clicks, not just single finger taps.
> +			 */
> +			l_btn = 0;

Hmm, so this is a clickpad device? We need to set clickpad property
then.

> +		}
> +
> +		if (packet[0] & BIT(5)) {
> +			/* multitouch mode: two fingers down */
> +			fingers++;
> +			if ((packet[0] & BIT(4)) == 0 && l_btn && r_btn) {
> +				/* middle-click in multitouch mode */
> +				l_btn = 0;
> +				r_btn = 0;
> +				m_btn = 1;
> +			}

The middle button emulation should be handled in userspace. Let
synaptics X driver deal with it.

> +			if (packet[0] & BIT(2)) {
> +				/* right finger down, ignore the event */

Needs better comment.

> +				return PSMOUSE_FULL_PACKET;
> +			}
> +		}
> +
> +		input_report_key(dev, BTN_TOUCH, fingers > 0);
> +		input_report_abs(dev, ABS_X, abs_x);
> +		input_report_abs(dev, ABS_Y, abs_y);
> +
> +		input_mt_slot(dev, 0);
> +		input_mt_report_slot_state(dev, MT_TOOL_FINGER, fingers >= 1);
> +		if (fingers >= 1) {
> +			input_report_abs(dev, ABS_MT_POSITION_X, abs_x);
> +			input_report_abs(dev, ABS_MT_POSITION_Y, abs_y);
> +		}
> +
> +		input_mt_slot(dev, 1);
> +		input_mt_report_slot_state(dev, MT_TOOL_FINGER, fingers >= 2);
> +		if (fingers >= 2) {
> +			input_report_abs(dev, ABS_MT_POSITION_X, abs_x);
> +			input_report_abs(dev, ABS_MT_POSITION_Y, abs_y);
> +		}
> +
> +		input_report_key(dev, BTN_TOOL_FINGER, fingers == 1);
> +		input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers == 2);
> +		input_report_key(dev, BTN_LEFT, l_btn);
> +		input_report_key(dev, BTN_MIDDLE, m_btn);
> +		input_report_key(dev, BTN_RIGHT, r_btn);
>  		break;
>  
>  	case FSP_PKT_TYPE_NORMAL_OPC:
> @@ -699,6 +791,7 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
>  		/* normal packet */
>  		/* special packet data translation from on-pad packets */
>  		if (packet[3] != 0) {
> +			unsigned char button_status = 0;
>  			if (packet[3] & BIT(0))
>  				button_status |= 0x01;	/* wheel down */
>  			if (packet[3] & BIT(1))
> @@ -776,6 +869,7 @@ static int fsp_activate_protocol(struct psmouse *psmouse)
>  	val &= ~(FSP_BIT_EN_MSID7 | FSP_BIT_EN_MSID8 | FSP_BIT_EN_AUTO_MSID8);
>  	/* Ensure we are not in absolute mode */
>  	val &= ~FSP_BIT_EN_PKT_G0;
> +
>  	if (pad->buttons == 0x06) {
>  		/* Left/Middle/Right & Scroll Up/Down/Right/Left */
>  		val |= FSP_BIT_EN_MSID6;
> @@ -799,6 +893,19 @@ static int fsp_activate_protocol(struct psmouse *psmouse)
>  	fsp_onpad_vscr(psmouse, true);
>  	fsp_onpad_hscr(psmouse, true);
>  
> +	/* Enable absolute positioning, two finger mode and continuous output
> +	 * on Cx and newer pads (version ID 0xE0+)
> +	 */
> +	if (pad->ver >= 0xE0) {
> +		val = FSP_CX_ABSOLUTE_MODE |
> +			FSP_CX_2FINGERS_OUTPUT |
> +			FSP_CX_CONTINUOUS_MODE;
> +		if (fsp_reg_write(psmouse, FSP_REG_SWREG1, val)) {
> +			dev_warn(&psmouse->ps2dev.serio->dev,
> +				 "Failed to enable multitouch settings.\n");
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -854,6 +961,7 @@ static int fsp_reconnect(struct psmouse *psmouse)
>  
>  int fsp_init(struct psmouse *psmouse)
>  {
> +	struct input_dev *dev = psmouse->dev;
>  	struct fsp_data *priv;
>  	int ver, rev, buttons;
>  	int error;
> @@ -880,11 +988,34 @@ int fsp_init(struct psmouse *psmouse)
>  	priv->flags |= FSPDRV_FLAG_EN_OPC;
>  
>  	/* Set up various supported input event bits */
> -	__set_bit(BTN_MIDDLE, psmouse->dev->keybit);
> -	__set_bit(BTN_BACK, psmouse->dev->keybit);
> -	__set_bit(BTN_FORWARD, psmouse->dev->keybit);
> -	__set_bit(REL_WHEEL, psmouse->dev->relbit);
> -	__set_bit(REL_HWHEEL, psmouse->dev->relbit);
> +	__set_bit(BTN_MIDDLE, dev->keybit);
> +	__set_bit(BTN_BACK, dev->keybit);
> +	__set_bit(BTN_FORWARD, dev->keybit);
> +	__set_bit(REL_WHEEL, dev->relbit);
> +	__set_bit(REL_HWHEEL, dev->relbit);
> +
> +	/* Set up multitouch mode on Cx+ version hardware (reg value 0xE0+)
> +	 * for example ASUS Zenbook UX21E has Sentelic touchpad version 0xE3
> +	 */
> +	if (ver >= 0xE0) {
> +		/* NOTE: maximum values are not documented anywhere and are
> +		 * not available in any register, these are the maximum
> +		 * values reported by a Zenbook.
> +		 */
> +		int abs_x = 965, abs_y = 705;
> +
> +		__set_bit(EV_ABS, dev->evbit);
> +		__clear_bit(EV_REL, dev->evbit);
> +		__set_bit(BTN_TOUCH, dev->keybit);
> +		__set_bit(BTN_TOOL_FINGER, dev->keybit);
> +		__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
> +
> +		input_set_abs_params(dev, ABS_X, 0, abs_x, 0, 0);
> +		input_set_abs_params(dev, ABS_Y, 0, abs_y, 0, 0);
> +		input_mt_init_slots(dev, 2);
> +		input_set_abs_params(dev, ABS_MT_POSITION_X, 0, abs_x, 0, 0);
> +		input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, abs_y, 0, 0);
> +	}
>  
>  	psmouse->protocol_handler = fsp_process_byte;
>  	psmouse->disconnect = fsp_disconnect;
> diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
> index 2e4af24..c72ca5e 100644
> --- a/drivers/input/mouse/sentelic.h
> +++ b/drivers/input/mouse/sentelic.h
> @@ -41,6 +41,7 @@
>  #define	FSP_REG_OPTZ_YLO	0x36
>  #define	FSP_REG_OPTZ_YHI	0x37
>  #define	FSP_REG_SYSCTL5		0x40
> +#define	FSP_REG_SWREG1		0x90
>  #define	FSP_BIT_90_DEGREE	BIT(0)
>  #define	FSP_BIT_EN_MSID6	BIT(1)
>  #define	FSP_BIT_EN_MSID7	BIT(2)
> @@ -64,6 +65,13 @@
>  #define	FSP_PKT_TYPE_NORMAL_OPC	(0x03)
>  #define	FSP_PKT_TYPE_SHIFT	(6)
>  
> +/* swreg1 values, supported in Cx hardware */
> +#define FSP_CX_ABSOLUTE_MODE	BIT(0)
> +#define FSP_CX_GESTURE_OUTPUT	BIT(1)
> +#define FSP_CX_2FINGERS_OUTPUT	BIT(2)
> +#define FSP_CX_FINGER_UP_OUTPUT	BIT(3)
> +#define FSP_CX_CONTINUOUS_MODE	BIT(4)
> +
>  #ifdef __KERNEL__
>  
>  struct fsp_data {
> -- 
> 1.7.7.6
> 
Thanks.

-- 
Dmitry

From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [PATCH 2/2] Input: sentelic: Absolute mode and multitouch support
 for Cx+ hardware.
Date: Mon, 30 Jan 2012 00:29:52 +0800 (CST)
Message-ID: <12013000101413.23561@cnaqrzbavhz.fragryvp.pbz>
References: <20120124232254.GB4905@timantti.taisia.fi>
 <20120128205629.GA23595@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809760-591349633-1327854592=:23561"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:17453 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab2A2Q37 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jan 2012 11:29:59 -0500
In-Reply-To: <20120128205629.GA23595@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oskari Saarenmaa <os@ohmu.fi>, linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809760-591349633-1327854592=:23561
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Sat, 28 Jan 2012, Dmitry Torokhov wrote:
> Hi Oskari,
>
> On Wed, Jan 25, 2012 at 01:22:54AM +0200, Oskari Saarenmaa wrote:
>> - Implement absolute position mode and multitouch support for Cx+ revision
>>   hardware based on latest documentation provided by Sentelic.
>> - Supports two-finger horizontal and vertical scrolling, edge scrolling and
>>   clicks on the clickpad.  Hardware click-on-tap is disabled.
>>
>> The patch was developed and tested on an ASUS Zenbook UX21E.
>>
>> Signed-off-by: Oskari Saarenmaa <os@ohmu.fi>
>
> Adding Tai-hwa Liang so he has a chance to comment. Also some comments
> below...

   Sorry for the late response. Just returned from Chinese lunar New Year
holiday...

>> ---
>>  drivers/input/mouse/sentelic.c |  149 +++++++++++++++++++++++++++++++++++++---
>>  drivers/input/mouse/sentelic.h |    8 ++
>>  2 files changed, 148 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
>> index 87c910d..e851cf5 100644
>> --- a/drivers/input/mouse/sentelic.c
>> +++ b/drivers/input/mouse/sentelic.c
>> @@ -21,6 +21,7 @@
>>
>>  #include <linux/module.h>
>>  #include <linux/input.h>
>> +#include <linux/input/mt.h>
>>  #include <linux/ctype.h>
>>  #include <linux/libps2.h>
>>  #include <linux/serio.h>
>> @@ -37,7 +38,7 @@
>>  #define	FSP_CMD_TIMEOUT2	30
>>
>>  /** Driver version. */
>> -static const char fsp_drv_ver[] = "1.0.0-K";
>> +static const char fsp_drv_ver[] = "1.0.0-K-OS1";
>>
>>  /*
>>   * Make sure that the value being sent to FSP will not conflict with
>> @@ -671,8 +672,11 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
>>  	struct input_dev *dev = psmouse->dev;
>>  	struct fsp_data *ad = psmouse->private;
>>  	unsigned char *packet = psmouse->packet;
>> -	unsigned char button_status = 0, lscroll = 0, rscroll = 0;
>> +	unsigned short abs_x, abs_y, fingers = 0;
>> +	unsigned short vscroll = 0, hscroll = 0, lscroll = 0, rscroll = 0;
>> +	unsigned short l_btn, r_btn, m_btn;
>>  	int rel_x, rel_y;
>> +	static bool lifted;
>>
>>  	if (psmouse->pktcnt < 4)
>>  		return PSMOUSE_GOOD_DATA;
>> @@ -684,9 +688,97 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
>>  	fsp_packet_debug(psmouse, packet);
>>
>>  	switch (psmouse->packet[0] >> FSP_PKT_TYPE_SHIFT) {
>> +	case FSP_PKT_TYPE_NOTIFY:
>> +		/* Notify packets are sent with Cx and newer
>> +		 * touchpads if register 0x90 bit 1 is set.
>> +		 */
>> +		switch (packet[2]) {
>> +		case 0x86:
>> +			vscroll =  1;
>> +			break;
>> +		case 0x82:
>> +			vscroll = -1;
>> +			break;
>> +		case 0x84:
>> +			hscroll =  1;
>> +			break;
>> +		case 0x80:

   Based on Oskari's version, the attached patch also turns these magic 
numbers into pre-defined constants(patch against Dmitry's master branch).
Perhaps you guys could have some time to take a look at it?

   Note that I only tested the compilation part as I don't have the real 
hardware due to holiday shutdown. Will need to test these after getting
back to the office.

>> +			hscroll = -1;
>> +			break;
>> +		}
>> +		input_report_rel(dev, REL_WHEEL, vscroll);
>> +		input_report_rel(dev, REL_HWHEEL, hscroll);
>> +		break;
>
> Do we need to support the non-absolute mode if we can support absolute
> mode for the device? Users expect to have true multi-touch support
> nowadays, I think we should keep the driver as simple as possible and
> support only absolute mode for MT devices.

   This is true for newer hardware; however, it would be better to stick
with relative mode for older hardware(ex: FSP found on OLPC) since the
relative coordination outputs are much better on them when compared with
abs. outputs.

>> +
>>  	case FSP_PKT_TYPE_ABS:
>> -		dev_warn(&psmouse->ps2dev.serio->dev,
>> -			 "Unexpected absolute mode packet, ignored.\n");
>> +		/* Absolute packets are sent with version Cx and newer
>> +		 * touchpads if register 0x90 bit 0 is set.
>> +		 */
>> +		abs_x = (packet[1] << 2) | ((packet[3] >> 2) & 0x03);
>> +		abs_y = (packet[2] << 2) | (packet[3] & 0x03);
>> +
>> +		l_btn = packet[0] & BIT(0);
>> +		r_btn = packet[0] & BIT(1);
>> +		m_btn = packet[0] & BIT(2);
>> +
>> +		if (packet[1] || packet[2] || packet[3]) {
>> +			/* at least one finger is down */
>> +			fingers++;
>> +			lifted = false;
>> +		} else {
>> +			if (lifted == false) {
>> +				lifted = true;
>> +				return PSMOUSE_FULL_PACKET;
>> +			}
>> +		}
>> +
>> +		if ((packet[0] & (BIT(4)|BIT(5))) == 0 && l_btn) {
>> +			/* on pad click, let other components handle this.
>> +			 * NOTE: do not filter out on-pad clicks when
>> +			 * we're in multitouch mode, BIT(5), they are real
>> +			 * clickpad-clicks, not just single finger taps.
>> +			 */
>> +			l_btn = 0;
>
> Hmm, so this is a clickpad device? We need to set clickpad property
> then.

   I presume you're talking about something like SYN_CAP_CLICKPAD() in
synaptics.c?  Given that retrieving capability information would incur 
more register reading overhead, I'm wondering about if there's any
way to read PnP ID in psmouse.c such that sentelic.c can take advantage
of these vendor specific tags to identify the hardware capability?

>> +		}
>> +
>> +		if (packet[0] & BIT(5)) {
>> +			/* multitouch mode: two fingers down */
>> +			fingers++;
>> +			if ((packet[0] & BIT(4)) == 0 && l_btn && r_btn) {
>> +				/* middle-click in multitouch mode */
>> +				l_btn = 0;
>> +				r_btn = 0;
>> +				m_btn = 1;
>> +			}
>
> The middle button emulation should be handled in userspace. Let
> synaptics X driver deal with it.

   Agreed.

>> +			if (packet[0] & BIT(2)) {
>> +				/* right finger down, ignore the event */
>
> Needs better comment.
>
>> +				return PSMOUSE_FULL_PACKET;
>> +			}
>> +		}
>> +
>> +		input_report_key(dev, BTN_TOUCH, fingers > 0);
>> +		input_report_abs(dev, ABS_X, abs_x);
>> +		input_report_abs(dev, ABS_Y, abs_y);
>> +
>> +		input_mt_slot(dev, 0);
>> +		input_mt_report_slot_state(dev, MT_TOOL_FINGER, fingers >= 1);
>> +		if (fingers >= 1) {
>> +			input_report_abs(dev, ABS_MT_POSITION_X, abs_x);
>> +			input_report_abs(dev, ABS_MT_POSITION_Y, abs_y);
>> +		}
>> +
>> +		input_mt_slot(dev, 1);
>> +		input_mt_report_slot_state(dev, MT_TOOL_FINGER, fingers >= 2);
>> +		if (fingers >= 2) {
>> +			input_report_abs(dev, ABS_MT_POSITION_X, abs_x);
>> +			input_report_abs(dev, ABS_MT_POSITION_Y, abs_y);
>> +		}
>> +
>> +		input_report_key(dev, BTN_TOOL_FINGER, fingers == 1);
>> +		input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers == 2);
>> +		input_report_key(dev, BTN_LEFT, l_btn);
>> +		input_report_key(dev, BTN_MIDDLE, m_btn);
>> +		input_report_key(dev, BTN_RIGHT, r_btn);
>>  		break;
>>
>>  	case FSP_PKT_TYPE_NORMAL_OPC:
>> @@ -699,6 +791,7 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
>>  		/* normal packet */
>>  		/* special packet data translation from on-pad packets */
>>  		if (packet[3] != 0) {
>> +			unsigned char button_status = 0;
>>  			if (packet[3] & BIT(0))
>>  				button_status |= 0x01;	/* wheel down */
>>  			if (packet[3] & BIT(1))
>> @@ -776,6 +869,7 @@ static int fsp_activate_protocol(struct psmouse *psmouse)
>>  	val &= ~(FSP_BIT_EN_MSID7 | FSP_BIT_EN_MSID8 | FSP_BIT_EN_AUTO_MSID8);
>>  	/* Ensure we are not in absolute mode */
>>  	val &= ~FSP_BIT_EN_PKT_G0;
>> +
>>  	if (pad->buttons == 0x06) {
>>  		/* Left/Middle/Right & Scroll Up/Down/Right/Left */
>>  		val |= FSP_BIT_EN_MSID6;
>> @@ -799,6 +893,19 @@ static int fsp_activate_protocol(struct psmouse *psmouse)
>>  	fsp_onpad_vscr(psmouse, true);
>>  	fsp_onpad_hscr(psmouse, true);
>>
>> +	/* Enable absolute positioning, two finger mode and continuous output
>> +	 * on Cx and newer pads (version ID 0xE0+)
>> +	 */
>> +	if (pad->ver >= 0xE0) {
>> +		val = FSP_CX_ABSOLUTE_MODE |
>> +			FSP_CX_2FINGERS_OUTPUT |
>> +			FSP_CX_CONTINUOUS_MODE;
>> +		if (fsp_reg_write(psmouse, FSP_REG_SWREG1, val)) {
>> +			dev_warn(&psmouse->ps2dev.serio->dev,
>> +				 "Failed to enable multitouch settings.\n");
>> +		}
>> +	}
>> +
>>  	return 0;
>>  }
>>
>> @@ -854,6 +961,7 @@ static int fsp_reconnect(struct psmouse *psmouse)
>>
>>  int fsp_init(struct psmouse *psmouse)
>>  {
>> +	struct input_dev *dev = psmouse->dev;
>>  	struct fsp_data *priv;
>>  	int ver, rev, buttons;
>>  	int error;
>> @@ -880,11 +988,34 @@ int fsp_init(struct psmouse *psmouse)
>>  	priv->flags |= FSPDRV_FLAG_EN_OPC;
>>
>>  	/* Set up various supported input event bits */
>> -	__set_bit(BTN_MIDDLE, psmouse->dev->keybit);
>> -	__set_bit(BTN_BACK, psmouse->dev->keybit);
>> -	__set_bit(BTN_FORWARD, psmouse->dev->keybit);
>> -	__set_bit(REL_WHEEL, psmouse->dev->relbit);
>> -	__set_bit(REL_HWHEEL, psmouse->dev->relbit);
>> +	__set_bit(BTN_MIDDLE, dev->keybit);
>> +	__set_bit(BTN_BACK, dev->keybit);
>> +	__set_bit(BTN_FORWARD, dev->keybit);
>> +	__set_bit(REL_WHEEL, dev->relbit);
>> +	__set_bit(REL_HWHEEL, dev->relbit);
>> +
>> +	/* Set up multitouch mode on Cx+ version hardware (reg value 0xE0+)
>> +	 * for example ASUS Zenbook UX21E has Sentelic touchpad version 0xE3
>> +	 */
>> +	if (ver >= 0xE0) {
>> +		/* NOTE: maximum values are not documented anywhere and are
>> +		 * not available in any register, these are the maximum
>> +		 * values reported by a Zenbook.
>> +		 */
>> +		int abs_x = 965, abs_y = 705;
>> +
>> +		__set_bit(EV_ABS, dev->evbit);
>> +		__clear_bit(EV_REL, dev->evbit);
>> +		__set_bit(BTN_TOUCH, dev->keybit);
>> +		__set_bit(BTN_TOOL_FINGER, dev->keybit);
>> +		__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
>> +
>> +		input_set_abs_params(dev, ABS_X, 0, abs_x, 0, 0);
>> +		input_set_abs_params(dev, ABS_Y, 0, abs_y, 0, 0);
>> +		input_mt_init_slots(dev, 2);
>> +		input_set_abs_params(dev, ABS_MT_POSITION_X, 0, abs_x, 0, 0);
>> +		input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, abs_y, 0, 0);
>> +	}
>>
>>  	psmouse->protocol_handler = fsp_process_byte;
>>  	psmouse->disconnect = fsp_disconnect;
>> diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
>> index 2e4af24..c72ca5e 100644
>> --- a/drivers/input/mouse/sentelic.h
>> +++ b/drivers/input/mouse/sentelic.h
>> @@ -41,6 +41,7 @@
>>  #define	FSP_REG_OPTZ_YLO	0x36
>>  #define	FSP_REG_OPTZ_YHI	0x37
>>  #define	FSP_REG_SYSCTL5		0x40
>> +#define	FSP_REG_SWREG1		0x90
>>  #define	FSP_BIT_90_DEGREE	BIT(0)
>>  #define	FSP_BIT_EN_MSID6	BIT(1)
>>  #define	FSP_BIT_EN_MSID7	BIT(2)
>> @@ -64,6 +65,13 @@
>>  #define	FSP_PKT_TYPE_NORMAL_OPC	(0x03)
>>  #define	FSP_PKT_TYPE_SHIFT	(6)
>>
>> +/* swreg1 values, supported in Cx hardware */
>> +#define FSP_CX_ABSOLUTE_MODE	BIT(0)
>> +#define FSP_CX_GESTURE_OUTPUT	BIT(1)
>> +#define FSP_CX_2FINGERS_OUTPUT	BIT(2)
>> +#define FSP_CX_FINGER_UP_OUTPUT	BIT(3)
>> +#define FSP_CX_CONTINUOUS_MODE	BIT(4)
>> +
>>  #ifdef __KERNEL__
>>
>>  struct fsp_data {
>> --
>> 1.7.7.6
>>
> Thanks.
-- 
Sincerely yours,

Tai-hwa Liang
---1463809760-591349633-1327854592=:23561
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=diff-sentelic-mt
Content-Transfer-Encoding: BASE64
Content-ID: <12013000295216.23561@cnaqrzbavhz.fragryvp.pbz>
Content-Description: 
Content-Disposition: attachment; filename=diff-sentelic-mt

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvbW91c2Uvc2VudGVsaWMuYyBi
L2RyaXZlcnMvaW5wdXQvbW91c2Uvc2VudGVsaWMuYw0KaW5kZXggNWJhYmM0
Ny4uMWYxZjAyMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW5wdXQvbW91c2Uv
c2VudGVsaWMuYw0KKysrIGIvZHJpdmVycy9pbnB1dC9tb3VzZS9zZW50ZWxp
Yy5jDQpAQCAtMiw3ICsyLDcgQEANCiAgKiBGaW5nZXIgU2Vuc2luZyBQYWQg
UFMvMiBtb3VzZSBkcml2ZXIuDQogICoNCiAgKiBDb3B5cmlnaHQgKEMpIDIw
MDUtMjAwNyBBc2lhIFZpdGFsIENvbXBvbmVudHMgQ28uLCBMdGQuDQotICog
Q29weXJpZ2h0IChDKSAyMDA1LTIwMTAgVGFpLWh3YSBMaWFuZywgU2VudGVs
aWMgQ29ycG9yYXRpb24uDQorICogQ29weXJpZ2h0IChDKSAyMDA1LTIwMTIg
VGFpLWh3YSBMaWFuZywgU2VudGVsaWMgQ29ycG9yYXRpb24uDQogICoNCiAg
KiAgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJl
ZGlzdHJpYnV0ZSBpdCBhbmQvb3INCiAgKiAgIG1vZGlmeSBpdCB1bmRlciB0
aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlDQpA
QCAtMjAsNyArMjAsOSBAQA0KICAqLw0KIA0KICNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4NCisjaW5jbHVkZSA8bGludXgvdmVyc2lvbi5oPg0KICNpbmNs
dWRlIDxsaW51eC9pbnB1dC5oPg0KKyNpbmNsdWRlIDxsaW51eC9pbnB1dC9t
dC5oPg0KICNpbmNsdWRlIDxsaW51eC9jdHlwZS5oPg0KICNpbmNsdWRlIDxs
aW51eC9saWJwczIuaD4NCiAjaW5jbHVkZSA8bGludXgvc2VyaW8uaD4NCkBA
IC0xNjIsNyArMTY0LDcgQEAgc3RhdGljIGludCBmc3BfcmVnX3dyaXRlKHN0
cnVjdCBwc21vdXNlICpwc21vdXNlLCBpbnQgcmVnX2FkZHIsIGludCByZWdf
dmFsKQ0KIAlwczJfc2VuZGJ5dGUocHMyZGV2LCB2LCBGU1BfQ01EX1RJTUVP
VVQyKTsNCiANCiAJaWYgKHBzMl9zZW5kYnl0ZShwczJkZXYsIDB4ZjMsIEZT
UF9DTURfVElNRU9VVCkgPCAwKQ0KLQkJcmV0dXJuIC0xOw0KKwkJZ290byBv
dXQ7DQogDQogCWlmICgodiA9IGZzcF90ZXN0X2ludmVydF9jbWQocmVnX3Zh
bCkpICE9IHJlZ192YWwpIHsNCiAJCS8qIGludmVyc2lvbiBpcyByZXF1aXJl
ZCAqLw0KQEAgLTI2MSw3ICsyNjMsNyBAQCBzdGF0aWMgaW50IGZzcF9wYWdl
X3JlZ193cml0ZShzdHJ1Y3QgcHNtb3VzZSAqcHNtb3VzZSwgaW50IHJlZ192
YWwpDQogCXBzMl9zZW5kYnl0ZShwczJkZXYsIDB4ODgsIEZTUF9DTURfVElN
RU9VVDIpOw0KIA0KIAlpZiAocHMyX3NlbmRieXRlKHBzMmRldiwgMHhmMywg
RlNQX0NNRF9USU1FT1VUKSA8IDApDQotCQlyZXR1cm4gLTE7DQorCQlnb3Rv
IG91dDsNCiANCiAJaWYgKCh2ID0gZnNwX3Rlc3RfaW52ZXJ0X2NtZChyZWdf
dmFsKSkgIT0gcmVnX3ZhbCkgew0KIAkJcHMyX3NlbmRieXRlKHBzMmRldiwg
MHg0NywgRlNQX0NNRF9USU1FT1VUMik7DQpAQCAtMzA5LDcgKzMxMSw3IEBA
IHN0YXRpYyBpbnQgZnNwX2dldF9idXR0b25zKHN0cnVjdCBwc21vdXNlICpw
c21vdXNlLCBpbnQgKmJ0bikNCiAJfTsNCiAJaW50IHZhbDsNCiANCi0JaWYg
KGZzcF9yZWdfcmVhZChwc21vdXNlLCBGU1BfUkVHX1RNT0RfU1RBVFVTMSwg
JnZhbCkgPT0gLTEpDQorCWlmIChmc3BfcmVnX3JlYWQocHNtb3VzZSwgRlNQ
X1JFR19UTU9EX1NUQVRVUywgJnZhbCkgPT0gLTEpDQogCQlyZXR1cm4gLUVJ
TzsNCiANCiAJKmJ0biA9IGJ1dHRvbnNbKHZhbCAmIDB4MzApID4+IDRdOw0K
QEAgLTYyMCwxNyArNjIyLDM1IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRl
X2dyb3VwIGZzcF9hdHRyaWJ1dGVfZ3JvdXAgPSB7DQogfTsNCiANCiAjaWZk
ZWYgRlNQX0RFQlVHDQotc3RhdGljIHZvaWQgZnNwX3BhY2tldF9kZWJ1Zyh1
bnNpZ25lZCBjaGFyIHBhY2tldFtdKQ0KK3N0YXRpYyB2b2lkIGZzcF9wYWNr
ZXRfZGVidWcoc3RydWN0IHBzbW91c2UgKnBzbW91c2UsIHVuc2lnbmVkIGNo
YXIgcGFja2V0W10pDQogew0KIAlzdGF0aWMgdW5zaWduZWQgaW50IHBzMl9w
YWNrZXRfY250Ow0KIAlzdGF0aWMgdW5zaWduZWQgaW50IHBzMl9sYXN0X3Nl
Y29uZDsNCiAJdW5zaWduZWQgaW50IGppZmZpZXNfbXNlYzsNCisJY29uc3Qg
Y2hhciAqcGFja2V0X3R5cGUgPSAiVU5LTk9XTiI7DQorDQorCS8qIEludGVy
cHJldCAmIGR1bXAgdGhlIHBhY2tldCBkYXRhLiAqLw0KKwlzd2l0Y2ggKHBz
bW91c2UtPnBhY2tldFswXSA+PiBGU1BfUEtUX1RZUEVfU0hJRlQpIHsNCisJ
Y2FzZSBGU1BfUEtUX1RZUEVfQUJTOg0KKwkJcGFja2V0X3R5cGUgPSAiQWJz
b2x1dGUiOw0KKwkJYnJlYWs7DQorCWNhc2UgRlNQX1BLVF9UWVBFX05PUk1B
TDoNCisJCXBhY2tldF90eXBlID0gIk5vcm1hbCI7DQorCQlicmVhazsNCisJ
Y2FzZSBGU1BfUEtUX1RZUEVfTk9USUZZOg0KKwkJcGFja2V0X3R5cGUgPSAi
Tm90aWZ5IjsNCisJCWJyZWFrOw0KKwljYXNlIEZTUF9QS1RfVFlQRV9OT1JN
QUxfT1BDOg0KKwkJcGFja2V0X3R5cGUgPSAiTm9ybWFsLU9QQyI7DQorCQli
cmVhazsNCisJfQ0KIA0KIAlwczJfcGFja2V0X2NudCsrOw0KIAlqaWZmaWVz
X21zZWMgPSBqaWZmaWVzX3RvX21zZWNzKGppZmZpZXMpOw0KIAlwc21vdXNl
X2RiZyhwc21vdXNlLA0KLQkJICAgICIlMDhkbXMgUFMvMiBwYWNrZXRzOiAl
MDJ4LCAlMDJ4LCAlMDJ4LCAlMDJ4XG4iLA0KLQkJICAgIGppZmZpZXNfbXNl
YywgcGFja2V0WzBdLCBwYWNrZXRbMV0sIHBhY2tldFsyXSwgcGFja2V0WzNd
KTsNCisJCSAgICAiJTA4ZG1zICVzIHBhY2tldDogJTAyeCwgJTAyeCwgJTAy
eCwgJTAyeFxuIiwNCisJCSAgICBqaWZmaWVzX21zZWMsIHBhY2tldF90eXBl
LA0KKwkJICAgIHBhY2tldFswXSwgcGFja2V0WzFdLCBwYWNrZXRbMl0sIHBh
Y2tldFszXSk7DQogDQogCWlmIChqaWZmaWVzX21zZWMgLSBwczJfbGFzdF9z
ZWNvbmQgPiAxMDAwKSB7DQogCQlwc21vdXNlX2RiZyhwc21vdXNlLCAiUFMv
MiBwYWNrZXRzL3NlYyA9ICVkXG4iLCBwczJfcGFja2V0X2NudCk7DQpAQCAt
NjM5LDE3ICs2NTksMjkgQEAgc3RhdGljIHZvaWQgZnNwX3BhY2tldF9kZWJ1
Zyh1bnNpZ25lZCBjaGFyIHBhY2tldFtdKQ0KIAl9DQogfQ0KICNlbHNlDQot
c3RhdGljIHZvaWQgZnNwX3BhY2tldF9kZWJ1Zyh1bnNpZ25lZCBjaGFyIHBh
Y2tldFtdKQ0KK3N0YXRpYyB2b2lkIGZzcF9wYWNrZXRfZGVidWcoc3RydWN0
IHBzbW91c2UgKnBzbW91c2UsIHVuc2lnbmVkIGNoYXIgcGFja2V0W10pDQog
ew0KIH0NCiAjZW5kaWYNCiANCitzdGF0aWMgdm9pZCBmc3Bfc2V0X3Nsb3Qo
c3RydWN0IGlucHV0X2RldiAqZGV2LCBpbnQgc2xvdCwgYm9vbCBhY3RpdmUs
DQorCQkJIHVuc2lnbmVkIGludCB4LCB1bnNpZ25lZCBpbnQgeSkNCit7DQor
CWlucHV0X210X3Nsb3QoZGV2LCBzbG90KTsNCisJaW5wdXRfbXRfcmVwb3J0
X3Nsb3Rfc3RhdGUoZGV2LCBNVF9UT09MX0ZJTkdFUiwgYWN0aXZlKTsNCisJ
aWYgKGFjdGl2ZSkgew0KKwkJaW5wdXRfcmVwb3J0X2FicyhkZXYsIEFCU19N
VF9QT1NJVElPTl9YLCB4KTsNCisJCWlucHV0X3JlcG9ydF9hYnMoZGV2LCBB
QlNfTVRfUE9TSVRJT05fWSwgeSk7DQorCX0NCit9DQorDQogc3RhdGljIHBz
bW91c2VfcmV0X3QgZnNwX3Byb2Nlc3NfYnl0ZShzdHJ1Y3QgcHNtb3VzZSAq
cHNtb3VzZSkNCiB7DQogCXN0cnVjdCBpbnB1dF9kZXYgKmRldiA9IHBzbW91
c2UtPmRldjsNCiAJc3RydWN0IGZzcF9kYXRhICphZCA9IHBzbW91c2UtPnBy
aXZhdGU7DQogCXVuc2lnbmVkIGNoYXIgKnBhY2tldCA9IHBzbW91c2UtPnBh
Y2tldDsNCi0JdW5zaWduZWQgY2hhciBidXR0b25fc3RhdHVzID0gMCwgbHNj
cm9sbCA9IDAsIHJzY3JvbGwgPSAwOw0KKwl1bnNpZ25lZCBzaG9ydCBhYnNf
eCwgYWJzX3ksIGZncnMgPSAwOw0KKwl1bnNpZ25lZCBzaG9ydCB2c2Nyb2xs
ID0gMCwgaHNjcm9sbCA9IDAsIGxzY3JvbGwgPSAwLCByc2Nyb2xsID0gMDsN
CiAJaW50IHJlbF94LCByZWxfeTsNCiANCiAJaWYgKHBzbW91c2UtPnBrdGNu
dCA8IDQpDQpAQCAtNjYwLDIxICs2OTIsMTA3IEBAIHN0YXRpYyBwc21vdXNl
X3JldF90IGZzcF9wcm9jZXNzX2J5dGUoc3RydWN0IHBzbW91c2UgKnBzbW91
c2UpDQogCSAqLw0KIA0KIAlzd2l0Y2ggKHBzbW91c2UtPnBhY2tldFswXSA+
PiBGU1BfUEtUX1RZUEVfU0hJRlQpIHsNCisJY2FzZSBGU1BfUEtUX1RZUEVf
Tk9USUZZOg0KKwkJaWYgKHBhY2tldFsxXSAhPSBGU1BfTk9USUZZX01TR19H
SUQpDQorCQkJYnJlYWs7CS8qIHVuc3VwcG9ydGVkIG1lc3NhZ2UgdHlwZXMg
Ki8NCisNCisJCXN3aXRjaCAocGFja2V0WzJdKSB7DQorCQljYXNlIEZTUF9H
SURfU1BfVVA6DQorCQkJdnNjcm9sbCA9ICAxOw0KKwkJCWJyZWFrOw0KKwkJ
Y2FzZSBGU1BfR0lEX1NQX0RPV046DQorCQkJdnNjcm9sbCA9IC0xOw0KKwkJ
CWJyZWFrOw0KKwkJY2FzZSBGU1BfR0lEX1NQX0xFRlQ6DQorCQkJaHNjcm9s
bCA9ICAxOw0KKwkJCWJyZWFrOw0KKwkJY2FzZSBGU1BfR0lEX1NQX1JJR0hU
Og0KKwkJCWhzY3JvbGwgPSAtMTsNCisJCQlicmVhazsNCisJCWRlZmF1bHQ6
DQorCQkJZGV2X2RiZygmcHNtb3VzZS0+cHMyZGV2LnNlcmlvLT5kZXYsDQor
CQkJCSJHSUQgMHgleFxuIiwgcGFja2V0WzJdKTsNCisJCQlicmVhazsNCisJ
CX0NCisJCWlucHV0X3JlcG9ydF9yZWwoZGV2LCBSRUxfV0hFRUwsIHZzY3Jv
bGwpOw0KKwkJaW5wdXRfcmVwb3J0X3JlbChkZXYsIFJFTF9IV0hFRUwsIGhz
Y3JvbGwpOw0KKwkJaW5wdXRfZXZlbnQoZGV2LCBFVl9NU0MsIE1TQ19HRVNU
VVJFLCBwYWNrZXRbMl0pOw0KKwkJYnJlYWs7DQorDQogCWNhc2UgRlNQX1BL
VF9UWVBFX0FCUzoNCi0JCWRldl93YXJuKCZwc21vdXNlLT5wczJkZXYuc2Vy
aW8tPmRldiwNCi0JCQkgIlVuZXhwZWN0ZWQgYWJzb2x1dGUgbW9kZSBwYWNr
ZXQsIGlnbm9yZWQuXG4iKTsNCisJCWFic194ID0gKHBhY2tldFsxXSA8PCAy
KSB8ICgocGFja2V0WzNdID4+IDIpICYgMHgwMyk7DQorCQlhYnNfeSA9IChw
YWNrZXRbMl0gPDwgMikgfCAocGFja2V0WzNdICYgMHgwMyk7DQorDQorCQlp
ZiAocGFja2V0WzBdICYgRlNQX1BCMF9NRk1DKSB7DQorCQkJLyoNCisJCQkg
KiBNRk1DIHBhY2tldDogYXNzdW1lIHRoYXQgdGhlcmUgYXJlIHR3byBmaW5n
ZXJzIG9uDQorCQkJICogcGFkDQorCQkJICovDQorCQkJZmdycyA9IDI7DQor
DQorCQkJLyogTUZNQyBwYWNrZXQgKi8NCisJCQlpZiAocGFja2V0WzBdICYg
RlNQX1BCMF9NRk1DX0ZHUjIpIHsNCisJCQkJLyogMm5kIGZpbmdlciAqLw0K
KwkJCQlpZiAoYWQtPmxhc3RfbXRfZmdyID09IDIpIHsNCisJCQkJCS8qDQor
CQkJCQkgKiB3b3JrYXJvdW5kIGZvciBidWdneSBmaXJtd2FyZQ0KKwkJCQkJ
ICogd2hpY2ggZG9lc24ndCBjbGVhciBNRk1DIGJpdCBpZg0KKwkJCQkJICog
dGhlIDFzdCBmaW5nZXIgaXMgdXANCisJCQkJCSAqLw0KKwkJCQkJZmdycyA9
IDE7DQorCQkJCQlmc3Bfc2V0X3Nsb3QoZGV2LCAwLCBmYWxzZSwgMCwgMCk7
DQorCQkJCX0NCisJCQkJYWQtPmxhc3RfbXRfZmdyID0gMjsNCisNCisJCQkJ
ZnNwX3NldF9zbG90KGRldiwgMSwgZmdycyA9PSAyLCBhYnNfeCwgYWJzX3kp
Ow0KKwkJCX0gZWxzZSB7DQorCQkJCS8qIDFzdCBmaW5nZXIgKi8NCisJCQkJ
aWYgKGFkLT5sYXN0X210X2ZnciA9PSAxKSB7DQorCQkJCQkvKg0KKwkJCQkJ
ICogd29ya2Fyb3VuZCBmb3IgYnVnZ3kgZmlybXdhcmUNCisJCQkJCSAqIHdo
aWNoIGRvZXNuJ3QgY2xlYXIgTUZNQyBiaXQgaWYNCisJCQkJCSAqIHRoZSAy
bmQgZmluZ2VyIGlzIHVwDQorCQkJCQkgKi8NCisJCQkJCWZncnMgPSAxOw0K
KwkJCQkJZnNwX3NldF9zbG90KGRldiwgMSwgZmFsc2UsIDAsIDApOw0KKwkJ
CQl9DQorCQkJCWFkLT5sYXN0X210X2ZnciA9IDE7DQorCQkJCWZzcF9zZXRf
c2xvdChkZXYsIDAsIGZncnMgIT0gMCwgYWJzX3gsIGFic195KTsNCisJCQl9
DQorCQl9IGVsc2Ugew0KKwkJCS8qIFNGQUMgcGFja2V0ICovDQorDQorCQkJ
Lyogbm8gbXVsdGktZmluZ2VyIGluZm9ybWF0aW9uICovDQorCQkJYWQtPmxh
c3RfbXRfZmdyID0gMDsNCisNCisJCQlpZiAoYWJzX3ggIT0gMCAmJiBhYnNf
eSAhPSAwKQ0KKwkJCQlmZ3JzID0gMTsNCisNCisJCQlmc3Bfc2V0X3Nsb3Qo
ZGV2LCAwLCBmZ3JzID4gMCwgYWJzX3gsIGFic195KTsNCisJCQlmc3Bfc2V0
X3Nsb3QoZGV2LCAxLCBmYWxzZSwgMCwgMCk7DQorCQl9DQorCQlpZiAoZmdy
cyA+IDApIHsNCisJCQlpbnB1dF9yZXBvcnRfYWJzKGRldiwgQUJTX1gsIGFi
c194KTsNCisJCQlpbnB1dF9yZXBvcnRfYWJzKGRldiwgQUJTX1ksIGFic195
KTsNCisJCX0NCisJCWlucHV0X3JlcG9ydF9rZXkoZGV2LCBCVE5fTEVGVCwg
cGFja2V0WzBdICYgMHgwMSk7DQorCQlpbnB1dF9yZXBvcnRfa2V5KGRldiwg
QlROX1JJR0hULCBwYWNrZXRbMF0gJiAweDAyKTsNCisJCWlucHV0X3JlcG9y
dF9rZXkoZGV2LCBCVE5fVE9VQ0gsIGZncnMpOw0KKwkJaW5wdXRfcmVwb3J0
X2tleShkZXYsIEJUTl9UT09MX0ZJTkdFUiwgZmdycyA9PSAxKTsNCisJCWlu
cHV0X3JlcG9ydF9rZXkoZGV2LCBCVE5fVE9PTF9ET1VCTEVUQVAsIGZncnMg
PT0gMik7DQogCQlicmVhazsNCiANCiAJY2FzZSBGU1BfUEtUX1RZUEVfTk9S
TUFMX09QQzoNCiAJCS8qIG9uLXBhZCBjbGljaywgZmlsdGVyIGl0IGlmIG5l
Y2Vzc2FyeSAqLw0KIAkJaWYgKChhZC0+ZmxhZ3MgJiBGU1BEUlZfRkxBR19F
Tl9PUEMpICE9IEZTUERSVl9GTEFHX0VOX09QQykNCi0JCQlwYWNrZXRbMF0g
Jj0gfkJJVCgwKTsNCisJCQlwYWNrZXRbMF0gJj0gfkZTUF9QQjBfTEJUTjsN
CiAJCS8qIGZhbGwgdGhyb3VnaCAqLw0KIA0KIAljYXNlIEZTUF9QS1RfVFlQ
RV9OT1JNQUw6DQogCQkvKiBub3JtYWwgcGFja2V0ICovDQogCQkvKiBzcGVj
aWFsIHBhY2tldCBkYXRhIHRyYW5zbGF0aW9uIGZyb20gb24tcGFkIHBhY2tl
dHMgKi8NCiAJCWlmIChwYWNrZXRbM10gIT0gMCkgew0KKwkJCXVuc2lnbmVk
IGNoYXIgYnV0dG9uX3N0YXR1cyA9IDA7DQogCQkJaWYgKHBhY2tldFszXSAm
IEJJVCgwKSkNCiAJCQkJYnV0dG9uX3N0YXR1cyB8PSAweDAxOwkvKiB3aGVl
bCBkb3duICovDQogCQkJaWYgKHBhY2tldFszXSAmIEJJVCgxKSkNCkBAIC03
MTUsNyArODMzLDcgQEAgc3RhdGljIHBzbW91c2VfcmV0X3QgZnNwX3Byb2Nl
c3NfYnl0ZShzdHJ1Y3QgcHNtb3VzZSAqcHNtb3VzZSkNCiANCiAJaW5wdXRf
c3luYyhkZXYpOw0KIA0KLQlmc3BfcGFja2V0X2RlYnVnKHBhY2tldCk7DQor
CWZzcF9wYWNrZXRfZGVidWcocHNtb3VzZSwgcGFja2V0KTsNCiANCiAJcmV0
dXJuIFBTTU9VU0VfRlVMTF9QQUNLRVQ7DQogfQ0KQEAgLTc1NCw2ICs4NzIs
NyBAQCBzdGF0aWMgaW50IGZzcF9hY3RpdmF0ZV9wcm90b2NvbChzdHJ1Y3Qg
cHNtb3VzZSAqcHNtb3VzZSkNCiAJdmFsICY9IH4oRlNQX0JJVF9FTl9NU0lE
NyB8IEZTUF9CSVRfRU5fTVNJRDggfCBGU1BfQklUX0VOX0FVVE9fTVNJRDgp
Ow0KIAkvKiBFbnN1cmUgd2UgYXJlIG5vdCBpbiBhYnNvbHV0ZSBtb2RlICov
DQogCXZhbCAmPSB+RlNQX0JJVF9FTl9QS1RfRzA7DQorDQogCWlmIChwYWQt
PmJ1dHRvbnMgPT0gMHgwNikgew0KIAkJLyogTGVmdC9NaWRkbGUvUmlnaHQg
JiBTY3JvbGwgVXAvRG93bi9SaWdodC9MZWZ0ICovDQogCQl2YWwgfD0gRlNQ
X0JJVF9FTl9NU0lENjsNCkBAIC03NzcsNiArODk2LDE3IEBAIHN0YXRpYyBp
bnQgZnNwX2FjdGl2YXRlX3Byb3RvY29sKHN0cnVjdCBwc21vdXNlICpwc21v
dXNlKQ0KIAlmc3Bfb25wYWRfdnNjcihwc21vdXNlLCB0cnVlKTsNCiAJZnNw
X29ucGFkX2hzY3IocHNtb3VzZSwgdHJ1ZSk7DQogDQorCS8qIEVuYWJsZSBh
YnNvbHV0ZSBjb29yZGluYXRlcyBvdXRwdXQgZm9yIEN4L0R4IGhhcmR3YXJl
ICovDQorCWlmIChwYWQtPnZlciA+PSBGU1BfVkVSX1NUTDM4ODhfQzApIHsN
CisJCWlmIChmc3BfcmVnX3dyaXRlKHBzbW91c2UsIEZTUF9SRUdfU1dDMSwN
CisJCQlGU1BfQklUX1NXQzFfRU5fQUJTXzFGIHwNCisJCQlGU1BfQklUX1NX
QzFfRU5fR0lEIHwNCisJCQlGU1BfQklUX1NXQzFfRU5fQUJTXzJGKSkgew0K
KwkJCWRldl93YXJuKCZwc21vdXNlLT5wczJkZXYuc2VyaW8tPmRldiwNCisJ
CQkJICJGYWlsZWQgdG8gZW5hYmxlIGFic29sdXRlIGNvb3JkaW5hdGVzIG91
dHB1dC5cbiIpOw0KKwkJfQ0KKwl9DQorDQogCXJldHVybiAwOw0KIH0NCiAN
CkBAIC04MzIsNiArOTYyLDcgQEAgc3RhdGljIGludCBmc3BfcmVjb25uZWN0
KHN0cnVjdCBwc21vdXNlICpwc21vdXNlKQ0KIA0KIGludCBmc3BfaW5pdChz
dHJ1Y3QgcHNtb3VzZSAqcHNtb3VzZSkNCiB7DQorCXN0cnVjdCBpbnB1dF9k
ZXYgKmRldiA9IHBzbW91c2UtPmRldjsNCiAJc3RydWN0IGZzcF9kYXRhICpw
cml2Ow0KIAlpbnQgdmVyLCByZXYsIGJ1dHRvbnM7DQogCWludCBlcnJvcjsN
CkBAIC04NjQsNiArOTk1LDMxIEBAIGludCBmc3BfaW5pdChzdHJ1Y3QgcHNt
b3VzZSAqcHNtb3VzZSkNCiAJX19zZXRfYml0KFJFTF9XSEVFTCwgcHNtb3Vz
ZS0+ZGV2LT5yZWxiaXQpOw0KIAlfX3NldF9iaXQoUkVMX0hXSEVFTCwgcHNt
b3VzZS0+ZGV2LT5yZWxiaXQpOw0KIA0KKwlpZiAodmVyID49IEZTUF9WRVJf
U1RMMzg4OF9DMCkgew0KKwkJLyoNCisJCSAqIEhhcmR3YXJlIHByaW9yIHRv
IEN4IHBlcmZvcm1zIG11Y2ggYmV0dGVyIGluIHJlbGF0aXZlIG1vZGU7DQor
CQkgKiBoZW5jZSwgb25seSBlbmFibGUgYWJzb2x1dGUgY29vcmRpbmF0ZXMg
b3V0cHV0IGFzIHdlbGwgYXMNCisJCSAqIG11bHRpLXRvdWNoIG91dHB1dCBm
b3IgRHggaGFyZHdhcmUuDQorCQkgKi8NCisJCWludCBhYnNfeCA9IDEwMjQs
IGFic195ID0gNzY4Ow0KKw0KKwkJX19zZXRfYml0KEVWX0FCUywgZGV2LT5l
dmJpdCk7DQorCQlfX2NsZWFyX2JpdChFVl9SRUwsIGRldi0+ZXZiaXQpOw0K
KwkJX19zZXRfYml0KEJUTl9UT1VDSCwgZGV2LT5rZXliaXQpOw0KKwkJX19z
ZXRfYml0KEJUTl9UT09MX0ZJTkdFUiwgZGV2LT5rZXliaXQpOw0KKwkJX19z
ZXRfYml0KEJUTl9UT09MX0RPVUJMRVRBUCwgZGV2LT5rZXliaXQpOw0KKwkJ
X19zZXRfYml0KElOUFVUX1BST1BfU0VNSV9NVCwgZGV2LT5wcm9wYml0KTsN
CisNCisJCWlucHV0X3NldF9hYnNfcGFyYW1zKGRldiwgQUJTX1gsIDAsIGFi
c194LCAwLCAwKTsNCisJCWlucHV0X3NldF9hYnNfcGFyYW1zKGRldiwgQUJT
X1ksIDAsIGFic195LCAwLCAwKTsNCisJCWlucHV0X210X2luaXRfc2xvdHMo
ZGV2LCAyKTsNCisJCWlucHV0X3NldF9hYnNfcGFyYW1zKGRldiwgQUJTX01U
X1BPU0lUSU9OX1gsIDAsIGFic194LCAwLCAwKTsNCisJCWlucHV0X3NldF9h
YnNfcGFyYW1zKGRldiwgQUJTX01UX1BPU0lUSU9OX1ksIDAsIGFic195LCAw
LCAwKTsNCisNCisJCS8qIGRldmljZSBnZW5lcmF0ZWQgZ2VzdHVyZSBJRCBl
dmVudHMgKi8NCisJCWlucHV0X3NldF9jYXBhYmlsaXR5KGRldiwgRVZfTVND
LCBNU0NfR0VTVFVSRSk7DQorCX0NCisNCiAJcHNtb3VzZS0+cHJvdG9jb2xf
aGFuZGxlciA9IGZzcF9wcm9jZXNzX2J5dGU7DQogCXBzbW91c2UtPmRpc2Nv
bm5lY3QgPSBmc3BfZGlzY29ubmVjdDsNCiAJcHNtb3VzZS0+cmVjb25uZWN0
ID0gZnNwX3JlY29ubmVjdDsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0
L21vdXNlL3NlbnRlbGljLmggYi9kcml2ZXJzL2lucHV0L21vdXNlL3NlbnRl
bGljLmgNCmluZGV4IGVkMTM5NWEuLjA1Y2FmMTEgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2lucHV0L21vdXNlL3NlbnRlbGljLmgNCisrKyBiL2RyaXZlcnMv
aW5wdXQvbW91c2Uvc2VudGVsaWMuaA0KQEAgLTIsNyArMiw3IEBADQogICog
RmluZ2VyIFNlbnNpbmcgUGFkIFBTLzIgbW91c2UgZHJpdmVyLg0KICAqDQog
ICogQ29weXJpZ2h0IChDKSAyMDA1LTIwMDcgQXNpYSBWaXRhbCBDb21wb25l
bnRzIENvLiwgTHRkLg0KLSAqIENvcHlyaWdodCAoQykgMjAwNS0yMDA5IFRh
aS1od2EgTGlhbmcsIFNlbnRlbGljIENvcnBvcmF0aW9uLg0KKyAqIENvcHly
aWdodCAoQykgMjAwNS0yMDEyIFRhaS1od2EgTGlhbmcsIFNlbnRlbGljIENv
cnBvcmF0aW9uLg0KICAqDQogICogICBUaGlzIHByb2dyYW0gaXMgZnJlZSBz
b2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yDQogICog
ICBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZQ0KQEAgLTMzLDYgKzMzLDcgQEANCiAvKiBGaW5n
ZXItc2Vuc2luZyBQYWQgY29udHJvbCByZWdpc3RlcnMgKi8NCiAjZGVmaW5l
CUZTUF9SRUdfU1lTQ1RMMQkJMHgxMA0KICNkZWZpbmUJRlNQX0JJVF9FTl9S
RUdfQ0xLCUJJVCg1KQ0KKyNkZWZpbmUJRlNQX1JFR19UTU9EX1NUQVRVUwkw
eDIwDQogI2RlZmluZQlGU1BfUkVHX09QQ19RRE9XTgkweDMxDQogI2RlZmlu
ZQlGU1BfQklUX0VOX09QQ19UQUcJQklUKDcpDQogI2RlZmluZQlGU1BfUkVH
X09QVFpfWExPCTB4MzQNCkBAIC01NCw2ICs1NSwxNiBAQA0KICNkZWZpbmUJ
RlNQX0JJVF9GSVhfSFNDUglCSVQoNSkNCiAjZGVmaW5lCUZTUF9CSVRfRFJB
R19MT0NLCUJJVCg2KQ0KIA0KKyNkZWZpbmUJRlNQX1JFR19TV0MxCQkoMHg5
MCkNCisjZGVmaW5lCUZTUF9CSVRfU1dDMV9FTl9BQlNfMUYJQklUKDApDQor
I2RlZmluZQlGU1BfQklUX1NXQzFfRU5fR0lECUJJVCgxKQ0KKyNkZWZpbmUJ
RlNQX0JJVF9TV0MxX0VOX0FCU18yRglCSVQoMikNCisjZGVmaW5lCUZTUF9C
SVRfU1dDMV9FTl9GVVBfT1VUCUJJVCgzKQ0KKyNkZWZpbmUJRlNQX0JJVF9T
V0MxX0VOX0FCU19DT04JQklUKDQpDQorI2RlZmluZQlGU1BfQklUX1NXQzFf
R1NUX0dSUDAJQklUKDUpDQorI2RlZmluZQlGU1BfQklUX1NXQzFfR1NUX0dS
UDEJQklUKDYpDQorI2RlZmluZQlGU1BfQklUX1NXQzFfQlhfQ09NUEFUCUJJ
VCg3KQ0KKw0KIC8qIEZpbmdlci1zZW5zaW5nIFBhZCBwYWNrZXQgZm9ybWF0
aW5nIHJlbGF0ZWQgZGVmaW5pdGlvbnMgKi8NCiANCiAvKiBhYnNvbHV0ZSBw
YWNrZXQgdHlwZSAqLw0KQEAgLTYzLDYgKzc0LDk5IEBADQogI2RlZmluZQlG
U1BfUEtUX1RZUEVfTk9STUFMX09QQwkoMHgwMykNCiAjZGVmaW5lCUZTUF9Q
S1RfVFlQRV9TSElGVAkoNikNCiANCisvKiBiaXQgZGVmaW5pdGlvbnMgZm9y
IHRoZSBmaXJzdCBieXRlIG9mIHJlcG9ydCBwYWNrZXQgKi8NCisjZGVmaW5l
CUZTUF9QQjBfTEJUTgkJQklUKDApDQorI2RlZmluZQlGU1BfUEIwX1JCVE4J
CUJJVCgxKQ0KKyNkZWZpbmUJRlNQX1BCMF9NQlROCQlCSVQoMikNCisjZGVm
aW5lCUZTUF9QQjBfTUZNQ19GR1IyCUZTUF9QQjBfTUJUTg0KKyNkZWZpbmUJ
RlNQX1BCMF9NVVNUX1NFVAlCSVQoMykNCisjZGVmaW5lCUZTUF9QQjBfUEhZ
X0JUTgkJQklUKDQpDQorI2RlZmluZQlGU1BfUEIwX01GTUMJCUJJVCg1KQ0K
Kw0KKy8qIG5vdGlmaWNhdGlvbiBtZXNzYWdlIHR5cGVzICovDQorI2RlZmlu
ZQlGU1BfTk9USUZZX01TR19HSUQJKDB4YmEpDQorI2RlZmluZQlGU1BfTk9U
SUZZX01TR19IWF9HU1QJKDB4YzApDQorDQorLyogZ2VzdHVyZSBJRHMgKi8N
CisvKiogR0lEIGZvciAyRiBTdHJhaWdodCBVcCAgICAgICAgICAgICAqLw0K
KyNkZWZpbmUJRlNQX0dJRF9TUDEJCSgweDg2KQ0KKyNkZWZpbmUJRlNQX0dJ
RF9TUF9VUAkJRlNQX0dJRF9TUDENCisNCisvKiogR0lEIGZvciAyRiBTdHJh
aWdodCBEb3duICAgICAgICAgICAqLw0KKyNkZWZpbmUJRlNQX0dJRF9TUDUJ
CSgweDgyKQ0KKyNkZWZpbmUJRlNQX0dJRF9TUF9ET1dOCQlGU1BfR0lEX1NQ
NQ0KKw0KKy8qKiBHSUQgZm9yIDJGIFN0cmFpZ2h0IFJpZ2h0ICAgICAgICAg
ICovDQorI2RlZmluZQlGU1BfR0lEX1NQMgkJKDB4ODApDQorI2RlZmluZQlG
U1BfR0lEX1NQX1JJR0hUCUZTUF9HSURfU1AyDQorDQorLyoqIEdJRCBmb3Ig
MkYgU3RyYWlnaHQgTGVmdCAgICAgICAgICAgKi8NCisjZGVmaW5lCUZTUF9H
SURfU1A2CQkoMHg4NCkNCisjZGVmaW5lCUZTUF9HSURfU1BfTEVGVAkJRlNQ
X0dJRF9TUDYNCisNCisvKiogR0lEIGZvciAyRiBab29tIEluICAgICAgICAg
ICAgICAgICAqLw0KKyNkZWZpbmUJRlNQX0dJRF9TQzYJCSgweDhGKQ0KKyNk
ZWZpbmUJRlNQX0dJRF9TQ19aT09NX0lOCUZTUF9HSURfU0M2DQorDQorLyoq
IEdJRCBmb3IgMkYgWm9vbSBPdXQgICAgICAgICAgICAgICAgKi8NCisjZGVm
aW5lCUZTUF9HSURfU0MzCQkoMHg4QikNCisjZGVmaW5lCUZTUF9HSURfU0Nf
Wk9PTV9PVVQJRlNQX0dJRF9TQzMNCisNCisvKiogR0lEIGZvciAyRiBDdXJ2
ZSBDVyAgICAgICAgICAgICAgICAqLw0KKyNkZWZpbmUJRlNQX0dJRF9EQzEJ
CSgweEM0KQ0KKyNkZWZpbmUJRlNQX0dJRF9EQ19ST1RfQ1cJRlNQX0dJRF9E
QzENCisNCisvKiogR0lEIGZvciAyRiBDdXJ2ZSBDQ1cgICAgICAgICAgICAg
ICAqLw0KKyNkZWZpbmUJRlNQX0dJRF9EQzIJCSgweEMwKQ0KKyNkZWZpbmUJ
RlNQX0dJRF9EQ19ST1RfQ0NXCUZTUF9HSURfREMyDQorDQorLyoqIEdJRCBm
b3IgM0YgU3RyYWlnaHQgVXAgICAgICAgICAgICAgKi8NCisjZGVmaW5lCUZT
UF9HSURfVFM0CQkoMHgyRSkNCisjZGVmaW5lCUZTUF9HSURfVFNfVVAJCUZT
UF9HSURfVFM0DQorDQorLyoqIEdJRCBmb3IgM0YgU3RyYWlnaHQgRG93biAg
ICAgICAgICAgKi8NCisjZGVmaW5lCUZTUF9HSURfVFMyCQkoMHgyQSkNCisj
ZGVmaW5lCUZTUF9HSURfVFNfRE9XTgkJRlNQX0dJRF9UUzINCisNCisvKiog
R0lEIGZvciAzRiBTdHJhaWdodCBSaWdodCAgICAgICAgICAqLw0KKyNkZWZp
bmUJRlNQX0dJRF9UUzEJCSgweDI4KQ0KKyNkZWZpbmUJRlNQX0dJRF9UU19S
SUdIVAlGU1BfR0lEX1RTMQ0KKw0KKy8qKiBHSUQgZm9yIDNGIFN0cmFpZ2h0
IExlZnQgICAgICAgICAgICovDQorI2RlZmluZQlGU1BfR0lEX1RTMwkJKDB4
MkMpDQorI2RlZmluZQlGU1BfR0lEX1RTX0xFRlQJCUZTUF9HSURfVFMzDQor
DQorLyoqIEdJRCBmb3IgMkYgQ2xpY2sgICAgICAgICAgICAgICAgICAgKi8N
CisjZGVmaW5lCUZTUF9HSURfREYxCQkoMHgxMSkNCisjZGVmaW5lCUZTUF9H
SURfREZfQ0xJQ0sJRlNQX0dJRF9ERjENCisNCisvKiogR0lEIGZvciAyRiBE
b3VibGUgQ2xpY2sgICAgICAgICAgICAqLw0KKyNkZWZpbmUJRlNQX0dJRF9E
RjIJCSgweDEyKQ0KKyNkZWZpbmUJRlNQX0dJRF9ERl9EQkxDTElDSwlGU1Bf
R0lEX0RGMg0KKw0KKy8qKiBHSUQgZm9yIDNGIENsaWNrICAgICAgICAgICAg
ICAgICAgICovDQorI2RlZmluZQlGU1BfR0lEX1RGMQkJKDB4MTkpDQorI2Rl
ZmluZQlGU1BfR0lEX1RGX0NMSUNLCUZTUF9HSURfVEYxDQorDQorLyoqIEdJ
RCBmb3IgM0YgRG91YmxlIENsaWNrICAgICAgICAgICAgKi8NCisjZGVmaW5l
CUZTUF9HSURfVEYyCQkoMHgxQSkNCisjZGVmaW5lCUZTUF9HSURfVEZfREJM
Q0xJQ0sJRlNQX0dJRF9URjINCisNCisvKiogR0lEIGZvciBQYWxtICAgICAg
ICAgICAgICAgICAgICAgICAqLw0KKyNkZWZpbmUJRlNQX0dJRF9QTTEJCSgw
eDM4KQ0KKyNkZWZpbmUJRlNQX0dJRF9QQUxNCQlGU1BfR0lEX1BNMQ0KKw0K
Ky8qIGhhcmR3YXJlIHJldmlzaW9ucyAqLw0KKyNkZWZpbmUJRlNQX1ZFUl9T
VEwzODg4X0E0CSgweEMxKQ0KKyNkZWZpbmUJRlNQX1ZFUl9TVEwzODg4X0Iw
CSgweEQwKQ0KKyNkZWZpbmUJRlNQX1ZFUl9TVEwzODg4X0IxCSgweEQxKQ0K
KyNkZWZpbmUJRlNQX1ZFUl9TVEwzODg4X0IyCSgweEQyKQ0KKyNkZWZpbmUJ
RlNQX1ZFUl9TVEwzODg4X0MwCSgweEUwKQ0KKyNkZWZpbmUJRlNQX1ZFUl9T
VEwzODg4X0MxCSgweEUxKQ0KKyNkZWZpbmUJRlNQX1ZFUl9TVEwzODg4X0Qw
CSgweEUyKQ0KKyNkZWZpbmUJRlNQX1ZFUl9TVEwzODg4X0QxCSgweEUzKQ0K
KyNkZWZpbmUJRlNQX1ZFUl9TVEwzODg4X0UwCSgweEU0KQ0KKw0KICNpZmRl
ZiBfX0tFUk5FTF9fDQogDQogc3RydWN0IGZzcF9kYXRhIHsNCkBAIC03Nyw2
ICsxODEsNyBAQCBzdHJ1Y3QgZnNwX2RhdGEgew0KIA0KIAl1bnNpZ25lZCBj
aGFyCWxhc3RfcmVnOwkvKiBMYXN0IHJlZ2lzdGVyIHdlIHJlcXVlc3RlZCBy
ZWFkIGZyb20gKi8NCiAJdW5zaWduZWQgY2hhcglsYXN0X3ZhbDsNCisJdW5z
aWduZWQgaW50CWxhc3RfbXRfZmdyOwkvKiBMYXN0IHNlZW4gZmluZ2VyKG11
bHRpdG91Y2gpICovDQogfTsNCiANCiAjaWZkZWYgQ09ORklHX01PVVNFX1BT
Ml9TRU5URUxJQw0K

---1463809760-591349633-1327854592=:23561--

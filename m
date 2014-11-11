From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] psmouse: Add some support for the FocalTech PS/2 protocol
 extensions.
Date: Tue, 11 Nov 2014 19:58:22 +0100
Message-ID: <54625C4E.6010407@redhat.com>
References: <544B910A.6070304@gmail.com> <544E1304.2060006@redhat.com> <20141111165553.GA27720@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48249 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbaKKS60 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2014 13:58:26 -0500
In-Reply-To: <20141111165553.GA27720@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mathias Gottschlag <mgottschlag@gmail.com>, linux-input@vger.kernel.org

Hi,

On 11/11/2014 05:55 PM, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Mon, Oct 27, 2014 at 10:40:20AM +0100, Hans de Goede wrote:
>> Hi Matthias,
>>
>> On 10/25/2014 02:01 PM, Mathias Gottschlag wrote:
>>> +static void focaltech_report_state(struct psmouse *psmouse)
>>> +{
>>> +	int i;
>>> +	struct focaltech_data *priv = psmouse->private;
>>> +	struct focaltech_hw_state *state = &priv->state;
>>> +	struct input_dev *dev = psmouse->dev;
>>> +	int finger_count = 0;
>>> +
>>> +	for (i = 0; i < FOC_MAX_FINGERS; i++) {
>>> +		struct focaltech_finger_state *finger = &state->fingers[i];
>>> +		int active = finger->active && finger->valid;
>>> +		input_mt_slot(dev, i);
>>> +		input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
>>> +		if (active) {
>>> +			finger_count++;
>>> +			input_report_abs(dev, ABS_MT_POSITION_X, finger->x);
>>> +			input_report_abs(dev, ABS_MT_POSITION_Y,
>>> +					focaltech_invert_y(finger->y));
>>> +		}
>>> +	}
>>> +	input_mt_report_pointer_emulation(dev, false);
>>> +	input_mt_report_finger_count(dev, finger_count);
>>
>> These 2 lines should be replace with:
>> 	input_mt_report_pointer_emulation(dev, finger_count);
>>
>> So that BTN_TOUCH properly gets set when at least one finger is down (this is
>> mandatory when not reporting pressure).
> 
> I am baffled by this suggestion. input_mt_report_pointer_emulation()
> always report BTN_TOUCH, regardless of the value of the 2nd argument.

My bad, I misread the code (I think I mixed up the use_count and count vars).

> Also, the name of the 2nd argument is "use_count" and it is boolean, so
> I am not sure why you are suggesting that we basically do:
> 
> 	if (finger_count)
> 		input_mt_report_pointer_emulation(dev, true /*count them again */);
> 	else
> 		input_mt_report_pointer_emulation(dve, false);
> 
> Did you mean to tell Mathias to call
> input_mt_report_pointer_emulation(dev, *true*); to instruct MT core to
> count contacts and emit appropriate BTN_TOOL_* based on number of
> contacts (if any)?

Right, rereading things, their is no need for the focaltech code to do
its own finger counting, and these 2 calls:

	input_mt_report_pointer_emulation(dev, false);
	input_mt_report_finger_count(dev, finger_count);

Should be replaced with:

	input_mt_report_pointer_emulation(dev, true);

Sorry for the confusion.

Regards,

Hans

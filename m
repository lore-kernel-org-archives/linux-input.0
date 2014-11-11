From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] psmouse: Add some support for the FocalTech PS/2
 protocol extensions.
Date: Tue, 11 Nov 2014 08:55:53 -0800
Message-ID: <20141111165553.GA27720@dtor-ws>
References: <544B910A.6070304@gmail.com>
 <544E1304.2060006@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:50247 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbaKKQz6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2014 11:55:58 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn18so1322849igb.13
        for <linux-input@vger.kernel.org>; Tue, 11 Nov 2014 08:55:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <544E1304.2060006@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mathias Gottschlag <mgottschlag@gmail.com>, linux-input@vger.kernel.org

Hi Hans,

On Mon, Oct 27, 2014 at 10:40:20AM +0100, Hans de Goede wrote:
> Hi Matthias,
> 
> On 10/25/2014 02:01 PM, Mathias Gottschlag wrote:
> > +static void focaltech_report_state(struct psmouse *psmouse)
> > +{
> > +	int i;
> > +	struct focaltech_data *priv = psmouse->private;
> > +	struct focaltech_hw_state *state = &priv->state;
> > +	struct input_dev *dev = psmouse->dev;
> > +	int finger_count = 0;
> > +
> > +	for (i = 0; i < FOC_MAX_FINGERS; i++) {
> > +		struct focaltech_finger_state *finger = &state->fingers[i];
> > +		int active = finger->active && finger->valid;
> > +		input_mt_slot(dev, i);
> > +		input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
> > +		if (active) {
> > +			finger_count++;
> > +			input_report_abs(dev, ABS_MT_POSITION_X, finger->x);
> > +			input_report_abs(dev, ABS_MT_POSITION_Y,
> > +					focaltech_invert_y(finger->y));
> > +		}
> > +	}
> > +	input_mt_report_pointer_emulation(dev, false);
> > +	input_mt_report_finger_count(dev, finger_count);
> 
> These 2 lines should be replace with:
> 	input_mt_report_pointer_emulation(dev, finger_count);
> 
> So that BTN_TOUCH properly gets set when at least one finger is down (this is
> mandatory when not reporting pressure).

I am baffled by this suggestion. input_mt_report_pointer_emulation()
always report BTN_TOUCH, regardless of the value of the 2nd argument.
Also, the name of the 2nd argument is "use_count" and it is boolean, so
I am not sure why you are suggesting that we basically do:

	if (finger_count)
		input_mt_report_pointer_emulation(dev, true /*count them again */);
	else
		input_mt_report_pointer_emulation(dve, false);

Did you mean to tell Mathias to call
input_mt_report_pointer_emulation(dev, *true*); to instruct MT core to
count contacts and emit appropriate BTN_TOOL_* based on number of
contacts (if any)?

Thanks.

-- 
Dmitry

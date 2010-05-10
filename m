From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 1/2] elantech: Improved protocol support for hardware
 2
Date: Mon, 10 May 2010 14:27:07 +0200
Message-ID: <4BE7FB9B.3050805@euromail.se>
References: <4BE59352.4070407@tudelft.nl> <4BE5A353.2080308@euromail.se> <4BE604CC.7010903@tudelft.nl> <4BE6EBF6.7060900@euromail.se> <4BE7F5EB.9060904@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:52787 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751655Ab0EJM3D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 May 2010 08:29:03 -0400
In-Reply-To: <4BE7F5EB.9060904@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

>>> @@ -467,6 +480,8 @@ static void elantech_set_input_params(struct psmouse
>>> *psmouse)
>>>  		break;
>>>
>>>  	case 2:
>>> +		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
>>> +		input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2, ETP_WMAX_V2,
>>> 0, 0);
>> Is there an appropriate signal-to-noise ratio for the width? How does the device
>> handle fingers going away? Does it send one or several zero-width events?
> What do you mean by SNR for the width? The minimal variation which is
> significant for an actual change in the width of the finger? On my
> hardware it was fairly precise, and a unit was stable as long as I kept
> the finger pressed the same way.

Yes, that was what I was thinking of. If there is a lot of variation, it makes
sense to use the fuzz parameter to reduce the number of events emitted from the
input core.

> Actually at some low pressures I could
> swear it detects my blood pulse ;-)

It probably does - question is if that means the fuzz should be increased
somewhat. :-)

> That said, in all the measures the
> values were between 13 and 55, but I put as min and max 0 and 64. I did
> this because I'm not sure it's the same with every version of the
> hardware (apparently some old versions of the hardware even just report
> 0 all the time). It sounded more conservative this way. Is that the
> right way?

It sounds fine. The min and max are not exactly enforced by the input core, but
having the theoretic scale helps a lot when setting up applications.

> When you leave the last finger, the device sends one message with "0
> finger". However, as it is currently working, the driver then just sends
> one "BTN_TOUCH 0", but not any change in the ABS_TOOL_WIDTH. According
> to the input protocol, should it also sends in this case a
> "ABS_TOOL_WIDTH 0"?

It is fine with just BTN_TOUCH for the non-MT protocol.

The reason I asked specifically about this is partly because the current defuzz
mechanism might need to be extended for some special values, like zero for the
width and pressure events. For example, rather than emit zero, the input core
will emit anything between zero and the value of the fuzz parameter, upon
receiving a zero value.

Dmitry, this problem is very similar, but not identical to, the flat parameter
used for joysticks. Is there or has there been any thought about a similar
mechanism for the ABS events?

Henrik

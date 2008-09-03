From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] bcm5974-0.62: Compatibility mode reverted, BTN_TOUCH
 event added
Date: Wed, 03 Sep 2008 21:55:16 +0200
Message-ID: <48BEEBA4.4050301@euromail.se>
References: <48BD9CA4.7080805@euromail.se> <20080902161432.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:47207 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752765AbYICTz0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Sep 2008 15:55:26 -0400
In-Reply-To: <20080902161432.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: akpm@osdl.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Tue, Sep 02, 2008 at 10:05:56PM +0200, Henrik Rydberg wrote:
>> @@ -296,6 +297,7 @@ static int report_tp_state(struct bcm5974 *dev, int size)
>>
>>  	input_report_abs(input, ABS_PRESSURE, int2bound(&c->p, p));
>>
>> +	input_report_key(input, BTN_TOUCH, p > 0);
> 
> Just relying on p will probably make it too sensitive, have you tried
> adding hysteresis, like synaptics driver does?
> 

I have, and the problem is somewhat more complicated when dealing with
multiple fingers. The simple patch shown about actually works very well
in practice. However, things can always improve. Yesterday I sent a
second patch, bcm5974-0.63, which addressed this issue. However, the
quality of the mouse movement has regressed a little in that patch.
I would like to send yet another patch today, bcm5974-0.64, I hope this
does not cause too much confusion.

Regarding mousedev, I noticed that the tap functionality does not distinguish
between a tap (on/off localized in time and space) and a quick drag (on/off
localized in time only).


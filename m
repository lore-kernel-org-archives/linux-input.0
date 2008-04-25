From: Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] [INPUT] ucb1400: add key interface
Date: Fri, 25 Apr 2008 20:47:23 +0200
Message-ID: <20080425184723.GA23710@www.tglx.de>
References: <20080424110305.GA2971@www.tglx.de> <20080425112156.ZZRA012@mailhub.coreip.homeip.net> <20080425174535.GA10734@www.tglx.de> <20080425142949.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:34999 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932723AbYDYSr3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 14:47:29 -0400
Content-Disposition: inline
In-Reply-To: <20080425142949.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

* Dmitry Torokhov | 2008-04-25 14:32:53 [-0400]:

>> >Plus, you might want
>> >to select some kind of pressure thresholds before reporting touch press
>> >and release.
>> Sure but depending on what? Are there any drivers doing this allready?
>> I didn't find any on my grep.
>> Since these values are HW specifc they should be some userspace control
>> (like for max/min x/y).
>
>Synaptics for example does it. You just need to guesstimate what
>values are most likely to work by default (since you are trying to
>provide compatibility with a legacy interface, just to get user going)
>and then leave fine-tuning to evdev/tslib.

The code:
|        /* Post events
|         * BTN_TOUCH has to be first as mousedev relies on it when doing
|         * absolute -> relative conversion
|         */
|        if (hw.z > 30) input_report_key(dev, BTN_TOUCH, 1);
|        if (hw.z < 25) input_report_key(dev, BTN_TOUCH, 0);

Nothing happens if z is lets say 27. How do I do fine tunning with
evdev? This looks like nothing has any influence on 30 & 25.
My minimum pressure seems to be around 500 and I didn't get it past 700.
I get nothing if I touch lightly the touchscreen so I thing having
nothing is allready sane.

>Dmitry

Sebastian

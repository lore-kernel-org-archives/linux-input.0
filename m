From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 4/4] input: mt: Add pressure to pointer emulation code
Date: Mon, 29 Nov 2010 12:20:07 +0100
Message-ID: <4CF38C67.20509@euromail.se>
References: <1291014802-17061-1-git-send-email-rydberg@euromail.se> <1291014802-17061-5-git-send-email-rydberg@euromail.se> <20101129094715.GA9303@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101129094715.GA9303@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

>> @@ -124,9 +125,13 @@ void input_mt_report_pointer_emulation(struct input_dev
*dev)

>>  	if (oldest) {
>>  		int x = input_mt_get_value(oldest, ABS_MT_POSITION_X);
>>  		int y = input_mt_get_value(oldest, ABS_MT_POSITION_Y);
>> +		int p = input_mt_get_value(oldest, ABS_MT_PRESSURE);
> 
> What if device does not report ABS_MT_PRESSURE/ABS_PRESSURE? Do we rely
> on input core to suppress unsupported events? A comment would be nice...


Yes, the setup values are the only ones producing output here. How about this
addition to the function text: "The input core ensures only the KEY and ABS axes
already setup for this device will produce output."?

> Also, is there a gelper to set up pointer emulation capabilities for MT
> device?


This is certainly the plan with time, but currently it seemed best to leave the
rest of the event setup code untouched.

Thanks,
Henrik

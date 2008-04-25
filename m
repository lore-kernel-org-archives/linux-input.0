From: Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] [INPUT] ucb1400: add key interface
Date: Fri, 25 Apr 2008 19:45:35 +0200
Message-ID: <20080425174535.GA10734@www.tglx.de>
References: <20080424110305.GA2971@www.tglx.de> <20080425112156.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:46839 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731AbYDYRpq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 13:45:46 -0400
Content-Disposition: inline
In-Reply-To: <20080425112156.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

* Dmitry Torokhov | 2008-04-25 11:26:23 [-0400]:

>Hi Sebastian,
Hello Dimitry,

>> diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
>> index 9337352..ad14413 100644
>> --- a/drivers/input/touchscreen/ucb1400_ts.c
>> +++ b/drivers/input/touchscreen/ucb1400_ts.c
>> @@ -326,12 +326,14 @@ static int ucb1400_ts_thread(void *_ucb)
>>  			 */
>>  			if (valid) {
>>  				ucb1400_ts_event_release(ucb->ts_idev);
>> +				input_report_key(ucb->ts_idev, BTN_TOUCH, 0);
>
>Why don't you put input_repoer_key() inside ts_event_release()?
yep, looks better.

>>  				valid = 0;
>>  			}
>>  
>>  			timeout = MAX_SCHEDULE_TIMEOUT;
>>  		} else {
>>  			valid = 1;
>> +			input_report_key(ucb->ts_idev, BTN_TOUCH, 1);
>
>And here it should go into ucb1400_ts_evt_add().
same..

>Plus, you might want
>to select some kind of pressure thresholds before reporting touch press
>and release.
Sure but depending on what? Are there any drivers doing this allready?
I didn't find any on my grep.
Since these values are HW specifc they should be some userspace control
(like for max/min x/y).

>Thanks.
>
>-- 
>Dmitry

Sebastian

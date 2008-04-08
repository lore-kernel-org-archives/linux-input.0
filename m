From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 1/1] Input/Touchscreen Driver: add support AD7877touchscreen driver
Date: Tue, 8 Apr 2008 18:13:33 +0100
Message-ID: <8A42379416420646B9BFAC9682273B6D56269C@limkexm3.ad.analog.com>
References: <1202980649-13309-1-git-send-email-bryan.wu@analog.com> <20080407161007.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756586AbYDHRNx@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080407161007.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <bryan.wu@analog.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>
List-Id: linux-input@vger.kernel.org



>-----Original Message-----
>From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>Sent: Montag, 7. April 2008 22:16
>To: Bryan Wu
>Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Michael
>Hennerich
>Subject: Re: [PATCH 1/1] Input/Touchscreen Driver: add support
>AD7877touchscreen driver
>
>Hi Bryan, Michael,
>
>On Thu, Feb 14, 2008 at 05:17:28PM +0800, Bryan Wu wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> [try #3] Changlog (Add feedback from Dmitry Torokhov):
>>  - Change handling of spi_sync / spi_async return value handling
>>  - Remove depreciated dev->power.power_state
>>  - Fix error return path in ad7877_probe
>>  - delete pending kernel timer
>>  - Some minor cleanup (indention, use dev_err etc.)
>
>Sorry for the long silence... I have a couple of comments at the moment
>but I am sure i will have more ;)
>
>> +
>> +	status = spi_sync(spi, &req->msg);
>> +
>> +	if (status == 0)
>> +		status = req->msg.status;
>> +
>> +	kfree(req);
>> +	return status ? status : req->sample;
>
>Use after free here.

Yeah this is definitely broken. 

>
>> +
>> +	ts->irq_disabled = 1;
>> +	disable_irq(spi->irq);
>
>I am a bit uneasy here... do we need to wait for an async spi
completion
>here before proceeding? Overall I have some concerns about the
>irq/spi/removal/sysfs iteractions, I will need some more time to look
>through the driver.


I think you are right - let me come up with a patch.

Thanks and best regards,
Michael

>
>> +	status = spi_sync(spi, &req->msg);
>> +	ts->irq_disabled = 0;
>> +	enable_irq(spi->irq);
>> +
>
>--
>Dmitry

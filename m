From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 1/1] Input/Touchscreen Driver: add support AD7877touchscreen driver
Date: Mon, 12 May 2008 14:33:50 +0800
Message-ID: <386072610805112333w7bc935eo4ad0aae47b1c3975@mail.gmail.com>
References: <1202980649-13309-1-git-send-email-bryan.wu@analog.com>
	 <20080407161007.ZZRA012@mailhub.coreip.homeip.net>
	 <8A42379416420646B9BFAC9682273B6D56269C@limkexm3.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:7440 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbYELGdx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 May 2008 02:33:53 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1229443ywe.1
        for <linux-input@vger.kernel.org>; Sun, 11 May 2008 23:33:50 -0700 (PDT)
In-Reply-To: <8A42379416420646B9BFAC9682273B6D56269C@limkexm3.ad.analog.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <bryan.wu@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 9, 2008 at 1:13 AM, Hennerich, Michael
<Michael.Hennerich@analog.com> wrote:
>
>
>>-----Original Message-----
>>From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>>Sent: Montag, 7. April 2008 22:16
>>To: Bryan Wu
>>Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Michael
>>Hennerich
>>Subject: Re: [PATCH 1/1] Input/Touchscreen Driver: add support
>>AD7877touchscreen driver
>>
>>Hi Bryan, Michael,
>>
>>On Thu, Feb 14, 2008 at 05:17:28PM +0800, Bryan Wu wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> [try #3] Changlog (Add feedback from Dmitry Torokhov):
>>>  - Change handling of spi_sync / spi_async return value handling
>>>  - Remove depreciated dev->power.power_state
>>>  - Fix error return path in ad7877_probe
>>>  - delete pending kernel timer
>>>  - Some minor cleanup (indention, use dev_err etc.)
>>
>>Sorry for the long silence... I have a couple of comments at the moment
>>but I am sure i will have more ;)
>>
>>> +
>>> +    status = spi_sync(spi, &req->msg);
>>> +
>>> +    if (status == 0)
>>> +            status = req->msg.status;
>>> +
>>> +    kfree(req);
>>> +    return status ? status : req->sample;
>>
>>Use after free here.
>
> Yeah this is definitely broken.
>
>>
>>> +
>>> +    ts->irq_disabled = 1;
>>> +    disable_irq(spi->irq);
>>
>>I am a bit uneasy here... do we need to wait for an async spi
> completion
>>here before proceeding? Overall I have some concerns about the
>>irq/spi/removal/sysfs iteractions, I will need some more time to look
>>through the driver.
>
>
> I think you are right - let me come up with a patch.
>
> Thanks and best regards,
> Michael
>
>>

Hi Dmitry,

Sorry for no updates, I forget to send out that patch, although
Michael fixed the driver as your review.

So need I send out one updated patch including Michael's fixing or
just send out his incremental patch？

Thanks
-Bryan

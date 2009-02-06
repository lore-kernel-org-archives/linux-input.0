From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH] Input: bf54x-keys: ! has a higher priority than >
Date: Fri, 6 Feb 2009 08:49:49 -0000
Message-ID: <8A42379416420646B9BFAC9682273B6D0883413D@limkexm3.ad.analog.com>
References: <1233818395-6461-1-git-send-email-cooloney@kernel.org> <20090205140045.ef9fd5e6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:61334 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbZBFItx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2009 03:49:53 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20090205140045.ef9fd5e6.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, roel.kluin@gmail.com, michael.hennerich@analog.com, cooloney@kernel.org



>From: Andrew Morton [mailto:akpm@linux-foundation.org]
>Sent: Thursday, February 05, 2009 11:01 PM
>Subject: Re: [PATCH] Input: bf54x-keys: ! has a higher priority than >
>
>On Thu,  5 Feb 2009 15:19:55 +0800
>Bryan Wu <cooloney@kernel.org> wrote:
>
>> From: Roel Kluin <roel.kluin@gmail.com>
>>
>> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> Signed-off-by: Bryan Wu <cooloney@kernel.org>
>> ---
>>  drivers/input/keyboard/bf54x-keys.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/bf54x-keys.c
>b/drivers/input/keyboard/bf54x-keys.c
>> index 1928401..ee855c5 100644
>> --- a/drivers/input/keyboard/bf54x-keys.c
>> +++ b/drivers/input/keyboard/bf54x-keys.c
>> @@ -209,8 +209,8 @@ static int __devinit bfin_kpad_probe(struct
>platform_device *pdev)
>>  		goto out;
>>  	}
>>
>> -	if (!pdata->debounce_time || !pdata->debounce_time > MAX_MULT ||
>> -	    !pdata->coldrive_time || !pdata->coldrive_time > MAX_MULT) {
>> +	if (!pdata->debounce_time || pdata->debounce_time > MAX_MULT ||
>> +	    !pdata->coldrive_time || pdata->coldrive_time > MAX_MULT) {
>
>What is this `pdata' thing from which the data comes?

Platform device data.

struct bfin_kpad_platform_data *pdata = pdev->dev.platform_data;

>
>It seems a bit rude to kill the driver when we've detected an error
>which could easily be fixed up.

It actually just prints the error and then uses some default value later
on.

>
>>  		printk(KERN_ERR DRV_NAME
>>  			": Invalid Debounce/Columdrive Time from
pdata\n");
>
>nit: a colon does not terminate a sentence.
>
>This comment misspells "column".

Bryan will send a patch addressing this typo.

Best regards,
Michael

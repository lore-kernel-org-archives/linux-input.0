From: =?UTF-8?Q?S=c3=a9bastien_Szymanski?=
        <sebastien.szymanski@armadeus.com>
Subject: Re: [PATCH 3/3] HID: cp2112: fix broken gpio_direction_input callback
Date: Mon, 6 Nov 2017 14:58:46 +0100
Message-ID: <cb980f5f-48a0-8de0-f01d-5a90720797d6@armadeus.com>
References: <1509621164-28830-1-git-send-email-sebastien.szymanski@armadeus.com>
 <1509621164-28830-3-git-send-email-sebastien.szymanski@armadeus.com>
 <20171106081120.GC9728@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 3.mo6.mail-out.ovh.net ([178.33.253.26]:47693 "EHLO
        3.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752800AbdKFOAU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Nov 2017 09:00:20 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 8D0D011834F
        for <linux-input@vger.kernel.org>; Mon,  6 Nov 2017 14:50:19 +0100 (CET)
In-Reply-To: <20171106081120.GC9728@mail.corp.redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Julien Boibessot <julien.boibessot@armadeus.com>

On 11/06/2017 09:11 AM, Benjamin Tissoires wrote:
> On Nov 02 2017 or thereabouts, Sébastien Szymanski wrote:
>> When everything goes smoothly, ret is set to 0 which makes the function
>> to return EIO error.
>>
>> Fixes: 8e9faa15469e ("HID: cp2112: fix gpio-callback error handling")
>> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
>> ---
>>  drivers/hid/hid-cp2112.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
>> index 28e3c18..f7754a6 100644
>> --- a/drivers/hid/hid-cp2112.c
>> +++ b/drivers/hid/hid-cp2112.c
>> @@ -205,12 +205,13 @@ static int cp2112_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
>>  	ret = hid_hw_raw_request(hdev, CP2112_GPIO_CONFIG, buf,
>>  				 CP2112_GPIO_CONFIG_LENGTH, HID_FEATURE_REPORT,
>>  				 HID_REQ_SET_REPORT);
>> -	if (ret < 0) {
>> +	if (ret != CP2112_GPIO_CONFIG_LENGTH) {
> 
> Ack for this.

As explained in the interface specification, the device doesn't answer
to set reports, so the transfer should be CP2112_GPIO_CONFIG_LENGTH (5)
bytes.

> 
>>  		hid_err(hdev, "error setting GPIO config: %d\n", ret);
>>  		goto exit;
>>  	}
>>  
>> -	ret = 0;
>> +	mutex_unlock(&dev->lock);
>> +	return 0;
> 
> Wouldn't it be better to just turn
> - return ret < 0 ? ret : -EIO;
> into
> + return ret <= 0 ? ret : -EIO;
> at the end of the function?

Well, the commit I mentioned in the Fixes tag, changes from

- return ret <= 0 ? ret : -EIO;

to

+ return ret < 0 ? ret : -EIO;

because ret being 0 could mean that one of the hid_hw_raw_request
returned 0.

Regards,

> 
> I'd rather keep the same exit path in both cases, error or success.
> 
> Cheers,
> Benjamin
> 
> 
>>  
>>  exit:
>>  	mutex_unlock(&dev->lock);
>> -- 
>> 2.7.3
>>


-- 
Sébastien Szymanski
Software engineer, Armadeus Systems
Tel: +33 (0)9 72 29 41 44
Fax: +33 (0)9 72 28 79 26

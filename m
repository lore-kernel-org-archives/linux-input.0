Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9721E3B994A
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539656; cv=none; b=OEbqB8TSFECAlokObbiah3rXiFHEt3CA2Q2aRohZX4Qcj/6dV00GzzrbGjBiboBCJv4V30aeNBvVDNVUn06BMc/iltyaBvuyfnk6+MTUYLL+N1Gnl1vpHJqVxD59U/YkOIdMncDLa/fTYjK5g22EpiL0DBKT6GWYGxDqhGu7yEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539656; c=relaxed/simple;
	bh=tiuZVcNMy4DoPrQxIQRUlnLwAUukJl8DE8Icjw+1Rt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oj1jcvPI6exCySH2rmhiihJnqDgvtL4ou8DsXt1vttEz0hiyzUfSWm0SuMMLSDvEV0HtUdKBmpxVFsigU7oMnYenxjM8vVjp6HdTEgCJaB+iKwxiC039quYgwBB6d5M0cEAeYyIxj9YqZ5g9cre24saDe0QdMxTYAWyKwxhUqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiFU4WYq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiFU4WYq"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso200480966b.1
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788539653; x=1789144453; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gPGTFIafJjtEs8a95kfreZyPn0d1cOhdwIliaHPfLNc=;
        b=fiFU4WYqz0oq+D+2keXdq8WVonrsTDwmBD6qupKkoDWg3pYIPYwtcV59wWdr2GZHRS
         ahQQzZqz7vwdK8kVLZQHmxf/96eTwQsZ30M/dMMLlnfAstNmvboW3qyQDqG0IXV9qerd
         sa0JWaNraBnECuu39XZYMMcNi8lSLdQKxPol6f+CiwdsJ7o02LGMMYEFK2x0BCXUye8U
         68e8ddQQvs9XtyN2G18oOjAiPbq0CBOPygKuHwxGS8e+NVsGHS1+iECBItEbPxzoFpO3
         Q0oBZwvCJHqymtNPaKf2zDRU11YaqmbBuFE43pZGavZaTdSoz0hU3K1yezc/SLXyao+L
         PLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788539653; x=1789144453;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gPGTFIafJjtEs8a95kfreZyPn0d1cOhdwIliaHPfLNc=;
        b=nylYmwvtB4s1ngeNuzHfwmtvl2YFGoxIcsaLlV7SlPQI8f8E4RMA45WFGi3A8q43Xv
         msKEpvIpZuK5EVKh6bqqiBqwhpAkpZ/4N9f9hENcfURvVSc/8wat8gyt8L/35spQ8oSq
         A47g2LyEKpgKFFGJ4+qEOhQ4SDKOw6sTGNyrk2r4IfuUD0m1d6CPdHeQ/Yskdf7rPfxm
         Z/TN4B7cyFFsGsMt2CSecFEAhEcJ46MyBBPws01u0+0v9T2IgB9BG5gB1nOtcHcQttl1
         ZOtm4vweS/Ow7g+xVGnvC8ZtxwTa3EknGCNXlcDqvQft8oGLPaLQne+CZ1m700DOJklZ
         o9eQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHrzrs9CIvidUOrHe/1iGBfuZ+biqhs2dzEygkydrL+MUhOFkqhybaYu9naRfW7TsTnM0iB8Ux6hL2Yg==@vger.kernel.org
X-Gm-Message-State: AFuF++mieX91Lu6HqMBlplPB+VdSMpZA3yh8/IyMTQNea30iFl2ArDu/
	ybwfGjx/kic2NyThomESXP7r4kzCBacILu+JL7Rbrhp3tgjcghag3TUj
X-Gm-Gg: AYBFou3WG2xuQj5vWy9FBggPI7q15sFgGvr1cGs2vdR8Oy9KdM6IZMFe0C1o2febk0D
	gxBTNVVY8MnyfV14PHZyvNM/P8EzldbH1Ls/50xsS+SDKJPrbP72vQ7uwZPvaM4HBf+vWY2ekhp
	hg3rVrR3ZQvmR+z2qhEloZwhhDTaFXFRAOPrVVYQMl7GkdNcB5VE93smyJOqEZUqhDLXjWfO4/M
	DRR+QZ79ZG+6BwYH2t5AGtM/yBVdsn/ltyVqQpROVgucseLUp8mObOeiJ46UQm+YzGP8FmzsERu
	BdDaHKy0tncNjDHLhRnm7DPT7XAnVO3Gd653RBtFIa3IdNqIk/wWdBzYX3GzUZSVERHN41qcmV/
	5bAiIkuzUBiU/J2ipfmnkQT+k8RAm7EfOKkXyYPDcJKL6QA6jtwQRD2aiinpR3XxRhTyQiRTsGf
	9zLsNHZIauzVtrvPora0Dn+vbUgZQxx3hzOpGCHq/6Eb8aPOYnMfcCYO5g4pjw0x92fMLF43Az2
	SZtspiPHc5KR9VnWwsRawnnyEyYfxBr+JMR+N1N/X3qeA==
X-Received: by 2002:a17:907:c50e:b0:c25:6c9a:88bc with SMTP id a640c23a62f3a-c260cc0e2a2mr522780866b.19.1788539652420;
        Fri, 04 Sep 2026 09:34:12 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5773c5sm133847966b.40.2026.09.04.09.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 09:34:11 -0700 (PDT)
Message-ID: <119cd005-ece9-4e2a-aded-0d6d66c5bcfc@gmail.com>
Date: Fri, 4 Sep 2026 18:34:09 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: logitech-hidpp: fix hi-res scroll for Bolt-connected
 MX Master
To: Alexey Zagorodnikov <xglooom@gmail.com>,
 Rafael Passos <rafael@rcpassos.me>, lains@riseup.net, hadess@hadess.net,
 jikos@kernel.org, bentiss@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
References: <20260904034843.1340846-1-rafael@rcpassos.me>
 <96cd3161-3a6c-455e-a63c-f3226b27f74f@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
In-Reply-To: <96cd3161-3a6c-455e-a63c-f3226b27f74f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!
Is this the same issue as in
https://lore.kernel.org/linux-input/20260901-bolt-scroll-fix-v1-1-58bca7ae487f@protonmail.com/
The symptoms seem similar at least, and if so the approach to fixing
it in that case is to simply treat Bolt devices like previous DJ
devices, rather than having special treatment for Bolt.
Can you who have Bolt mice maybe test that patch too to see if it
solves the same issue?
Regards
Erik

On 9/4/26 09:44, Alexey Zagorodnikov wrote:
> Hi, thanks for your patch. I've tested it with my MX Master 4 + Bolt.
>
> I'm not seeing a regression from mainline hid++ enabling, as in Solaar 
> high-res scrolling was disabled in my config.
>
> But with hid++ for Bolt enabled by mainline and your patch fixing 
> high-res scroll init, I finally got smooth high-res scrolling on MX 
> Master 4 via a Bolt connection.
>
> Tested-by: Alexey Zagorodnikov <xglooom@gmail.com>
>
> On 9/4/26 08:48, Rafael Passos wrote:
>> The new added support for Logitech HID++ caused this mouse to
>> scroll too far for each tic when using the USB dongle (Bolt).
>> Previously, this mouse was handled as hid_generic over the Bold
>> connection, and logitech-hidpp when over Bluetooth.
>>
>> Cause:
>> Over the Bolt receiver, the mouse reports  are forwarded over the 
>> generic
>> interface 1, instead of the new HID++ child device. The generic hid does
>> now know about the hi-res scrolling used by the HID++.
>> In my tests, I discovered this mouse has a multiplier factor of 15. This
>> multiplier is only handled by the logitech-hidpp driver. When piped to
>> hid_generic, the "hi-res" value was piped to a "low-res" field, making
>> the scroll unbearable.
>>
>> The fix routes the wheel using the HID++, so the ticks are scaled by the
>> multiplier and correctly reported as a hi-res event.
>>
>> I also had to move the hidpp_is_bolt_child function up, to use it in the
>> hidpp_connect_event function, where the gate for
>> hidpp_initialize_hires_scroll function lives.
>>
>> Tested with:
>> - Logitech MX Master 3S (mouse) via Bolt receiver and Bluetooth.
>>
>> Fixes: 022eb347ff3a ("HID: logitech: add Bolt receiver support for 
>> Logitech HID++ devices")
>> Signed-off-by: Rafael Passos <rafael@rcpassos.me>
>> ---
>>
>> Hi,
>> I decided to send this patch as soon as I made it work, to try to make
>> it into this fix cycle.
>>
>> I do not have other devices to test this with.
>> It would *be great* to have other users testing this.
>>
>> Lastly, I decided to make all the changes in a single patch.
>> But I can break it up if asked.
>>
>> Thanks,
>> Rafael
>>
>>
>>   drivers/hid/hid-logitech-hidpp.c | 47 ++++++++++++++++++++++----------
>>   1 file changed, 32 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/hid/hid-logitech-hidpp.c 
>> b/drivers/hid/hid-logitech-hidpp.c
>> index 1504de32b1c84..960543bfd5ea1 100644
>> --- a/drivers/hid/hid-logitech-hidpp.c
>> +++ b/drivers/hid/hid-logitech-hidpp.c
>> @@ -3900,6 +3900,19 @@ static int 
>> hidpp10_consumer_keys_raw_event(struct hidpp_device *hidpp,
>>       return 1;
>>   }
>>   +static bool hidpp_is_bolt_child(struct hid_device *hdev)
>> +{
>> +    struct device *parent = hdev->dev.parent;
>> +    struct hid_device *receiver_hdev;
>> +
>> +    if (!parent)
>> +        return false;
>> +
>> +    receiver_hdev = to_hid_device(parent);
>> +    return receiver_hdev->vendor == USB_VENDOR_ID_LOGITECH &&
>> +           receiver_hdev->product == 
>> USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER;
>> +}
>> +
>>   /* 
>> -------------------------------------------------------------------------- 
>> */
>>   /* High-resolution scroll 
>> wheels                                              */
>>   /* 
>> -------------------------------------------------------------------------- 
>> */
>> @@ -3910,7 +3923,9 @@ static int hi_res_scroll_enable(struct 
>> hidpp_device *hidpp)
>>       u8 multiplier = 1;
>>         if (hidpp->capabilities & 
>> HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
>> -        ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
>> +        bool use_hidpp = hidpp_is_bolt_child(hidpp->hid_dev);
>> +
>> +        ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, use_hidpp);
>>           if (ret == 0)
>>               ret = hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
>>       } else if (hidpp->capabilities & 
>> HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL) {
>> @@ -3998,6 +4013,19 @@ static int 
>> hidpp20_hires_wheel_raw_event(struct hidpp_device *hidpp,
>>           return 1;
>>       }
>>   +    /* wheel movement event: 16-bit signed delta in HID++ ticks */
>> +    if ((data[3] & 0xf0) == 0x00 && size >= 7 && hidpp->input &&
>> +        hidpp->vertical_wheel_counter.wheel_multiplier) {
>> +        s16 delta = get_unaligned_be16(&data[5]);
>> +
>> +        if (delta) {
>> +            hidpp_scroll_counter_handle_scroll(hidpp->input,
>> +                &hidpp->vertical_wheel_counter, delta);
>> +            input_sync(hidpp->input);
>> +        }
>> +        return 1;
>> +    }
>> +
>>       return 0;
>>   }
>>   @@ -4405,19 +4433,6 @@ static int hidpp_initialize_battery(struct 
>> hidpp_device *hidpp)
>>       return ret;
>>   }
>>   -static bool hidpp_is_bolt_child(struct hid_device *hdev)
>> -{
>> -    struct device *parent = hdev->dev.parent;
>> -    struct hid_device *receiver_hdev;
>> -
>> -    if (!parent)
>> -        return false;
>> -
>> -    receiver_hdev = to_hid_device(parent);
>> -    return receiver_hdev->vendor == USB_VENDOR_ID_LOGITECH &&
>> -           receiver_hdev->product == 
>> USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER;
>> -}
>> -
>>   static int hidpp_bolt_init(struct hidpp_device *hidpp)
>>   {
>>       struct hid_device *hdev = hidpp->hid_dev;
>> @@ -4579,7 +4594,9 @@ static void hidpp_connect_event(struct 
>> work_struct *work)
>>       }
>>         hidpp_initialize_battery(hidpp);
>> -    if (!hid_is_usb(hidpp->hid_dev))
>> +
>> +    if (!hid_is_usb(hidpp->hid_dev) ||
>> +        hidpp_is_bolt_child(hidpp->hid_dev))
>>           hidpp_initialize_hires_scroll(hidpp);
>>         /* forward current battery state */

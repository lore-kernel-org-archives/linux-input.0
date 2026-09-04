Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59863E51F9
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545868; cv=none; b=oLdd9qKRoGijJHtvgEj/Myb3nq/XspCAHWeJAV3QgOSMSnC3ZpnhrVQ38FR68vlLNLhFpFS94SHsAI1K/CQowQm4r3NX7/dojuzMw1rWuwxBNVu1H6ztMYYhLe5b8bvybzB6aNaxMtYZgyDauoOa8asv2sGKbRrgFW11i6dPH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545868; c=relaxed/simple;
	bh=YVmzWIs/Deix0juAaF89dGwQmWBVLKLJyeQCcIuAZiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPtQoEhwG1LLhDLnxe/jLXyuNg0ZQouH4mti4pqxX4w2oInDOBa0Ghv+5mRLoigreXdPaOrC/lUDZrJWVjMLjVyCxA63ronF9f5PXeOYRaUxOC1vuwd/knHt24jV+gbFXdP42xc6vQ9APL0Z4Oby6ivqMhmnkm7nevxvwziUP6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbXj4ZtS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbXj4ZtS"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48444ec4fe2so875781f8f.0
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788545865; x=1789150665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mJ8W+ze/gMbCaYGCqYlN+8Ir9SMTsdeudEOptRqezHw=;
        b=CbXj4ZtSocbko3FJkzuzorgskT/dIyMDIR1oPpyTHKL4/39ifeNkJPl7YhUDN+UDty
         8DVXn4j4tiV9tMDMkO//OvpTQXqFokElJ6WpUP/+4Qr4fEdv5cVJPsaeqrykiNuG6TQW
         XvMUrT/iZXAOr12nODPqcoT3iRmFDB78B0bCBvEt1RHnwmTf0a1jnWNxpBBKF+gOIiqk
         U9knzHCxVIpj40cApA/5p92Wp+tuS6nM0N68SjtrdjYVqcjo7/tkNoHp6UADyoaVOWDE
         OQQHlmVY7h4Zu5buXJfqiH8pscZ3SkceML1jlDZ4jifU397DbDk4hThz0Rq9MB2Ptk5g
         Dhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788545865; x=1789150665;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mJ8W+ze/gMbCaYGCqYlN+8Ir9SMTsdeudEOptRqezHw=;
        b=d7Dzshuel1V4Vhoalc2CtExYoJlFm36DUbYRXE+TFpGLAvSrjaenHPe5uwwQSeFcLz
         ae/O9Fv2stKpAMjKXCpBDxdoh1IV6d9sK3PFQ/fdSF7Kf4CEavMMqAoTcxhfoGC7FHPf
         oQ+undoWMBgUjUAnYqgPQHuXLbARo9RO4VG4S59oeDc6bFFuinqYGDjDNInm0PkmS9+Q
         Fek+sqfdYGBG0RLM4fCgoRWPAulCTYVWjeFCckKbarEDp/UqAr4KRGXYLSzzlWj+SBP6
         Kt6M0TqX4ZP4mxrl7L7xCTsbzkI7Zww+DC63piAP/etvwlRHg2wLJZkSsgf7+MVLq8J2
         mpfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGOLzZExYgQni7/p1B+D8Z39Lik6rytUREnbGYuxBBc7HwXGpcFXGrlAlMiSTh9p1TqjgIQr82w98Lnw==@vger.kernel.org
X-Gm-Message-State: AFuF++l9d1XIe0JIOjzonYX032ZCP2wXPN99/r/wHVAbqPje5bpSOpYn
	+ZmO27/ggozqIaOE9ru+xytVFLl4zKYQg2IekmGvk/OsV3vXHrUz81AYpIbofy8d
X-Gm-Gg: AYBFou2OH2xnb+ZBSa/5zS+n500bqG8c9tgmNfJsFn79sp+gPi20GQvRn4Gf3o5ZCTf
	jpdvCPaqSO8vcvEKU5Um+rXXuLxk/bzP9JkKLN1n4AFmqEN+yBwC+vmRcdE0yxgm+86Mlpn17vW
	H3HPEfmb6oLsb0U4dyUXlAGqiVjVE3WDlz9uOQ4NkwHbKi40iG7Fg1mgnZAyavoEPWBmVe64xaO
	sGfuEikoLErB2qxmoDMUik1vA5CFXA0nQRrdmRcnME+m9WjnPu8HaSalz18ohnzj2JouXfVsX0b
	CKoHekmJp02F0lkSLdhbu2ys+2kFYtGGHEhRDQEL1AJ/OMaJUeXcROl2NspmYQM8AGYJ1uM8NKR
	dEs4kWqNd+l+eNDUr9hqBP5mcVU0fQz/q/B2ZcQuLMjHN6w1zqlYauRFdzE8ZDnnK80siNV30k/
	n+UhOMqrWdPME6jN269VZtK+L+j6hLWnXnWk2JTeOjcAKVPef+1aC7Lun4i4BdtXxCHKALwym6R
	T1ewCY=
X-Received: by 2002:a05:600c:a0a:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49cf81e6cebmr121736065e9.4.1788545864023;
        Fri, 04 Sep 2026 11:17:44 -0700 (PDT)
Received: from ?IPV6:2a0c:9a40:8950:f000::3a4? ([2a0c:9a40:8950:f000::3a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b7bfasm8313258f8f.29.2026.09.04.11.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 11:17:43 -0700 (PDT)
Message-ID: <3fca5207-198d-4dc8-956e-7b196f71b934@gmail.com>
Date: Fri, 4 Sep 2026 23:17:40 +0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: logitech-hidpp: fix hi-res scroll for Bolt-connected
 MX Master
To: =?UTF-8?Q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>,
 Rafael Passos <rafael@rcpassos.me>, lains@riseup.net, hadess@hadess.net,
 jikos@kernel.org, bentiss@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
References: <20260904034843.1340846-1-rafael@rcpassos.me>
 <96cd3161-3a6c-455e-a63c-f3226b27f74f@gmail.com>
 <119cd005-ece9-4e2a-aded-0d6d66c5bcfc@gmail.com>
Content-Language: en-US
From: Alexey Zagorodnikov <xglooom@gmail.com>
In-Reply-To: <119cd005-ece9-4e2a-aded-0d6d66c5bcfc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I've tried your patch, and MX Master 4 + Bolt goes crazy, it moves on 
vertical with very high speed, and very very slow on horizontal.

On 9/4/26 21:34, Erik Håkansson wrote:
> Hi!
> Is this the same issue as in
> https://lore.kernel.org/linux-input/20260901-bolt-scroll-fix-v1-1-58bca7ae487f@protonmail.com/ 
>
> The symptoms seem similar at least, and if so the approach to fixing
> it in that case is to simply treat Bolt devices like previous DJ
> devices, rather than having special treatment for Bolt.
> Can you who have Bolt mice maybe test that patch too to see if it
> solves the same issue?
> Regards
> Erik
>
> On 9/4/26 09:44, Alexey Zagorodnikov wrote:
>> Hi, thanks for your patch. I've tested it with my MX Master 4 + Bolt.
>>
>> I'm not seeing a regression from mainline hid++ enabling, as in 
>> Solaar high-res scrolling was disabled in my config.
>>
>> But with hid++ for Bolt enabled by mainline and your patch fixing 
>> high-res scroll init, I finally got smooth high-res scrolling on MX 
>> Master 4 via a Bolt connection.
>>
>> Tested-by: Alexey Zagorodnikov <xglooom@gmail.com>
>>
>> On 9/4/26 08:48, Rafael Passos wrote:
>>> The new added support for Logitech HID++ caused this mouse to
>>> scroll too far for each tic when using the USB dongle (Bolt).
>>> Previously, this mouse was handled as hid_generic over the Bold
>>> connection, and logitech-hidpp when over Bluetooth.
>>>
>>> Cause:
>>> Over the Bolt receiver, the mouse reports  are forwarded over the 
>>> generic
>>> interface 1, instead of the new HID++ child device. The generic hid 
>>> does
>>> now know about the hi-res scrolling used by the HID++.
>>> In my tests, I discovered this mouse has a multiplier factor of 15. 
>>> This
>>> multiplier is only handled by the logitech-hidpp driver. When piped to
>>> hid_generic, the "hi-res" value was piped to a "low-res" field, making
>>> the scroll unbearable.
>>>
>>> The fix routes the wheel using the HID++, so the ticks are scaled by 
>>> the
>>> multiplier and correctly reported as a hi-res event.
>>>
>>> I also had to move the hidpp_is_bolt_child function up, to use it in 
>>> the
>>> hidpp_connect_event function, where the gate for
>>> hidpp_initialize_hires_scroll function lives.
>>>
>>> Tested with:
>>> - Logitech MX Master 3S (mouse) via Bolt receiver and Bluetooth.
>>>
>>> Fixes: 022eb347ff3a ("HID: logitech: add Bolt receiver support for 
>>> Logitech HID++ devices")
>>> Signed-off-by: Rafael Passos <rafael@rcpassos.me>
>>> ---
>>>
>>> Hi,
>>> I decided to send this patch as soon as I made it work, to try to make
>>> it into this fix cycle.
>>>
>>> I do not have other devices to test this with.
>>> It would *be great* to have other users testing this.
>>>
>>> Lastly, I decided to make all the changes in a single patch.
>>> But I can break it up if asked.
>>>
>>> Thanks,
>>> Rafael
>>>
>>>
>>>   drivers/hid/hid-logitech-hidpp.c | 47 
>>> ++++++++++++++++++++++----------
>>>   1 file changed, 32 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/hid/hid-logitech-hidpp.c 
>>> b/drivers/hid/hid-logitech-hidpp.c
>>> index 1504de32b1c84..960543bfd5ea1 100644
>>> --- a/drivers/hid/hid-logitech-hidpp.c
>>> +++ b/drivers/hid/hid-logitech-hidpp.c
>>> @@ -3900,6 +3900,19 @@ static int 
>>> hidpp10_consumer_keys_raw_event(struct hidpp_device *hidpp,
>>>       return 1;
>>>   }
>>>   +static bool hidpp_is_bolt_child(struct hid_device *hdev)
>>> +{
>>> +    struct device *parent = hdev->dev.parent;
>>> +    struct hid_device *receiver_hdev;
>>> +
>>> +    if (!parent)
>>> +        return false;
>>> +
>>> +    receiver_hdev = to_hid_device(parent);
>>> +    return receiver_hdev->vendor == USB_VENDOR_ID_LOGITECH &&
>>> +           receiver_hdev->product == 
>>> USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER;
>>> +}
>>> +
>>>   /* 
>>> -------------------------------------------------------------------------- 
>>> */
>>>   /* High-resolution scroll 
>>> wheels                                              */
>>>   /* 
>>> -------------------------------------------------------------------------- 
>>> */
>>> @@ -3910,7 +3923,9 @@ static int hi_res_scroll_enable(struct 
>>> hidpp_device *hidpp)
>>>       u8 multiplier = 1;
>>>         if (hidpp->capabilities & 
>>> HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
>>> -        ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
>>> +        bool use_hidpp = hidpp_is_bolt_child(hidpp->hid_dev);
>>> +
>>> +        ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, use_hidpp);
>>>           if (ret == 0)
>>>               ret = hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
>>>       } else if (hidpp->capabilities & 
>>> HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL) {
>>> @@ -3998,6 +4013,19 @@ static int 
>>> hidpp20_hires_wheel_raw_event(struct hidpp_device *hidpp,
>>>           return 1;
>>>       }
>>>   +    /* wheel movement event: 16-bit signed delta in HID++ ticks */
>>> +    if ((data[3] & 0xf0) == 0x00 && size >= 7 && hidpp->input &&
>>> +        hidpp->vertical_wheel_counter.wheel_multiplier) {
>>> +        s16 delta = get_unaligned_be16(&data[5]);
>>> +
>>> +        if (delta) {
>>> + hidpp_scroll_counter_handle_scroll(hidpp->input,
>>> +                &hidpp->vertical_wheel_counter, delta);
>>> +            input_sync(hidpp->input);
>>> +        }
>>> +        return 1;
>>> +    }
>>> +
>>>       return 0;
>>>   }
>>>   @@ -4405,19 +4433,6 @@ static int hidpp_initialize_battery(struct 
>>> hidpp_device *hidpp)
>>>       return ret;
>>>   }
>>>   -static bool hidpp_is_bolt_child(struct hid_device *hdev)
>>> -{
>>> -    struct device *parent = hdev->dev.parent;
>>> -    struct hid_device *receiver_hdev;
>>> -
>>> -    if (!parent)
>>> -        return false;
>>> -
>>> -    receiver_hdev = to_hid_device(parent);
>>> -    return receiver_hdev->vendor == USB_VENDOR_ID_LOGITECH &&
>>> -           receiver_hdev->product == 
>>> USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER;
>>> -}
>>> -
>>>   static int hidpp_bolt_init(struct hidpp_device *hidpp)
>>>   {
>>>       struct hid_device *hdev = hidpp->hid_dev;
>>> @@ -4579,7 +4594,9 @@ static void hidpp_connect_event(struct 
>>> work_struct *work)
>>>       }
>>>         hidpp_initialize_battery(hidpp);
>>> -    if (!hid_is_usb(hidpp->hid_dev))
>>> +
>>> +    if (!hid_is_usb(hidpp->hid_dev) ||
>>> +        hidpp_is_bolt_child(hidpp->hid_dev))
>>>           hidpp_initialize_hires_scroll(hidpp);
>>>         /* forward current battery state */

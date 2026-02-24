Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8255363C4C
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771976104; cv=none; b=RB4Gt+68qx8HFonVblQULPeWw3btWZbaMlVVBJOGqpz4IeyFLxT/prWH0du7AIAdy659zXup9VJ513N1D+XUHPYfyQUEv4KjnlivXW6/ULJqi2O2hcx5BCYWDU1U0BIg9QyJPOtQVs5C7pyU7fpjj/tUP1dSPVJ+jwsHEQTYegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771976104; c=relaxed/simple;
	bh=v+9fGze6c4m+bBxApiBGBcQRFXK3TzOBRqBAr9LU09Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVcT0EC9B7cmqYwyfhnX1tWrsY0MaBWS7DBr8VdSGBGE7o2JqB5saTakbSDwInG2Xj4fCBBBnZdSg3k24EIGHQcdBmtGnYcKw95p/+HOzIHx08FevgqriOfOEUt3ut0rCzLwS6aChnQnu4y8MGS/UF4winemPD1bg/TZ2zxFzcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7DnmLyQ; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7DnmLyQ"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bdbd13ca01so994115eec.0
        for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 15:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771976101; x=1772580901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yNpazGv5au7R/7nkHvCa0SyG4eiAPdXgU70gdoYbgc4=;
        b=I7DnmLyQxvmkJ4t63h1BFzmjYJJq0UoN++AZbORDW4hz/qqNOKjsvKpAgohfvUO5jK
         Ji9DlPplB8jqPF0b/vDzPcjeXcJBCZVdkowksET8TGryc1eZnz3c16BArrwNt+BQx5pN
         9W/kD5sYFWsc/UTzrJGcQ8TKdOrxPIdsys0zmMjdyeNEjMjuuRRIByrG25/e5wvKZN/z
         7q8wo3Q3LOsrcjPPssrtj7z2/8paeIOEZ54A48BS0+SFM2DAIFBhCFNKa8sSy6YqQHkJ
         u89+bsPguN0k2MAuEfiD4LtGuFpIDzDJOYsM9byVAui3GRsao7t3VuEw9JWKSKv0qn/W
         Vkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771976101; x=1772580901;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNpazGv5au7R/7nkHvCa0SyG4eiAPdXgU70gdoYbgc4=;
        b=ccFe+jBBRaNvF9lLeBMrC/O0e/Y15Bc/h2Nrws0+/3PDJIo5nthhjO8oQiAXpstyNJ
         G/XSYzVoAN+XLY2gboxzeFP/yx8wA2xZ7kbXyPk+CpcoG9omoMo2arJDclDv0ptF2tTp
         ExUrm/wDOd62ZamgCEORuEpdXQ0I2CF0zVCSZL3wUsP8EK4qxUCDakWV0zHldeBcBrVS
         XnW5LNPQV2U9/pQW0j/TLnB+XVFJrz96Pj1UqAJjbWMRZB4VjDRoEoo7hi4vzdjBPQhW
         7rxCkYLHl6wW3ly1/1w9we9E3qsCUN4mcjM+tgYPFGksAc/lbcvbiQ9Rorbr5yHTGbZj
         MF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPplKuJgJrvYNaPye7ZQIskJOR/1NQpHT1NnhPKLJqZH1m+3DpN/a5E7Uo5v7g0OU1wyGXTMEV1HzbPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD+tYX31ucuF0EewdEbkdvjyS3CvthZEricD4oHMjXaGlk1I12
	VcmLT6Kphg+9EdewmP2wFVtNh+cQxBaw1A9vexnfQzf2lfhe+aacCBQH
X-Gm-Gg: ATEYQzxIxt6zF3BnS68GMl18/QMCnKHPua1r/yf52VuZoXsNEZa7UCgNXhYKYLdnc28
	/9r1QvhrxeFsHSonUcUHp6+sMxPK3hn4SApL5/KiKY9Bo5nu87kAWRz8DVBZg8jA16plGTXceYn
	NEW4bGSY81NTtL4lLTeispp7eteLHuBDfs8vEMN5abh+Csp7xNJzdVFMk+4FKPslo/4ci5l4heL
	ppP+d1DC9XJKu75OmuwQqx+At8jpKhPROMhJOp5u7ZqP+po0P53WgpE3vJJ+q/L1HFfXGdPsUhO
	d/q1wCs5+D+m6fKkdyA3VyPxQCcOc32RMFi987RY/coWAuPiOCMOnxgxECZ7kTbbx707hD48y4k
	ujqsvQmcciQebjcSc9lOrdYzfwtJlx66H058hNpjEH69d0z8lMHgP1G8LmzV2oJdKkhoDzz1J6w
	Qb8Xj7N/7EaXXnhKxfAguCoAseRul23jz4fOxwb4eRf7dt+MhHZj4J3vW/gSpk43JDABvBu8LY
X-Received: by 2002:a05:7300:fd08:b0:2bd:b961:7e8b with SMTP id 5a478bee46e88-2bdc339d1cemr110068eec.24.1771976100780;
        Tue, 24 Feb 2026 15:35:00 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdc412c8aasm55856eec.25.2026.02.24.15.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 15:35:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f16e34ee-0ab7-450f-a2e9-273393983767@roeck-us.net>
Date: Tue, 24 Feb 2026 15:34:58 -0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] HID: playstation: Center initial joystick axes to
 prevent spurious events
To: Siarhei Vishniakou <svv@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Roderick Colenbrander <roderick.colenbrander@sony.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251111234519.369652-1-svv@google.com>
 <fcaa494a-43ba-410e-ac2b-162f5b4814bc@roeck-us.net>
 <CAKF84v0eVCSM7L-EvtmoquN87sSS0GA1yX-ewGyzr-hqO7tAGA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAKF84v0eVCSM7L-EvtmoquN87sSS0GA1yX-ewGyzr-hqO7tAGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/24/26 14:44, Siarhei Vishniakou wrote:
> вт, 24 февр. 2026 г. в 13:10, Guenter Roeck <linux@roeck-us.net>:
>>
>> On Tue, Nov 11, 2025 at 03:45:19PM -0800, Siarhei Vishniakou wrote:
>>> When a new PlayStation gamepad (DualShock 4 or DualSense) is initialized,
>>> the input subsystem sets the default value for its absolute axes (e.g.,
>>> ABS_X, ABS_Y) to 0.
>>>
>>> However, the hardware's actual neutral/resting state for these joysticks
>>> is 128 (0x80). This creates a mismatch.
>>>
>>> When the first HID report arrives from the device, the driver sees the
>>> resting value of 128. The kernel compares this to its initial state of 0
>>> and incorrectly interprets this as a delta (0 -> 128). Consequently, it
>>> generates EV_ABS events for this initial, non-existent movement.
>>>
>>> This behavior can fail userspace 'sanity check' tests (e.g., in
>>> Android CTS) that correctly assert no motion events should be generated
>>> from a device that is already at rest.
>>>
>>> This patch fixes the issue by explicitly setting the initial value of the
>>> main joystick axes (e.g., ABS_X, ABS_Y, ABS_RX, ABS_RY) to 128 (0x80)
>>> in the common ps_gamepad_create() function.
>>>
>>> This aligns the kernel's initial state with the hardware's expected
>>> neutral state, ensuring that the first report (at 128) produces no
>>> delta and thus, no spurious event.
>>>
>>> Signed-off-by: Siarhei Vishniakou <svv@google.com>
>>> Reviewed-by: Benjamin Tissoires <bentiss@kernel.org>
>>> ---
>>>   drivers/hid/hid-playstation.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
>>> index 1468fb11e39d..a145b5ea4405 100644
>>> --- a/drivers/hid/hid-playstation.c
>>> +++ b/drivers/hid/hid-playstation.c
>>> @@ -718,11 +718,16 @@ static struct input_dev *ps_gamepad_create(struct hid_device *hdev,
>>>        if (IS_ERR(gamepad))
>>>                return ERR_CAST(gamepad);
>>>
>>> +     /* Set initial resting state for joysticks to 128 (center) */
>>>        input_set_abs_params(gamepad, ABS_X, 0, 255, 0, 0);
>>> +     gamepad->absinfo[ABS_X].value = 128;
>>
>> input_set_abs_params() can fail to allocate absinfo. If that happens,
>> this will crash. AI suggests setting the value with input_abs_set_val()
>> to ensure that the value is checked before dereferencing.
>>
>> Guenter
>>
>>>        input_set_abs_params(gamepad, ABS_Y, 0, 255, 0, 0);
>>> +     gamepad->absinfo[ABS_Y].value = 128;
>>>        input_set_abs_params(gamepad, ABS_Z, 0, 255, 0, 0);
>>>        input_set_abs_params(gamepad, ABS_RX, 0, 255, 0, 0);
>>> +     gamepad->absinfo[ABS_RX].value = 128;
>>>        input_set_abs_params(gamepad, ABS_RY, 0, 255, 0, 0);
>>> +     gamepad->absinfo[ABS_RY].value = 128;
>>>        input_set_abs_params(gamepad, ABS_RZ, 0, 255, 0, 0);
>>>
>>>        input_set_abs_params(gamepad, ABS_HAT0X, -1, 1, 0, 0);
>>> --
>>> 2.51.2.1041.gc1ab5b90ca-goo
> 
> The function `input_set_abs_params` is ill-formed. If this call can
> fail, then it should return some kind of error result instead of void.
> In addition, the function name doesn't suggest that it's going to be
> doing any allocations.
> So the (short-term) fix should be something like this:
> 
> /* Set initial resting state for joysticks to 128 (center) */
> input_set_abs_params(gamepad, ABS_X, 0, 255, 0, 0);
> +   if (gamepad->absinfo == NULL) {
> +       // input_set_abs_params allocates "absinfo" struct, which could fail.
> +       return ERR_CAST(gamepad);
> +   }
> 

That function is called about 870+ times.

> A better long-term option would be to change the signature of
> input_set_abs_params to return a bool, or to add an explicit
> allocation step (looking at code search, there aren't too many places
> using this API today, but this might break 3-rd party stuff).
> 
> Curious to hear maintainers' opinions on this.

The same would apply to the following macro.

static inline void input_abs_set_##_suffix(struct input_dev *dev,       \
                                            unsigned int axis, int val)  \
{                                                                       \
         input_alloc_absinfo(dev);                                       \
         if (dev->absinfo)                                               \
                 dev->absinfo[axis]._item = val;                         \
}

which is called some 170 times with no error check.

Overall, input_abs_set_val() and input_alloc_absinfo() are widely used
in the kernel. Changing that would be monumental. While I agree that the
current code is less than perfect, I think the immediate fix should be
to avoid the crash and use the same mechanism that is used by all other
drivers.

Of course, I am not the maintainer, so that is just my personal opinion.

Thanks,
Guenter


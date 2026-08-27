Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9C23E35F;
	Thu, 27 Aug 2026 22:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787868799; cv=none; b=rFUnCjMYMI6ZAGqg1m1i2r8xSsswXAtCqhcIbnoSGNtPp+sct0RsmLQcLklOJZCdcLKWkALtLMOBjBpA1invWCwy5ASPlvkC3zKn2LyYfH7kMdQLEi3CMMqkysVRjK4U0N/S8WDWvXEgxtK8dMoODcDtMa9kVEcnn1LH7Vf1/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787868799; c=relaxed/simple;
	bh=oaclEGCFj0tbpBqUyYhr79xTsEv4PS0vCLrB3/XE5X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HA7QCrlAW4im7ESuhTt7dqmvlikXU5TrxSL3+CMhGFpLneVVsUejiX4rNVwDg1FdAfzgF4VvsHB6Or+J8y0SGBK7eMBwE5C8kVGasSAthV5Mmk2zvW7UWtKz0Sf41WDaYQ5i6rtTPjU3fA1u0ZKfYkowExMb3XIdeqTh12fm+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=FXfxdqbt; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="FXfxdqbt"
Received: from [10.10.12.8] (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 2A8CB2FC0048;
	Fri, 28 Aug 2026 00:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1787868786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JxISbfItN0NuzUGCyiyBKqofiPDb+/OmKGbmP4tONNQ=;
	b=FXfxdqbtzpTHms0mFwItIBBR/w+5VaDhSdruFbd6/oUADYbAnadqaIuaL5xc+YIzdvy3XZ
	Pu0WYb37Nw8TTx8/gp4ZkWVilUMAjz3b+vb8Pw1l3rV3l8d0eBn6/DyfAwkz0Gr9IZamiv
	TBFDO2LPQOoSKZYQ+Sra2o37XEwBBVQ=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <d54951b4-8216-49eb-9c3e-ed49ab3d4355@tuxedocomputers.com>
Date: Fri, 28 Aug 2026 00:13:05 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] HID: generic: add LampArray support via hid-lamparray
 helper
To: Cristian Mazzotta <cmmazzo@icloud.com>,
 Aaron Erhardt <aer@tuxedocomputers.com>
Cc: tgu@tuxedocomputers.com, jikos@kernel.org, bentiss@kernel.org,
 hansg@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <8c05e11f-6e63-420a-996b-5d1986743ce7@tuxedocomputers.com>
 <20260827184715.136843-1-cmmazzo@icloud.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20260827184715.136843-1-cmmazzo@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Am 27.08.26 um 20:47 schrieb Cristian Mazzotta:
> Am 25.03.26 um 11:35 schrieb Werner Sembach:
>> as Tim went on to other endeavors, I'm taking over this patch. I have
>> yet to test it myself, but i was already in the feedback loop while he
>> was writing it, so I'm not unfamiliar with the code.
taking Aaron into the loop who actually ended up taking over the development.
> Hi Werner,
>
> I recently got a new laptop (Acer Predator PT14-52T) with absolutely zero
> support for any RGB outside of Windows 11; while studying the behavior of
> the Windows driver, I found out about LampArray devices and so I ended up
> landing here.
>
> This laptop has 2 LampArray devices: a USB attached keyboard (05AF:767A)
> and an I2C ENE controller (0CF2:5130) for 3 zones in total. The original
> motivation was power draw during s2idle; the lights would stay on and
> constantly draw power. I measured 12.35W drop to 2.84W when I
> blanked the lights and measured with a simple usb power meter, so I've
> been working off of Tim's code for the past little bit.

The plan for the in kernel driver was to intentionally only provide basic 
support. Reason is the current UAPI of the leds subsystem does not offer the 
full flexibility lamp array offers, so it's a challange to map that already. 
Also most current DEs also only support very basic controls interacting with the 
leds subsystem.

If more control is needed a userspace driver should disable the leds subsystem 
control and directly control the device via hidraw. One such driver will 
probably be openRGB in the near future, but it only has initial, currently 
broken support for lamp array.

>
> Getting full support required touching most of the driver:
>
>   - Multi-zone support with individual zone states instead of a single
>     monolithic zone taking every device.
The driver tries to represent every device as one leds device with one zone to 
not confuse the DEs
>   - lamparray_read_lamp_count() used hid_hw_request(), which is
>     asynchronous, so the value was read before the transfer completed.
>     Switched to hid_hw_raw_request()
Probably something Aaron already fixed on his dev branch, but thanks for 
pointing it out.
>   - lamparray_parse_update_report() would bind to the last HID_LAIP_LAMP_COUNT
>     (usage 0x0003) parsed rather than the first, so LampCount ended up
>     being on the wrong field. This has been fixed by binding the first match.
Not familiar enough with the code myself to comment on that, but maybe a hint 
for Aaron
>   - Added suspend and resume hooks, including an autonomous mode refresh
>     on S4 that my laptop needed
Same as above
>   - use_leds_uapi=0 now leaves the LED class devs registered, but ignores
>     all writes rather than unregistering them.
Unregistering is important for userspace to know what happens, otherwise kde for 
example would still offer brightness control while it isn't actually doing 
anything.
>   - Also added ABI documentation since it was missing previously
Thanks, I think Aaron did something there too.
>
> About half of the driver changed, so I don't think it would be easily
> reviewable as a delta from v4.
>
> Would you prefer that I post it as a v5 with Tim's patch as a base, or
> should I just send you the changes that you can add to your own version?
> I don't want to duplicate work if you already have a v5 in progress.
>
> I have hardware in front of me so I can test whatever is useful.

I think it's best for Aaron sending his version first and then you reacting on 
that on the LKML and getting in touch. It's unfortunate that parallel work 
happened here.

Also you might wanna take a look at the openRGB userspace implementation for 
LampArray control. It still needs a lot of work. I too dabbled in there but 
still not quite enough.

Best regards,

Werner

>
> Thank you,
> Cristian Mazzotta

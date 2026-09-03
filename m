Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57172367B79;
	Thu,  3 Sep 2026 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427902; cv=none; b=Vt3DSdKJzjqHT2CAz0f584vI/kpIvysZzBrFs+6ZdU1LxChGw3/rPir5mt76YzBe2Agxfv0NH7v85FDTtcke3qSx+ex0RiNDCR9MabHmQvbVYjOEN+9d93VwNtv1up3eImbNry47+yyxBdSOIbIrHXfhQtEN+J7Rh/ibkBJ7NBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427902; c=relaxed/simple;
	bh=bgYjAczjSqCq1HkjokxhnudCSCwCew73jGcW2XLeUTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCajA40MmmPf6o2jTu1uUYMssTLiSGFo4GsMT/iH1wXuCGpd0XK2JpJBJWFDyQVzgZpH1nurhY+ajxhc3WwOVmEUVhRCDM6FffU74UBzNDhSqaSLT7Io/zo/0kPmts6oL59snGxX1biF3/tUCE/2tnXvr4uFUQYMYGpnhj5v/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=IAm3q5pC; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="IAm3q5pC"
Received: from [10.10.11.33] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id C866B2FC007D;
	Thu,  3 Sep 2026 11:31:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1788427895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7nBwgVlEfqpnTySlx9U+AI/L2fpp8CKG27e/r6cXBM=;
	b=IAm3q5pC1cbcJcT1ZOp9FMeUBYg+HtNfMTx+xHi9z9/RI1/lCcCu+ZeAcBN1AP9SRUtMIY
	VabXBmBRer0Ua1nz0b42co7WJlD4QePRr7a3WZDdfx/+ROjE1iK0tuiXibcHLVE2bntBqC
	bfnemveI2IFGfa5cCUyhZQfuL4umXxc=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
Message-ID: <175591b0-37ed-4143-9c99-f5da1988d686@tuxedocomputers.com>
Date: Thu, 3 Sep 2026 11:31:34 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] HID: generic: add LampArray support via hid-lamparray
 helper
To: Cristian Mazzotta <cmmazzo@icloud.com>
Cc: bentiss@kernel.org, hansg@kernel.org, jikos@kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, tgu@tuxedocomputers.com, wse@tuxedocomputers.com
References: <d54951b4-8216-49eb-9c3e-ed49ab3d4355@tuxedocomputers.com>
 <20260828144510.158538-1-cmmazzo@icloud.com>
Content-Language: en-US
From: Aaron Erhardt <aer@tuxedocomputers.com>
In-Reply-To: <20260828144510.158538-1-cmmazzo@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Cristian,

I just posted the patch with the updated driver.

Please test it and feel free to provide feedback :)

https://lore.kernel.org/linux-input/20260903073602.3815258-1-aer@tuxedocomputers.com/T/#m1b8fdad3bb17ddf6f9139b373ef41c626e52e44f

Best regards
Aaron

Am 28.08.26 um 16:45 schrieb Cristian Mazzotta:
> Am 27.08.26 um 22:13 schrieb Werner Sembach:
>> I think it's best for Aaron sending his version first and then you
>> reacting on that on the LKML and getting in touch.
> 
> Sounds good, I'll hold off and review Aaron's version when it lands.
> 
>> Unregistering is important for userspace to know what happens
> 
> That's fair, I'll be sure to change that.
> 
> As for multi-zone, my I2C controller has more than one
> LampArrayAttributesReport, and has 2 zones in effect, so the original
> would only grab one of them. I'm not sure if my device is spec compliant,
> but my implementation is agnostic to the zone count; I'll come back to it
> with Aaron's version. Quirks get an entry for each zone too.
> 
> To clarify, each zone in my implementation gets its own dev class where
> /sys/class/leds/<hid-id>:rgb:lamparray-<zone_number>
> And use_leds_uapi is accessible from both
> /sys/class/leds/<hid-id>:rgb:lamparray-<zone_number>/device/use_leds_uapi
> and /sys/bus/hid/devices/<hid-id>/use_leds_uapi.
> 
> For Aaron when he gets to see this, here are some things I noticed while
> testing on real hardware:
> 
> 1) lamparray_read_lamp_count() reads
>    lamp_count_field->value[lamp_count_index] immediately after
>    hid_hw_request(HID_REQ_GET_REPORT). As mentioned above, that call is
>    asynchronous, so the read races the transfer and returns stale values.
>    On my devices it consistently returned 0. hid_hw_raw_request() with a
>    heap buffer works.
> 2) In lamparray_parse_update_report(), usage 0x0003 is not unique within
>    the Lighting page, and the switch has no guard, so lamp_count_field ends
>    up bound to whichever match the parser saw last rather than the actual
>    LampCount field. I added a simple guard so only the first one binds.
>    Whether the first match will always be correct is an open question
>    however.
> 3) Both of my devices need the autonomous-mode disable re-asserted on S4
>    resume; without it they come back in firmware-driven mode and ignore
>    SET_REPORT.
> 4) I don't believe this would be consistent with all LampArray devices,
>    but mine in particular would ignore any change to the lighting that
>    was within 4 values of its current state, so consecutive updates that
>    are too similar silently do nothing.
> 5) My hardware did not support reading back the current state of the lamps
>    at all, so GET_REPORT and in effect, lamparray_hw_get_state(), can't
>    work here. Plenty of LED drivers return the cached value when getting
>    the state, which might be the safer default.
> 
> Also let me know if you want me to send my HID descriptors from
> hid-recorder or similar.
> 
> In the meantime, I will definitely go look at OpenRGB's implementation.
> I may also work on a driver that will fix s2idle residency on my laptop;
> it's part of what brought me here and this is just step one.
> 
> Thanks a lot,
> Cristian Mazzotta
> 


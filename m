Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AD335F163;
	Fri, 21 Aug 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787333712; cv=none; b=geoVXK1T0PSg9Hg2QwSu0BTkoulT3+KUlIZLw1nyuANQ1MRcjUu/1Rslw79rVlLf0I7NpGhuAzRG6LHwiGnaRNfaQOnU8P+/2nai3qEKNWhX7vQOE2dDeA9FwC+9MfUBWJBs+sJ+WjjNsmuxEf0YWlC4dpbht/gNwudIV1cDTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787333712; c=relaxed/simple;
	bh=tm57Ad6PECZlLu7lczCl2+y1DS+vkQi7R0ed20Yj/ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rY7r/SguAZhNalfIcubMU+E+0zmM2D/rVkH05o+GzrqaYxdIPV9nqHEBxRya2ewFAJrTWw1aPYiaf7oqcfF87+aeFIEg34GCvvxdHjeZV1g3rr7sK6szHIzCA3CtIZhP75Zj/GfUf7/B9+QNK0j0TkmI6sG9CZWvJvFQ5/sPGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=HQtt7lVZ; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="HQtt7lVZ"
Message-ID: <bbaca769-312c-4a24-9524-16cb2b4f277f@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1787333180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zprVL5/9BVqDOihmvOs/Q42nl1VQUNgjTILqKSw0w0=;
	b=HQtt7lVZcfVo8TYCvTeQ0igRuXaLHurfb35TIR+j+82dPXJmzUG154fUu75jZxBEkcGoWz
	jQF6wuQccZftNV5xbWF9/BZb4GXb3VPF9QyKki+En6V7FOPkbtwAbl5I3vuDSh0u10PNot
	uaRP2PHGDi0hh8BcUCzRWJymQ8yzwY4=
Date: Fri, 21 Aug 2026 19:26:12 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 08/10] HID: apple: Add DockChannel HID transport driver
To: Yureka Lilian <yureka@cyberchaos.dev>,
 Michael Reeves <michael.reeves077@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-input@vger.kernel.org
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-8-506d936a1707@gmail.com>
 <05d39c4d-8405-4fe7-a798-c8a9c92699ed@cyberchaos.dev>
 <CANpmGNs3s2yLw05jkpZ9mscQNZ9JvfbqEgyW8V=cMD29aU8c2A@mail.gmail.com>
 <03eb4c22-045e-470e-8259-ebf9b1cfe2ed@cyberchaos.dev>
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <03eb4c22-045e-470e-8259-ebf9b1cfe2ed@cyberchaos.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/1/26 23:56, Yureka Lilian wrote:
> On 7/1/26 16:32, Michael Reeves wrote:
>> Hi Yureka,
>>
>> Thank you for the review and the feedback.
>>
>> On Tue, Jun 30, 2026 at 11:21 PM Yureka Lilian 
>> <yureka@cyberchaos.dev> wrote:
>> [...]
>>>> +     strscpy(hid->uniq, dchid->serial, sizeof(hid->uniq));
>>> If the keyboard appeared before stm, dchip->serial might be 
>>> uninitialized.
>> Yes, true, thank you for picking this up!
>> [...]
>>>> +     /*
>>>> +      * Prefer to enable STM first, since it provides device IDs. 
>>>> Some
>>>> +      * firmware versions do not expose STM, so let the keyboard 
>>>> start
>>>> +      * without it.
>>>> +      */
>>>> +     if (iface->dchid->id_ready || !strcmp(iface->name, "stm") ||
>>>> +         !strcmp(iface->name, "keyboard"))
>>> I specifically asked for a mechanism to let the keyboard probe even on
>>> devices which do not expose/have stm. Thanks for adding that!
>>> However, I think this might need some more sophisticated mechanism to
>>> decide whether the stm is still going to appear after the keyboard, or
>>> not at all. I'm not sure if there is a way to tell this at this point,
>>> or we need to add a timeout for the stm to appearing, which needs to
>>> expire before we create the other interfaces with fake serials.
>>>
>> I do not think there is a way to tell at this point, unfortunately.
>>
>> I think the best way to resolve this would be to implement a delayed 
>> work
>> item that is scheduled during probe. If STM appears and initalises 
>> before
>> the timer (I'm not sure how long it should be right now, I will 
>> prototype and
>> experiment) we cancel the delayed work, get the real serial, and spin up
>> the keyboard. If the timeout expires without seeing the STM 
>> interface, we
>> assume the platform does not have one, mark id_ready as true, and
>> proceed to init the keyboard.
>
> I see three ways forward (no specific order):
>
> 1) Implement the timeout as you described.
>
> 2) Use the approach that always waits for the stm to appear, and is 
> proven to work well on the M2 devices targeted by this series. A 
> different behavior that does not wait for the stm / determines the 
> serials using other means can be added at a later point in the same 
> driver but with a different compatible string.
>
> 3) Add an stm subnode (like the downstream Asahi device trees have for 
> their dockchannel-mtp nodes [1]) which indicates whether the stm is 
> present. Check for the existence of this subnode to decide whether to 
> wait for the stm or add the HID devices with fake serials. Support for 
> other methods of retrieving the serials can be added later and 
> indicated by other subnodes.
>
> I would appreciate feedback from all of you on which of these options 
> we should move forward with.

After checking ioreg -l under macOS on the MacBook Neo (which is the one 
Apple Silicon MacBook having the non-force-touch trackpad variant, and 
sending no stm report), I'm convinced it legit has no Serial to report 
for the keyboard/trackpad HID devices, so we'll always have to use the 
fake one there.

Knowing this, I'd rule out Option 2). Between option 1 (timeout) and 
option 3 (device tree node), I prefer the device tree node. We already 
have the keyboard subnode and we know for each MacBook model whether it 
has an stm or not, so having the stm subnode seems logical. As a bonus, 
the code for this is quite simple, and I will prepare the v2 of this 
series shortly.

>
>>
>> I will work on this and experiment to see if it's the best solution or
>> if there's
>> any others as well as to find the ideal timeout, and submit as part 
>> of v2.
>> [...]
>>
>> Thanks again,
>> Michael
>
>
> Thanks,
>
> - Yureka
>
> Link: 
> https://github.com/AsahiLinux/linux/blob/asahi-7.1.5-2/arch/arm64/boot/dts/apple/t8112-j413.dts#L260 
> [1]
>

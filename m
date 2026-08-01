Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB03BED61;
	Sat,  1 Aug 2026 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621403; cv=none; b=uC/rB5q5dOe5WVnyCzp72KUNaf70Cyhzp1lPC2g176wcoeWKXkFWQfp4+YELB11J+i/a1UejLD2El6VvJJ4CGSZSjevx0js5npozt0Ml1KGALRVJXhcMIg3VvV6dhrkEZWzbWTxh2jjQheMmujWp4BcQkpJx9+8zZPyoQKvprCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621403; c=relaxed/simple;
	bh=t7EzEiPFxc4GuN5FmnkOGyt8BqSvWGuuHx+k4MnQxMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N40fzmQkbvl14t8J4RMLQLPes0b1/H207I1qo8/M5Vo1cvSqQZuuQGHUrgAfBYhDH+QZ8cE1okIY4R3GAz/eq+kcmA1/YjW+n178CConooJnsmahjl5VQCROpvxj6irfiVgIefUjHVuYuAa6v5onoXnp5gyIBbDuEZn4jNEhd3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=Xmddp+7G; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="Xmddp+7G"
Message-ID: <03eb4c22-045e-470e-8259-ebf9b1cfe2ed@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1785621398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8oEGy8rqwZ/gqYzJNGC0Im+DxBJzFqohOOWzha3aJP0=;
	b=Xmddp+7GQRTeX/CMdkkJE6vw4Zyu/9477fXl54HZRSDhJInS9Ax5tLWR0X9sCOkZ/OIk/D
	DgwY4x69kYBw+2X2mAi6YDH1umCIvjCrb47alfpFuLgGU8krLzUPrd8newkgtva2O/gaYW
	lHaQ6KbmX3Dgj+Bl6ZryVS/IGtW9Ek8=
Date: Sat, 1 Aug 2026 23:56:20 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 08/10] HID: apple: Add DockChannel HID transport driver
To: Michael Reeves <michael.reeves077@gmail.com>,
 Yureka Lilian <yureka@cyberchaos.dev>
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
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <CANpmGNs3s2yLw05jkpZ9mscQNZ9JvfbqEgyW8V=cMD29aU8c2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/1/26 16:32, Michael Reeves wrote:
> Hi Yureka,
>
> Thank you for the review and the feedback.
>
> On Tue, Jun 30, 2026 at 11:21 PM Yureka Lilian <yureka@cyberchaos.dev> wrote:
> [...]
>>> +     strscpy(hid->uniq, dchid->serial, sizeof(hid->uniq));
>> If the keyboard appeared before stm, dchip->serial might be uninitialized.
> Yes, true, thank you for picking this up!
> [...]
>>> +     /*
>>> +      * Prefer to enable STM first, since it provides device IDs. Some
>>> +      * firmware versions do not expose STM, so let the keyboard start
>>> +      * without it.
>>> +      */
>>> +     if (iface->dchid->id_ready || !strcmp(iface->name, "stm") ||
>>> +         !strcmp(iface->name, "keyboard"))
>> I specifically asked for a mechanism to let the keyboard probe even on
>> devices which do not expose/have stm. Thanks for adding that!
>> However, I think this might need some more sophisticated mechanism to
>> decide whether the stm is still going to appear after the keyboard, or
>> not at all. I'm not sure if there is a way to tell this at this point,
>> or we need to add a timeout for the stm to appearing, which needs to
>> expire before we create the other interfaces with fake serials.
>>
> I do not think there is a way to tell at this point, unfortunately.
>
> I think the best way to resolve this would be to implement a delayed work
> item that is scheduled during probe. If STM appears and initalises before
> the timer (I'm not sure how long it should be right now, I will prototype and
> experiment) we cancel the delayed work, get the real serial, and spin up
> the keyboard. If the timeout expires without seeing the STM interface, we
> assume the platform does not have one, mark id_ready as true, and
> proceed to init the keyboard.

I see three ways forward (no specific order):

1) Implement the timeout as you described.

2) Use the approach that always waits for the stm to appear, and is 
proven to work well on the M2 devices targeted by this series. A 
different behavior that does not wait for the stm / determines the 
serials using other means can be added at a later point in the same 
driver but with a different compatible string.

3) Add an stm subnode (like the downstream Asahi device trees have for 
their dockchannel-mtp nodes [1]) which indicates whether the stm is 
present. Check for the existence of this subnode to decide whether to 
wait for the stm or add the HID devices with fake serials. Support for 
other methods of retrieving the serials can be added later and indicated 
by other subnodes.

I would appreciate feedback from all of you on which of these options we 
should move forward with.

>
> I will work on this and experiment to see if it's the best solution or
> if there's
> any others as well as to find the ideal timeout, and submit as part of v2.
> [...]
>
> Thanks again,
> Michael


Thanks,

- Yureka

Link: 
https://github.com/AsahiLinux/linux/blob/asahi-7.1.5-2/arch/arm64/boot/dts/apple/t8112-j413.dts#L260 
[1]


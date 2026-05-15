Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A993F7865;
	Fri, 15 May 2026 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831532; cv=none; b=orSkD+X7uNNb4zE7kpSpSSRY8eC1TTV3/ksGP9b9DhwK9/e9Xe7Oln91UBfxtyR9SN+4citlc4R/9Uy/kuGiaxUkR/4pUjmCB0KEcRDikdapNw2N3VEANOKjEmbM36P0XukXG88FL16N8y1KX8vm6G4rYxSUgchsdg4bxc0xh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831532; c=relaxed/simple;
	bh=rU5vFQPgWNXsjzQAMnbzG8Yr7cL/r74rI2Jow5YcIQg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BYyl0CPHm3a/FcBFhxavdm97KFXqJ6MLV0GMmwZtgFDwxllARXEqF6S5UOzmQ6VOcRCrkie9mF3Mm5GYw7+8jgy5OhKH99kvA6tNCxIyn21leudGNZ2a1MGMUrnwORoC5p7b94Ox7ot3hbdz+tqiR8LJEex1Lrn9fuIhBPqhLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXkY4rWc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXkY4rWc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B28FC2BCB0;
	Fri, 15 May 2026 07:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778831532;
	bh=rU5vFQPgWNXsjzQAMnbzG8Yr7cL/r74rI2Jow5YcIQg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=BXkY4rWcTr5kQVU/0TWJfhyMZFYQ0nfWwTp2RR+2OnzcE7gjhKZixXebu+LFNQG2y
	 xCzNaXrVRg+Ljcsp4w3gi8AjPx8l5EoQs3eVz9zqa5eeB+3xU/Gy5ZNkfzYjaZpd7F
	 4HMq9XidZOIkwN7tIQig74eR8PMNMB0RuKZSemWGlT+0z24q3RNvsR3XpGbhs7K8Gu
	 aFcGG0zriVaHx2GKDkv3cHYvUeOAPIcvNj+LRxYNPuZzgbpnyLtZ/Fx1GTz3R6ISeo
	 aQ6wvBQ2AAVtd5qjlTRqKm0aGexqVGgswmhND8erwtGoIr/TyR/JuqT3fwJ6UCo/QX
	 SCmg2iaeSb/Bw==
Message-ID: <3a03ac01-3b82-4ad6-bd35-f91ce738847c@kernel.org>
Date: Fri, 15 May 2026 09:52:09 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: lg-g15: Add support for the Logitech G710/G710+
 gaming keyboards
From: Hans de Goede <hansg@kernel.org>
To: Xavier Bestel <xav@bes.tel>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260402075239.3829699-1-xav@bes.tel>
 <094db7d8-eb0c-4103-86fb-beb11580d53b@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <094db7d8-eb0c-4103-86fb-beb11580d53b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6-Apr-26 20:50, Hans de Goede wrote:
> Hi Xavier,
> 
> Thank you for your patch, it is always nice to have people helping
> with improving Linux support for devices like this.
> 
> On 2-Apr-26 09:52, Xavier Bestel wrote:
>> Add support for the Logitech G710 and G710+ (USB ID 046d:c24d) gaming
>> keyboards to the hid-lg-g15 driver.
>>
>> These keyboards have 6 G-keys (G1-G6), M-keys (M1-M3, MR), a game mode
>> toggle, and two independent backlights: one for the main keyboard and one
>> for the WASD keys, each with a physical button to cycle brightness through
>> 5 levels (0-4).
>>
>> Key implementation details:
>>
>>  - G-keys and M-keys are reported via HID input report 0x03 (4 bytes)
>>    using KEY_MACRO1-6, KEY_MACRO_PRESET1-3 and KEY_MACRO_RECORD_START.
>>
>>  - The WASD backlight LED is registered as
>>    "g15::kbd_zoned_backlight-wasd" rather than with a
>>    "::kbd_backlight" suffix, because UPower currently only supports a
>>    single kbd_backlight LED per device. This follows the nomenclature
>>    from Documentation/leds/leds-class.rst
> 
> Actually that nomenclature is something which was suggested in the past
> but has never been agreed upon.
> 
> Since the discussion about how to name the LED class devices for
> multi-zone keyboard backlights keeps coming up I've submitted a patch
> now to document how these should be named:
> 
> https://lore.kernel.org/linux-leds/20260406174638.320135-1-johannes.goede@oss.qualcomm.com/
> 
> Since the new userspace API for this needs to be agreed upon first, that
> patch should be accepted upstream first, before we can move forward with
> the G710 support from this patch.

My v2 patch with the LED naming scheme has been accepted into the
leds maintainer git tree now, so this is no longer a blocker for this
patch:

https://lore.kernel.org/linux-leds/20260504145434.12746-1-johannes.goede@oss.qualcomm.com/

Regards,

Hans




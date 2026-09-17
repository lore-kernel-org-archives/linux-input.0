Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26DE413230;
	Thu, 17 Sep 2026 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630199; cv=none; b=RdsHJsnLLim5VGAjdeMM7fpu073gGCgCC6OHcLtInPVyly9svldvN/QEHat2ZQJX+TjgZghLblp9lUKQcH9dKKslWSTrfjxzFPzD3AxgonEUw9MoqzOH2JLVR1YFix5OgLyI6aJ5rlv9UWKGxvnOuzLbp/6+KFcVB4i7WolIQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630199; c=relaxed/simple;
	bh=hmtmu9OFm2jMkG2p/REuNGFR2N1az17XiJ7XocUZ4w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUM+rxoVqrLdCFfaq5sl6AfZpW7iHtCAPyMI1vbsLBvdFbC/0vpTpVnX1qYVpP+e2vgJhMHPqRvy3WC436T74mbbYHoUlvHAhEoK6t+ofReo73v4e1PRvm7p2nD/3P6KVxDntY/llj6QnfLqc9tMk6sbwJiMMqImgkFWbMjCIUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=YKVhb38Y; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="YKVhb38Y"
Received: from [10.235.78.2] (dynamic-176-002-023-135.176.2.pool.telefonica.de [176.2.23.135])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id C48992FC008A;
	Thu, 17 Sep 2026 09:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1789630193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8wQE6SwLH5L7C2ebQaVH+SukVEVlP9i48FkxeJY66w=;
	b=YKVhb38Ye5G1TvOgGJmW+Jfi2PMfitcuOOqs3D9OSH2ubPwTc3QXkT8AFi67zIh0cGNgNs
	7Mz806CGH0/8noSV3TxJCD9ACIwxWUaR2pfXXqt7jnM5m6gjLBu5YQXndTYjeuJi/gDAQo
	eSCoyKX1mOtixt8Jy3SHVM+pjpqz2rQ=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
Message-ID: <5ef39e91-ad4c-4959-afe3-bad860486ca8@tuxedocomputers.com>
Date: Thu, 17 Sep 2026 09:29:51 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] HID: generic: add LampArray support via
 hid-lamparray helper
To: Cristian Mazzotta <cmmazzo@icloud.com>
Cc: W_Armin@gmx.de, bentiss@kernel.org, jikos@kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 wse@tuxedocomputers.com
References: <20260916144838.456239-1-aer@tuxedocomputers.com>
 <20260916161551.36695-1-cmmazzo@icloud.com>
Content-Language: en-US
From: Aaron Erhardt <aer@tuxedocomputers.com>
In-Reply-To: <20260916161551.36695-1-cmmazzo@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 16.09.26 um 18:15 schrieb Cristian Mazzotta:
> On 16.09.26 16:48, Aaron Erhardt wrote:
>> Add a new hid-lamparray helper module and integrate it with the hid-generic
>> driver.
> 
> Thanks for picking these up!
> 
> I do have two corrections on patch 3 however, and both were mine
> originally, so my bad:
> 
>  - The measurement in the commit message and in the comment above
>    lamparray_suspend() is wrong. It should be 12.35 W with lamps lit and
>    3.14 W blanked, which is 9.21 W or about 75% of s2idle draw, not
>    2.84 W / 77%. The 2.84 W was an earlier test on a local branch that
>    includes full multi-zone support. It's worth noting in the comment that
>    the 3.14 W still includes the lid zone, which single-zone control
>    cannot reach on this device.
> 
>  - The kerneldoc for lamparray_suspend() still says it "writes zeroes to
>    the rgb values only, keeping the brightness", but the call is now
>    lamparray_hw_set_state(ldev, 0, 0, 0, 0). The code is fine, but the doc
>    should follow it.

Ack. Will be fixed in v7.

> 
> On your question about the default state: I think the lights "look like
> they don't work" can be a real conclusion, but the cause is the intensity
> default rather than the brightness default.
> 
> With led_init_state NULL, last_r/g/b stay zero, register_led copies
> them into subleds[].intensity, and brightness_set reads r/g/b back out
> of subled_info[].intensity. So every brightness write sends
> (0, 0, 0, brightness), which is black at any brightness. The
> zero-brightness quirk does not change this since it only forces RGB to
> zero when brightness is already zero.
> 
> The LED class device is therefore inert rather than just dark;
> systemd-backlight restoring a saved brightness, or a DE slider, or
> UPower, all write brightness and see nothing happen. This is because
> nothing in that stack writes multi_intensity first.
> 
> Defaulting to autonomous mode would not fix that. It would replace an
> inert knob with an ignored one: the cached RGB and brightness would
> describe nothing the hardware is doing, and a DE would have to
> discover and write use_leds_uapi to make the node real. That is
> driver-specific knowledge that desktop environments are unlikely to
> carry.
> 
> On a second look, I would suggest keeping brightness at LED_OFF, but
> defaulting the intensities to max_r/max_g/max_b. The device is still
> dark at probe, autonomous mode is still disabled so the cached state
> matches the hardware, and the first brightness write from existing
> userspace lights it up. Combined with the quirk you added for Armin's
> device, it stays dark even on firmware that ignores the intensity channel.

I think this is a good idea. In general, the default should probably
either set intensities to max_(r|g|b) or brightness to max_brightness.
This would reduce the amount of writes necessary to see a result and I
agree that probably the brightness knob is most likely to be used by
userspace. Still, I'd like to have some more feedback, especially from
the maintainers before integrating this behavior in v7.

> 
> One hardware data point, since discoverability came up: on the Acer
> Predator PT14-52T the keyboard brightness keys are handled entirely in
> the EC and never reach the LED class device, so they cannot be relied
> on to show the user that anything is controllable.
> 
> On multi-collection, I don't see myself getting to it soon. I might work
> on it during fall or winter break of my university, however I cannot
> guarantee it, so please do not consider it blocked on me. The ENE
> controller exposes two LampArrayAttributesReport collections and
> lamparray_parse_update_report() only keeps the last.
> 
> I have a local branch which includes working multi-collection support.
> It's based off of Tim's v4, and it's what I referred to in the original
> v4 thread; I'd be happy to send over my branch as a reference, though
> porting it to v6 is not trivial.

I could have a look at your branch, but I think it's better to wait for
this series to be merged before exploring more advanced features. I
can't guarantee that I will work on that actively, especially since I
don't have access to such hardware, but I'm curious to see what changes
you have applied to make it work with v4.

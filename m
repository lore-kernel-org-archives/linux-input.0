Received: from box.trvn.ru (box.trvn.ru [45.141.101.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87311433E8C;
	Sun,  5 Jul 2026 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.141.101.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783236182; cv=none; b=Que11vDn0spV2QHVhYA9agSlfxdgs5VuXrgt3JlnBFah4gsooJd+vz0jAda6Pehchudoaq2LRYw6+r1Rw8/UteK2EUh4dl9HEgNhjbbQXUQFODY8yVwDRIYARiNMzxD9/pbnqscceeY3JFvw2+3ZZgt8t+IyMAEbcmYjD9L/X04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783236182; c=relaxed/simple;
	bh=jjsLW942hMhkGg7bz4fJSPFLypSmyTMGONy3kue+Gq8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dRwWpX8VOus9DVzJXH6OU4IwLh6ZkMkhqae3OS16wbPY1DKsN9meng7jopd7e70pXcfOeKRgecF5TysN1lOwvVhQAWvg0sFvSaaE2GhJpvpEQxf5WPBpBW7ELu5vo0/Gs5m/PhPVJf5CDBC7N4CU1P2QTb6fSIJELu48oQxTOv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=WjXvsaQ8; arc=none smtp.client-ip=45.141.101.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="WjXvsaQ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1783235591; bh=jjsLW942hMhkGg7bz4fJSPFLypSmyTMGONy3kue+Gq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WjXvsaQ8Bed6s8hlBpacx/KzlpRhKqQlvrR/Y/lhb4i7yhdlXxTIcXy2mkHE+W+Zk
	 FgpY/Xrp9JAzB1AvwcSKIxbscZIBRVIYc1OzYIuDEq9IEPuUpuc6pXsnjYs7VlbW0v
	 ne+dzAtWFmswh3N4IT1rG9FbFluB8Q9WY8njqoWmB0mDRXZOhwjtMiFWk/K6w9FDJw
	 1EdyGZK+F2fosYDzzL6ZqdfvMiK0ny4Eq87oo/0n4qkmRM3K2hk/dGkEJgXQczqFM2
	 ur3/TV0TJ5ABu0d4o0IhrFFFrxA+1hW3yVRtILHLpfYlkDOfXWqsovbdGn/qvbqSZt
	 wy8BAFrNuiEwg==
Received: from authenticated-user (box.trvn.ru [45.141.101.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id CC4B26DF07;
	Sun,  5 Jul 2026 12:13:11 +0500 (+05)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 05 Jul 2026 12:13:11 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Linus Walleij <linusw@kernel.org>
Cc: Thanh Nguyen <thanhnguyxn07@gmail.com>, dmitry.torokhov@gmail.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linus.walleij@linaro.org, timon37@lavabit.com
Subject: Re: [PATCH] Input: zinitix: iterate contact slots by finger count
In-Reply-To: <CAD++jLknVJYLc0-StNFcN67pUDRQunUJvNn-Npz+HJ-j2WXB5g@mail.gmail.com>
References: <20260408051907.792-1-thanhnguyxn07@gmail.com>
 <CAD++jLknVJYLc0-StNFcN67pUDRQunUJvNn-Npz+HJ-j2WXB5g@mail.gmail.com>
Message-ID: <8ca5a59eeb522bfd949f31e2416639fd@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linus Walleij писал(а) 30.06.2026 14:11:
> Hi Thanh,
> 
> sorry for slow reply!
> 
> On Wed, Apr 8, 2026 at 6:19 AM Thanh Nguyen <thanhnguyxn07@gmail.com> wrote:
>>
>> On affected devices (for example Samsung A3 2015), the value in
>> touch_event.finger_mask appears to behave as a count of reported slots
>> rather than a bitmask. Using for_each_set_bit() can then skip valid
>> contacts and break multitouch gestures.
>>
>> Keep filtering by SUB_BIT_EXIST to avoid reporting shadow contacts, but
>> iterate from slot 0 up to min(finger_mask, MAX_SUPPORTED_FINGER_NUM).
>> This follows the maintainer feedback to treat the field as a possible
>> count while preserving the anti-shadow check.
>>
>> Fixes: e941dc13fd37 ("Input: zinitix - do not report shadow fingers")
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221278
>> Signed-off-by: Thanh Nguyen <thanhnguyxn07@gmail.com>
>> ---
>> v2:
>>  - Address maintainer feedback: do not revert e941dc13fd37.
>>  - Keep SUB_BIT_EXIST filtering to avoid shadow contacts.
>>  - Treat finger_mask as a slot-count bound and iterate 0..min(mask, max).
> 
> I can test this if need be, but maybe Nikita want to check it
> first?
> 

Hi!

I've quickly checked it on my gt58 (bt532) but it made me remember that
on this device/chip it seems like only "TOUCH_MODE=0" is supported and
reported fingers don't have extra "width"/"angle" fields. (I have a
vague recollection that this was somehow related to touchkeys being
enabled or not) Otherwise on this chip (firmware? touch_mode?) the
finger count is indeed a count and not a mask. 

Given we have an EXIST bit IMO it still makes sense to make this change.
Maybe also worth adding a short comment why we're treating mask as
count if Linus's devices report mask and your/mine report count...

Nikita

> Yours,
> Linus Walleij

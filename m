Received: from lavabit.com (lavabit.com [46.23.82.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8E2218AB9;
	Tue, 14 Jul 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.23.82.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043899; cv=none; b=lzdlwNwtJId2P1Ut8xX6zJGJ5V1o0FLwKc9CgCL5sWOQjgaYmfrD9TIiZfRqNFPiOQH2eojdKOFHpiBsAwtM1RA8P3YsmvR0XoOBaA9/K0vKBtDdR0PR0rJXWktBAy83J5jv7QW0OMTyGHxxQejM6ijWovKik0Bxu9QAfCYCXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043899; c=relaxed/simple;
	bh=CJHq9VzWqWIlkXID+eJhoDfjBgxd3SkyIUunpshDsjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IINAwPFF7jTsY7rAEo0JJ75OZ1uuwmD+Z6A5IMChXT0GqcXCuOCMhu25whV1V9u6hHxD6qCLHGFqA50hlpOvJMTrRAZnODFX5sY3BDgwYSUQ2cj425/Uog57WRekG+700YAvxLdvak8TrYJFhpXB4HXYzLTApGdqIF3VXNBZLX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lavabit.com; spf=pass smtp.mailfrom=lavabit.com; dkim=pass (2048-bit key) header.d=lavabit.com header.i=@lavabit.com header.b=Ltt3ICsJ; arc=none smtp.client-ip=46.23.82.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lavabit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lavabit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lavabit.com header.i=@lavabit.com header.b="Ltt3ICsJ"
Received: from lavabit.com (localhost [127.0.0.1])
	by lavabit.com (Postfix) with ESMTP id C3736407AA7E;
	Tue, 14 Jul 2026 15:35:49 +0000 (UTC)
Received: from 10.10.10.10 (155.133.124.115)
	by lavabit.com with ESMTP id PVJ4HTOV97WN; Tue, 14 Jul 2026 15:35:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lavabit.com; s=bazinga;
	t=1784043349; bh=CtHbWYKEu6eFr+IjXohURNQKl0T8AwO0mZHzjATt1gw=;
	h=Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	b=Ltt3ICsJ3p69TwRFtgHswKmab16bBwDm7z4vyi+5Owlce4sDV+Z+JdaBSZXjPgvPg
	 vnTt7BijY6UYTmJgTwW6tvO682z40cFoA189OhztKWkpuRZK7PXp+mXUUY6auEEY9K
	 TVz8oYYij2vo4iCB6wW44gyO0Dv6kXWrxSJxikG6gBFipxCJcMEE8rCfEiZgTHi3j6
	 EOQ2WmlsNK1jJ+9AGbsB1r8HmM/9JbZc8mAV1nMVnojosLsdwChZDZfx/TCD6arjAr
	 7gEolmgTcWn18wPSJHIlZj94GVhROK5+4HXlvPPoEI9llOcku0QZWFrOz71fdZQmC7
	 +U4ejG/E3o5xQ==
Message-ID: <f0ceebbd-cf79-42d7-a32e-d7f92272ce1d@lavabit.com>
Date: Tue, 14 Jul 2026 17:35:49 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: zinitix: iterate contact slots by finger count
Content-Language: en-US
To: =?UTF-8?B?VGjDoG5oIE5ndXnhu4Vu?= <thanhnguyxn07@gmail.com>, nikita@trvn.ru
Cc: linusw@kernel.org, dmitry.torokhov@gmail.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linus.walleij@linaro.org
References: <20260408051907.792-1-thanhnguyxn07@gmail.com>
 <CAD++jLknVJYLc0-StNFcN67pUDRQunUJvNn-Npz+HJ-j2WXB5g@mail.gmail.com>
 <8ca5a59eeb522bfd949f31e2416639fd@trvn.ru>
 <CAPWvNi7ATfEKCC6qn+DTHnSLJxXamYiiNWA+1JgQmw2RG+PH6g@mail.gmail.com>
From: timon <timon37@lavabit.com>
In-Reply-To: <CAPWvNi7ATfEKCC6qn+DTHnSLJxXamYiiNWA+1JgQmw2RG+PH6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry for not replying earlier (life), but I don't think the v2 patch 
will fully work correctly.

At least on my samsung a3 the loop needs to work as it did before 
e941dc13fd37.

Meaning: iterate over all slots and check the (sub_status & 
SUB_BIT_EXIST) for whether the finger is active or not.
Because: the active fingers can be in later slots with the earlier slots 
being inactive.

For example when the user:
1. touches with one finger (1 finger active in slot 0)
2. touches somewhere else with a second finger (2 fingers active in 
slots 0, 1)
3. lets go with the first finger (1 finger active in slot 1)

In such a case the loop would only iterate over slot 0 and not report 
any fingers despite slot 1 still being active.
In practice this will likely be usable... but afaik and can tell it's 
still incorrect behaviour.

Best Regards,
Timon

On 7/5/26 13:17, Thành Nguyễn wrote:
> Hi Nikita, Linus, and Dmitry,
>
> Thank you all for the feedback and for confirming the fix on your end, Nikita.
>
> Unfortunately, since it's been a while since I submitted the v2 patch,
> I recently had to completely wipe my development machine and no longer
> have the local environment or the original patch files to create a v3.
>
> Since the logic in v2 is sound and the only change needed is a brief
> comment explaining the dual mask/count nature of `finger_mask`, would
> one of you be willing to add that comment and apply the patch on my
> behalf? I'd really appreciate it.
>
> Thanks again for your time and help with getting this merged!
>
> Best regards,
> Thanh Nguyen



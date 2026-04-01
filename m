Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D44943CEC3;
	Wed,  1 Apr 2026 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063970; cv=none; b=fya7s7kI42+jXkr+VWnTaMSJwFXhqcyEZMM05AvLNlT3ypC7qSZV5SPeZWjBz23V487MhuU/BBfz4zqtUc8hnI3BKxFmFRH6IhglAJr1oiENIJy1D9E1T/d1GcwPeIyBcOTIhNdDw7frvDI5PvYR/eXJVZU1pSlW3X0vUhAvM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063970; c=relaxed/simple;
	bh=AmZZ7WIiAHWNzRlRHL8eUpzvhxbsS1iTikBXiWWOhvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B81WFnyn0aAhv6srSzB4ImWTG6wTpNRhwomC9mCTT0r9kYhOzNAnKNxyiqU2RDRjaIgteHixtLJJ9pzwnM9FMmFCdijflNMuUSiNRNAg85NJVoKFUjmvV6kdfN2dNQ+2YkhelJKESE/u0KZaL3IaMjaPFCjS2FMv3zov/stwrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=AaJD36yR; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="AaJD36yR"
Received: from [192.168.178.25] (i5C75F65A.versanet.de [92.117.246.90])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 6C7582FC0050;
	Wed,  1 Apr 2026 19:19:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1775063964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCRCuaxhJ8FaH5GkY0OZqUaYm20R5ebkyZqhgfFRP+Y=;
	b=AaJD36yROw1wzbK4rBPIsORuY1mwGgzqgQEinqYE/9CE2ZLaiRNxZ7itgZPonhwFTvHPgt
	vMQidGcdlXYCjyJQAmrtfxxdJWNec2pMJwO95ixVzBFxd0I6vtFEj430xZWEMS0aLSZ4/O
	FOwZakC7zHOTtHt5W5+oOWuMAbNgdjw=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <6fd2bbbf-a462-439d-80cd-64d740731b4c@tuxedocomputers.com>
Date: Wed, 1 Apr 2026 19:19:24 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: i8042 - add TUXEDO InfinityBook Max 16 Gen10 AMD
 to i8042 quirk table
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260223142054.50310-1-wse@tuxedocomputers.com>
 <aZzMe2-4IqzIg3HS@google.com>
 <11135d8c-ef30-410a-a94a-4e11e062c27b@tuxedocomputers.com>
 <ac1FzV9dmb_JDXxo@google.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ac1FzV9dmb_JDXxo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Dmitry,

Am 01.04.26 um 18:22 schrieb Dmitry Torokhov:
> Hi Werner,
>
> On Wed, Apr 01, 2026 at 05:48:20PM +0200, Werner Sembach wrote:
>> Hello Dmitry
>>
>> Am 23.02.26 um 22:54 schrieb Dmitry Torokhov:
>>> On Mon, Feb 23, 2026 at 03:20:45PM +0100, Werner Sembach wrote:
>>>> From: Christoffer Sandberg <cs@tuxedo.de>
>>>>
>>>> The device occasionally wakes up from suspend with missing input on the
>>>> internal keyboard and the following suspend attempt results in an instant
>>>> wake-up. The quirks fix both issues for this device.
>>>>
>>>> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>> Applied, thank you.
>>>
>> May i ask you where it was applied?
>>
>> I can only find the former patch https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?id=aed3716db7fff74919cc5775ca3a80c8bb246489
>> for the InfinityBook Max 15 and not this one for the InfinityBook Max 16
>> (both patches have a nearly identical subject line).
> Isn't it this:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?h=for-linus&id=5839419cffc7788a356428d321e3ec18055c0286
>
> ?
Yes, thanks and sorry I somehow missed to search the for-linus branch.
>
>> Also I forgot to add cc stable, if the patch is not yet applied, can you add
>> it before?
> I added the tags to the commit above (unless it is not the right one,
> they all look very similar).

Yes, it's the one I was talking about. Maybe the next time I add the board name 
to the subject line in the hope that it makes it a little bit more clear.

Thank you very much,

Werner

>
> Thanks.
>

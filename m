Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EBF3A381F;
	Wed,  1 Apr 2026 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058507; cv=none; b=mft78+fIMDi7f1oLQHN0B+yMVfEAeojea93uwMnZHRGrpiDHYttvYJTNJXiHRF7hFqDpTQehDMkfRSJvMqlpHDylQAfF6dfYFGqzZxXpOIi3vf9kpO0me73zBuEAagpyKZc+q5wnGQPxDRyRoGehlwzFgQ17qmmXTeDUPjkw+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058507; c=relaxed/simple;
	bh=I7aoulrs1bcrK8d8xYvpYMlROIiWesUP7YD4GwyW/fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbVWShy/zIB+G5d/yn+z4Frhd52+oOKF2jKXf8CpJ3C/wHcfhSEBCMNJbypG/G2a90kvKXBOCPL/RcLVtq1tcAcPTQFFt35nr/7uvSEvppVsedYY10SrgLqh4l9su0O2IMJfWeC2Tg5krfBf4iVdnpf3DlIruq64rJ2WKNPmCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=H5XRykJH; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="H5XRykJH"
Received: from [192.168.178.25] (i5C75F65A.versanet.de [92.117.246.90])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id E3A7D2FC0050;
	Wed,  1 Apr 2026 17:48:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1775058501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq+Je/kzLaXm1ZMd3ISybo0gkzYJjCFQJOBFEU4vcAI=;
	b=H5XRykJHRUdl0H9KqEG1Kwpdl40DEV/hTIp2jYmShHuby3L0dY1UbAZ1i1cP46VrsPqbXb
	5Lj0qXXwEJutwAZHI3f0HJrIFxQrwldarLtJ2OjnO8SU3DZDmzgJ/JlGplM1UXU/IjFJrL
	I3hAcP0+2AWfYRWH3+zAMwSSiCfAEOQ=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <11135d8c-ef30-410a-a94a-4e11e062c27b@tuxedocomputers.com>
Date: Wed, 1 Apr 2026 17:48:20 +0200
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
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <aZzMe2-4IqzIg3HS@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Dmitry

Am 23.02.26 um 22:54 schrieb Dmitry Torokhov:
> On Mon, Feb 23, 2026 at 03:20:45PM +0100, Werner Sembach wrote:
>> From: Christoffer Sandberg <cs@tuxedo.de>
>>
>> The device occasionally wakes up from suspend with missing input on the
>> internal keyboard and the following suspend attempt results in an instant
>> wake-up. The quirks fix both issues for this device.
>>
>> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Applied, thank you.
>
May i ask you where it was applied?

I can only find the former patch 
https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?id=aed3716db7fff74919cc5775ca3a80c8bb246489 
for the InfinityBook Max 15 and not this one for the InfinityBook Max 16 (both 
patches have a nearly identical subject line).

Also I forgot to add cc stable, if the patch is not yet applied, can you add it 
before?

Best regards,

Werner


Received: from hades.hosts.managarm.org (hades.hosts.managarm.org [195.201.36.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E53C1994;
	Thu, 19 Mar 2026 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.36.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918699; cv=none; b=qkN1AZD0GxwJBaSKOSWhIO0DPylT+YpDr/uu5RU4nVkllPBLvlM/ssc0As2KDV7sCdOtU76l9NOb6QNJTk9twDrtyhA/zpYRVyLTATCM2JVq+NeumlislAaFTiQkzWAz11bv3MRZ8Xr2/3A74zOuuvr5MfZ52N+2sfFIbRsZYsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918699; c=relaxed/simple;
	bh=FNS8oQTZa73GvYLrr5vt4KvQiiktTaKpqv9qBuzMh/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKiOKmXaSa2knY3/NExw2pB5Y/Wn1fIHqXHPbPoGBd21XG885MfYxAxtjw8PUVBhrsTGKgXvG4zK6s3YUEBQqIdilBI7oI5inlBmFdrTJBk80FaWuFz6QHY9stsRa7j7EPLw/rz2f45MEKWinBhxyoPukv6Nb58vogFZocqCTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=managarm.org; spf=pass smtp.mailfrom=managarm.org; dkim=pass (2048-bit key) header.d=managarm.org header.i=@managarm.org header.b=ivOAZypG; arc=none smtp.client-ip=195.201.36.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=managarm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=managarm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=managarm.org header.i=@managarm.org header.b="ivOAZypG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=managarm.org; s=2021;
	t=1773918215; bh=FNS8oQTZa73GvYLrr5vt4KvQiiktTaKpqv9qBuzMh/Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ivOAZypGfxDpDopcDc+ZomxUE/QnJ/FmTCs/D1yMkLVQ7jZH9x/6AM3sKxGz7Jl9d
	 1jbFXB1Mjg5KmwBYp94I+SXqfWOEY+MjNsD5S5mcGyR2vCrKR3dWd0MLMc3J6iIAWe
	 GAOnXG97pr5GkShOuWCtRR1R1Wv8u5ruFSVH1XAm1EcRKRtm/ROK6wRsvvtogQV0iO
	 U6JC0C5OTVBhiScKTtalXvut+9GH8evJEItPbHnz5hvHadPmFguxehmgI86mkQdmmn
	 fWLJd6WSTGc7HNjxrlbdeOtGfsbpCzR9yy35FDSBcyNxPbpVlLUOkxYqaa/AhwQcQg
	 agO6QM4WbSx6g==
Received: from [192.168.1.169] (p54a7907d.dip0.t-ipconnect.de [84.167.144.125])
	by hades.hosts.managarm.org (Postfix) with ESMTPSA id 5B1E13FA9A;
	Thu, 19 Mar 2026 11:03:35 +0000 (UTC)
Message-ID: <8590f544-9146-4e8e-9ea6-a3ed9ed9fa1f@managarm.org>
Date: Thu, 19 Mar 2026 12:03:35 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: pulsar: add driver for Pulsar gaming mice
To: Nikolas Koesling <nikolas@koesling.info>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260318205503.64420-1-nikolas@koesling.info>
Content-Language: en-US
From: Leo <leo@managarm.org>
In-Reply-To: <20260318205503.64420-1-nikolas@koesling.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

While this driver looks fine at a glance, this does seem to use the
same protocol as the hid-kysona driver. It might be more appropriate to
extend that driver instead of rolling a new one? The HID identifiers in
hid-ids.h already have a vendor constant for USB_VENDOR_ID_KYSONA,
which takes the same value as this patch's USB_VENDOR_ID_PULSAR.

For context, I was investigating exactly this battery reporting for
another mouse, the ATK VXE R1 SE+. It does seem to use the exact same
protocol; in wired mode, that takes the device ID 3554:F58F, while the
wireless dongle has a device ID of 373B:1085. I plan on sending a patch
to add these IDs after some testing.

Cheers,
Leo

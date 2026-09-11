Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5293769F6;
	Fri, 11 Sep 2026 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123113; cv=none; b=KHPA4xLtFPfYahaBvACo6LAKlnCohzrHDlWfj2/30vadRfE/CgAJMx9D4K4SE2k9YwXnXjWFH/eaR515tGWqlcPbcwUecaz2md7xC4p/+TlWGn4AF9qIrC4CrvgQGKL02wd+/2OKPbZV7NYlxbNiSU4ZEc1NjzzHnU+Ci6NGEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123113; c=relaxed/simple;
	bh=ekZ3TED81f0IQUZ9r1uuNvq1t7YE45E6ueN257eRy/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8NprnNiM8uh0ace1dGNTM6sPeMloVa3O1SvgFnditrwc/MFor5VXxCU8OeIdGZ/5PyJdc3LRyIuvYUcb5cdTRnVm1x1FsfYb9kp15CBQ4CjjGX4FjkogdDP2bgrGpKdx1Vy1hpRBYN7vUAVNrgYabrm2BKo1N4Tf7InA6wHiXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=jtg2IPaT; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="jtg2IPaT"
Received: from [10.10.11.33] (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id A72072FC009D;
	Fri, 11 Sep 2026 12:38:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1789123106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rg/5NBUTSnmAWDhBQ3yAkNGPLyQu2qRqAx6JbI0KSlc=;
	b=jtg2IPaTxRKvYMmb6PEbxIsx8931uVJKwRZnJRiGizehgerZ8yiIWb630JQqyL/VlgTkVk
	0IEdmp4GmPI0PhAN7C1H1HyfJdQmRXugJjcnKNI9OUX+LdW/tMvlX7+JMGZCzHcqhbq8IG
	SZtuAkM1qF2oZkrQ10CqNFqlh2txCIc=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
Message-ID: <23f39dac-a13a-4211-83a7-17b90d5d8e11@tuxedocomputers.com>
Date: Fri, 11 Sep 2026 12:38:26 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] HID: lamparray: fixes from testing on Acer Predator
 PT14-52T
To: Cristian Mazzotta <cmmazzo@icloud.com>
Cc: W_Armin@gmx.de, bentiss@kernel.org, jikos@kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 wse@tuxedocomputers.com
References: <a62d1907-73cb-4cfd-98b1-7cdce3b37541@tuxedocomputers.com>
 <20260909165257.352597-1-cmmazzo@icloud.com>
Content-Language: en-US
From: Aaron Erhardt <aer@tuxedocomputers.com>
In-Reply-To: <20260909165257.352597-1-cmmazzo@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 09.09.26 um 18:52 schrieb Cristian Mazzotta:
> These are four fixes on top of the v5 series, posted 2026-09-03:
> https://lore.kernel.org/linux-input/20260903073602.3815258-1-aer@tuxedocomputers.com/
> 
> Tested on an Acer Predator PT14-52T, which has two LampArray devices: a
> USB keyboard (05AF:767A) and an I2C ENE controller (0CF2:5130).
> 
> With v5 as posted, the keyboard does not probe. LampCount reads back 0,
> and once that is fixed the level counts read back 0 as well, which
> divides by zero in led_mc_calc_color_components() during probe and takes
> the USB hub worker down with it. Patches 1 and 2 cover the reads and the
> validation; this is the same problem Aaron and Werner discussed in this
> thread, with a backtrace from hardware that hits it.
> 
> Patch 3 makes use_leds_uapi transfer control in both directions.
> Autonomous mode is currently only set at probe, so writing 1 re-registers
> the LED class device without taking the hardware back, and updates sent
> afterwards are ignored.
> 
> Patch 4 blanks the lamps across suspend. On this machine, the lighting
> accounts for 9.21W of the 12.35W s2idle power draw against 3.14W with
> the lamps blanked from this driver, so this is most of the suspend power
> on a laptop with RGB. This was also tested with one of the 2 lights on
> the ENE controller still on; this patch does not control both zones.
> 
> Please treat these as input for v6 rather than a separate series;
> squashing them in is fine by me, and I will rebase and retest against v6
> when it arrives.

Thanks for your patches! I have reviewed and tested them and the only
thing I noticed is that wrapping the resume/suspend methods with pm_ptr
is missing in the final patch. Otherwise everything LGTM.

I will follow up with v6 soon, adding you with "Co-developed-by" on
the relevant commits.

Best regards
Aaron

> 
> Two things I have not fixed:
> 
> - The ENE controller exposes two LampArrayAttributesReport collections.
>   lamparray_parse_update_report() has no first-match guard, so the second
>   overwrites the first and only one zone is claimed; the other stays in
>   firmware control. This is the multi-zone question from Werner's reply.
>   I really believe that multi-zone support should exist, but I have not
>   included it because I haven't started it; uni is taking away a lot of
>   my time currently.

Ack. I think this is better suited for a separate patch series, unless it
is trivial to add.

> 
> - hid_device_io_start() in lamparray_register() may no longer be needed:
>   hid_hw_raw_request() is synchronous and does not go through
>   hid_input_report(), so it does not need driver_input_lock released.
>   That would also address the second [High] item from the Sashiko review.

Ack. I will look into this for v6.

> 
> Cristian Mazzotta (4):
>   HID: lamparray: read attribute reports synchronously
>   HID: lamparray: raise log level of fatal probe errors
>   HID: lamparray: transfer control when use_leds_uapi changes
>   HID: lamparray: blank lamps across suspend and restore on resume
> 
>  drivers/hid/hid-generic.c     |  27 ++++++
>  drivers/hid/hid-lamparray.c   | 162 +++++++++++++++++++++++++++++-----
>  include/linux/hid-lamparray.h |  35 ++++++++
>  3 files changed, 200 insertions(+), 24 deletions(-)
> 
> 
> base-commit: 9b298109e37e5caf4b6800198c4907a5a6bf00ae


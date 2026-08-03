Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB15431E51;
	Mon,  3 Aug 2026 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783564; cv=none; b=IBblZNtxIoHx1KUQn0RPV+vNbDYMnrlseUbR3x9j0XWrtlw5EyL+t8U0y1rOUCqarpSa/3gXUYCASLMmdZTul0QL9NuBoNaG8Vzwz1xS/7D8d3ygZAHYpW2uWd+079zI8foM2N/ZyBvi87WkU1Jpc4R3Kyf3fcAVcHPQr0RZFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783564; c=relaxed/simple;
	bh=ZqYjwVmGKFVTOnlYa0mlwOFSqZvA0pOdtP5OLT4AyTs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QrHRp88b13uuJDv+A6yKyZnZC6Z0zsf/R/fGY+FZih7dMr8Nortar1E9dtq78+8hq8jnMY6+wsm6od3DRlao9ePldBAvXT7Qhayuu3zGV8eH/mldHMMwYHum7i4+uFajj0j5e0VN1qhOnD8+N96X9s0k0j12a9lmJDT2RCsQx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWdrXUKM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWdrXUKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DF81F000E9;
	Mon,  3 Aug 2026 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785783563;
	bh=aCDlGG1PTgnugr4SE3sx5tTqfbVd/vOsYWIRGAs+Yx0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=oWdrXUKMdd95+P9kZ4I6XEIOkt7X0gKtfE/JUew7r/GBkQVLJRO21DfvW1al6oh5U
	 hbX0lOCrgOZqxaMobayOiMYNY6euAE2A5hk7PiQueBDXhiM4xi+I+E6/M+G8uLqc+x
	 TCyEhzEzvN02IVyi9NkDrcy4eSiVnVbJ9zvoazStqkRYNnShBvy5ZbkNm5kT7wb7PW
	 jFGFKgAxGN7jLtDC5aupqBgB1gphh0LhrUm9Wk6faZ3BvxQ8gE7FQ1YgmAA8nSP8f3
	 OPTo6sDcTPBYzHCHoqnkPnOF05Gt7DYIHGO9stKQvyuSUU8ciiVnqwWF4/V7wICCwE
	 CajVPSs1XjvGQ==
Date: Mon, 3 Aug 2026 20:59:20 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Sriman Achanta <srimanachanta@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, 
    Simon Wood <simon@mungewell.org>, Christian Mayer <git@mayer-bgk.de>
Subject: Re: [PATCH v6 0/9] HID: steelseries: split out Arctis driver and
 add Nova 5X/Nova 7 support
In-Reply-To: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
Message-ID: <7ooq636n-q8s5-2rq5-7460-osr43q04q0n4@xreary.bet>
References: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 8 Jul 2026, Sriman Achanta wrote:

> From: Sriman Achanta <srimanachanta@gmail.com>
> 
> This series moves the SteelSeries Arctis headset support out of
> hid-steelseries.c into its own module, reworks it around a per-model
> device_info table, hardens the battery power-supply lifetime, adds an
> asynchronous status interface, and finally adds support for the Arctis
> Nova 5X and Nova 7 families. After the split, hid-steelseries.c is left
> handling only the SRW-S1 racing wheel.
> 
> Changes since v5:
>  - Nova: rename the Gen2-only parse function and device_info to
>    steelseries_arctis_nova_{parse_status,info} now that they are also
>    used by the Nova 5X and the 2026 refresh, not just Gen2.
>  - Nova: add device IDs and a device_info for the original (pre-Gen2)
>    Arctis Nova 7 family. It answers the same 0xb0/0xb7/0xb9/0xbb status
>    opcodes on the same interfaces as Gen2, but reports battery capacity
>    as a discrete 0-4 level rather than a raw percentage, so it gets its
>    own parse function that maps the level through
>    steelseries_map_capacity() instead of using it directly.
>  - Nova: add the Arctis Nova 5X, which shares the Gen2/2026 protocol.
>  - hid-ids.h: fix a whitespace-only bug where the new Nova 5X macro was
>    space-aligned instead of tab-aligned.
>  - Rebased on current master.
> 
> The Nova 5X protocol was verified against hardware by
> sp4m.an.joker@gmail.com, and the original Nova 7 protocol was verified
> against hardware by colin@1101b.com. Thanks to both for testing. I
> previously ommited other devices in the v4 patch series due to being
> unable to verify.
> 
> Sriman Achanta (9):
>   HID: steelseries: Fix ARCTIS_1_X device mislabeling
>   HID: steelseries: Split Arctis headset driver into separate module
>   HID: steelseries: Inline and simplify SRWS1 wheel driver
>   HID: steelseries: Refactor Arctis driver to use device_info framework
>   HID: steelseries: Report POWER_SUPPLY_STATUS_FULL when full
>   HID: steelseries: Correct Arctis 9 battery calibration range
>   HID: steelseries: Manage battery lifetime with refcounting
>   HID: steelseries: Add async status interface support
>   HID: steelseries: Add support for Arctis Nova 5X and Nova 7 families

Thanks for the series.

It however has quite a few conflicts when applying on top of 
hid.git#for-7.3/steelseries.

Could you please look into it, rebase and resend?

Thanks,

-- 
Jiri Kosina
SUSE Labs


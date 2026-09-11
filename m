Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E647ECFC
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133782; cv=none; b=a9AnMQW81hdqAKy/1uUsi/aCQHxigwYzzWO70LxtBdrzw7q0txUwpzSDsv/YQbPzEcAKceDQhNka6ijTZ2wi2E/sRSnLx9wET+IdTzXHnb8pNfR1xjqmotfc36HxEK/Jl0/bidaqcTVTUqXlIoe72cLiSc9WAeabctce2URIMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133782; c=relaxed/simple;
	bh=oK1d68c5KY3jOjGUdzUraqScOJ/nmyeDNuMA+tRPSkA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MlGNpEs+sHeBHfO/uY3OAtFdKbj09P0P2BlPlbEFkXOKiA9L6040LXmFl+LZuQnbN+RC/pk6xBXW0Zg/ITTEeCzwr/XaSNwF8irKb+zocqEhGiSaXNdbGe2ylxoigvPzRxSL3Cq4vi/06NK3IeOFr9SnY61uFJ6KTmjJLTr5qOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJHRS8lc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJHRS8lc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E491F000FF;
	Fri, 11 Sep 2026 13:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789133780;
	bh=bBSFpTvF4xuS68QtHMdJSmrYsul6zXVui2cYkk8Vms8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=DJHRS8lcGsXFV49ruVI1Axgn0YfaQF5PEzHFsw7HCDEofl7qJFbnlE/raPGJ7UxiQ
	 CETqrS8nvOlC9bD9Zog/i4KnXGnQDU8tUCI8fcsLvdNBzBL8xmtpES0RR67tGFI+Jb
	 8615hMtcHpir37et8EYMQAKrSaQP+2dV6lfpb74K2uJQ/JOqMIjNTutwE9wdK8u/DK
	 BZLZiGi56bedqVxOrLsLII0vrnE9m7ZdT/r6CZAcbTkx7J/Fa1bJoG52rOFoSHi3NT
	 JoXEsUS3KZ4aVE9hNgixBGKhc8PkrnHL3Mh7yBRCAcYeh6q1Dw7VfXSl4ccsWzliIC
	 B/XAKlceUy9eA==
Date: Fri, 11 Sep 2026 15:36:18 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 0/4] HID: amd_sfh: Add DMI quirk and support for new AMD
 SoCs
In-Reply-To: <20260902134431.3146117-1-Basavaraj.Natikar@amd.com>
Message-ID: <49q9507o-07q2-rr5r-rop4-482p5soorn11@xreary.bet>
References: <20260902134431.3146117-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 2 Sep 2026, Basavaraj Natikar wrote:

> This series makes two independent improvements to the amd-sfh HID
> driver: a DMI quirk for an existing platform, and Sensor Fusion Hub
> (SFH) support for newer AMD SoCs (MP2 1.2).
> 
> Patch 1 exposes intr_disable as a module parameter and adds a DMI quirk
> for the ASUS VivoBook TP420UA/TM420UA, which needs interrupts disabled
> for correct sensor operation.
> 
> Patch 2 enables the SFH on newer SoCs by adding PCI device ID 0x1152;
> MP2 1.2 reuses the MP2 1.1 initialization and operation paths.
> 
> Patches 3 and 4 switch human presence detection (HPD) and device-mode
> reads to DRAM instead of the C2P registers on these newer SoCs.
> 
> Basavaraj Natikar (3):
>   HID: amd_sfh: Add support for newer AMD SoCs
>   HID: amd_sfh: Add HPD support for new AMD SOC
>   HID: amd_sfh: Add device mode support for latest AMD SOC.
> 
> Helge Bahmann (1):
>   HID: amd_sfh: Add DMI quirk and module param to disable interrupts

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


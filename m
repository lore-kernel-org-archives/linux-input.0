Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF103BBFD0
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139084; cv=none; b=SRKlIQovqS5wASqoQ0Qew+wIFvSU52U/BhvUWFyUPCFaymDEuAtlHsPi7zvz9WSD5wWJRiz9vGhGhp3Ouxtb/bHM2zPtWWXqT4owvGWRfF2jYVCFYXR+llU9lnPICIa0p7Sx/V0jyzTvSSw4c/6BroGTygkiRSLLt7+xjGWidlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139084; c=relaxed/simple;
	bh=2dmxD6cEm+xi90zbsEE7ntXxFAaaH4pi9RhqBsK5rR0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qawj5JRimgCuFB7I3Ii03nY19K93pbEpGKgN8cWfoAFEd9Z2BbH0rCQw83gtwnSuCsD9xDxUfjij2d8z+TIw98ICiO0BjjsotDl8qSMukJtScv/rJMkdxGXvuvEVnC1uixDKmHIz/4FCv6U5UHWR89O0IBMlQi4xFkbOz0qzEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSSS71ZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSSS71ZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F063D1F000C4;
	Fri, 16 Oct 2026 08:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792139083;
	bh=q8oLKOwaB9OVcnmWI09Yk4ROtWJ20MYR4Aum52BknqA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=hSSS71ZOQ5e+Lh0ppSDM4IOsHawL6viJj1rLfqIJ5EBVxRg1mgX4038hUsi4VIGbl
	 Hjbo1KsVSM0vwBn7IhvO0KDw2+MrX0L4zW3Aa+CXahlATQAt5lfxOPpoIALqQokRu+
	 jq0Hz+0aab6/Whzubwx5NSeeJCm3Ll2D8RxIAMJW5SPNLzIkbH2gXauGG45f9h2IaI
	 uTHQhxOS1LrwerTDUarHWRzljqvZbe0y84LLykZW0D2yX20DSgrZe9K3wOfEhRA54S
	 QRPmS+6KyfOyX+0zWNEn98YwWnOymqjp6xr6lOdSanzARMax4LLKAE7S4+YT7UWSAg
	 1vi8K2nwPoZYw==
Date: Fri, 16 Oct 2026 10:24:40 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH -next v2 0/4] HID: amd_sfh: operating-mode telemetry
 sysfs and report fixes
In-Reply-To: <20261006103754.3614316-1-Basavaraj.Natikar@amd.com>
Message-ID: <q2n1qqo7-1r17-7p95-rp2r-6943889sqqr4@xreary.bet>
References: <20261006103754.3614316-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 6 Oct 2026, Basavaraj Natikar wrote:

> This series extends the amd-sfh sysfs interface with operating-mode
> telemetry and fixes two HID report handling issues.
> 
> Patch 1 moves the existing sysfs attribute handling into a dedicated file
> in preparation for adding more attributes (no functional change).
> 
> Patch 2 exposes the operating-mode telemetry reported by the SRA sensor
> (in-bag, out-of-bag, on-table, hinge angle, lid status and device mode)
> as read-only sysfs attributes.
> 
> Patch 3 removes an unsupported motion-state field from the accelerometer
> HID report descriptor that the hardware never populates, which caused
> hid-core to drop every accelerometer input report.
> 
> Patch 4 passes the requested report type to HID core. This prevents ALS
> feature reports from being parsed as input reports and fixes the
> "Event data for report 4 was too short (18 vs 14)" warning.
> 
> Changes in v2:
> - Add a fix for feature reports being sent to HID core as input reports.

Applied to hid.git#for-7.4/amd_sfh, thanks.

-- 
Jiri Kosina
SUSE Labs


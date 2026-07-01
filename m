Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7625B0B3;
	Wed,  1 Jul 2026 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915171; cv=none; b=e9E/QRWG0fij+npRVYRagh6EosrI7d3AUtPqnpoTuVcmePB/RqGcBI7ZEthikTZ+JyxAjYU2OvU65FWiIMBr37PIBR7mNllJQgGyNeVwkXGWXP03DnqQdviZd4wNSiBAIIBaiQFx+V606cAwWpb3t0sBDfIJiy+Boy9+TKW/liE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915171; c=relaxed/simple;
	bh=zS1p4n1rxLGveK9iYZinHD2uB02X4rcZdP+DWrmWRLI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D+0/sPA4eEBJiDW5OBs8mTLBsXiUlmHWhCd+ihlRgntFJkYSiGrImY8XgkN1ZF8rkT6IG0VV8bv7HoQ9weDYO+7DAwQTY5LIDv+CUnhIpeECYZCimkCzASm/SRIiYTU+wMhi1PxjP3XYKhlf6X2/5mTZ1cQMJwhKOsDj5CTDdCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECO7OBge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECO7OBge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA121F000E9;
	Wed,  1 Jul 2026 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782915170;
	bh=gGW44khjtC0Wqq9lbxS5xUlFRmHrbrHpC6x9dpLzXUY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ECO7OBge55N5gaEejuvHFKCh3pUhAwhhzApJrn5dfRT8pw6SCQel51gGziRgga5oD
	 I0iOD8+fg0+iZhk5/V0Iru2nyUkP5kchpXFJA/cREDy5rqMAb2nU6X4xFhmXh3CXAU
	 +fZnPgAveMMnRXSb240PWbzu7QqFPvUbuO9Zv3WHEyKnZVMCz9bcNdxqQHDaw9dc36
	 isl1z9pi11HIiHF9df8UJawoIFNVbo8hicCWQhSSJIYkEKDRR6WS5Pq47eYKvsqKkA
	 crIG53T9TNXiIZ5v9g8iexSHHlsp/pAjE4ZISsHUWyT8qb5nd0ztWhjb2/yeTwuSz3
	 DnlxbSMw3t6VQ==
Date: Wed, 1 Jul 2026 16:12:47 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Alexandru Serdeliuc <serdeliuk@yahoo.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: asus: add new Asus EC hid device for keyboard
 backlight and FN HotKeys
In-Reply-To: <9fc25f84-b8b1-4ffa-a79e-ff95020ec45f@yahoo.com>
Message-ID: <5o7r0493-19r1-208p-404q-n0nq453170q6@xreary.bet>
References: <20251221-add-support-for-the-asus-hid-ec-v1-1-35d7d70fbbfc@yahoo.com> <9fc25f84-b8b1-4ffa-a79e-ff95020ec45f@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 30 Jun 2026, Alexandru Serdeliuc wrote:

> Hi Jiri, Benjamin,
> 
> Enquiring if anyone has had a chance to look over this patch series from
> December?
> 
> To provide a bit of architectural context, this is a 100% pure HID client
> driver.
> 
> This laptop (Asus Zenbook A14 UX3407QA) runs on the Qualcomm ARM64 Snapdragon
> platform.
> 
> Because it is an ARM device, it does not use traditional legacy x86 ACPI/WMI
> code.
> 
> Instead, the Fn hotkeys and keyboard backlight controls are routed completely
> through standard vendor-specific HID reports (using Report ID 0x5A) over the
> existing I2C-HID transport layer.
> 
> It requires absolutely zero Device Tree modifications or external platform
> subsystem hooks to bind or function.
> 
> The driver matches strictly on Vendor/Product ID (0x0B05 / 0x0220) passed
> directly through the core HID subsystem.
> 
> I would highly appreciate any architectural feedback or a quick review!

Hi Alexandru,

first - sorry for not having handled this, it somehow fell in between 
cracks.

I have just one question -- wouldn't it be better to have this device 
handled as part of generic hid-asus driver? Giving too many Kconfig 
configurations for every specific model feels a little bit too 
overwhelming.

(yes, we'd need to have hid-asus depend on I2C ... I don't think that's a 
big issue).

Thanks, and sorry again,

-- 
Jiri Kosina
SUSE Labs


Received: from mail.koesling.network (vmd143767.contaboserver.net [45.67.216.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00BA34D903;
	Thu, 19 Mar 2026 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.67.216.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948457; cv=none; b=coiIShkxMDqkOyBgEu7stkudMWBjhKp/V5+70ctVIYi8pt0norlULT/Kz9JC21zIIGs/csdKWrUbzj8UMzxu80OESrAv3ki+GIjiecfAwPgTm9qernve42be7ACzaTXuSlU1Q9ad8quElEqKKFP5F8VOnetWBefmZynNdfigSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948457; c=relaxed/simple;
	bh=30AulUHgIzJVC7PQrMrHp4IwGe/nqQxVgnW5+9hOaJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abqtUiqzw4nSr+Gogyk5BBEIUGopC0CZ8wu9BjJKWiqzxaAXrPAFbv6zpYraYuq69gpsg4+seeQH7o+5RHgfTJ2d3FHz5F5RCIXDvCKVdd2PcOBDPDa3tz7QPnfD9bqYQjWqUJ3sgr5oEpe/q4mv5Cg7BSTuHWexNb4OewAcAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info; spf=none smtp.mailfrom=koesling.info; dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b=Z0qn3nin; arc=none smtp.client-ip=45.67.216.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b="Z0qn3nin"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86BAE132164D;
	Thu, 19 Mar 2026 20:27:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1773948447;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I508ZSs63yPlzhQOGuFr7LEymShF4GhsKO7JeeK9KeE=;
	b=Z0qn3ninH70Y4gvODj6xykMvaiqvpb6pZ/T5a6TGB4vl1gOA+cPdvCtQhICVZ2ZeAZprCq
	A7qSGE+j+VxoFwX6Si1Ex+X8NieoWTTHL1wPKoJPaObwDX7f3SgH9yUFcScb+YRLqaFnpe
	3+CL+taRmlHRzka4tQa3qRgRD5T4sePO94joPgnX2wQmnhWbGR6LY0KciXhgyVMXAQ3xEb
	IDE80ixdhI87HsaIEUbt0PlQSbu9pBppA6SzolTJhX8uUHSCFgeh2t6DhuuaDRLT7WwsZc
	BSruTKbbPImdIDhHmiWMoEqhyfAObU0JTQ9GnW4CjeVfguJFAVW3nCDCn+HTmA==
From: Nikolas Koesling <nikolas@koesling.info>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Leo <leo@managarm.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: pulsar: add driver for Pulsar gaming mice
Date: Thu, 19 Mar 2026 20:27:25 +0100
Message-ID: <2344095.iZASKD2KPV@nk-eos>
In-Reply-To: <8590f544-9146-4e8e-9ea6-a3ed9ed9fa1f@managarm.org>
References:
 <20260318205503.64420-1-nikolas@koesling.info>
 <8590f544-9146-4e8e-9ea6-a3ed9ed9fa1f@managarm.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi Leo,

thanks for the review.

> While this driver looks fine at a glance, this does seem to use the
> same protocol as the hid-kysona driver. It might be more appropriate to
> extend that driver instead of rolling a new one? The HID identifiers in
> hid-ids.h already have a vendor constant for USB_VENDOR_ID_KYSONA,
> which takes the same value as this patch's USB_VENDOR_ID_PULSAR.

Same vendor ID, same protocol. I should have caught the overlap with
hid-kysona.

I don't think simply adding Pulsar IDs to hid-kysona as-is would be sufficient.
The current driver has some issues I addressed in my patch:
 
1. No locking: raw_event writes battery state concurrently with get_property
reads
2. raw_event always returns 0, so battery/online status responses are never
consumed by the driver. They leak through to userspace as spurious input
events. hid-pulsar uses pending_event + completion to match commands to
responses and consumes responses to driver requests.
3. the protocol includes a checksum, but hid-kysona never validates it on
incoming data.
4. hid-kysona does not react in any way to the power change event messages
from the device.

> For context, I was investigating exactly this battery reporting for
> another mouse, the ATK VXE R1 SE+. It does seem to use the exact same
> protocol; in wired mode, that takes the device ID 3554:F58F, while the
> wireless dongle has a device ID of 373B:1085. I plan on sending a patch
> to add these IDs after some testing.

With three vendors sharing the same protocol, a vendor-neutral name would make
sense. Any suggestions? Something like hid-paw3395-battery (sensor),
hid-nrf52840-mouse (SoC), or is there a better identifier for this protocol?

What would you prefer: rework and rename hid-kysona in place, or rename and
extend hid-pulsar while keeping hid-kysona as-is for compatibility?

Kind regards,
Nikolas




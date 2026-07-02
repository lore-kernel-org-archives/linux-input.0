Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63535836E
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783029849; cv=none; b=oK9uIAQ4sEEE5e5qipdIfk4hcCIAhE0Hegbs+t/Ojmmm9p0W37T7wmCrabfoSWjE5DAxmGqNCytzJNYl5EVR80JTSRisRdVdc/rUTq6nog3ZKmDZmX7wZ+fWy59bmtD/W0SCGno/1lVkRo5Dl/Z2QWqiDK3r4cPRxG87zABpv4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783029849; c=relaxed/simple;
	bh=hs9+dDK72/v8wQmMzCEooRID044MR6oOYbShIxGhcBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LbHBM3B47c2oSyAhweQDn9xNmV2BADxz957/XjgVE+HwVq7SNHes9eeCPx486RFKUCUq5Z14bt+gRwxZtqpDE2vkMlhf4qOdbAs8GlQGqjov4tcyt7q3wQyG5Eib78urNAFLOVgx21FlYtfBv9i46ZQwcM3vww0T3NA/Wh6f38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz28aM6p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz28aM6p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEEE1F000E9;
	Thu,  2 Jul 2026 22:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783029848;
	bh=AyDjFNHGZt7Mk+v+RsMQ7YJVCZIXwUqeanWIlcmhwwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iz28aM6p0u6pSXUc5OnjL8LCer4GgTB5zq1XjI2mG+srEtKW+L0gN705B6PnHLUe3
	 PZ0Lhh8oE6/5JStuKjy46rlMSGWFTyg6Mtr1rneBUhvo2vHwNvjHTHQxz8/at0QDs6
	 eKka5UmLehsQNrMuUbbJbzIBC8bbTQf6Fv4JXT0AFWeXFByp6zyfX4Iv9NlaFX2Bdp
	 KQnhAouPtfq6D3YUw+CVTcvmnu8gVDvPWEsT7/4+24Zc607Vfw2tqS7xReDcAZZYkE
	 sDRwnOlWx48jRoiPQe5uELa9zcNU1HcGgu1M4QZnzN/JjBzaHsLT0H6k+zdxjX0yrx
	 SkTVsN+y6HzEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/3] HID: nintendo: Add preliminary Switch 2
 controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260702214704.1859350-2-vi@endrift.com>
References: <20260702214704.1859350-1-vi@endrift.com>
 <20260702214704.1859350-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 22:04:07 +0000
Message-Id: <20260702220407.EDEEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Concurrent URB completion and device disconnect paths cause a Use-=
After-Free due to missing synchronization.
- [High] Immediate resubmission of failed bulk IN URBs causes an interrupt =
storm.
--

Note: The format of this review has been altered to use a free-form summary=
 of findings rather than inline patch quoting due to recitation restriction=
s.

commit 77b4d4df4f2d3eefe6970b5429bc05e1a86ecc7e
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add preliminary Switch 2 controller driver

This adds a new driver for the Switch 2 controllers. The Switch 2 uses an
unusual split-interface design such that input and rumble occur on the main
HID interface, but all other communication occurs over a "configuration"
interface.

[Severity: High]
In switch2_bulk_in(), could this cause a use-after-free during device
disconnect?

When switch2_usb_disconnect() executes concurrently with an URB completion,
it calls usb_kill_anchored_urbs() to cancel in-flight URBs. However, the USB
core unanchors the URB just before invoking the completion handler. Thus,
usb_kill_anchored_urbs() misses the URB being processed:

switch2_usb_disconnect()
    usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
    cancel_work_sync(&ns2_usb->message_in_work);

If switch2_bulk_in() is preempted before it schedules work:

switch2_bulk_in()
    ...
    if (schedule)
        schedule_work(&ns2_usb->message_in_work);

the disconnect path will complete and free ns2_usb via devres. When the
completion handler resumes, it attempts to access the freed context. Does
this missing synchronization need to be addressed?

[Severity: High]
Can an interrupt storm occur if a bulk IN URB fails persistently?

In switch2_bulk_in(), if an URB completes with an error like -EPIPE or
-EPROTO, the schedule boolean is false, but the URB state is set to
NS2_URB_FREE. The driver then immediately evaluates it for resubmission:

switch2_bulk_in()
    ...
    usb_anchor_urb(ns2_urb->urb, &ns2_usb->bulk_in_anchor);
    err =3D usb_submit_urb(ns2_urb->urb, GFP_ATOMIC);

Since the device isn't shutting down and the anchor is empty, the exact same
failing URB is resubmitted instantly. This will likely fail again right
away, re-invoking the handler and creating an infinite loop. Should the
resubmission logic be delayed or halted upon encountering persistent
errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702214704.1859=
350-1-vi@endrift.com?part=3D1

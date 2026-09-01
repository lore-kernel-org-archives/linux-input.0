Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [37.187.220.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7AB49B202
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.187.220.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788286769; cv=none; b=Z6udviS6S3ioPwahlTCDZQpEmCtDwSBPCDYUW9w+njG3eN+w9IXPgbPiKLKpxmV9nFPVBa/zGz3ZbURw3Gr20q8gKWfPnCqjE41hbEEBmQuw0MuNpIeDWAvNohdBGzzHPp1b7uizHOU+9Znh92ZFoL7OLZy7oXLP1wtiRLipBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788286769; c=relaxed/simple;
	bh=xqr/T+nu8jxRDkFoy28e/w4KGKQ8yGwhce0PK05Ad5Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyQlmr0pMLzsFHNEYNXVLRXqBZ3WsDyV9xqZuKTKqybtf+rNWcEqRV3c0XmRZXm7cjOqFMaGYmGj65MKCHXwfYEFIRplqg/Gj8zGO2G3PfjGZjkPJCdr/alFi3QuQag7ISVIRyXz8kL7wN9IgumiEQad9hV2IGwUbHDIRp60Kuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=yWJZq9hJ; arc=none smtp.client-ip=37.187.220.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="yWJZq9hJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1788286752; x=1788545952;
	bh=S54BayegxHH4tLpSv/3OVD/O20bEkSy1mOPQq3YQ32A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=yWJZq9hJTS8apgMCpp3+A4u+Je+GkkbaOTanR/kjHTclw0S0dPNcb9oSAaFrtB7ne
	 LwFep+uejEke4nFlRNXfQ5hsYFXKQ4hSgaeiwoc6Dzl/CQoaquiJSB3t9FNkt4gtM7
	 hXK8yfoPTPiIilHUbQFDaqrv5PpngiSQ4mzOcgrj3tOmpLtLCVmt2pTtb/7oOFo5Cf
	 mP4xGkAi0RDhLeYcn+igVD/Wh7KX7Lb1+He255WZ7D4uTByEtpROlQL7ScSUgY+6Ae
	 w13d17/l7G0eVGrKHlIqjEDE7lSxAgLfVyNWLQjkigsK/hW/l5unj6Q52sfr+FckaZ
	 +pMuZT5I+9J5g==
Date: Tue, 01 Sep 2026 17:55:58 +0000
To: sashiko-reviews@lists.linux.dev
From: GreyXor <greyxor@protonmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-dj: forward Bolt receiver input to the dj child device
Message-ID: <6AJmiNZBCZLsy0vTWpix-cf5Oj4kDiUJhIjnN4DFAOuYr0QlnmZdZPjurmIiA0whAeUlQVElJgaE5nHYxD-N_TH92enTBfs1BauDTj0BdG8=@protonmail.com>
In-Reply-To: <20260901163731.A0F441F000E9@smtp.kernel.org>
References: <20260901-bolt-scroll-fix-v1-1-58bca7ae487f@protonmail.com> <20260901163731.A0F441F000E9@smtp.kernel.org>
Feedback-ID: 1917010:user:proton
X-Pm-Message-ID: fab4b594960c0444898a28e5e5774399ceb0ca7d
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 04:37:31PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does this code overwrite the shared djrcv_dev->unnumbered_application fie=
ld
> when multiple interfaces of a Bolt receiver use unnumbered reports?

No. That assignment is guarded by:

=09if (!input_report_enum->numbered)
=09=09djrcv_dev->unnumbered_application =3D rep->application;

and only interface 0 of the Bolt receiver is unnumbered. Report
descriptors as read from the hardware (046d:c548):

  interface 0  no report IDs       (keyboard, unnumbered)
  interface 1  IDs 2,3,4,11,60,61  (mouse)
  interface 2  IDs 16,17           (DJ/HID++)
  interface 3  IDs 40,41,42

Interface 1 is numbered, so it never reaches the assignment. Interface 0
is the only writer and sets HID_GD_KEYBOARD once, so there is no second
writer and no overwrite.

This is also why the patch is needed for keyboards: before it, interface 0
returned early as a generic-hid device and unnumbered_application was
never set at all, so a Bolt keyboard's unnumbered reports could not be
forwarded to the child device.

recvr_type_dj and recvr_type_gaming_hidpp have used no_dj_interfaces =3D 3
with this same interface layout for years.

> [Severity: Critical]
> This is a pre-existing issue, but is there a use-after-free regression du=
ring
> device teardown in logi_dj_remove()?

This patch does not touch logi_dj_remove(). The requeue is already
guarded: logi_dj_remove() clears djrcv_dev->ready under djrcv_dev->lock
before calling cancel_work_sync(), and delayedwork_callback() returns
early on !djrcv_dev->ready.

Thanks,
Gr=C3=A9goire


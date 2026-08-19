Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEAA38BF69
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787104369; cv=none; b=JF5zuD9pqdzeNlGfGN9BzmczKEz8t/HiAitfIJ0ebzHnEHwHs97RE1+wdmqOpP64sf0SbzDvYyXMOyuSeg58Q4RRtNbmeZ+D2mbn8l0jZXB/VMCirVy/wy8VDxUGkL4UUhqAXbs6wTuDWIQwUtDZ8lsMDSwpxVyNXGuOPXllnsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787104369; c=relaxed/simple;
	bh=QwD2EQ2TCsVWDkWtMlevfj/bQgFb3gJksa36oPyeY+Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ADDTprUgza/h/JE/iDaX+GnOCMIoPnlL2qwUb5rAX7xDq6jXH8gOHgrLTKXykeWspRDSeFrhN2ZYLo0uvHxwg/R+iQsyHRGaSW0uordbHNQO7DPhBdFf0+19c3kzEcRVAcpzYPrtguEC1LkBkP2F1eadR6Z60Kbmu2R807Mjdl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIo8u9Q7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIo8u9Q7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBD51F000E9;
	Wed, 19 Aug 2026 01:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787104367;
	bh=55panpPnRuUc7VM6kAnxcMTBbw4lGrkfhYF363N+xO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kIo8u9Q7o9I1/IbXbUUuUfBsUUa1s2NWz75OH+WBqWd66C5CPMTUyFCyzwWFJaaDK
	 +gC6KW1auNPFc1ewVCqw3Dr6kAFvAgeOfGPSqqKK/c0g8ZtPwZJIf8Kp9oNKUhx1SU
	 WguKf8HibHvnoOfiwSrQg10w7D608J3/8TKjhW5zSzr08QnRiK40TMAXbE5D7NfM/O
	 Rp+tqwBjia3aNlmQalOc3o4254I4d7EyF4uyaTUvGStp+R2fr/BXCXkimPu5OIoeJF
	 eOBeptBu7vZxNulA8AEScfTd1V/jce4w7NE0onn6cDcK2puJBMTAqLstC58++xoBjM
	 xhfpN5LHFlg2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: core: fix device cleanup on allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tristan Madani" <tristmd@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260819013149.889913-1-tristmd@gmail.com>
References: <20260819013149.889913-1-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 01:52:47 +0000
Message-Id: <20260819015247.ACBD51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent `hidraw` operations can cause a use-after-free on the S=
RCU structure during device destruction because `hid_bpf_destroy_device()` =
runs before `hid_remove_device()`.
--

--- Patch [1]: [PATCH] HID: core: fix device cleanup on allocation failure =
---
commit ef17fd6111206c1e7e801f388343922186fcf0dd
Author: Tristan Madani <tristan@talencesecurity.com>

HID: core: fix device cleanup on allocation failure

This commit replaces hid_destroy_device() with put_device() in the error
path of hid_allocate_device(). This prevents a general protection fault
caused by cleaning up an uninitialized SRCU structure when=20
hid_bpf_device_init() fails.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index cf123347a2af7..9534de5317783 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -3060,7 +3060,12 @@ struct hid_device *hid_allocate_device(void)
>  	return hdev;
> =20
>  out_err:
> -	hid_destroy_device(hdev);

[Severity: High]
This is a pre-existing issue, but looking at the implementation of=20
hid_destroy_device(), it destroys the BPF structures before unregistering
the device:

void hid_destroy_device(struct hid_device *hdev)
{
	hid_bpf_destroy_device(hdev);
	hid_remove_device(hdev);
	put_device(&hdev->dev);
}

Can this order cause a use-after-free on the SRCU structure during a
concurrent device teardown?=20

If a userspace process writes to the hidraw device concurrently with a=20
hot-unplug, the hidraw writer could check the destroyed flag and then get=20
preempted before taking the SRCU lock:

CPU1 (hidraw writer)
dispatch_hid_bpf_raw_requests()
	if (unlikely(hdev->bpf.destroyed))
		return -ENODEV;
	<preempted>

CPU2 (device unplug)
hid_destroy_device()
	hid_bpf_destroy_device()
		// sets bpf.destroyed =3D true
		cleanup_srcu_struct(&hdev->bpf.srcu);
	hid_remove_device()=20
		// blocks waiting for CPU1

CPU1 (resumes)
	idx =3D srcu_read_lock(&hdev->bpf.srcu);=20

Could CPU1 resume and dereference the freed SRCU internal pointers?=20

Should hid_remove_device() be called before hid_bpf_destroy_device() to=20
ensure userspace interfaces like hidraw are disconnected before the SRCU=20
structure is destroyed?

> +	/*
> +	 * hid_destroy_device() cannot be used here because
> +	 * hid_bpf_device_init() failed and the SRCU struct was never
> +	 * initialized.  Release the device directly.
> +	 */
> +	put_device(&hdev->dev);
>  	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(hid_allocate_device);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819013149.8899=
13-1-tristmd@gmail.com?part=3D1

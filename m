Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489ED3563EB
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678359; cv=none; b=Sw5MIRnohi4Gd5KISz1JTLMpf07XgLlaWzZjuQk6lWW5HOSkMroCHI/naPjn0pAFuQ3csyfUke+tuMqTG4a4tCWofxsr64coHUsJpw7dnYrkmAj9v2z6xnXzKNH1MKNSvyvO3Xt+tk53DV1bBAa75RFADjod1vDdfVp8zsqwWA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678359; c=relaxed/simple;
	bh=mYmQcHoL4CMwAEqTDcVIYu2iNDOCW2HtlLBCxOWMQeE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iwtulhMdR3XkO9we+WXc6usRmZrYf0bjXL4SuKASKcLFpTOBbijwpVKPtmtFYk35lt1rxMXuhww5ZrH2SfTWN+RKfDkjO8lLJO3WkrXhsqHeGscSqgQO+XpPVHpEgwTcB7ifzVr9uIIK0YPVUJn+E/DC+kPT27i6A7txt8ENa60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAel0EGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAel0EGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F18E1F000E9;
	Tue, 25 Aug 2026 17:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787678357;
	bh=bHBTXRv5i/eg0695lVXkiNzRm1shsEGg4SpSKizZi04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gAel0EGegLlj270wIShApl5cdhIpcOyrBCW0Oh3d35gBYdlXVcj9gFJzkzg9YSdSv
	 SRP/t1CF+ditXtLWEUMGf3Gb+W32VquVDxTuSeSC/znLuDCB8LLZEauIV0l9Yp+5Wx
	 mSGoF1u24UeRSW4mgmPC9BU6+pr0vG9jG9KsGIBoi7tJFsiHzNB88/da3dTBhkwhsG
	 LMAs1xQkFiU9Vy8g1+vYQS4wqgoFyMZny+IM6j9zt9LlOQMoUINc+L6qVzzj39/A8b
	 IeK7IB6QDlgJH02Ylo8foCiwBeyjS2z5SDQMzmB+pV66b50G7/FWf9YancqVZAuf7k
	 mS6uPX9rvIm5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] HID: wacom: Use hdev->product in
 wacom_setup_touch_input_capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260825151242.576456-1-lee@kernel.org>
References: <20260825151242.576456-1-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 17:19:17 +0000
Message-Id: <20260825171917.9F18E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of workqueues and timers in the probe error path l=
eads to a Use-After-Free vulnerability.
--

commit 84f0c894069529e6d333664a987e925e1ef88eb8
Author: Lee Jones <lee@kernel.org>

HID: wacom: Use hdev->product in wacom_setup_touch_input_capabilities

This commit simplifies wacom_setup_touch_input_capabilities() by replacing
lookups of wacom_wac->shared->touch->product with direct access to
hdev->product. It retrieves the hdev pointer using container_of() on the
provided wacom_wac.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index a29bf051ada7c..4436faf2d2bbd 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
[ ... ]

While reviewing this patch, I noticed a pre-existing issue in
wacom_parse_and_register() located in drivers/hid/wacom_sys.c:

drivers/hid/wacom_sys.c:wacom_parse_and_register() {
    ...
	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
		error =3D hid_hw_open(hdev);
		if (error) {
			hid_err(hdev, "hw open failed\n");
			goto fail_hw_stop;
		}
	}
    ...
fail_hw_stop:
	hid_hw_stop(hdev);
fail:
	wacom_release_resources(wacom);
	return error;
}

[Severity: High]
This isn't a regression introduced by this patch, but is a pre-existing
issue. Does this error path fail to cancel asynchronously scheduled works?

In wacom_probe(), the wacom structure is allocated via devm_kzalloc().
During wacom_parse_and_register(), hid_hw_start() is called which enables
hardware interrupts that can schedule async works (e.g., battery_work).
Additionally, wacom_query_tablet_data() explicitly schedules init_work.

If a subsequent initialization step fails (like hid_hw_open() above), the
function jumps to fail_hw_stop and returns an error without cancelling the
pending works.

Since wacom_probe() then returns this error, causing the devres cleanup to
free the wacom structure, could these pending works later execute and
access the freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825151242.5764=
56-1-lee@kernel.org?part=3D1

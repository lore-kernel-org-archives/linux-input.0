Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA41991CB
	for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782593321; cv=none; b=N3Wo3b8OAzhUfKdbYDyOiwdOg7Tq8Me08CYL0FedYxlnaeiMyg0jlQhUiZs5V4htBadU1TCL8yN+E5cPIC7KdWBW3xAXoRuW81ZsU0yGSSc91Xbqez4YDHui+n0Dj7gO74oMVIGru+X3w+hTBGLwQIj5WC7noyEGG4NV2gr8Ngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782593321; c=relaxed/simple;
	bh=eRDG4rD8d8DK/dtFWIrLGCvwjJlHboydRuuey1rTZR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JJrrZPm0wKE6atehZZRIwlA/ViejjF4L1y/YJAAH65Ug2vHR7uVHbNdnL9H0XXB5rciTMmWDH5FBjUiRz12vCRmKOLOFHDItxJMF7rvihMmL3VCcJ4yZWWfsCLNoU9u+x+ChQfFJ/7ahM1QDS/DXshP1mlX39z1tl9HkOk2u3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS3LR2dx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS3LR2dx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD671F000E9;
	Sat, 27 Jun 2026 20:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782593320;
	bh=kjeB/tsFLAiuWI8ezx8qKcnKMzOuUEfu//ZML67w8Uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fS3LR2dx57JNfw2KMnpVafAQCIxZdyms6D2LE2p2b9QX8fkQOC8f2uUas/S+Md/Au
	 /X2VOnIsdLToXDp126D76EAzthwSSQWWA36mT5BiHPh7uBjNhqgpH5Jvrc2ode+O3X
	 StvQyImQ/VMF1/LCprD+J7ZVlJKNOOcG3UaSR8jH8WKYdhHos6O/MsRK2atFj9Natp
	 jwBNodHlvnCYO8y5HzVfZiKKwl3ykX+pBi6NS+04mW2Gu0tVFFnmcA0WW0xydnApi+
	 ayvgryAvGOh8vR1zAxuPtO+S7BLPJbQY0Ir3Z/QbKWx41MCEq2IHWkDx0SCE2emMpS
	 3QL1NhKuGuWVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: hyperx-headset: Add support for HyperX headset
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sofia Schneider" <sofia@schn.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260627203948.1053589-1-sofia@schn.dev>
References: <20260627203948.1053589-1-sofia@schn.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 20:48:39 +0000
Message-Id: <20260627204840.2DD671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing power supply unregister on the `hid_hw_start` failure path=
 causes a resource leak and Use-After-Free.
--

commit 100439ac6279809f99a9f4158c6fe4a272508223
Author: Sofia Schneider <sofia@schn.dev>

HID: hyperx-headset: Add support for HyperX headset devices

Introduce a HID driver for HyperX Cloud III Wireless headsets,
supporting battery reporting and connection status.

> diff --git a/drivers/hid/hid-hyperx-headset.c b/drivers/hid/hid-hyperx-he=
adset.c
> new file mode 100644
> index 0000000000000..b77931d4dfb08
> --- /dev/null
> +++ b/drivers/hid/hid-hyperx-headset.c

[ ... ]

> +static int hyperx_headset_probe(struct hid_device *hdev,
> +				const struct hid_device_id *id)
> +{

[ ... ]

> +	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret !=3D 0) {
> +		hid_err(hdev, "hw_start failed\n");
> +		cancel_work_sync(&drvdata->battery_work);

[Severity: High]
Does this error path leak the power supply if it was already registered?

If the device sends a connected event early during hid_hw_start(),
battery_work may execute concurrently. It can register the power supply
and store it in drvdata->battery. If hid_hw_start() subsequently fails
(e.g. during hid_connect), this error path cancels the work but fails
to unregister drvdata->battery.

Because drvdata is managed by devm, it will be freed when probe returns
an error. This leaves the registered power supply with a dangling pointer
to drvdata, which can lead to a use-after-free if its sysfs attributes
are accessed.

Should this path check and unregister drvdata->battery before returning?

> +		return ret;
> +	}
> +
> +	schedule_delayed_work(&drvdata->poll_work, 0);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627203948.1053=
589-1-sofia@schn.dev?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB942BFC7B
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840018; cv=none; b=hLE8Bm0ebvS5BTSXGsY7HGJBETMNtK3PdiT5BOyfxgm/bT033CVFPFBkcIcyTP39T9lW0oj2Lx3eKs+3TsfAlPZBHMz3STkIufCiYRiaDECpdPY+mMxUEDDw/KiY/zea+Gnz6+8L0V5hRZiDHhTATou63U9ghQMbTyaYOCIfN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840018; c=relaxed/simple;
	bh=uTpVL8VFxiH0aXwtgaqKoP5zxzsZ7uRk4O7pMWoaOi0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hOIZAjCSVephPh9s1Fs5DFSxNH895CA4qDnyrZLIqgTJx5/I9WJkI+IDGRHWdRlN6o3iD6i12Wm+Ah8UKOsNX9TVUk9zPgO/1nFrXzITiJUyhmmv3R9NTnKtDXWJqY+3nY2Huf9cB2orS8TVKLNzG+t4/476vHNHk/xulPo5D18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5pa+xwr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5pa+xwr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07601F0089B;
	Mon, 12 Oct 2026 21:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791840017;
	bh=CHIMEk2xK/Fw1yJgwI/OV1boLhouWHei2v2o3fnlE2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l5pa+xwrTTf/sDz4JZ8GwIGRJzzL0QHgmr1O4s9q1V7dSfsyNso6bJvmJnHpOMYWJ
	 O2LSox2gRIiSPGuN5TnOI8Wk0VSwwKVn62QavVpj5UbBmDoNo/9xZPb6jrRpZmRUW8
	 rckvIc+4iQI6GhtREColn04JPehGsumcmw5jjv7UpqLG705qtGiDPhXvNrLct4xLBs
	 W565FQ3+GSbZQCiNIy/IdROlsP9z0GR7ajca8KxJpdkAvBpyW85ud+q1UplS8LY0hu
	 AXOLXshMAqy2OAx+cZAegUlwGSu82ZNZJMlOpyvq0DErAhTwWYmRaIvQ3xceNuCGvC
	 lhjUHd0b7CwEw==
Message-ID: <sashiko-outbox-168615@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] HID: UNCTRL: add basic battery reporting for
 UNCTRL RAGE Mouse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bishwa Bhusan Saha" <contact@bishwasaha.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261013-b4-unctrl-m1-battery-v2-2-bd6752021753@bishwasaha.com>
References: <20261013-b4-unctrl-m1-battery-v2-0-bd6752021753@bishwasaha.com>
 <20261013-b4-unctrl-m1-battery-v2-2-bd6752021753@bishwasaha.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 21:20:16 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: unbalanced hid_hw_close() in unctrl_remove() for non-vendor i=
nterfaces
--

commit 34f6450fbc06f0259d8e3dc8b22b5c1567b8c302
Author: Bishwa Bhusan Saha <contact@bishwasaha.com>
HID: UNCTRL: add basic battery reporting for UNCTRL RAGE Mouse

This initial patch will probe the battery only once. A later patch
will add periodic checking.

> diff --git a/drivers/hid/hid-unctrl-m1.c b/drivers/hid/hid-unctrl-m1.c
> new file mode 100644
> index 0000000000000..3896468adf77f
> --- /dev/null
> +++ b/drivers/hid/hid-unctrl-m1.c
[ ... ]
> +static int unctrl_probe(struct hid_device *hdev, const struct hid_device=
_id *id)
> +{
[ ... ]
> +	ret =3D hid_hw_start(hdev, connect_mask);
> +	if (ret) {
> +		hid_err(hdev, "%s:hw start failed with error %d\n", __func__,
> +			ret);
> +		return ret;
> +	}
> +
> +	if (!vendor)
> +		return 0;
> +
> +	dev =3D kzalloc_obj(*dev);
[ ... ]
> +	/* usbhid polls the interrupt in endpoint only while it is open */
> +	ret =3D hid_hw_open(hdev);
[ ... ]
> +static void unctrl_remove(struct hid_device *hdev)
> +{
> +	struct unctrl_dev *dev =3D hid_get_drvdata(hdev);
> +
> +	hid_hw_close(hdev);

[Severity: High]
Does this code cause a hardware reference count underflow for non-vendor
interfaces?

When the driver binds to a non-vendor interface, unctrl_probe() correctly
returns 0 early without calling hid_hw_open() or allocating the private
dev struct. However, upon driver unbind, unctrl_remove() unconditionally
calls hid_hw_close() before checking if dev is NULL.

Any hot-unplug, module unload, or manual driver unbind of a non-vendor
interface will trigger this unbalanced close, underflowing the
hdev->ll_open_count. This corrupts the transport open state and prevents
the device from being properly opened subsequently (e.g., by hidraw or
hidinput).

> +
> +	hid_hw_stop(hdev);
> +
> +	if (!dev)
> +		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-unctrl-=
m1-battery-v2-0-bd6752021753@bishwasaha.com?part=3D2

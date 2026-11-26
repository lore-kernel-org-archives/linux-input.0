Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708240;
	b=z4M/ZHqDNprFRMxBYBvS5MO2lYJ61EQDFc5LbeZ3GsPT2YYM2VoyYuFgUIZyA8XggPSL
	 xYs6fPM+tC3s2vD4MyoGCzkTPaqtIUX4w7mqZ9mDbmHluqQXeJNnL6yDF+/cZFDgHMb7y
	 8PtnRSZEIgKGjItSpbG2YxSqOzpalNPGYm70HB1+G0XoN+M1qiep1dmw8YUAPe2uor6ZU
	 lTyAWjpKnVFXzUecSYUmyvQUr5eOCrKQUp69LL05Fpm0ClPIKJWwZeM/QqBoXVE4+FQjf
	 /DcUPGKy6fAxcGcF5bs425uhzuIKx8NSa66R7/maEkSs+P6401sgagwAOLHUaI98pmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708240;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qK5AqhcQoRbTxbwRBzLzsmL5Fqrz5xEHm/fbODCFgbA=;
	b=UxwDjWEhH5FaxUXsa17mo0ahJ9T75bA7V5VHWIJRfutqlz72+9U5o2N17kTgRPDL8U1Z
	 yfw5dIuDtcelxylx9CmufQQQNc2e6LLXi4RCAGYKKJgvq16O53CBxVtQ6UVVAIeYImVuZ
	 7l6jruFQHSjuW9Emm+eX7Htb7/vE0XgsgLzSs4gTUOjlrv+WhCaD1dkE210RzCHGnpjLT
	 bEf8ghvxV+7Nurgn0Bti3jzQGFWoEvyryWGchHrEgbiT/WHf7Nue2rpv3L47+v9BU77Xk
	 fvisZ80jgMWr42iGijszh7NMKTrjBMiQzO9XBXaEZPzJ3usl26gtRckxFdKC9ZSSiiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcZ+SId5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3733606A334
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcZ+SId5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39EA1F000E6;
	Thu, 26 Nov 2026 15:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795708240;
	bh=qK5AqhcQoRbTxbwRBzLzsmL5Fqrz5xEHm/fbODCFgbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lcZ+SId5Wjs5PKNHaBon4r1jcJ2cpI7TVVsIRyCU5PRdTGi3GuhEgpjhYu7kK6a/N
	 L0zvTcB76emuUJGHQMyWcElLadpUxRE0aA1AKRm71N7ZzD1/x0ojWFGsbMfomw7qes
	 1ZZ4uT/MnnSByWSi5Gw1wOVk/EaG/HrLShdAvN9N5asqmUDldzCCw3keLKQ+XvlAqT
	 yiF2eI5QDmVkhrXxCkhxodRdM9aAgzQADyHO55EVc11SRu1ydbIhx3UnsXQlPrJ35J
	 MD9oEVTl8bxXjxkrgrW5yBexME8aKlpbE5wrkos9LscdH6HdFsUfeSPGMbpQUEZC+G
	 5eIO4XUXqkogw==
Message-ID: <sashiko-outbox-235847@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: core: include product version in the uevent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matteo Bruni" <mbruni@codeweavers.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261126153925.9488-1-mbruni@codeweavers.com>
References: <20261126153925.9488-1-mbruni@codeweavers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 15:50:39 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: core: redundant unprefixed PRODUCT uevent in
  hid_uevent()
--

commit f1a7bbe068e7bfcbcd219202f30241d7b9e0e8bc
Author: Matteo Bruni <mbruni@codeweavers.com>

HID: core: include product version in the uevent

This commit adds a PRODUCT variable containing the bus, vendor, product,
and version fields to the HID device uevent environment.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 64ac7606927ca..6b71104aa3319 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -3003,6 +3003,10 @@ static int hid_uevent(const struct device *dev, st=
ruct kobj_uevent_env *env)
>  			return -ENOMEM;
>  	}
> =20
> +	if (add_uevent_var(env, "PRODUCT=3D%x/%x/%x/%x",
> +			   hdev->bus, hdev->vendor, hdev->product, hdev->version))
> +		return -ENOMEM;

[Severity: Medium]
Does adding an unprefixed four-field PRODUCT variable to hid_uevent()
conflict with the parent USB device's PRODUCT uevent while duplicating
existing HID sysfs and uevent attributes?

For USB HID devices, usb_uevent() on the parent USB node emits a
three-field PRODUCT=3D%x/%x/%x (idVendor/idProduct/bcdDevice), whereas
usbhid_parse() sets hid->version to hdesc->bcdHID (the HID specification
version) before the HID device uevent is emitted.  Consumers or udev rules
walking up parent devices from hidraw looking for USB's three-field
PRODUCT variable will hit this four-field bus/vendor/product/bcdHID value
on the child HID device first and misparse the fields.

In addition, other variables in hid_uevent() use the HID_ prefix (with
HID_ID already exporting bus, vendor, and product), and commit
cdf826a94e0f ("HID: core: Expose id attributes in sysfs") already exposes
hdev->version for all HID and UHID devices via the id/version sysfs
attribute.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126153925.9488=
-1-mbruni@codeweavers.com?part=3D1

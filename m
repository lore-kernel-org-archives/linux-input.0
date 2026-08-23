Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81193033EC
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787512231; cv=none; b=gtGxgwK/VvzfCI2PQGglknixGYHGmir7eftx5nQOacv6wyK2PXGj9J9/z59Tjhly74mM+thtJrsQHdi/T80gpGXLi3WmRv8COCpBny5JJ1jO6nl1dL7rDeMV75Q9cgi08YWFfcBjYrLR/FV0XPn2kPyzHCrC9Pm8Y4+3sheS6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787512231; c=relaxed/simple;
	bh=DGWcXQWQlZCo8obxFc2a32i0yVFbvvsEMKAM8VA5ah8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sKI/jj5QHtF5QJUSaOA1VZosWI8gK6qJYgSOk1qI3dYBY/C1T3rhstCYdDA7mXFsDslCg3PrL4NdYqfrbBc4U4XmNRbBRH2cdV5UOV/A2PWQ8HVqjIbHvB0RfGcOAGbvLevXaQQuB3LLowNhb7Sfk0KV/CSGGOTi88dmsPqr41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aE+VYmrP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aE+VYmrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCDC1F000E9;
	Sun, 23 Aug 2026 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787512230;
	bh=MpK3qkjbwZ8tkISid0qyrwOX/UiesW/KQjrzbS2YZV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aE+VYmrP4yD5hVhpcjns2tjsENLV0WVDpZfUr5ldShjxkaZuB4EWaQKpkh94dMKH2
	 oVaYxpv7R/RPqYl97zeqjwYECk+umM8rUuhE8IPukEAopK7SqRCWXFe7cLMSO4shPQ
	 HWBss5pzpyFyAismlzfEOuUmTzk/rmaVRlXNhQ6KIUhe7MPESg+puyCSega4YCQ5VD
	 yiLmKdzdJb33io9V0cdZPBU0L7YMBmMviyB01IR2tAbtvSkaFQu424sHOBC3Nrvy9d
	 2A5OhZFNScW/8HOp9HL685YFU5agJi9G3YNa0/KXG9laaKxH8e0M+pry7kHL9ZCrow
	 LO+tTRttirHTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/12] HID: asus: add support for ROG Ally handhelds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260823185849.2478673-3-denis.benato@linux.dev>
References: <20260823185849.2478673-1-denis.benato@linux.dev>
 <20260823185849.2478673-3-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 19:10:29 +0000
Message-Id: <20260823191030.4BCDC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing endpoint count validation leads to an Out-Of-Bounds read o=
n malformed USB devices.
--

--- Patch [2]: [PATCH v3 02/12] HID: asus: add support for ROG Ally handhel=
ds ---
commit 361cb3e0d7ac3fa396f12b80e08c07137d346210
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for ROG Ally handhelds

This commit adds support for ASUS ROG Ally handhelds. It extends the=20
hid-asus driver to initialize the device to a ready state, implements=20
Ally X input mapping, and manages specific handheld features.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 9ce21fcc7d2e0..048bc902323ab 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> +static int ally_get_endpoint_address(struct hid_device *hdev)
> +{
> +	struct usb_host_endpoint *ep;
> +	struct usb_interface *intf;
> +
> +	if (!hid_is_usb(hdev))
> +		return -ENODEV;
> +
> +	intf =3D to_usb_interface(hdev->dev.parent);
> +	if (!intf || !intf->cur_altsetting)
> +		return -ENODEV;
> +
> +	ep =3D intf->cur_altsetting->endpoint;
> +	if (!ep)
> +		return -ENODEV;
> +
> +	return ep->desc.bEndpointAddress;

[Severity: High]
Does this code miss a check for the number of endpoints?

If a malformed USB device provides an interface with 0 endpoints
(where bNumEndpoints =3D=3D 0), the endpoint array could be empty. Accessing
ep->desc.bEndpointAddress (which is essentially endpoint[0].desc) could
then result in an out-of-bounds read or a kernel panic when syzkaller or a
malicious peripheral interacts with the system.

Should this function verify that intf->cur_altsetting->desc.bNumEndpoints >=
 0
before attempting to access the endpoint structure?

> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823185849.2478=
673-1-denis.benato@linux.dev?part=3D2

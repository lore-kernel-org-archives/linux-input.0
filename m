Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357919;
	b=hhZWx0ON1nUUCm07XfaoeokOXfsMeT9WOe6qPZcOd4weddIV3Dnaz6rvovzIs7mqEskD
	 Qyvf7lPoK8aWKRo1c8HLbKZ5LywjWmmxtYRBz3xUru4TwURCxiy4TNtRYkBFwgkkwWHu1
	 n6zrxifFN6Qly6RvAIR5ullYDZ9o7uX9heDaAkemrZU8oTpV0X6h7B9PGy1jp2t/ywqVR
	 UZAy9ca78yqkH1/8gBzT42XWVtEyVXfVeiC5XyWI++Jmpiwb8gJvaK8ra8UbkLhjl/ZLC
	 ctxVrswFCXc/dvWHfMzgx35GkxBwnwsRnNGiJe6FsYi9iPqIjs79ereamVxj+8ihBsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357919;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ojhn9DOSAcW7Svh+u+IQt482QtXo91iBmGllRdYBjEU=;
	b=kJ2WLL6cYoHowi8jdPbJTZx7j8zWsdXFOncJOSUnwQIMydyC1l1Tj7noxarGJVE3DWje
	 uaBl7jlLrJ8+fAnG9h6Hb9MrRu8KCwJVvmXk7ovs+mq904fKsYrEBJnc1UCGdjOqdLXsE
	 J4sVA8w6NTibp3He9pE3C8vmrVZXBcPo7rOZNggskKld4f+1755XWP6mCROyurR1kXb21
	 +ihmbWIelhtaZBtQpP3zTQKz6WCklwkSo0eTdZ4Jv+xCy3t8oc9qp4e5WGvEJ+Kffdiyw
	 iefTacFEpRzowLCYfnA8KFT02FxvlyrGPiJkA4btbpC9jVjRN7pMUSyEXwbU+Uk8kUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6lPq1Mp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87F606A31C
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 00:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6lPq1Mp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9359F1F0089F;
	Wed, 11 Nov 2026 00:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794357918;
	bh=Ojhn9DOSAcW7Svh+u+IQt482QtXo91iBmGllRdYBjEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y6lPq1MpUsub2/Gy66wtRTzk3sVpWJKyf4m31ONxktnpcOnK7hsqwAQjJiIdshWSO
	 G14zlSGeJnn4zs4NaCohuh+5u2BMQfybTpfeIqS9Ge0SPLuc1UpDupX06lybgoYudR
	 PpS6/FlEcMSQ5cM632FRGThLkgGbJrnlOAkF0nlB6OPawUSnVrUYpare8mplVjWq0M
	 PB418tVonkTywJ9EiDfsvVP425serhkgOatuIBPDTHDgV4M59Ko6qfCg5gZWgbrWmW
	 wIN+f6xQeaQGIoum4KcHPaJ/6E51HjvQbZR8S0BUgXJ7mRvq0LTziqAuFM787WX1gh
	 O1YF0m/OdIJrg==
Message-ID: <sashiko-outbox-208030@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 9/9] HID: haptic: Remove stubs in favor of inlined
 dead code elimination
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Zhang" <i@rong.moe>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261110-hid-haptic-kmod-v2-9-b835a067cb62@rong.moe>
References: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
 <20261110-hid-haptic-kmod-v2-9-b835a067cb62@rong.moe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:45:18 +0000
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
- [Medium] HID: haptic: hid_haptic_connected_to_input() returns ERR_PTR
  instead of false
--

commit 3914d83f5b9ce7ec32449543dd125ffa8f399224
Author: Rong Zhang <i@rong.moe>

HID: haptic: Remove stubs in favor of inlined dead code elimination

This commit removes the #else stub implementations in
drivers/hid/hid-haptic.h and replaces them with hid_haptic_enabled()
checks inside the inline helpers.

> diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
> index a71ccee569f31..070b56189ccbe 100644
> --- a/drivers/hid/hid-haptic.h
> +++ b/drivers/hid/hid-haptic.h

[ ... ]

> @@ -80,6 +87,9 @@ static inline struct hid_haptic_device *hid_haptic_allo=
c(struct hid_device *hdev
>  static inline bool hid_haptic_connected_to_input(struct hid_haptic_devic=
e *haptic,
>  						 struct input_dev *input)
>  {
> +	if (!hid_haptic_enabled())
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	return haptic->input_dev =3D=3D input;
>  }

[Severity: Medium]
Should hid_haptic_connected_to_input() return false instead of
ERR_PTR(-EOPNOTSUPP) when !hid_haptic_enabled()?  Because the return type
is bool, the non-NULL error pointer converts to true, inverting the return
value of the removed stub and preventing dead-code elimination in callers
such as mt_touch_input_configured().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-hid-haptic=
-kmod-v2-0-b835a067cb62@rong.moe?part=3D9

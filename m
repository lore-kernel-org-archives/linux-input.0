Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356757;
	b=Hicg0cKiRgNpb4MU/OtSq+WGRax80FtiRzSRZGxD79Y9z+tZMb1zvQGSreMjNnJDIJw4
	 YofQB/I5jaeP6hsvlhzU8A5/i0GmN7uEy+E1KNZ+ASqvisSPpMx6z0eD97SMNAMb8d6mK
	 xdyql+2yBUZn/K5nDn2R3yJQmEZp57BeVRWPOadFemNaoALopziSFxE62mTwsjwxsZfnk
	 D+OQc46NRNLN5YRid4l+zDmh1ShUkcblXrbKlmINGc9vFU9OxKTl1MgwRhIQIurJBwByd
	 cQFXaXUgPhYsqNxq1ZEXVvfthxqGN/X01NzuPtxJ52Gk7jUTTEGcXx5drtIRNeEqHHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356757;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Sl4b3EWxBDK4omBSZONaFHPAyFO7aeNS71Yx9T8CDpQ=;
	b=DK9CQ0Usyhl9EGo7v3gPMssl9vZ4WPG4tB8bBKb0IW9isIlh6eUdJDkaRuWZL0Q+RkyA
	 BJxSBzaFyp/CAvoApfkvURbTt4IV7ZxiLH+1mPBLGx4E0YXDY53z9MaBJOCqsuR3UTAbf
	 lcYly3eD9ReOOynrq7B7R9BWTb1/SfQo3R8DwfbwpkL4Qoa70yleuCpOX06N21pIG15Pl
	 lsTTt0N2HHjvoQC+Ye9IID7P3fcQkUzX1kaZ4bUqITFBgaXo2aKFpxeFjE1M4o4gmVDCJ
	 Dm5eflxDyBZsGpZqyhUMTydBpR9pDub8nM24AxfjGrFMlfzmRROofYkk4Az9DTdqtZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dztOt5vL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71091606A321
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dztOt5vL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE1D1F0089F;
	Wed, 11 Nov 2026 00:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356757;
	bh=Sl4b3EWxBDK4omBSZONaFHPAyFO7aeNS71Yx9T8CDpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dztOt5vLOPm9yoTbWL1AjftCRoLPUNDMA3GRncxJds+q82h9H6442FWKM1Y8l7W2Z
	 WJ/FBhQYgjX3+b9ZzhOT0Yy+hFyse0UrUaRkO8aI6zr/Y1izTmM6HNsuQWts3W3yp5
	 Hu7gKxFl3NWBool6FB2zyWKKNF5n8rWZMm5ThdlqWIjbxgEhyBO0+nsafod6pyq195
	 St5nOuCOkPsAYzkuQ0UbbZD+JXakEZ3jIaTY6TQSUCJngu/dvNsqKL0OV4SXxCli10
	 Bkqtwqh/ic1Xzmq+A8tj0Of3+1mOhg0LqXIq8l0iF4TI/ItF3nqkrajWN+qtTEvQsa
	 sGvN/WoEDPKaA==
Message-ID: <sashiko-outbox-208018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] HID: Add hid-plugin framework for loadable
 plugin modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Zhang" <i@rong.moe>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261110-hid-haptic-kmod-v2-7-b835a067cb62@rong.moe>
References: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
 <20261110-hid-haptic-kmod-v2-7-b835a067cb62@rong.moe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:25:56 +0000
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
- [Low] HID: hid-plugin: missing Return section in hid_plugin_register()
  kernel-doc
--

commit ea30651fd5d31e4684e4f118c37b9199cf1158fc
Author: Rong Zhang <i@rong.moe>

HID: Add hid-plugin framework for loadable plugin modules

This commit introduces a hid-plugin framework that allows HID drivers to
request optional loadable or builtin plugin modules via RCU and module
reference counting.

Link: https://lore.kernel.org/linux-input/auypydfkhx2eg7vp764way4batdilzc35=
inqda3exwzs3tk3ff@oagat6g46zto/

> diff --git a/drivers/hid/hid-plugin.h b/drivers/hid/hid-plugin.h
> new file mode 100644
> index 0000000000000..4038325c51a08
> --- /dev/null
> +++ b/drivers/hid/hid-plugin.h

[ ... ]

> +/**
> + * hid_plugin_register() - Register an HID plugin.
> + * @id: Unique ID of @plugin
> + * @plugin: Pointer to the HID plugin
> + */
> +static __always_inline int hid_plugin_register(enum hid_plugin_id id, st=
ruct hid_plugin *plugin)
> +{
> +	BUILD_BUG_ON(!hid_plugin_enabled(id));
> +
> +	return __hid_plugin_register(id, plugin);
> +}

[Severity: Low]
The kernel-doc comment for hid_plugin_register() omits a Return: section,
which causes a kernel-doc warning when building with W=3D1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-hid-haptic=
-kmod-v2-0-b835a067cb62@rong.moe?part=3D7

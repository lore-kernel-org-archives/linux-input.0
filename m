Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AD23B6BF3;
	Tue, 21 Jul 2026 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784633201; cv=none; b=Ar3+5yE5x0Uq8orfoUHuzowDSZypi8ZhBLYtcA8ZRbOHeSKuOGAlGXafnC5V4H7939Hy6LAE+U5xMc8dzmhKOwrH6pRp5VJEnJgh8QV23ihaCKTxLJ9azluC9glv6bOXpyhb1in1e600UqzHrlGToSGaes9dD9Cr3rFA7+gM2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784633201; c=relaxed/simple;
	bh=sVFotNKdXV9E8CP3Dd8WzTxJjtl67ELB/7oIgyMSQrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bf0hIajT5U5rTeIkstHSryD2g6Ybz7JM9dXOxfwgn9FrY2RfCynEAokPzeyUc7Gn7p82PpamQzNZah9ZHIk4PMDW/vqr2FXF4SpnMzpKncWed5TAjSlLQurLB3XRmIV2JOlRifBrlQ3TtERTypG2aKuN+rt0Ru65T7IMB0FaIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEyWpv1r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEyWpv1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773E01F00A3A;
	Tue, 21 Jul 2026 11:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784633197;
	bh=sVFotNKdXV9E8CP3Dd8WzTxJjtl67ELB/7oIgyMSQrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MEyWpv1rSP9JJJpmhNWSioHJRx0ySIYkjsI/p/0UHd0qWGGt2AlCgkpPrYvaAuBye
	 VkRXgAIacSZIz6EcZw87oYURQ/aSNg+O2kgvuQai32AZlHz6Nkl5ZMM2D2eFwa3YM7
	 lmkqjBVRAdPEgFS8maZtCKBavNnkzpHs9qsNePTIeBJoueC2bxM59+QAhd7K0jRqSd
	 LYXKgpwg4nN2QQU6MegfCrw7LLV8q2JPQPlUNOz/Ky076XcyzohDAFOV/gAHoy9Vec
	 KdYbCN8CjLz3U0UjwMl65comxHuoXDsnqd6xG3XdIKwMrpIoWEJNYcaA/OvRHet3G1
	 WjuNBh1EzH9Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] ARM: dts: Rename the TPS65217 regulator nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, lee@kernel.org
In-Reply-To: <20260721112133.70382-3-egbostina@gmail.com>
References: <20260721112133.70382-1-egbostina@gmail.com>
 <20260721112133.70382-3-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:26:36 +0000
Message-Id: <20260721112636.773E01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> The TPS65217 regulator nodes are named regulator@0 to regulator@6 and
> rely on the deprecated 'regulator-compatible' property to be matched
> against the driver, which looks for "dcdc1" to "ldo4".
>=20
> Documentation/devicetree/bindings/regulator/tps65217.txt states the
> regulators must be named dcdc[1-3] and ldo[1-4].
>=20
> Rename the nodes accordingly and drop 'regulator-compatible' along with
> the unit addresses it made necessary.
>=20
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721112133.7038=
2-1-egbostina@gmail.com?part=3D2


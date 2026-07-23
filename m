Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C643744D;
	Thu, 23 Jul 2026 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801787; cv=none; b=Q/VQys86LyuxQH8Xq4HRvJVInK9FgzNUthzUf+KUl54Hga7sUl1rpn6oLKeSDjjYxF+HI29CsA3nFxWnbS942vM4dt+LXBthkwifZh1J+btqpFpdJ40YAyFaDXtnnvDsZCmJBh2r4Z4oNZwgKidc6jW/H4rejg8zbXZ6SbHWHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801787; c=relaxed/simple;
	bh=2AQHtmH++ujNKbkQiRN7j62h7+OBOvExh3JqXe+5XPQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qz6mCFJaHJ+uF/a0aCzSqtk8mf9IXftUMvO6IAJlsOdMP3VfqDKA2CzN+wU0JFsZLCPWAUhwWzZkl7V/qNc1fltYKYnff7ZLeVZslV8IqAHK0wOiusB1+sB13Q1onx73gc2O/0HFu5jgIPb9dBZtnM3n7rYnBOJtBt9hjbtjCK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHTZYqAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHTZYqAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C34E1F000E9;
	Thu, 23 Jul 2026 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784801786;
	bh=2AQHtmH++ujNKbkQiRN7j62h7+OBOvExh3JqXe+5XPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KHTZYqAVAvt67PSRMHBMDYH8ipyCy6lgzElu2e0FiJh6jB71mwZGMR+V0hU7QrxhA
	 BISJWx2p4rB6gXSbN1vDUwyfbD4ckv0KaYHnUpDyICq4hakTPL/L0Dnxjnf5zJsaIF
	 fT3kQOlSZaXLf2t2e7xF085QhI56vjaGh7EOd+YHIsETQ9oLrjAlMJbbLaLlW3w2G2
	 F37SsNficKBJlfMh2MLR1Nv5gZmjrIqnUZ++7Ir5L03n+L8WGtK8bfyzn6O8ZsLTzx
	 acuV1ZC9Ip2WPHk/yG9LaeZ92I3VyZ8eOFWTQDkQohEdzPTCgQ0l5k5YEvNzPsLMAX
	 SX41MIciNZVOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] ARM: dts: Rename the TPS65217 regulator nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org, conor+dt@kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260723100605.628882-3-egbostina@gmail.com>
References: <20260723100605.628882-1-egbostina@gmail.com>
 <20260723100605.628882-3-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:16:24 +0000
Message-Id: <20260723101625.7C34E1F000E9@smtp.kernel.org>
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
> regulators must be named after their hardware counterparts, dcdc[1-3]
> and ldo[1-4].
>=20
> Rename the nodes accordingly and drop 'regulator-compatible' along with
> the unit addresses it made necessary.
>=20
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723100605.6288=
82-1-egbostina@gmail.com?part=3D2


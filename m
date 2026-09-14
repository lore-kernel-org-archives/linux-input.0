Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFE73BE16E;
	Mon, 14 Sep 2026 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429444; cv=none; b=gRuUiCqcQ8dWmbvvU3HMDyzwmhJ5Qrk+E9+yjzIuEkrv2BF/W2Ms8/95VVlVEhK1bGQ0SVIy0+Qr3lutzuW6Skfh92s4qzRVJvtJTjd/9k+OJBt+8vO+2srJBpK2q1G6D4NuFIylT/zVcngS0k0+EYkFFsbRCOTm/7e5pARYOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429444; c=relaxed/simple;
	bh=0v3rh1uZWfsrU06EObL41v0iKwdjYkGRm2w6iLLOcCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gOrcnrDtDhn/Sig08OdVV310Abu3R9PYu5rm594l/WnwiMHdLE5ajsptWX3+WLsxssZRsisGp5LVf0+4IA1T0iLUgo246khirkmeaGpX6q3Ci7+Ke2SKe00bhsrBAaIGgkRl+6lqeLGXy8KEEt3f067X4RH7S4Nwt+V+yRf1XZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAsrDghi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAsrDghi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504951F000FF;
	Mon, 14 Sep 2026 23:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429442;
	bh=0v3rh1uZWfsrU06EObL41v0iKwdjYkGRm2w6iLLOcCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DAsrDghiGzdxa6K4qs3cu4vllbJDvIydjm1/wVvtUQllY7I8Ps7iJjTGqy4UGXrkN
	 NjQTWC9cad2wncUGV9clKdqcxf/Hc4WgWCKumyJ9xiogEhNdKVCuol/nNdrcPdNgfk
	 cqft8mG30kqlrjViUn0tM/xRlZTh9+cHHZttX1d6vpHEuQLx5g5TXa3QOelty0ByIi
	 vtO1LvcgKWpkM804M/BuURKAHeGUwoGcojUQdl8PfgcU5xf2HfHpn16OJSytQv3VPN
	 +m3FylRuJYX3HlMVeUmGoD5IdkdhK6NXIz4/4mSaHvDo+lBIrF3o77COp+sXkLZrgq
	 BcahN9d3DPOQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] hwmon: (aquacomputer_d5next) Avoid truncating
 scaled sensor readings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vas Zayarskiy" <contact@vasily.cc>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20260914233728.22725-3-contact@vasily.cc>
References: <20260914233728.22725-1-contact@vasily.cc>
 <20260914233728.22725-3-contact@vasily.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:44:01 +0000
Message-Id: <20260914234402.504951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> High Flow Next power is reported in watts. Multiplying the 16-bit value
> by one million can overflow both the signed intermediate and the u32
> cache. Store power in long, perform the conversion in u64, and clamp to
> LONG_MAX. The other existing power conversions fit in a signed 32-bit
> value. Return ENODATA for unavailable power instead of exposing the
> stored error as a reading.
>=20
> Widen the shared current cache to u32. The Aquastream XT calibration can
> exceed 65535 mA; clamp its negative calibration results to zero before
> assigning to the unsigned cache. This also permits devices with scaled
> aggregate currents to store milliamperes directly.
>=20
> Assisted-by: LLM sparse
> Signed-off-by: Vas Zayarskiy <contact@vasily.cc>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914233728.2272=
5-1-contact@vasily.cc?part=3D2


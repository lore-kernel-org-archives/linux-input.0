Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265B33C1D53;
	Mon, 14 Sep 2026 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429971; cv=none; b=S2s4lu5sdsSfwppxsbjgKHeXH9uzTa9/hPAcQ+nvm+GNwc5gOi0wacewVyFYIy+icpvcrJF0HWM6oq5xCKfHJATF0U4Q58i7iPfBfYP1loCfbA/J2c4E+DHl6mpxE5Wmz9OCid9HJMNLNsoQ8NvPIKnJaBA3uVXn8cDKXBtzfzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429971; c=relaxed/simple;
	bh=PxFvqgNG/XWUYeAGck/+1CY9ff684gqWfryDNDedoxQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F7Vhy3HXnpd/j6jSJfv2MuRCqhpw9/5fNMTj1Vo7UDhRiNrpcr3w1iuexglDoqqEGyAknFbEfijjVqmJT9jYVYQgKopVpEYoIB4cYoEAc9CgOpm7lt7EVtdnNaaZ7n0UIERXAXrFvIP0T31bb0oR7sgCFRcRlIBP5yP5+9FIhuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNf6gtDx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNf6gtDx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27171F000FF;
	Mon, 14 Sep 2026 23:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429969;
	bh=PxFvqgNG/XWUYeAGck/+1CY9ff684gqWfryDNDedoxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jNf6gtDxNFgl0IIM7mdYQWy4W35WGZB5xPqG7iiMBMtKTaVG3uKPWG3wR9Yir29vs
	 LPh3DB6XqXF488ROz0+p6EUR8Bn3zhB47E+sB7ZTfyNx7s8eu7PZ6qG+oUEVRulnP2
	 CL4fvPIX6fl9wjqGyo3ysmiIXa0aDLjntnaByj/TzV4QJ6ws4J2Z2r6QV6/21ocm/I
	 cIEA9MbLYiCL6IpdsMtkRcbAd7iHvuJBFYwioGC5rkKhhApuXVVIjFRTI0NEu7AVSM
	 pIKf6NAgkNx8eriAebvI52OM0u7bErdzlPnOZlUVk5Ubt+IKJRshrR8PZ3jV3Cjkw/
	 5zMTjnGicRwMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] hwmon: (aquacomputer_d5next) Expire the initial
 sensor cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vas Zayarskiy" <contact@vasily.cc>
Cc: linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260914233728.22725-4-contact@vasily.cc>
References: <20260914233728.22725-1-contact@vasily.cc>
 <20260914233728.22725-4-contact@vasily.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:52:49 +0000
Message-Id: <20260914235249.A27171F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> The initial update timestamp makes the cache expire at the current
> jiffy. Since aqc_read() uses time_after(), a read in that same jiffy can
> expose zero-initialized data or skip the first legacy report request.
>=20
> Initialize the timestamp one tick earlier so the cache starts expired
> for every supported device.
>=20
> Assisted-by: LLM sparse
> Signed-off-by: Vas Zayarskiy <contact@vasily.cc>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914233728.2272=
5-1-contact@vasily.cc?part=3D3


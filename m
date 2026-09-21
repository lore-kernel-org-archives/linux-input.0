Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507B4F68A4;
	Mon, 21 Sep 2026 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014924; cv=none; b=DAlK2mml0nk++FwRPsYw27pJAlaX3NQp5ucw2VYT8ovaP2rLIYxLVx24xOl6m4juQ+drb1j7lZGfI/wDxh3A7t8HQLyWhBB+eSTxmGe2H7F9lMXdy9K9QHLEWXaxw/B1bdrwjZxuoi17KDiQjVQFZXQIamd0R62as5m1qzSea8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014924; c=relaxed/simple;
	bh=BzFzzH9wb1qfFQVPGQLgHolj3tumQOjpjc6bGa5E39c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p3eRlrOVnrPSDDPhv1pqwQc87nc9uqkSNzFL3KGuKvKx+l3EyMpAFtl/3rlr7OX18d78Wmedv3hZUxKkkUR9HuzcIktoIc+HF+zL5baA0LaHvTf770IZEGFYfePpObEa/ZKrFTTrnAbRRzxz+K6a7DySh7L6SV+5sR8LwSSIWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egUYGUDK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egUYGUDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8168F1F000FF;
	Mon, 21 Sep 2026 18:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790014923;
	bh=BzFzzH9wb1qfFQVPGQLgHolj3tumQOjpjc6bGa5E39c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=egUYGUDKEL4adWsIOp0cj08vSxmjki9tPxqsE3JuyBc+CrP4vmVBqYGl3j/Ciraer
	 i/0H+tyW6Xwvrmq3trgoGy+edgByue+ziOJosrsWTMjv0utBPtFlrnkwGEEOIY4EXi
	 nfygZCfxP8JEJWEgIvO1t2VWJToAPEwV2YxuV1YY+Jwqinbaya8+xBK1JgZubJB+vA
	 zdrVTFhx6Bev08SoDgfPE7lql8gudniEi4PelUv6IilzAo6rr6tRn8fNjtQ9/qpTnt
	 tW8iaCwMeB+WveXeG+ggatGBnMxe9BjaPK0e1i3QqOs8pGWumfRWDFpgwXgeWdSNnp
	 bsAf6cYtyj1Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com, robh@kernel.org, lee@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, linux-input@vger.kernel.org, mfd@lists.linux.dev
In-Reply-To: <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:22:02 +0000
Message-Id: <20260921182202.8168F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the compatible string for the SDHCI controller on the
> MSM8952 platform.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D5


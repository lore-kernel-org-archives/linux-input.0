Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF804511181;
	Wed, 16 Sep 2026 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568849; cv=none; b=TWZDq+nfGSillaxvHg2oDrFn7NPMshOVNdiQqtcf8UNzSjF5e0irq5ovgF+iBhILEKd+VrizP3WmT1Lk+8xOSNFtFKOZVB32ovQaFXKsg5SLJe70m1tnBqfyCRUdJbxeTsEE1loapG+Q+P9Le4A6oAng28P9vXykIXi/kRia83c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568849; c=relaxed/simple;
	bh=VgWgxD/Ryi0YERIij1GbIYj9gs+Qkza8E2sDyBNSAE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XPFVVQlvv1tnA5NRk1g0o08WO3Lg0rlxv+sGQWPIZUqA3wdfvZkrw07i+60tVue+2KlXZWCKNc3PZIRoLNAEgdERKDzRMqQ4kFiBSzFRAAXRJGFYJjKmjGetVtPkapClneWF1m+llkmbGBOLmC9Se6HWXubKj54BlUGelwPi6R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbrRMEXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbrRMEXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB01D1F000FF;
	Wed, 16 Sep 2026 14:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789568848;
	bh=VgWgxD/Ryi0YERIij1GbIYj9gs+Qkza8E2sDyBNSAE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VbrRMEXdakRTbOGi8PfA1B2WA9cQnTl8l3aUuT7Y9FDAb6QJyBsl6/0/ER0/WEyFM
	 soIe80934osQq8nWlzJpfJ7fr9PrhM3HvqXVgAP+BPAyMX7YhybnBDnZ/mWmux7DT0
	 OEmad8AKNQYQJya86030nBvf5TiL+sLx/E2YpkncyKoXRMqYgQqB7lKNRzWdhTusng
	 VOIb2l7iGrMD5t1n/H4aZQnImrW7UVGndzZAj9PDkM0+w0mq9Rve0eYgbjm/O44DYw
	 y0A9XQXYig3lEQBQKBVPTHtKc3ZTzRL6wBEX2mMfItU5dpSgbWyyFIX4WgH2mDcmxf
	 +XI1Rv1Jvu97Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, conor+dt@kernel.org, linux-clk@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-5-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-5-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:27:27 +0000
Message-Id: <20260916142727.CB01D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the compatible string for the SDHCI controller on the
> msm8952 platform.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D5


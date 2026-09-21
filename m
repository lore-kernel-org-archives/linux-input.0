Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498B343499F;
	Mon, 21 Sep 2026 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015121; cv=none; b=Zmmet3tjD/ggxHZTa/TTF1YpFB9go8UXiRJ1TlQBIT2myGEygtWRoXzr2rVAQfqwe8P5qeiitsndNSTCnIiQxANLjapMnpExI8Ou94MfIhz44s7tmCiJ26oc3Jl5okHuDz6fUANqfr05ENL0A+kRbV1+ka61lIl8MXjhppVjSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015121; c=relaxed/simple;
	bh=9VVnxWaPyzqRw93VtoDk0/scnPPESEg4PwBwUCD2/Vo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T0H7RDcV5nG3X7ZaIJynRFZ/KN1Ci4PaY8u4LyyUPs9Lk0i71QcTen3Hs/jt90312Hp5RX5Gk3puRqpPjSEB9BFQAV9b+EX4xlzIV3jdCjuGe8qSgqA/EoiibqbuLpmL9ARj5rkkjhejfZsXJBvkUv1nfuj4jF33H7Z8ZkhBeb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHt02Rqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHt02Rqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525FD1F000FF;
	Mon, 21 Sep 2026 18:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790015119;
	bh=9VVnxWaPyzqRw93VtoDk0/scnPPESEg4PwBwUCD2/Vo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHt02RqqcbTOWkNuarUBLENcfCgPUAZUVp3w1j//uR1vGaDnhDtLvcPAJSPEUZ1X9
	 i+1cjgtX8b9b39TrKkXkxBdtuH0bS9ClRImZZxU4V4ZK0vm0arCs88htWSyBmxhp9f
	 pm3aPkkJUtw3AnMKnlqt+nyG9vhdCTL4kY4eqX4/A7Q2E29BPXA/XcfVA8n53FKfS/
	 FeIioEP8zAgumnm9BNVD+X8o0ppExHSIfDqmNkuF8AjBmwv+d+b1rv6TVHvigtKpzc
	 PRkfbg/IM+IGnnG/WzeAojP9i7GBWoDcC0jqZ6r6dzVgE5+UQB2pGBUrq3IMnHH/92
	 SaXij5a+dUlMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/19] dt-bindings: mfd: qcom,tcsr: Add compatible
 for MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, lee@kernel.org, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, linux-clk@vger.kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-9-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-9-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:25:18 +0000
Message-Id: <20260921182519.525FD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the qcom,tcsr-msm8952 compatible.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D9


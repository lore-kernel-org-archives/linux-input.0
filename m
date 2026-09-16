Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014951E445;
	Wed, 16 Sep 2026 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568794; cv=none; b=tWn3aDMvSA7Ciw575S7IuyR+iQDhTNWkbPgMnl2pHLkAC+7kg7vy9tv2yf0Q3z6raG2R6rOUPRNMRXXSVndvm95iAgNjKpSsos87mggpsi5ecYCK9sdBhgC+aV1A5+kRuuLmFSU+Q7F0F00DlMceb+0m29qev/s2JRHvfAwn1Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568794; c=relaxed/simple;
	bh=G2diwEhhfbntTHq2imLXbTwmhACiPiz0HrIR7BPSfGo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KcqhK5YxWd3gPGPwVsXp8I9UbLSLTwFrHo6RLYZxySOsH4ewWaRrCFQFx4ePikR6RVpgigmbBZHL6wpVow3g+fTcKRRa6vLt0CztxwEzsDve5oCMG9DiBNUGIG9VklFVX3Kk4ny+V1iU5vfDXvRRpcwS4IJ2AGJzOp2KL715GVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRbWmF4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRbWmF4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838521F00899;
	Wed, 16 Sep 2026 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789568790;
	bh=G2diwEhhfbntTHq2imLXbTwmhACiPiz0HrIR7BPSfGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RRbWmF4pHhjcaJmP6mNLzHbrIoL5a59jwJaW1gxprKss9fSeCpYuUPSuank2mTuLx
	 IfRzxhiRkxkUcX2QAoKBbAhv8cKKC3yEXIwEgoF+aTupxM1+O4Z36Dbqr51XbVLT6e
	 C4Sl4Ryq0HEpQ0xNW2m9YmHoC+1dP9viok93NAacoiC+etd7xXPHsV1YE2YLPRu4aM
	 7YbJI7SjTEtC6eAtnE4qDmgAlCyWD7sYNq7mfXWrDy3LOFm+m3H8SOxpMk37stat1Q
	 9zrC0GSyfStTtjhZpB2YDphiuFv/3hkKqDiRkyRhM2tEipJ0HmWVasMB7usZHaCWfC
	 o/SeZFcUJ/A8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/19] dt-bindings: mfd: qcom,tcsr: Add compatible
 for MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, mfd@lists.linux.dev, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, lee@kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-9-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-9-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:26:29 +0000
Message-Id: <20260916142629.838521F00899@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D9


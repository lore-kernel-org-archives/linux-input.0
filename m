Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1582519925;
	Wed, 16 Sep 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569082; cv=none; b=DScr/vPo6HV6do2Dld5kZZcdoVwgp3blNLWcjY/ivZD9QHCNDobv3VED8+FeYZoQyL1oZFV6K4LMX8yt7dpo2iw0KTOEI9p/PbdpSV57ZsPLBDP7laBibNxPZ2oMKhM8nRaBIAaienikM8dnbTvSEaO6qdVMXVpD5rb5OSjJt5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569082; c=relaxed/simple;
	bh=vinY7j095+XFfKjnUcfcd2zFXlIrEQyC5ZueZLN7QS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BEA9KrHGhb3sLgxdP2pW2ivNH+y4w4Bd8kY67jjtSa1odrayZIJmVGg7z8ZpROgsHZLQ3AdaoSl9e0AnGw53uvA2o1PydwLjnMJFHV8N0ENksQgp11q1WquDkBeUsoQbtybuUEIvNNHHCGMWP+l0Q6gMLHS2JpxTY06Pd8UmhPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2JaJPNL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2JaJPNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857711F00893;
	Wed, 16 Sep 2026 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569080;
	bh=vinY7j095+XFfKjnUcfcd2zFXlIrEQyC5ZueZLN7QS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n2JaJPNLr/e10MpQOWQRQMe62vGd3KINGVcg4M2MtAmONCMVKtUCU+G0BNrWody5M
	 XSpyYcGk0g0dUoC2WL6v6Zm3zxMB3e5d1c6wAGheGY3Xdyc2x6VhD3K5zXTErg9TYb
	 JA2xa3h4pYNU5DuQ1tk+1/1IhYLXIKeqFyTYhh5OSP6+Cg9pApb+ot0vWT2fRXXCrO
	 zPr9qQjBmhYR/QA2t6yYSl1eASUWhF6FejJZL4+8t/qfrlCzHNF8EcYmFbAHTlSOzU
	 5g5qC0cf+REtjiFFNZSbtu4vW5LeZ+Clby6+vErCup4vw/LWzapHZyt1PkCAI2Ng2J
	 3UaJQ7LjoZj3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/19] dt-bindings: clock: qcom: Add MSM8952 global
 clock controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-clk@vger.kernel.org, robh@kernel.org, lee@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com, mfd@lists.linux.dev, linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-1-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-1-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:31:19 +0000
Message-Id: <20260916143119.857711F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Add a device tree binding to describe clocks, resets and power domains
> provided by the global clock controller on MSM8952 SoC.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12ED51FCBE;
	Wed, 16 Sep 2026 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568833; cv=none; b=ipTb8yjNEa1z+RX6bETAJaG9KA/HqthTDpFMzc8Nv8tqGmgaKVQGWJqZCqirHdTP79rsAc8YuebAhnlbzk8mrRpYZZivVCQgG58rmim97oDr0H0kcoiCPIoif2DnDLQH+U5FSckIKfRdnexqbmaewiCZmhLO4MmbHgevVy3IQY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568833; c=relaxed/simple;
	bh=eFwzOxf+cncUKdIQUWKHRxFXQ0Kn/v8AGmd6pRlnur4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IPHz4eRK1knzgcKY6xdiR8gE3DhtlH+lg7JzH4uiXjtGm1320jacjse+lbG1783TFkE+xvsQiloNbNeIfqjPiqh7gsPWRnvuqXxK8lJELKIzwN1qkVP4TfO75tI7aL9QzLOH3OHtXQxpREDN1yyv4dWMgQpXYNNUIIlgknOItrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY8EcLqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY8EcLqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CF31F000FF;
	Wed, 16 Sep 2026 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789568832;
	bh=eFwzOxf+cncUKdIQUWKHRxFXQ0Kn/v8AGmd6pRlnur4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AY8EcLqgKoNCNw0EHhUlkDDWraf/YrOMsCqG6PpEKMvFU7cgJYOOjZubQ0iGbrGt1
	 VdU0sPThTULNivgOu/CqpCIIj/Im9zVMzRCCXVbESkBFO1W8ewD345GvAJ2jZgfGsT
	 rPkqdnW3l0TWO3RyzvtnU/TNsR1W60FTspo0nnpC3W0mIajHMF1gCdzzjtm6q80TJX
	 05OXeRYRJ8qIBpeHZtSY7VS2Uf+zxBCbOMtbCoGmd0dRnFIyqLGDxDOi5sac7Z0Rzy
	 rLvSWbem0DVXcuu+oAvf9WCgTJvALd5L5Dwin4G8heeMbgia2YPEcDkPojUtJbro8W
	 vI/8F4vDfY9iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/19] dt-bindings: nvmem: Add compatible for MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: lee@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, robh@kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-3-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-3-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:27:11 +0000
Message-Id: <20260916142711.B7CF31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the QFPROM block found on MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D3


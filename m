Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB287423EB9;
	Sat, 12 Sep 2026 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202856; cv=none; b=Rx+Q4Flh3K/rHzyezzlSJt4Vzvo/j86iyFNuojlyuVxzcE1tUfc8O38dnfXCZYO1cKYZLFY8mCerZ93actfRLlCTV1IdiscTil3dLV1qrgfyo+0KOOGtl6rFwkTuqnUvdxqfh7dq9qbAhqCUfdTruDu9lU/DF7vNJWosic4vg7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202856; c=relaxed/simple;
	bh=8Vy94n9WwOHWb2dNmZDjMBQp4y4nlxN2R5dyHYszS6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m12TegJf9cVmt0NOJZFJ3JKirqHYSAln+Y08BY+wMD93VK5ZasUDEoAiKGIj0cN+mJ9XGiGAaUCieH0mblirOgs512v6wlbPx04d5MLD9sCbwBjVP3JxpiHBovmM7spcBfqG5tkuiUviVZsxxbME1UDqOR1NULr00No4EStNSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koamoVVC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koamoVVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED371F000FF;
	Sat, 12 Sep 2026 08:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202855;
	bh=8Vy94n9WwOHWb2dNmZDjMBQp4y4nlxN2R5dyHYszS6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=koamoVVCjUx4KW2l08ly9n32D+FmGqd/1F3CuAY7osoX49luiEzmcrDiLDhVGjRZ6
	 t/ma9nicqHXPEb3exS+wwwwIeCiZRAhk1uzz30C3sIhVwSbuP63g0Kvz1EcW1ea0p6
	 1giVWfMSpTvqPKOwE4ROVxdDizW9KqgV9LBUYXdfncjPNBGi6TNqoCt+yQ65M0OL3z
	 /Av2QYvlN3fm0Bbz1/+eTfYMUmGSRa5TLZfp0DSx8V7SEVNlNNMo+LvoNX3JzE3b3P
	 O3JLAix7XIb1XAiDBO5k1nJeVX6vUuqE5IIFUI+pSlKEjkWf6cRRWteBD3pKo4YW8m
	 ZCYwRBAO1pMGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/20] dt-bindings: display/msm: qcom, mdp5: Add
 MSM8952 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com, mfd@lists.linux.dev
In-Reply-To: <20260912-msm8952-initial-support-v1-10-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-10-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:47:34 +0000
Message-Id: <20260912084735.2ED371F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Add the compatible for the MDP5 found on MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D10


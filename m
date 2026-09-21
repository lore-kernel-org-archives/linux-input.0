Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BF14F55C7;
	Mon, 21 Sep 2026 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015100; cv=none; b=DfsZC6H0jDUcrhVFTo6d+2IFglamkIEqd5J08cH8UXv++YFCWHWkqiQDdN2Ya/BKhCmzB5DGR7wb26ccUYgzol1m0IwdHirQdkrfXt/Y2x1YbhtGidL7tTSIDuPjCbxLWdwUbipQuldByCtQfzlmQLKuThca7p7C7WlY6UkhxtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015100; c=relaxed/simple;
	bh=is3FgDq+8e7aC+cKPj/HZa7V8OPw8lsHhUUPFx4UDq8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eIRI2nQad5TirzPgy4QZgVL7x/v+g398M0t3ZZ2zIYPUAUWB4pZJWYlTDagQFrxOC0+nh/TyJTC/ChdO0xKmVekDNhQ5OtsRDX9Iw8TmDIkcCce0gARDPhJwPH/ToWTKKgxStpmSqAXABVIxgcMVULBEnJmj1EQhr65MaryS+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5cXZWnF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5cXZWnF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D6B1F000FF;
	Mon, 21 Sep 2026 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790015098;
	bh=is3FgDq+8e7aC+cKPj/HZa7V8OPw8lsHhUUPFx4UDq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P5cXZWnF328l2Kj2hdJfudnvWmbk95XjTVg/wvCr4c+/weJInd2aD0PCqaQiMFx3C
	 xR/Cj6QDWFpWCtM8tEZS7e1ySPVQRQjh6JujrlsQslCKB1uxs9wVCHtDZmVBhBk3gN
	 mRl7zjWycZiEzi2nWiu/3Sl/BpZ6Dm6c0U/R+1RY7ZGnwGgxi9JJcD5jYPl5+hPDr7
	 zttuaw2lR2h3RGl7rDovfPsYwSuKnZtCjHPjB5gLqRT8hqbZvRgWXniWQ4+ltAr6UN
	 WNO7PNy9ggTKdYYZdKft9ARVTuOxrLwVtB6gg5b98aGQXi0+0NlP16Xfd/OFkAE5Va
	 ZXvEO7UvtJCtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/19] dt-bindings: display/msm: qcom, mdp5: Add
 MSM8952 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260921-msm8952-initial-support-v3-10-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-10-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:24:57 +0000
Message-Id: <20260921182458.31D6B1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D10


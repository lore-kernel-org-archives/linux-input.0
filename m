Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD962511E69;
	Wed, 16 Sep 2026 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568827; cv=none; b=aqrQ3hRjlUuCM+zeKf98vya+/WJob+NjnvENwTwDkgUSyfPwQi7GZGh2FUFO4hNcK4yCeieqmHyYyu9Dn4Jg9k7DT0pz38hYVg5Km8yb3r5/v0oRtHPbcR0oyTuvBf2NTuVnkXqv0XOP43jeAnB9bXdIqDFXQqo6F6IcUvWfG9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568827; c=relaxed/simple;
	bh=oqGl7Y9RJHRAQQrs3tHgPs5iDdohv0EUAEwLeFc3c8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dnhvpI/v6GXAJJTDa+GsB8Go1sQy2Lw4MmgmxtoF6Yjr53m3pjqN4nB+VJy/dIQB3LKLzsfIlgtimb8Vh9IISHLbfwsRj5Jq5gl1HWWxAwu1uGVlJY2qtejf4pj3BpMtppD0QMnOnhsYGtukPCWLZfKb3758Rtn4JuzNrDLeHhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvhq7k+Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvhq7k+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31A71F000FF;
	Wed, 16 Sep 2026 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789568826;
	bh=oqGl7Y9RJHRAQQrs3tHgPs5iDdohv0EUAEwLeFc3c8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kvhq7k+Ztt7uDRWy936I4MxeoNiPZcAr2oagrOYLjIXm5uf2ia8oV83u5VpyVcN9Z
	 yMR7n2NnZgdhQGOmZAtYqDEgwHtjSayWBtppUOxTroVZDdsOFKS4lJGeiUtgFBndwe
	 RwhVcgopH90xW4WUXSLbQMrrW5GpZPxzoM+lmz+DGCHkN0u4K2u+9KE1fQMndG4+qs
	 Z9aaMziflIHb7VSOgYkvwEDiANm56tkPbZVVeIPI/yhL5xBGmQ7wbRz7xuCd6Z7C1Z
	 fNzYsei7wKSvpwgpxZzMaR6PDsK5SZGQmJ17TlgKYF+PMs9mEQMstZnQeJxHH1OLcb
	 2njCWpWjLxXwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/19] soc: qcom: ubwc: Add UBWC config for MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: lee@kernel.org, mfd@lists.linux.dev, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-14-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-14-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:27:05 +0000
Message-Id: <20260916142705.A31A71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
>=20
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D14


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67481443E2C;
	Thu, 20 Aug 2026 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229609; cv=none; b=XNHKuAuGwPqvXneWOgVTQhQGlULH0axvoSJyIK/PBMs1ktu6fnqNlk5LhakM9jDEhzLD4FGS23HJ+rcbH0ZNaKukImfZzarq86vV/EszwFKoTuQ5zDzp9HJWIlD0hDh/5puYzPU1yKxng3bI6EpES1zZM8ZieJ0CbU+E0lp8Seg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229609; c=relaxed/simple;
	bh=kasZidRnn7dykMtgeKL8U5ZSomZt4pyfILAjSqAwP9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BzOpMepRK0BFzkasBlorTLHBJCcPSDaEgtHdZIWEiw5vbrGM9KZtQc0Ufiw2Eig/AWA773WlHag/bYXAgvWB/sxK1X6xL1xicjmlnO/e85LV8Smsol7pFMLKv8yCuP544C/T0+wuyngJo9+Xbp0+vjjwAxLkSUN/fUxLECI1hhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+aumGEv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+aumGEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A365F1F000E9;
	Thu, 20 Aug 2026 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787229608;
	bh=kasZidRnn7dykMtgeKL8U5ZSomZt4pyfILAjSqAwP9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K+aumGEvYDqUmq3BxxLfTVaeGzdpfwupmjSEP8BjkxmAhYlGhfydOWH9CT6PSiwg5
	 3+a0ae9hs5F5cPhnQqDSQ7/3doRVJYaGYnk47nALV4uj2QmP4vSmXq9b8O3q4ztsqQ
	 H7DhephO4tP9RBN3w4JTW+NMfdkHQZAjdLFn3/xK9yJUq31yl00bVO4qpEFBY55Jd4
	 K4Ij82H9Ijs1Rk9eKvAo8OJ0ZkhYff5MnOo+3hunAqO19hivZQ9MtyjOt2cFC4asHS
	 GcRznBEL8vSSD1o1Roq/dOaBAR0TCWZl2sZNTUH1FK+KCNSlguoN4B2ki3jc/Iv3LG
	 OOsulkuMIEEmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: lee@kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, mfd@lists.linux.dev
In-Reply-To: <20260820122242.120039-2-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
 <20260820122242.120039-2-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 12:40:07 +0000
Message-Id: <20260820124007.A365F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Describe the MT6392 PMIC and its RTC and regulator devices. This device
> is mostly based on MT6323 with some similarities to MT6397 and is usually
> found on boards using the MT8516/MT8167 SoC.
>=20
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820122242.1200=
39-1-l.scorcia@gmail.com?part=3D1


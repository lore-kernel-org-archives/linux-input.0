Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FACC52ED51;
	Wed, 16 Sep 2026 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569092; cv=none; b=SqgFd4tCSiPk1OzbsLIwcEfPoWXdwrNTA1iFIqvQTioUqPLKgevwsFcwgMZNowJ8W4fq3UmpLh6uROOMxuShFPskyd78kEGqmxST/MNEwGbjirZoBUGimPLYs3S/zSExandcgbh9eOY04CdCTKz1/tYUXPXv2RQeHR9TBqrMPi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569092; c=relaxed/simple;
	bh=QziSslsWsBG40yrzelNbceDEATCdWN2Iwkt7b7xhN5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t9hTXTqZDIRznzExWhz7Js//yiZu1fVxXwWeFAp3Iqym7TswZwwRKCE4wwimGP0iq40ImBhUxwrXI5gWth+598fHW5uVeDO62d2pm+IEtFwxOSP/U/cpHXtDmafLc7I9vtx3zmIfIkA+PaeC6CjZMWYhJlhFsnFxm2cKJN6emDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfjsBf4Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfjsBf4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958041F000FF;
	Wed, 16 Sep 2026 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569091;
	bh=QziSslsWsBG40yrzelNbceDEATCdWN2Iwkt7b7xhN5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mfjsBf4ZFrpejdigNxvebcphZ4Yc4p0T9Fp2FBW9cAiS9g5zGFMCHlBFdLA3k6UpE
	 e+30Omqfd1HQLRnLeB7VaOsRjxT5vSZpfUKapuFpB5IRS06yY9bABLwdj7ULxXnxN8
	 Bu9N4qd/ifmW62h2f/sWLC3r8kxmKUiEAJz6rkGz6lCItaeox7VL1dZv+MwgP1CDS5
	 vFncoSAVHlSvKaM20Cs3vJY4upaKNjtYX/CmhcyAEmzgZRbjyMh/zKSlkp+ASGXw3i
	 yBey7F4x/gM3hZV01KmCQqKtpAwdI2OP13M3Jf3g6RIZ2d51BCpB+iUefHjf9vUEsD
	 mwjhLDsugGeXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/19] dt-bindings: thermal: tsens: Add MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, lee@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, conor+dt@kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-15-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-15-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:31:30 +0000
Message-Id: <20260916143130.958041F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Add compatible string for tsens block found in MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D15


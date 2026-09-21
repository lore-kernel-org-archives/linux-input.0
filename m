Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B44FC8C3;
	Mon, 21 Sep 2026 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014898; cv=none; b=ZDi6ojvEPAXCZoO6MDLnWQP7kCN5Rd5d+V7si9PZLG+YuZ2ZIALXcvhThBBSn18haMEevzDOsloHhkFbG+9Ya9fM0TsJrZlydOrz2X6yZYwaIlU1acQjBn4ws+89Xfevu3K1vcNG4nOKIxKaYw3/VZaTdt8L9VE99FDimyttdHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014898; c=relaxed/simple;
	bh=/godxLzqsZ6qnaUy/9kWZB8iyX6LFxBi0v0sV2WiCkI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fxApN/QF7K2fpFU8TdAghJTm4SoWSx12zcAabY/uBmihZmESmMxWjjadvuT5NLtAzDHye6hcaUcSOSe5tcy34jzjQyfZBmHWKozsvCN7Og6LCqwubirof72erYg8fzzIOYNMwqOvO71srccHNUbmYFsBfkIGEQFACo00zCpG9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCUj7Qyt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCUj7Qyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D521F00893;
	Mon, 21 Sep 2026 18:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790014897;
	bh=/godxLzqsZ6qnaUy/9kWZB8iyX6LFxBi0v0sV2WiCkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FCUj7Qyt+igw1RAsPqKzrinleLlh8lM9zrfmlZjYaRDdvEdgrQqsBmMl6F5L/a0dB
	 OQ281+2McTyci1EVh4AwklL3k4yL4J8f+he6rTTrQyiqf47FJdWdw3sWKWwvVv5nkS
	 BiiiygF7eskMPBmmGHLFFuI6Bi+Mti6AIAyhEuo/2rUdz7VAVAAEoF2GfRwczQupmG
	 UeDBqdRAgcLbbZ6cv2a7Zbwck59UgzxW7ClrNyYySRkliHSdTiIE+IX7t0MmVJ2c+d
	 b0hfMhaSjA8sbqHm08E3Kp1EDar0bL5Xn+pN7fP+Gq4GIhfHIfHGNcLNOS1QAaCiAN
	 i+SIdp1UcRv4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/19] dt-bindings: nvmem: Add compatible for MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org, lee@kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org, linux-clk@vger.kernel.org, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-msm8952-initial-support-v3-3-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-3-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:21:36 +0000
Message-Id: <20260921182136.64D521F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the QFPROM block found on MSM8952.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D3


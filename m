Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88318501290;
	Mon, 21 Sep 2026 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014967; cv=none; b=A+aTPr/XQMieTJ1HWwSbblbu+mQQ0TrYsAMYvhVLRa9qsrqQOhc28XQEGPnlkomssab4n0cVU8M8MGWYvJo+mTUo8ma3PSlPVILchEOgc5GJtQ3WfRGAVeE8cvMyA/70reG3uGLCYnn1iFpki66rRKqxOE3LX9J8fPZiUFZoG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014967; c=relaxed/simple;
	bh=B35YIX9QdqTbHk2SwYr9L+CKZWgkR2j2SfJyGsx5EWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oEsJ1KSVZKByk79yEYVYmq2LF5O9toHnxydEXeoOBq5fOuITslYpCl/l2KI7KMG1/bDCG2aSqqxOAKXRyrBFmJ8qm9qR01VzK4ONjSiE/a9gfWPcPTWdAlT7WhVCcpfp2iUK4ef49hQtYSLvA5wBSHBOWfKqa4k+4NR88Z2+hFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8Hu58oJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8Hu58oJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47C21F00893;
	Mon, 21 Sep 2026 18:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790014966;
	bh=B35YIX9QdqTbHk2SwYr9L+CKZWgkR2j2SfJyGsx5EWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8Hu58oJqm7c8oIH5Aup/KL5HkbUmPo1uhKV6yyUr7HnHJuZaweGvbWyVLJYaOvBs
	 tVzq8U9wTu6lLXeikP8tJZDT1hemWW8K7wJYp98zuqgm9OfUnSac+bAbSCanlaAOkI
	 TUcZcsW6KL++x4G7TWx9HA0loGUx0zu92j5Sz9/i5KMLiZC3xPxtq7MIi5I+bBHTNe
	 xfWfa7a1RmrEvcDHqXWirf4/TmzQckK6NLcvUeVWFgAe8Z9w999RtRRgCAjKOiS0Fb
	 pgjMKmBCbk8qBF9Yn1Th7lhSfH5DyP2v0Ppr55Sqj40qmAb2FsqkmVaH6FYEkT2O4K
	 UE7sm+zcFUthg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/19] dt-bindings: arm: qcom: Document MSM8952 SoC
 binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, lee@kernel.org, linux-clk@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-7-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-7-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:22:45 +0000
Message-Id: <20260921182245.C47C21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the MSM8952 and add General Mobile shamrock to it.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D7


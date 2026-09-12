Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270D41F5D5;
	Sat, 12 Sep 2026 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202559; cv=none; b=CYDjr8D+5GxlknRkErZxYRYx7koA+kMQBn43qNwI2gOHKS/XfabtvwYuUIH0pEU9DR3diaRhFC9XsbMXWOdR14lGXQV5YbGVlmHi1i9vzHsLu1Kb24yuO/s+tbO4GGd10PpG4B4Mp+jQY+ZV8PQqixHFxQXLssu/qRX11LhsJpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202559; c=relaxed/simple;
	bh=OF37lqCTggQhqObjLxJvaki9WQUPt/AeuzuVGIkE7uE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ls+PRk0rZMUzhx7TJhVxCTkX+nVg7EBDFT6V1SrxeQwJmNQ8yVnhi05aszU8aK33a3XLu9QMNiJehKSr+X5oKULK7SLxrfDoILNPMPBoWEbpj6lhYkMO4TMndsON3hPcxJAEWTfPG3avFC/2PqJtkXzJlZ+dbWHi7DDAzelInTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNrT4JEa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNrT4JEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC271F000FF;
	Sat, 12 Sep 2026 08:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202558;
	bh=OF37lqCTggQhqObjLxJvaki9WQUPt/AeuzuVGIkE7uE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JNrT4JEa6/FwOSCb/kQiSrMmdd2ANutT5km42EegVcV9YNBxuYGWei5rGiHzsZPu3
	 lZd2q1MVdCB21C+baUsXs/cV+H659YSHZBHnOLeR2lcJUl98IY7ouIYuiSnxsgmMd+
	 FfRHRsr6f1qInRbhq/8TRpE3W6XEOsZPUEXHTQQQjXZ68+V3QYs5nsbsJ6QG1FTiAB
	 bHIOrV6IRgVRsYRzmqYvR5Qc1XHjREan7JjSGwaq3R0SlTT7sYp8UKufluZomqvS+a
	 1MHtp7N7LIKpXKei6gWhSrogpjc1GjdrF1V/Eh/alsArAC7Q7ATyVmjQUuhlpigksS
	 7M8FtZMfGjssg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/20] dt-bindings: iommu: qcom,iommu: Add MSM8952
 IOMMU to SMMUv2 compatibles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: mfd@lists.linux.dev, linux-clk@vger.kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org, devicetree@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-8-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-8-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:42:37 +0000
Message-Id: <20260912084238.2FC271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Add MSM8952 compatible string with "qcom,msm-iommu-v2" as fallback
> for the MSM8952 IOMMU which is compatible with Qualcomm's secure
> fw "SMMU v2" implementation.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D8


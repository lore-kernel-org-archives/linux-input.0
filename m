Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11421400DF6;
	Sat, 12 Sep 2026 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202903; cv=none; b=CfVaUSxo4X8cM5lfRpX/0i78jdU/LOoJu27/Xj3QcJzNEaL3ZhcsIaI+NHaaW3c2mudHLUoRDWhs3EPKLERI/zSXCpmAz9hG/kYv1GBBKK2D63u94Q664o+u2Gw06zuc74blh41MCoBiFMyE+7DJ9wnlUNL9+A7mVSYLQxDsU7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202903; c=relaxed/simple;
	bh=Buc+viVam7kZEFCB1UuibokZEgQcX4yL0d5r0rhufyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EfddOfRKJ8xW7Ze9M4ey55hk+f0XXSA4SQysLQBsovb7glViVb0lxCSUmjCcFcvnhEdfCf5lE7FdezlK1TH9h7r59FrfnX79ukx3hgz11skTPJ/QIsbPD2rrIuzoHIxNXIV8kpGQWWytOy7ixiNONUCdpHRoZkW3EUDBfUR933w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmGMVF2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmGMVF2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AC81F000FF;
	Sat, 12 Sep 2026 08:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202901;
	bh=Buc+viVam7kZEFCB1UuibokZEgQcX4yL0d5r0rhufyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KmGMVF2uZhM7G5pzxWcj1+S8AdLEpop0TUM9kp+808duvvsBNWw2d63MX8M7/DT57
	 /2RYPqrNN6+Lfxm4hYTlKzTRyh9H27irUz07GUiDfxaW5gDPOy8zj6XSLqNFxkKNNQ
	 V7ysiSMP37C1zF6ZZ29xy02vrnF56ltPg1EZfjYIl7BolWALDDP/KBZn+Y/Ox/3QPO
	 ei0jtFkc5Gu3KInQSODxelar4y0of+8nE4GtfuHVJ3l/5ZmeeEe0RLTSK+EJeVMZfO
	 95JRLPf425rruQQ2tFpZ2WN/GGPl5zhPrkB+KbvwgyDC8YjOPwLfiHjLr8cT//4tvN
	 vku5uEBQVV65g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/20] dt-bindings: arm: qcom: Document MSM8952 SoC
 binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev, lee@kernel.org, linux-clk@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912-msm8952-initial-support-v1-7-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-7-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:48:20 +0000
Message-Id: <20260912084821.48AC81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Undocumented Side-Effects / Missing Commit Message Information
--

commit b2938fc599ccd3f200169a9387303de5b8f42abe
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

dt-bindings: arm: qcom: Document MSM8952 SoC binding

This commit documents the MSM8952 SoC binding and adds the General Mobile
shamrock to the list of compatible devices.

> dt-bindings: arm: qcom: Document MSM8952 SoC binding
>=20
> Document the MSM8952 and add General Mobile shamrock to it.

[Severity: Medium]
Does this commit message accurately reflect the changes in the patch?

The commit message explicitly claims only to document the MSM8952 and add
General Mobile shamrock to it. However, the patch introduces a 3500-line
clock controller driver and multiple unrelated dt-bindings (clock, mmc,
nvmem, power).

For example, the patch introduces the following probe function:

drivers/clk/qcom/gcc-msm8952.c:gcc_msm8952_probe()

It appears that this driver is not removed or re-split in subsequent patches
in the series.

Could the commit message be updated to reflect the full contents, or should
this patch be split to separate the clock driver and unrelated dt-bindings
for proper subsystem review?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D7

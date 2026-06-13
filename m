Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36282D7398
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389403; cv=none; b=ZVEHSglfIck44DhkKrnhbrGlv+beaEH+44OGq9NrRCYdx+Kl460ohJPkJj2V6GSqOBO1ulCYIy8V0y5+Lhc0I7RZzM2qs5W6Rv9wZmfRGjTGcxn+K+eWv6CDodVHYCWC9aoapGgQ7VOUTpS/vFJBHNNl0/9oUQopFjQu9aqk20I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389403; c=relaxed/simple;
	bh=Sm0tgm0GQ17IlhziLx/OPBOyA86AtMcdmHfgAgoRoDk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=soExhYcmoAoLxjlX41loI1NyS4y3zypPTJR9POphOXCbdaXPvRS3pLePVaogb9wHLOPBOEJuvWDW/64PQKmwZEVoG/eQaMc5FPzQdQBDvjmzGPUsPw0U1g6x7oM/5972omRYQGNrMjdSPA8Zjzg2keMsNEEtBcu/EV2GAqRGoes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSdevQkd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSdevQkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0471F000E9;
	Sat, 13 Jun 2026 22:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781389401;
	bh=Sm0tgm0GQ17IlhziLx/OPBOyA86AtMcdmHfgAgoRoDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NSdevQkdliwfFVmJBNMRDNN95Z8YazgB3xvj6sZxbGIXeAd+p02TPFoVN7MTwvFFC
	 40i3wntWJ7ASaLCVWlEvM3DiEihrLehph1ggIN0QHhZa9ffnIaK4Bb+jODjrkaqO/f
	 8jqOV7d1SBso3LcFt9lrXSrmmWEF0NOmV9aDq6ffKoD1X0lQ3y/mzisnmqEU0iJ5j9
	 QkHrW8tILb5SMKwjmepBm17tKxMZ4A4wYdmajGm14935VZQRbY0dIun7+s8MCkFEhm
	 9658nnS6srFrPBttKVfrDmZhy+2pojhTHSB/qIughNcYFk1eQ3BkD1Upu+5A/Fp8ww
	 hsKviW7fUQbhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - correct CONFIG_RMI4_F34 macro
 name in comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ethan Nelson-Moore" <enelsonmoore@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260613222105.101418-1-enelsonmoore@gmail.com>
References: <20260613222105.101418-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 22:23:21 +0000
Message-Id: <20260613222321.BB0471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message contains a typo and repeats the same macro name =
twice when describing the change. It states that the comment 'incorrectly r=
efers to CONFIG_RMI4_F34 instead of CONFIG_RMI4_F34', whereas the actual co=
de diff shows the old macro name was 'CONFIG_RMI_F34'.
--

commit 0b9599ce581aac6de8ca3435e1928df9a8121100
Author: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Input: synaptics-rmi4 - correct CONFIG_RMI4_F34 macro name in comment

This commit fixes a typo in a preprocessor endif comment in the
synaptics-rmi4 driver, changing CONFIG_RMI_F34 to CONFIG_RMI4_F34.

> A comment in the synaptics-rmi4 driver incorrectly refers to
> CONFIG_RMI4_F34 instead of CONFIG_RMI4_F34. Correct it.

[Severity: Low]
This isn't a bug, but there is a typo in the commit message description.
It states the comment refers to CONFIG_RMI4_F34 instead of CONFIG_RMI4_F34,
repeating the same macro name twice. The actual code diff shows the old
macro name was CONFIG_RMI_F34.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613222105.1014=
18-1-enelsonmoore@gmail.com?part=3D1

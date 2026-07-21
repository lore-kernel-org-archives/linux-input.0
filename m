Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB647AF4B;
	Tue, 21 Jul 2026 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629229; cv=none; b=aroenodU254fYYevAZY2ex6bufE00l8EmCXJP26F0wES1RrFJNnXM2CgdjtBJX14XN5tBl7+RbdRibxCmtt/hqCYSGhmwuJgMzwc48YhRBeAJ4iqkKdpR/0CzxRbXjBEBkrvQYjzQid3lak0oem0+UYdeWEUJTHfR+MQmNlvLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629229; c=relaxed/simple;
	bh=zABv5SVKnVc43C7bfG3bzVfENvmmaY7u+VCbEYT+X5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IBEvMwaGMXkveBO4SghMo3b9zqBYSORUd6H1bPmTmH1PcI+K8LpzXFMz83MqZPxPtTakDia33Gj9IAvlm/Rrot4z/UbqNI6V/mEqSedcd6dwpOTz/NLUj2FxLoRq+2XxE0POmLz7smfpnTDVWw67QJgjjdyEq2H16OZpoMsubzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb+1sjK5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb+1sjK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115851F000E9;
	Tue, 21 Jul 2026 10:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629228;
	bh=zABv5SVKnVc43C7bfG3bzVfENvmmaY7u+VCbEYT+X5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fb+1sjK5tcSDq0Z4iRcMvouIwjTRh+aq+G4WIZ8pfgJQM2NgLgQ/1bKiyayE4NhPI
	 HWirQTsWl7RNzflPxtKiDcIgQuYMo33xHfBUf6KwnBbWfgURmh1a8eK49ASbw+ZL3s
	 6auZUaLAwvxCP1IJjXUlj1s6seUievQvg2ig/muHKhD8HVYtZi+V9cWDYJj30iJIfs
	 QRigVjAdri4c4HmKLKKJJ8/QThGRXl/++oKBj+zDPSslfk2u+mlqHMjFkxkO7iDWks
	 3XJiP/F9a+D3Ewc0x9jzaH60QS0a2UYp8NbmM/iqP39QcDjFkmKAcvn5Ttg3LwGhme
	 tDN3CX8WOJvPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/6] mfd: motorola-cpcap: add support for Mot CPCAP
 composition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: lee@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org
In-Reply-To: <20260721095654.429346-7-clamor95@gmail.com>
References: <20260721095654.429346-1-clamor95@gmail.com>
 <20260721095654.429346-7-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:20:27 +0000
Message-Id: <20260721102028.115851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message description is not capitalized, violating MFD su=
bsystem guidelines.
--

--- Patch [6]: [PATCH v7 6/6] mfd: motorola-cpcap: add support for Mot CPCA=
P composition ---
commit 8d174ab85721459a22732636e016f27b79a8d93b
Author: Svyatoslav Ryhel <clamor95@gmail.com>

mfd: motorola-cpcap: add support for Mot CPCAP composition

This commit adds an MFD subdevice composition used in Tegra20 based Mot
boards (Motorola Atrix 4G and Droid X2).

> mfd: motorola-cpcap: add support for Mot CPCAP composition

[Severity: Low]
This isn't a bug, but should the description after the subsystem prefix be
capitalized? The MFD subsystem guidelines mandate capitalizing the descript=
ion
after the prefix (e.g., "mfd: motorola-cpcap: Add support...").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721095654.4293=
46-1-clamor95@gmail.com?part=3D6

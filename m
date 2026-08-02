Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8937BE80
	for <linux-input@vger.kernel.org>; Sun,  2 Aug 2026 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785671893; cv=none; b=Qkal6NqMaYqB6cAxQBnRtVA/rzA6Xxr7MtsvCZH53fzaOWEcvJF5foj3kmPN3hnbGWzTEeueQliJ/R01qKInu7fZ6pxobzbeiY5l85tZPadDhpekkC8WPEyDUBuOfvAiwM0o1boC0Gh/8+BfQ6LVP/fhzrVdwSJ6k1CVoXuZ53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785671893; c=relaxed/simple;
	bh=kmmhxFcJG+0nT9oR2NXh6g+ejkbhbPKD4gVnTb5olrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NBvwq7D0GkZJhkPL1CWIKOkvKM6azoe6TSWG0og3JYECMQziBo9L5l/WpStnXmOaV0XjhJgjQEUMhbrIX853nAIb3XmfVQbY8fl04weKTfzCjSYdgzO16gXITa6Re3QsuCMDT9nl4Jb8/kLjv3ZDlXy+0wHDLfJI2lBMS88efiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tli0m2SF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tli0m2SF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18D01F000E9;
	Sun,  2 Aug 2026 11:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785671892;
	bh=tIgjzTsOGPH/yXxjVvpSrPrMd/ZvJx5iJUt7AMCJ1ng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tli0m2SFOE+KBLpLrUOWCf/Qa33uAA+DoI0qfNudgfDHOZiw5IAIa7lb/yBxqQIXz
	 4gD2SUeJCl8brHjbm7msYyrfsJ6PE6sVVn1DTiX9crsK2ifNUDm2EBXpLBLkmYDkCD
	 aiZ5oE+c03ysa1LkirQA/LGESchtErzxS5r2UD6gIRfJo8FGw1DstfhgpET/BWQpWa
	 KtNlCiMnifTuskMtz1Dz7DfOklYXSQ9vUT5pKo5dfGtwjQjnt365KQwwblSUcOmX+v
	 pLsurBk++XKDH/mMyY1g/1kfWTYM3e0s5gYeM3ovhECl0DAD7L/dhTCEI1iIjgGLqY
	 OC2WnkyPQ766Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] HID: logitech-hidpp: Add support for HID++
 Multi-Platform feature (0x4531)
Reply-To: sashiko-reviews@lists.linux.dev
To: DevExalt <exalt.dev.team@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260802115009.90840-1-exalt.dev.team@gmail.com>
References: <20260625080807.74157-1-exalt.dev.team@gmail.com>
 <20260802115009.90840-1-exalt.dev.team@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 11:58:11 +0000
Message-Id: <20260802115811.E18D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to add specific device IDs and remove =
quirks, but the patch does not modify any device ID tables or quirks file.
--

--- Patch [1]: [PATCH v6] HID: logitech-hidpp: Add support for HID++ Multi-=
Platform feature (0x4531) ---
commit 2283951914fe82c9f82d572a2c1e9090262e500b
Author: Baraa Atta (Dev Exalt) <exalt.dev.team@gmail.com>

HID: logitech-hidpp: Add support for HID++ Multi-Platform feature (0x4531)

Add support in the Logitech HID++ driver for the HID++ Multi-Platform
feature (0x4531), which enables HID++ devices to adjust their behavior
based on the host operating system.

> This patch:
>  * Adds device IDs for MX Keys S (046d) and Casa Keys (046d).

[Severity: Medium]
The commit message claims to add specific device IDs for MX Keys S and Casa
Keys, and the v6 changelog mentions removing them from hid-quirks.c, but the
patch diff does not modify any device ID tables or quirks files. Were these
changes accidentally dropped during a rebase or intended for a separate pat=
ch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802115009.9084=
0-1-exalt.dev.team@gmail.com?part=3D1

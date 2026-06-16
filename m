Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066B397338
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594504; cv=none; b=ZIMU6jp1tH4t3dB2dJC7in80V1Od3hHDnffkN+gfRvffxIMq4yJFn8NUjcSZraVxKpc8VZls80WE9PWMo6SiqRKy2UPzZajzF3a9zaqBGNLJwNb6ttAQoJk8Z/+q27RqlPQxm4QLw2UNvFWzg7qX2x9GlBfR2ivFkjybM1F0Ie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594504; c=relaxed/simple;
	bh=i6orrrLIIG/YJbo4xRckgIFTeN0WsVD3M+ijxIPWbdA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlqQerrXNchw7W04lbPTSdHVDC/gdf/Uq5fneIMVAKo32u0lxS4U9VnQSPijK6WoAfmGut4NCwRS+dYCfqEofceu9FpylcoklkexdQLmdBt4sxMOz3FobUrDs5/R20q7Jo/DW4yyW4/c8nWdwD/kUJRh1fkB3SIdOABD2WSc6w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KF9JiaR7; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KF9JiaR7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781594500; x=1781853700;
	bh=Fg0DS+RZu/Hij+QWp04WetPsioIHw42dTp5rSSz9Ao4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KF9JiaR7ptOfWoEWvCjU7VwnkDbzs9/ZVblK/0hI7vk85zZpEDngUAszlfz3B2lWA
	 d7NN589YgozrZychMiQ2T9bQ1K+so7+fOC/mPXQeKtnpbrIgzSxdBRQIgpd2How8E3
	 OBbsTdDWqkZXzqHUfHjU2eVyGr4XDKHbktswkMyc7AnEPtOvEy72qOHuPk36UXNO5s
	 OVWfO5mDT0a3bjbzVJOzDACWVjWO/xe/R0n1uXWQU2VsNdgUBfKXcUAHOpD+uxn2YP
	 G49/4M2oJwG10fqpKAoF2bZnZy67DYGoY5Te+eEqkNgqvfnqdgY7U37W335kxgL3Hk
	 4yMj4QLfrHEBg==
Date: Tue, 16 Jun 2026 07:21:37 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-input@vger.kernel.org, Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] Input: mms114 - replace BUG() and fix alignment
Message-ID: <20260616072133.158968-1-hexlabsecurity@proton.me>
In-Reply-To: <20260616050912.1531241-5-dmitry.torokhov@gmail.com>
References: <20260616050912.1531241-1-dmitry.torokhov@gmail.com> <20260616050912.1531241-5-dmitry.torokhov@gmail.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: c9c071771588f502fe42b686d89676934322cca4
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Replacing BUG() with WARN_ON() + return is the right call, and the rest of
the patch is fine.

One nit on the changelog though: this guard isn't reachable from userspace.
reg and len are always driver-internal constants -- there is no sysfs/debug=
fs/
ioctl that lets userspace pick a register, every __mms114_read_reg() call s=
ite
passes a fixed reg >=3D MMS114_INFORMATION (0x10), and the single MMS114_MO=
DE_CONTROL
read is short-circuited by the cache in mms114_read_reg() before it ever re=
aches
__mms114_read_reg(). So the condition only fires if a *future in-kernel cal=
ler*
requests a read that spans the write-only MODE_CONTROL register -- a driver=
-
internal invariant, not a userspace-triggered one.

Worth tightening the wording, since that distinction is exactly what justif=
ies
WARN_ON() here: a genuinely userspace-reachable WARN_ON() would itself be a
problem (log spam / panic_on_warn). Maybe something like:

  "Avoid taking the machine down with BUG() if a caller ever requests a rea=
d
   spanning the write-only MODE_CONTROL register; warn and return -EINVAL s=
o
   the driver can recover."

The code is good either way.

Thanks,
Bryam


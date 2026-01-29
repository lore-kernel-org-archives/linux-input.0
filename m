Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5AA2F6562
	for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769719238; cv=pass; b=HS8MOA4EbclisAP4YzuqBTyd0ZFVqnfF8mcxTh82cOsBzWiHXAT9IinjyvUhsUZXrV6mI3BBoqfr84SPpY8FiHFz9yKPUczVecpGGbF2QboAPve500K0dfFUOJGAFUYdvWY9vfxp6CwZI7WV0NS5LzPqBV08JoWuOqINPfe4Afg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769719238; c=relaxed/simple;
	bh=AFBAF5ZRO/Rz73vhBj5Gh1wf30cKosT8X+to77/aiis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMYrntzXU7Zg9H6Y2WPcKRZeyKOM4fvMOhgkqfQnrfftcz9AaCi8UrPlmqEEAj6IqBahb6/d1rFiLGoQZyQExNWMl8MtMSZCYXIbU2sXNMgqvpzmvatGMu4iYxjSteeu+1kavdre64i7w2WeP3lznZbd+IYrsVMQaGT/Ua5mNYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcnTwjLD; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcnTwjLD"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6611cab8ca3so822998eaf.3
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 12:40:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769719236; cv=none;
        d=google.com; s=arc-20240605;
        b=CbFHpxqGfHlbeTmrAV95S5qqHcNlupMdIMt5cTAEDO6r4BmzecGo5AgwxqmbVUIIoT
         2Kr1vwe2ZV2lckp1pn6FhgVZOGlvDyZdX6lKSqiZyN2y88TkbEgc9pivN5KAnpqohKUM
         9EUFd1VPQ7fJK9GBodKUGFiLoePBy6whIrt3La2v6Tn3oRP1uRjM3gP0Npy2gzAqRPI7
         V9+wGJ6IlToIdesYuf0K+iXIrV3Eyd1CPJTzveeOkRfgJw+sMwzW/nuvvfNJelTRqCr6
         u8pNTq/Pv5UJjyn+LkU0H7VJqDtPcxdmlgsut97c7ThkptlwJwN1jWlmbXbpgfAGobbM
         zyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AFBAF5ZRO/Rz73vhBj5Gh1wf30cKosT8X+to77/aiis=;
        fh=t1iCRrcvDhSO9vg/iZZLQ7sVT4Ksm84RrOzCuleveuk=;
        b=XcCtwY6UyTVbQNp4qOkW9gGsfwqoZgZlBNUXtSPe4SjpXJUNPCbGeafE6w1uJR0O+F
         2H2872IXbtN/c3CmAMqFvTiQVGsvpBT14Ve/hlxu9r+i2UBlUUwZFtqDlZnLZ2yYYNx8
         LcDT4gzBJqDzZDUS3SXBznHoL0GIG8iRs7wzMeK16rGw7jSsgbG+QC5Zt90jMQ9aa6Xh
         PAbDRc1S00pw22vRXpdA32coLls/U0arqSn8j1Ix9Eg9oFOyfyxUdK4II5Zxie6k0Rjm
         y1QdeSpxa7+bU9R1Fxme7pINROAlWuoYIIsZv6/s1LKjVxA9g6zqIAiayveDjzBakFlk
         UKiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769719236; x=1770324036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFBAF5ZRO/Rz73vhBj5Gh1wf30cKosT8X+to77/aiis=;
        b=CcnTwjLDzhc97SJIrUPVL2X6uTltR6v5++D+4QA+z+AaMaFr73GftMTgmXRe0NXhe2
         WrG/an8JSk/VsM/DO6zMBk1qWBUm+F2WD4rBz2ZmRpo3c/aHiX/6Po57d0GpQP10E+fM
         HhOw1xT62Abot4WKKawEJq7Gj8Z8WHwQ9Tyl6vuPJbqHN+kWfPY0Zt+C0Jz7Cl9LHPaB
         T2Rp+9Yy0kggZoxSajthugOO07yAe0qmoxKq/+lETGcbyM33f3DEP2NE8223Ng9yiHkP
         XoMsrGjE7KnRp8LHXZasgQ6UlUdE4hiN9846G6KiCP8I0VgnN2DrZ8Dpilmipio0cPmJ
         ZQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769719236; x=1770324036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AFBAF5ZRO/Rz73vhBj5Gh1wf30cKosT8X+to77/aiis=;
        b=WOtzU0qc6qpmC/p5KRnb1Zf/d7m02PtfkCTwd2Eh6flL1p6RLOX5FSayim7Pb166Y8
         OW0Sw4X1Ap38w9T7+KA4BHqXBDk50c/BJ+2qA67f4DAm9a8G4mKlB0LoRp6/E5d+lJCg
         ACOfJc88nD66QBib0M4If6P23hljJayjrZeoUQZH6+aY4uPevFOzI26iSC67a5jVh/R+
         DZliPatJ5MWPuyaMx5gL6w/cY7/4TRQTJtE2nVb5KPlisWiVBb/3RkbYkFgmY+UmVYsC
         7uzhNIsPgnCt/eShhIfx3s/K4RcS05LVupdK9xWvr+JFVj14mMh126R8qI/XvxBj1CfY
         nHqA==
X-Gm-Message-State: AOJu0YznOCncPNoYUnXffsppsPPFiS5cpQYgldXfbtOpX9G/b0tfggxV
	JYJKcFKK3DFAuY8xDAj0tuINU7Y+3HLnNFcSkL1tCOrAf5RN75G8Wbm5xbHEt99/WnhGZwRoZoL
	g/elzzfwGGCHyPm9/GOMDdmCrhqofrQ==
X-Gm-Gg: AZuq6aKmGaZmrkBUTGLULcaH12NGk7fztRvVG5VxiFqHrOPzcbcxw27wkSVWHHMBpzb
	+EBHTEtTEuAhDYZMgd7o4VN/Ozo91ql42vbc2P/683mwm4q45FXg/nrZKLDNU8qYgSUmZLUbcF/
	SDbRs73pDzsq/O5OdMuGRg4pXIl9xjAOvW/64qOz8MviJ7u1iFXU02Iy9ebrYqiQihItjcff/Ve
	aold+IEfDf/Ys7lDHvQ0j2rVvH7cF/vgRcFNqWLnoZgLlZbxrJo1zV/y8l/K4oCHO9pVAmTmdlb
	vWdEpIc=
X-Received: by 2002:a05:6820:3088:b0:662:e066:7396 with SMTP id
 006d021491bc7-6630f3cb958mr416693eaf.77.1769719235641; Thu, 29 Jan 2026
 12:40:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007203544.9963-1-kupper.benedek@gmail.com> <076s5qon-0o97-r3o4-10n0-s415q569sp40@xreary.bet>
In-Reply-To: <076s5qon-0o97-r3o4-10n0-s415q569sp40@xreary.bet>
From: Benedek Kupper <kupper.benedek@gmail.com>
Date: Thu, 29 Jan 2026 21:40:22 +0100
X-Gm-Features: AZwV_QjxEbOuE9lvVxyrnR5JxfE1Asl9eQTUEVi5Ib_3XwzoZd68fteLvpv_q2c
Message-ID: <CA+T7n9n43sne5L6N--zm5yhMxsmdpYCZT4tVxgHEtGYxRpPTWA@mail.gmail.com>
Subject: Re: [PATCH] drivers: hid: renegotiate resolution multipliers with
 device after reset
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bentiss@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I=E2=80=99m just checking in about this patch, if everything is on track fo=
r it
to be sent upstream. I see it is on "for-6.18/upstream-fixes" branch,
but no further activity in the last 2 months. There is an Ubuntu bug report
that can be updated once the patch reaches a released kernel:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2131607
If there's anything need on my side or from our user base, let us know.

Thanks,
Benedek

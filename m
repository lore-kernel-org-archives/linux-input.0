Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716D73BE177;
	Mon,  9 Mar 2026 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060858; cv=none; b=SkG3bBzqgSVmF/NiQRsrL9XALYo5qrt13Qslb7d3o+lfdkAp0CRHuGtIoQqozj3ST56357bbnNmJL9tqjpCxTok4fKTlBW3cJMOjsQ9VD4rVN+8KGC4Xiv+BWLl0dC3orrjkrg269jJEPVpxS/6ey83gbA273M0x4Ttgqtsh1N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060858; c=relaxed/simple;
	bh=x7XTUyTEjlyfsknKIPpydodGdMSgv3hWaBjEYFEIgXY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mtz4JVeJOMxClo+jdFFkU7CNzokZ1ig+3rnidE0SpKzhTQDHsttBcJIrdUJR7ihhNEjMmZ1z/YaFVd/tJVULu0L1xaRjiX9Ns58/IU4k7r1TmKTTTdzHg5ATa5mth/qb8jNp/4p8YqOIblaCuFwoOsQnEJQBYg2moSlEBg0HGkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=MBSENcaf; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="MBSENcaf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773060847; x=1773665647; i=hendrik-noack@gmx.de;
	bh=x7XTUyTEjlyfsknKIPpydodGdMSgv3hWaBjEYFEIgXY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Message-ID:In-Reply-To:
	 References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MBSENcafam1hrwDp2EsM6ajgp9ZEp7iyDofUtO0FzAbgRUOJK+o6+Ynsl+zgC6eZ
	 QFM74q9JB1Dt6keHgZNSZV/AKWJDRq9vlwP10Ax3cJfWpiwuXSOodyYQqrsia1skC
	 wc23HmPTh2aXVSTb0ynU8dYKaqDAMwc5rWLrz/EqbsJqdAwD5Xidw392uS7Q+4XaX
	 lc9iRd4TKQJ0GiSbqt84uM/93aToRT8cbj3PRURuaRoX5DYkMrYd1MprjyuIJvbRH
	 uB3MzuTeU15luKMdj+yoOn+y9c+3quaCuDgdPTwHrtTSiAsTmh2Z6Clzkm0rvh7lw
	 nzjunCCKI/Lg8B2iyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3mt-1w5sYP3cKJ-00QG4t; Mon, 09
 Mar 2026 13:54:06 +0100
Date: Mon, 9 Mar 2026 13:54:05 +0100
From: Hendrik Noack <hendrik-noack@gmx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <feae85c4-bea1-40b2-87d5-952b26ff3ee3@gmx.de>
In-Reply-To: <20260308-vivacious-coucal-of-current-2d7ac8@quoll>
References: <20260307181557.66927-1-hendrik-noack@gmx.de> <20260307181557.66927-2-hendrik-noack@gmx.de> <20260308-vivacious-coucal-of-current-2d7ac8@quoll>
Subject: Re: [PATCH v4 1/2] dt-bindings: Input: Add Wacom W9000-series
 penabled touchscreens
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <feae85c4-bea1-40b2-87d5-952b26ff3ee3@gmx.de>
X-Provags-ID: V03:K1:nVijRyHmk749Xxe1SaVVxZjhv78CcLPfY5Zp6VWCcVPx0LRgpAv
 YlUaMlQ2khbG0//+B/pLuxHkEtXU7Wixowg3mGJqr5oPHxCgey/1Jo5veqr7hOEjPdMG6i5
 tOp4i2in3/ccnIVMsQrfozOT6K/pD3Rkcx8hRou7ucRSOgxqj2EqdCa1pzNoM9PkxcFPlbh
 x67d4XBXngfBRCh0Q862g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+Wdq1jJsiDw=;RzuVWuRaOrWiuFsvF6bWoXiMBZL
 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

Hello Krzysztof,

08.03.2026 10:15:35 Krzysztof Kozlowski <krzk@kernel.org>:

> You received review and instruction what to do. Did you read it?

I read the review of Dmitry and incorporated it into this version.

> Your way of organizing your work makes it difficult for us. Look, try
> yourself:
>
> b4 diff '20260307181557.66927-2-hendrik-noack@gmx.de'
> Checking for older revisions
> Grabbing search results from lore.kernel.org
> =C2=A0 Added from v3: 2 patches
> ---
> Analyzing 16 messages in the thread
> Preparing fake-am for v3: dt-bindings: Input: Add Wacom W9000-series pena=
bled touchscreens
> ERROR: v3 series incomplete; unable to create a fake-am range
> ---
> Could not create fake-am range for lower series v3
>
>
> Best regards,
> Krzysztof

The b4 diff error might happen because git didn't add the v3 label on
the 2/2 patch of v3. First running b4 diff on v3 with:
b4 diff '20251205152858.14415-2-hendrik-noack@gmx.de
resulted in a working diff on v4:

b4 diff '20260307181557.66927-2-hendrik-noack@gmx.de'
Grabbing thread from lore.kernel.org/all/20260307181557.66927-2-hendrik-noa=
ck@gmx.de/t.mbox.gz
Checking for older revisions
Grabbing search results from lore.kernel.org
=C2=A0 Added from v3: 2 patches
---
Analyzing 17 messages in the thread
---
Diffing v3 and v4
=C2=A0=C2=A0=C2=A0 Running: git range-diff c371c3410e81..d467d6770a1b 0bfd1=
357fb44..1c9f51e8b572
---
...

Best regards,
Hendrik

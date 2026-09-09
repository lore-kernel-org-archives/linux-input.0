Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B8F3B7742;
	Wed,  9 Sep 2026 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985728; cv=none; b=Bpv0xUCwiI+eCFj8l3/rjPqL6W588906nVJO5x1QbRhR2yEJhZs1mZSA8RRBgwgBY5MW3OpSUlgChhLSVEDrm4CApwkmRg5hfqE9IbDSP8FpfJOEvPD/1vvMHHmf4ztJrQQrFMEEVSSvJjvlMjlEihYnUreUSDzoC1QIFsLKVSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985728; c=relaxed/simple;
	bh=QISU5wQMrvMhMtMCIZ/TuxNbQ2q9R16Gc79aX5NAMQM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NSUHhL1W2ykJBwOKt1tCk178OhJtH4tHjelFNiFo2cX5s1mdNepgRA5J3D6FZULflzWlif3YK4+9FdW43YVl4UulCA7empWLNGRG0eoFoVF42SOPorCDmGwvrXe/OCBbBAI1hPhzpmzpmsD1vwdzWhXHKiz5aUud2Q76Q7clLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fols19Bh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fols19Bh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5A61F00893;
	Wed,  9 Sep 2026 20:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985722;
	bh=I+kxnJhecEnYspOixEfBiX1GOqSVXXYgliBU2I5h0UY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=fols19BhcnoVFViG7MRlm/xSNYoyZW1iUzGGvPPwTBEPkTAoSSDv4SWvZA/wSMuOs
	 Rn8a48x7FXHOzBkJUYC46B3E1dvcqiJK/P9wBxeIhQCIW9t0X7K1PXod5IYEUfWzSw
	 gho00p+xVU1Jm7hG3YI2JldJRvJRKAkPkRN1KAW0GYHY/NIxCK/05NP144A3mZo40G
	 o3hC2yk39TenVB/UXIk/z9zlM7TDYIfLYecA1pUabso6O/1ELgcN8uFp/k7+jR/E57
	 IQAZ/nu5Zm9g5G7fwYP+aPOXeQSEe+LsE7GQUAcT9oDvXt1Af7Aa+RKcY7AS2z89Z6
	 sXWah7Cm11ssg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 59E75198003A;
	Wed,  9 Sep 2026 16:28:39 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 09 Sep 2026 16:28:39 -0400
X-ME-Sender: <xms:dMGhakZrAgTBnlBqFftocUXviR0J2l7Sre8N_hkU3bm99NdIDpI_vQ>
    <xme:dMGhaqNkf1UVpBqqwwAIKZGe6ZLR5887KxkWzxjdQYI3lCGrl43WgdmPSAAxnQHsP
    Uox-U9EzoXttS4S5-47rSz-rZ2uAoCXuXOQors4CntR1dH4NInHP8jwKQ>
X-ME-Proxy-Cause: dmFkZTE8Kd/+IGN7zwsPgDLBZ7Pw2HSIlU3e1eyy66uQrsX01THEP44sRyzEQVpoW8v+S7
    UUKed+8n4cu4eeFtESaBbopZLJ6LrBTdCRAync7iQXnwkzKgdYbtZFutVSF81TSkj5oLHm
    r580h0FhuAildnT6ONm+KzGew4F0SEbuCQV4nqvUhYlCrVwT9UfknvcS497JIK7cA13NaY
    9Ud5IRKSG/vIwSogDRhoQkRzAa3SDHKuqOM0bM1KH7FXh9QDZUTCQwPNYTXC9RwyKnmJDH
    V7+T/rFge4J+gL6ogMK86+6wii7xZ1h6OLfZj9KgnGZLdocmKJaNmoyXFpo/+mxxaiEdkT
    jlWHsCaLqv1TGspZZq12xA8euHVb7zvVRyb2MXaU3xRe5DtA//BGIKLrgLh+dmhrsOl0Zr
    LhWH2PfvgXrEg28p9yDwL50pLFysJbkseor7mYCo6kqWkSeWAqQTWUlbSkBwY2s5Tn9yji
    zYbo1j/RT1XLUpGjwAmSZuYwovSpvRBA32oYRPXhVGksgdotjvcV8f5mqReuuUuAW9l67w
    /etZ6hRhJ7BppXSfmCE1NW0Z51mYf/ZYPGj3MzO3OLBodhCqoMiydyYfetnuz+QZbRmWXG
    6DUPUYvLLxpKQYFcX8kN926mmi5lo/AquurTUISnXbXY9XE75EuEaMhb2KlQ
X-ME-Proxy: <xmx:d8Ghas_AlNDs4o4m4hmLeopgBHxFnbofTtd53FIHx00SNOdAX09wmA>
    <xmx:d8GhatetjFIRC8dRHihv3Rdu5cMWoC3ft1F1tCAIAUNioBHRZa6oIw>
    <xmx:d8GhagtO6IjNdv5Jht6BhK6wRORMmcDzfx-4GiJr1UkH7c_qnHCeLw>
    <xmx:d8Ghau2zRd_Qf-XFQel1Ar1hzUadP-wn0PBMyD9aurfsjithUavzxA>
    <xmx:d8GhalBJh7CQ2Q4n7PDcU-vbkiGbQPaVyavFhkAYmhgNTQLesx-lqTph>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id CB1DB32A007B; Wed,  9 Sep 2026 16:28:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6VsXwS0CIh3
Date: Wed, 09 Sep 2026 22:28:16 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 media-ci@linuxtv.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Rob Herring" <robh@kernel.org>,
 linux-input@vger.kernel.org,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Florian Fainelli" <florian@openwrt.org>, "Lee Jones" <lee@kernel.org>
Message-Id: <098645b4-afea-47db-9c43-ecd5ef61c68a@app.fastmail.com>
In-Reply-To: <20260909133956.E4DD51F00A3D@smtp.kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-3-arnd@kernel.org>
 <20260909133956.E4DD51F00A3D@smtp.kernel.org>
Subject: Re: [PATCH 02/14] mfd: remove unused rdc321x southbridge support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 9, 2026, at 15:39, sashiko-bot@kernel.org wrote:
>> Remove this driver, as there is no way to run Linux any more on the
>> older chips after i486 support has been removed.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> [Severity: Low]
> Since the entire platform and driver support is being removed, should we
> also clean up the remaining dead references to the RDC321x platform?
>
> Specifically, the reboot fixup code in arch/x86/kernel/reboot_fixups_32.c
> has a rdc321x_reset() function and an associated entry in fixups_table that
> appear to be left behind now that the hardware is no longer supported.
>
> Additionally, the PCI_DEVICE_ID_RDC_R6030 definition in include/linux/pci_ids.h
> is no longer used by any active driver.

This sounds like something that should go through the x86 tree, but probably
not this patch.

> Finally, there is a stale "RDC R-321X SoC" entry in MAINTAINERS that might
> need to be removed to complete the cleanup.

Removed this now, and added Florian to Cc here and in the changelog.

     Arnd

Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E092B13C9C4;
	Tue, 23 Jun 2026 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782180353; cv=none; b=PEZFs9L3DSIKXL65S0g6uTrEnkcD2zPlPj5GcIJlKjX6gFv48/KIP2KPeXJ8tMSleQt/mICoj7bvI3qBIImqVGVd9S7EH81lVU5njmJumS97pTabrl45D7ihJhvjVVIx/jby/803XDwx3g26IaIM74cgc6Uuogc2qxQJIeqzNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782180353; c=relaxed/simple;
	bh=2uHEyOL7J8wczbfq0wsGkUfh4LBRCgX6lX6v0C3egbY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sk0uP6MvabMhntRrFw2MSGhHcLXQ4jxIl3bieuhdxtA2k9nSPPaKlfNU6wTVE3OCJgE0CSqhurSW2uQ2qk+kOKE1uBc66XV3wlnheqJkYm76Uwr3LreR3Hzx5Bc1QTtCrYTqQzMZPpn0Y9lmAvLhsDD14MkMOGKDNo4fDKETFTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=H3dfA4Oc; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="H3dfA4Oc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782180345; bh=A0ckX5UaxOA4E9S6nP1w1P1HE0pBxIlcM4UzfJrCk2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H3dfA4OcYuhsdmFgrF20gbcG8wWre2HTnmAJf01ec4QOKGBMS9Xz/JKC87V6Fbega
	 td4PMiAvxLHFtZDsTi8sDRnYzqUnpHtlHdnVAg85nsZbfzdpOkL9hDFoR09PYwZy2u
	 LmUpOjUwgP8K2+ZAjhxizLHQNhfkWv/u0NqA4fHs=
Received: from mail.red54.com ([103.253.24.18])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 15F0B4E6; Tue, 23 Jun 2026 10:05:31 +0800
X-QQ-mid: xmsmtpt1782180331tbpq048x4
Message-ID: <tencent_9F36AD4CCF9BB5FADFD7B3557BCE0F412006@qq.com>
X-QQ-XMAILINFO: NibnO81X6Pb5F8h/Nz09PgZOlSqepxZ8Q6P/5I9lTSNQghFRcX746EoyexeNPv
	 /fi6ODJzIYVvEOB4wbxhlR5F+eQHLH0+tMz/bXETIpC+BMIwH2n38eIsBXyGWvyd/JqYmA52QFIi
	 3VKKVp7FMQaeEclTwk5NZtLa1HaFLBdBU3xG041Rw5ZosLysQ9gEAqwqvlFv875mkMUcRfk5eJiM
	 bDvbvh2YgZPcwJpLHvIQklN/J4BY2LLDwu7RhUYe0F29BY6KKdGeveCuokRA0mPevXkfBHDXimiX
	 pQLznnH6gENiWj8+KhW7rdyCtS6d77ZXkNT0Tc8xANAP0VeKq/+B4w8OhYmx8P20vMpRqo809fN8
	 uKTcmKxxLosFjtXu1L5odlFISfjI00JNo7kc1DQD0WzHOZoQbu4m58Hs83BSHwOxHewOM7c+yuZp
	 xGp8KgbH7XC48sd81bceKyHOgYvjXwzNOypXCNQ3obKdf7TBPcdZMBhyKjV6OMV9vzsZdKyQOoqf
	 4HKfvjpfjF/GAyAVptfViJufl7Ka18VxP11AVCSOQxjB4lhEZlEO0hasTF1ms04CF4KCmnAifhIw
	 4X2plu8prwTe/sxzhtD6TqhVHOWd9XxNQlB/ISr0dlGuLqcsLmaQiv11whRqjlY6Lh1CKg2ktBmA
	 E0BvPD8C1NQKSjdsGn5zXmrODQqVwCtmrJWdz20p6bp2eD7YwtPbltnVW2mnmM35SqXDrqBArSvc
	 YEk5Bbg1u0O9EOf8TcBrRFsJrJBmtQeabNHQudTrGD0ANZNKV+sofFTDXKgEIcpWoZfPv+saCTcU
	 Q+WY/G3tbtvFJMgfFFVZSa/LBwTdW+moWaLfEKoMAvP7/QDQn9WxuRCCdL+Vf8kmuhbkw3ExpASM
	 /su+ojyUu7cu7LGLTjiuDFMpmeZ1MkOmuxo6twn+sRVWNfnSXEwrxzegZKBNTRjutVCrqkzzrCnH
	 ydPzeSe0ZtiGxFybh+7OsqgMhvFW1FxCqolqw1qbFZb8vprEIa2cRHIxXnsSGBijhxq9FkWX/UNK
	 myRuRE58oif7zMJ3Mx0ytlEgWbbNJPshq5nPFDwnTN1xXUd+3Kt3KQD7XedovCXp8XldG986BXzn
	 K+V5fJ
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com,
	bentiss@kernel.org
Cc: Yeking@Red54.com,
	dianders@chromium.org,
	jikos@kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	superm1@kernel.org
Subject: Re: [PATCH v3] HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver
Date: Tue, 23 Jun 2026 02:05:14 +0000
X-OQ-MSGID: <20260623020516.294389-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0ff827b8-4690-4ec7-9025-6816befd1d7b@kernel.org>
References: <0ff827b8-4690-4ec7-9025-6816befd1d7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hans, hi Benjamin,

On Tue, Jun 09, 2026 at 03:07:53PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 9-Jun-26 12:10, 谢致邦 (XIE Zhibang) wrote:
> > Hi Hans,
> > 
> > Thanks for the review.
> > 
> > The current header-based approach lets i2c-hid-acpi-prp0001.c work
> > independently by just including a header for the _DSM helper. Switching
> > to EXPORT_SYMBOL_GPL would force prp0001 to depend on i2c-hid-acpi —
> > a Kconfig "depends on I2C_HID_ACPI", plus module-level dependency at
> > load time — all for sharing a single function. I find that hard to
> > accept.
> > 
> > I understand that adding a new header for one prototype is unusual,
> > though it contains only a single static inline function and introduces
> > no runtime dependency between the two drivers.
> > 
> > Looking back at the full discussion: Benjamin made it clear from the
> > start that he doesn't want i2c-hid-of.c handling ACPI _DSM fallback.
> > His line is that ACPI devices and OF devices should each go through
> > their own drivers without cross-contamination. If you still prefer
> > exporting the function from i2c-hid-acpi.c, then prp0001 would have to
> > drag i2c-hid-acpi along with it — an independent leaf driver turned
> > into something that can't stand alone.
> 
> Well it is a special case/version of the ACPI driver so depending
> on it seems fine to me.
> 
> Anyways if you prefer the inline function in header solution that is
> fine with me.
> 
> Lets see what bentiss has to say about this.
> 
> Regards,
> 
> Hans
> 

Friendly ping — v5 was posted on Jun 12:
https://lore.kernel.org/all/tencent_8AE8ED913FEC8151B4BA3D85D6BB7F3ACF08@qq.com/

No further review comments have come in.

Is there anything else you'd like changed, or can we move forward?

Regards,
Zhibang


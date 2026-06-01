Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908433101A0;
	Mon,  1 Jun 2026 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332669; cv=none; b=Lgx/eTnvN5lJ4M2YpjVDz169v2rF9WYjQGQCrPdT903ezJifpJD6W3Vj/aGHxHHSTVD6QDf4SXIcD0M+s2F27iUXcNBaGBCZwIa0vFJ73Fqv6QmeLNT8iZBAh2Gy4VUH9d64VEneA2u3rTKFJ6U6HHemAgMieX2iYTy7n4/KReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332669; c=relaxed/simple;
	bh=mnSvAkyAKEV64YOg4TXgo6ur5+tE84mQn/kzgI2OKHc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mKc9rOxSpfdsgK3N3N4tlwn1Z8TzleuHOwkZg+50FxP7M+ALdREN6FhBaLDZZ1Cql3LDMSmLUydU6lq/O6jHaWYd5NlR38eEXNfhUE8LAfXYO+423x7XGPYA/dv2eGpm8NRsXoCrFpMRRgioKaluim7OeW7+lP0tOdzYJr6QS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPiKEsII; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPiKEsII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2681F00893;
	Mon,  1 Jun 2026 16:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780332668;
	bh=czmPJqXZMmdpshyUZi9ZFX1mrThHJaOUqSLQ0ZlacWI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=bPiKEsIIjuS0SzESIHKPkLJYVfj7MY1KHTZxnFs3c/h3qZHTq+K/ph8CKPpnO0JNk
	 +wTtvF5NY1NU4W3FWMhegKz/ptXdw+0VBbWVa5vGaX4KY6AyrDuVNzfogaGEQK3Cbe
	 /UEjRvZ3dL6EkeDz2bGPmXzXiLimosqKCT0ZXECfs7e8Ax6EnAnWLFhnroU9wjohKx
	 M584TOmRvptV3A/nAJZ00KCh9UaxlMscOAb08lScopeesRgy3X0KCtg+RVwntlO5rg
	 SmNx9NQ/4Aw3lzJpAPrfNaxkIjA+zmvs8/1zTtBX0dUzPzQ0Drp/6t6/flGt1rCWiT
	 cx3Icq083ZfBg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 447EFF40097;
	Mon,  1 Jun 2026 12:51:07 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Mon, 01 Jun 2026 12:51:07 -0400
X-ME-Sender: <xms:e7gdauhhu95keg-RXpu4IoCXpvI5L94tmu3h211J11HVdnPQziAasQ>
    <xme:e7gdap3zLX3Racp-R-1NVSBtnEwpR_SVw3pgvs9HGzQDBmWO5d_ueM5nwzcI2jNlD
    N0Y6mkNVXKDcCTjFf8VE9AdOgU__oITEymUAlGn90WP7227lMAtnU0>
X-ME-Proxy-Cause: dmFkZTEsnE6xJLC9nA7G9BbfEpwnb72Uxk2msx5m6J9qRN0ZQGEThJK5Em/LgCcdV3G1LU
    LmECNPt6iBGeBOekCeOqSK1sitRy916kTyrli8rG6nO5inRhaq/seJOyea0q8kiJtGsjur
    FP+RE8t/zCAKSrt712azKNoZNMyWO0BYh3enlC9CetBSPyVOCC97zMCMAW4lnyBu5BEzNb
    Mx4L9/sowFccFtJv7i8EhGqJVHPdCOX1U9qoI4QPwRekkacJdsIBGCImY7LYpllEACLYch
    s7L0yxssXox9soXt6PLVdWkNredOEztkbU5YWdW0zENLISA02NvvC3xKJ1tPlvTUwFWzE2
    KAvZ/yv3k+5bVMRi3+4gzQRfkk1wca5oS1YSQr3mkcNrCilseTuxTq1vGFfFbbzD1YxqHK
    RnaMt3/Mdxfoy94VZ6UdYkOdir8auQJvUa/Njb7HRtQMhhWhUcHJMo7IDLeDjN5MP2RsIo
    jB84ooZKq3wiVOMBauQHjTPIEJLtt8ZOhH5qO6Cij+hOYP8bFgFPGDVlL2K+O2iwG4jmj0
    maGvMTpDWk2NDOKT+S7Peq+HkEYeIDbJ7Zu4kamxrUyJwMEPsUOg6awyqdhI276FR1QVvp
    jKi+OPlpcgxogpA38x5VapzD/KIMlPQ/3zmbcnHZT5y2q1z48hz62bMRRA1Q
X-ME-Proxy: <xmx:e7gdagFg4dV41RCqWbZFuB3tVhYNsuqcYYobknNbvNHIoNQDyzj7Tg>
    <xmx:e7gdapdHtPYhFxUWpan1YDA9Q45eAd30IWoQsK5FbmY25inN7LcQxQ>
    <xmx:e7gdaiEvG2KpXQL8UkDYEFhLIOZ7eKEzJ9eGXTI3rBXKmFovcKDPDQ>
    <xmx:e7gdaqV3haWd0JSfKO4KJ6JeJ65kHZVOgDZVQsAw27RIsZHKPZMunQ>
    <xmx:e7gdahI9WDOglMhvZ9xOGw04C0q6TrgX5gVszmz2u6hwsu1Klt7vKIhl>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1697F182007E; Mon,  1 Jun 2026 12:51:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADJg51WCz7jo
Date: Mon, 01 Jun 2026 18:50:16 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Message-Id: <c998d342-c001-4ed9-a359-2be24984ca02@app.fastmail.com>
In-Reply-To: <20260530004519.A9BAB1F00898@smtp.kernel.org>
References: <20260520183815.2510387-2-arnd@kernel.org>
 <20260530004519.A9BAB1F00898@smtp.kernel.org>
Subject: Re: [PATCH 01/10] [v2] [net-next] net: dsa: b53: hide legacy gpiolib usage on
 non-mips
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, May 30, 2026, at 02:45, sashiko-bot@kernel.org wrote:
>
> [Severity: High]
> Does this silently ignore probe errors like -EPROBE_DEFER?
>
> Previously, if devm_gpio_request_one failed, the error was returned to the
> caller. Now, b53_switch_get_reset_gpio handles the request and returns an
> ERR_PTR on failure, but that error pointer is simply stored in dev->reset_gpio
> while b53_switch_init unconditionally returns 0.
>
> Later in the code, b53_switch_reset_gpio relies on IS_ERR(dev->reset_gpio)
> to gracefully return, which would silently skip the reset sequence entirely
> if the GPIO controller simply isn't ready yet (-EPROBE_DEFER) or if there
> was a memory allocation failure (-ENOMEM).

The driver already ignored errors previously on BCM47xx. and
I can see that -EPROBE_DEFER cannot happen because the gpio
driver is very simplistic and always built-in.

I've updated the patch to propagate -EPROBE_DEFER anway as that
is clearly the correct thing to do in case it ever gets used extended
to other platforms. All other errors continue to be ignored to
keep the current behavior of the driver.

       Arnd

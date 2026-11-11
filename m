Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395427;
	b=25payIhczhvdub9Xw6Vd5M9hPP6wElxV6DIVBqQ0fmm9K1fVGw3ylBd9UCvVOw7+3PaA
	 yQ9Pr46Cf4TfHrcu2U0hG3QhCTPLGFvH2RuXpwHL6s+MmFX/6VVMebdt7l8yGAd1KeAPq
	 NOKjCcHCVN0kXt8yYIradK/51lhdILw7anUSHGkpJ7DeoKkvW4JegALIT/PhE+P6Pr3Gt
	 1sOI7yRNDK1JDIRnX2kf/y0YnT4j3gwOoEJFz2y/BPJjfGpHE1X4HDMJ9Gku6gxYdb4Ym
	 jpqzwkGTvJt5uiOqnhO33dQeu+Q7mdmXWJ7IesFjScuZVIf1i+95Jq9QRNTsBOnCpcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XwkuBLy5toj4xmSecRyiSJuZGOX5kjvXYj7mL+5wNR8=;
	b=o0DWvKYVSiAeKg4GbIKTl+oloiiTVr1s5VpkVw8SpP+i3Ae1ACWrxP9OljnyomJaKjBw
	 Nhu84gyatWIpfhfzLT+zaPhxf2fw1WYiwCn4HqhxQ8dZgjoehtVFgTvwk8CtKovIEMpse
	 STKeueD93BH8cIKWID+FZFh13t+3NXD1zFHzblL+GDXMvBhlcrhwW9+A9RkWLfsQO0237
	 G44/ZUkbSR3uEMMTSkqFJolzYGoRgPkC3JNPrxEjppfb45Ud26+1P7yg5f6oZi8tebw0I
	 r/wRJpxfGKhfHLIJc9r346hU8zK54H8SEbW9y2KgHgL23PdoCsyBf+XahrxLRH7hf/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AMltq5/y";
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBDA606A33A
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 11:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DBDA606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMltq5/y
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so1400211f8f.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 03:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794395425; x=1795000225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XwkuBLy5toj4xmSecRyiSJuZGOX5kjvXYj7mL+5wNR8=;
        b=AMltq5/yGNWP58DK7r+glzzonp8mh5I4LgGC006a2C30lJF69tWzRY+aJchL9xmHEP
         b1SnLObtvr3c3H6UYX1tsjwRxjqrbVY/3bHPMOVIoXSB7m/H5y6Ir6wB6lPkpgWweLnt
         nJs5F1QW95WlZl8enGFIVzt8Hk5NxtaVUIe6FBU6YjpbImBMrPYQ2+czBAPY8Efy1MCw
         rLt1YgY7g7UP6zadrTCg8G509eaDtGAuzJATMGrjiowta9aWhcOtGUEsppjtq6BWyozI
         UJ46hvK4IdPUKlcWZQlN2705oEehi1IEVoK90eJnOT/4XJJpQcVJmlYiC8kcQLMv1Xt9
         UY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395425; x=1795000225;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XwkuBLy5toj4xmSecRyiSJuZGOX5kjvXYj7mL+5wNR8=;
        b=UfZsOlJHJOsOgH6CLRtKacysaIys9biYOHyb4Wxfccw0ec1Ys0LxV0YChkLWWMH6MM
         UnRYh2SPUE8+R0UuvTnoLUL/HRaFEwBxRfsbyxUoWLU+qHPGOs/qij0SHSJZit2ZfA7l
         f7sWadWnulTicuxylZz1j5z7IBfWZq4LhxsgNneL2jIXjt1GbJoR2J27eZ6gazmg9hpL
         45HUp4GQLtc9tQjhfXNL1PzhpFDxOoIB1xjt6oSGkg7afl2WFm+XMg7ZF9nMwu5DhfUs
         7C5mtIXz4b2Vol0KW2sB2LHlyuFql4GdaRvQ6tUdzb/lr1D22BjpXaQFIsWSSffXX9mM
         4xJQ==
X-Forwarded-Encrypted: i=1; AL+hErH7QCgkqsNvVqtV77OYdqa/ruWsNa/omJR6EEQux0BZu0C1MZgziRPiPBBbIn3cehXpTRfRKCTAO/MpFA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+gcTMtYXciYf5NhDTbaT+hUKY5ZsTW5I34GqZUC0Y/lg4WDVvv
	+eg0ykAXoSQQJ1SFwLF/J8Q0mT2deyMPYRU20sXc230BFchvazpm8aXa
X-Gm-Gg: AYBFou3Zzq0hOltP958dmNhJacnBNZNSyrkF2A5MSqQjLHsymuzPK7PUvTd9oU8Kafs
	Bm+tSbWFXP18wMh7eGcL+JRHR/T3o66KCtUoKdd8wkTcu3gWKDBgbrnOwUF6ecZw6KeM52XmYLO
	4MA1g0on76uNJ+yRkBM38h3+6klpl7AaRUDYEWY2yfd2aJFnzfWBZdTxXVnmyrn5BPiOQFoIw2a
	Dq0/j+RrgLVT14c4hkGxMk60cNHT+6DAOGIqQcHIZe+00lP1Le4Q1+M/oGtilCANLN+YXaLdgop
	OEhWUq5faAjRIEdPe+WSBPmLUoM7ltTPNPXF3d5/OW+abrG4IMjfZc1t6ZK1M2c58D8JNmnntna
	5gLrgQ3hB+O3Li/hHXhckPuxMh9KpQvf/UyAeENuqJAMi/ujHQZeYwKanQZkXiser6xaRGWlONM
	oW5PsnAUxLfRRvTDAaDWPBxkpJ6nojC3jDzvOuNfdCmgxITPxEdlvpYu0tMFZO/WVntdcp3+P70
	KFa2H5VRODopG9MEE3o6A9yS6Q6AQUwiNlULEeMKB7Wv7ecIBRW4fer1wphE/a2eTpVEnpc/nVG
	4vV8mMXzm7Df3RqqxpRukCWXmuhXQfp46r7jSBU=
X-Received: by 2002:a5d:64e9:0:b0:48f:bed6:4d79 with SMTP id ffacd0b85a97d-499c792ef43mr3394834f8f.48.1794395425185;
        Wed, 11 Nov 2026 03:10:25 -0800 (PST)
Received: from foxbook (bfj76.neoplus.adsl.tpnet.pl. [83.28.47.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585923bsm10645983f8f.11.2026.11.11.03.10.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Nov 2026 03:10:24 -0800 (PST)
Date: Wed, 11 Nov 2026 12:10:18 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Olli Salenius <opsalenius@gmail.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
 linux-input@vger.kernel.org, bentiss@kernel.org, jikos@kernel.org,
 linux-usb@vger.kernel.org, git@mayer-bgk.de, "hadess@hadess.net"
 <hadess@hadess.net>, "srimanachanta@gmail.com" <srimanachanta@gmail.com>,
 "mathias.nyman@intel.com" <mathias.nyman@intel.com>
Subject: Re: [BUG] HID: steelseries-arctis: NULL deref in xhci_urb_enqueue
 from status timer during resume from suspend (Arctis 9) -> system hang
Message-ID: <20261111121018.49797328.michal.pecio@gmail.com>
In-Reply-To: <CACQx0bFrJYn60_QAogb23n0yiSy4hu5ZHQWXbRb_WBfS908tSQ@mail.gmail.com>
References: <CACQx0bG8+c9+CjLRa-tbgGkc5_4Wxhmanbd2vToo8Aj8k_WUYw@mail.gmail.com>
	<CACQx0bG4bvt4bHa+WG4u2UGmUc_YMUnhpWovz5+rzp76Jpb9ZA@mail.gmail.com>
	<079cf13d-542b-4084-9023-06a89fa4ea97@linux.intel.com>
	<20261110105709.5fdec4a9.michal.pecio@gmail.com>
	<CACQx0bFrJYn60_QAogb23n0yiSy4hu5ZHQWXbRb_WBfS908tSQ@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 22:46:27 +0200, Olli Salenius wrote:
> Disclaimer, I am not well versed kernel level stuff and using Claude
> Opus 5.5 in debugging this issue, so the following info may not be
> accurate, however the patch did seem to fix the hang at least on a few
> test suspend/resume -cycles.

Your LLM is right. The test patch makes no difference, but commit
555040535 removed the trigger. If you revert 555040535, the crash
will be back.

It happens because xhci_reset_or_discover_device() allocates new
state for the device, but it doesn't bother to update the root hub
pointer, leaving this job to xhci_setup_device().

To fix the crash we need either the dumb patch below or some rework
to preserve more state during resets. Probably the dumb fix is the
only viable short-term option.

It doesn't solve my problem #2, but that one is a race condition,
so much less likely to actually happen in practice.

Regards,
Michal

---

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index e5c8b3a945a6..81656bfdaf66 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1662,6 +1662,11 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		goto free_priv;
 	}
 
+	if (!xhci->devs[slot_id]->rhub_port) {
+		ret = -EHOSTUNREACH;
+		goto free_priv;
+	}
 	if (xhci->devs[slot_id]->rhub_port->link_inactive) {
 		xhci_dbg(xhci, "Can't queue urb, port error, link inactive\n");
 		ret = -ENODEV;

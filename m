Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707570;
	b=NsJrc3fQ2YqmdCbiyh1dsUEdLA+yrcJimQOuky+erj6+pKsF1NiZVPbZjWsXd45TlgRT
	 T4PQ8rHpEnokgG2nCnaQ64VjSabHBXPdFU6ixe/fe3itr7iIMMwVHjEy/QqiFlKxeK3Bh
	 PRnC9xcmJNKLqSTwMRHr5wwHDcCLMJyAyQph9QrPVol8f2YlolGwhubTAotVfi7GcZCt/
	 PwJiQ4RL1Rnc/boNoKZDwICvC7b9YkMaAcOuhrrTha4YzgO0yJOL6CQ/evzKGWCTxTzMX
	 VUgCRwOE/O9XWlMYvJyMVRfUg8qbcoyZKVzHHtCrSxY5tUElJlTJ2LKGK0uuSfM8jVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707570;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=U0AJFYm3QCB3lPqgQWLUdo4C3TPrVpIZvpdC9mNsATQ=;
	b=oF7NIa7UXhmXN7NPM+xZvwy2qcG+6bfSfJcJINORfLdbYv9wJ1k375ZDxGZQ3dV0ZuSx
	 0j5FCOsuearCHd7z0Fuv+M8NYdDmhOw8atRGw257ag3S09/U6VX+yCO5mtsKn/Ox2EjyQ
	 4mRDTmNiHx4pcnw0fvQ7VtPlqgUlyntj/uw4TlhriOd31OHnXneGmUCtNvvri0KcFRBSl
	 t6zo1F40gErrqDIImbzqWNiqIYDm7FX3Tb8HOGpNQVZcKShMXw0WWLAsidXm8IBFcpvNB
	 bGQy+1cnqM4mSszL5DrQim2+rgjaJijeVzkF6Cm87J13SUi/VJy9XBpZsoFvDBvCzlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeweavers.com;
	spf=pass smtp.mailfrom=codeweavers.com;
	dkim=pass header.d=codeweavers.com header.i=@codeweavers.com header.a=rsa-sha256 header.s=fm2 header.b=fjjp7qSs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=EmGmXaym;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF4606A321
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 15:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94CF4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeweavers.com header.i=@codeweavers.com header.a=rsa-sha256 header.s=fm2 header.b=fjjp7qSs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=EmGmXaym
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D2CDB14002FA
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 10:39:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 26 Nov 2026 10:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codeweavers.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795707568; x=
	1795793968; bh=U0AJFYm3QCB3lPqgQWLUdo4C3TPrVpIZvpdC9mNsATQ=; b=f
	jjp7qSsfloJhS6Pkn9rVzbXd48/Wssrae0S+eeXYFlalrj9zgGXcDGuWvMGA1KM8
	d8Hmv8+v3tK0sMxyMlYc5FuxZuShjW4Yk1hK1OMMw2i7QGfmivZYA27gR6BA8fYL
	h6jstUd7lgavADLcufV75W/kCQj5tk/KPOw0XtGCe5hLJxQMDIsJy/ezZHLfEWm0
	kmmvC2Qf2wJjuOO3ChqgPKnMz7p+L3ffamHIKBDjUjXWzHs1FaPa2QCbOgjVKxSY
	raB7rAycdGl4FJg3ehAn7UuW1Gz3UU9HB0+S2+pialwoJG3apCNsbtyB5io0vs/u
	eRCR9CToA1rkcZ5EzXgRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795707568; x=1795793968; bh=U
	0AJFYm3QCB3lPqgQWLUdo4C3TPrVpIZvpdC9mNsATQ=; b=EmGmXaymcoYK4t2Vt
	jZe37cle2ka7N4LEzatTHzyEHpGvNq8Fo3asssH2Lp6gv0vFhFBQdUQE0INIZnsm
	wHJYgN2xoWxedUBx9vxjNP5nI5+EoN7cl4J7jMFmKUdUTob3Zyi1VO7gZ1zqlcd4
	CooLhtbTEqdfe45PP+eo32lqXla8qImI8m+3bXYRsy04LAUopm5QwDAQPJ75U93n
	8uHjU2Z0eh4JVAQFwOLnbqGiqRFg0qMyNp/kx3cWuSFlNLNyKKZVmaqr/tltoH38
	x54Xp36zq+BLW1PxzQUm9EHYWVfbVxEUZOcKW4YZ/HR6NeaOLYIVBrk+Fvp/sUZC
	XN77w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=codeweavers.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795707568; d=codeweavers.com;
	mf=PG1icnVuaUBjb2Rld2VhdmVycy5jb20+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:L9nZn0T1bm/sv+vqoEhLOIJJfL/vS8k5KXpIk6tjeGYpGnX
	DFndZ62ii1C5NkxQpu7mFhJYIZBMZcEYx0dslk+n/Yac2Fow4fi0LF39ZfxJsNo/
	dtW+WpnMiQByULuQWKZEu6JSAqBzsSmK7JtHFNlmTX28IJkTgEFEfRtbGzehKiWX
	FmR8RAPhcQiryohQM/02zghZB6qTLhd44IXAWTvskVbeWQCchKn9kl/c2PDJ4zy3
	hN1YZEYRBxGH9LsQK7NBrxa1DcmMixtGYHzA5Xqc1MBkjUKX25Fa1Pz+0+tL487v
	BHvClzM4b2w9d7xIzwskIq8YmdpzR1LrPazHIoA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:MDc/6PvUUjt5QcVXt/se0WHmh1xlcOzczzDYjbxS4bA=:w1dU3eyllDTB42cyscM3MtKs8ekYN9xLVJVJADb7ss8=;
X-ME-Sender: <xms:sFIIa2rP2PNVvyKxujliawBlYKFld7NBSZ6Z3KULaywW-mKotc-9Ig>
    <xme:sFIIa7pMkCLDcYunJ8NRdP62FYizt-s8MpXp7gBQUv-AafdkbYLa6aJlX_NRRp-EI
    53mWVApc1_Sths7XLzBQe2pqDHdvccP17lH3QE81ul7YK5MCqGg9rd7>
X-ME-Received: <xmr:sFIIawPVwdGbltCQGlmab6WloeX2O7bqKC-gKscKFWdR7JAMj1RGKzJm36apzyaU>
X-ME-Proxy-Cause: dmFkZTGJvtjEVXz+AKFPWHgokqV5HXKM4lK1NVaIC7IUyhaJKSlVCk8nLQlwniq2w3XfVd
    fCBPVkeq/Ib8432tJ2ieuq3l9YMJrIJesCeldf0Bb+u6BZtQTftbIwt//wORzAFk+rqtvQ
    Y8TNst4WUX74JH/G2GldLEK3emtk0xGiCp1ZB/YrLZNaqJ3G80V6UH2G8cBzrqcBQ14hwZ
    wY2wZrVYCbyC6SjtnIXO8ULh4F9laFb5notTgoI0ZItPU78bEqacVE94D48COBOR89rdnY
    d4gZta9Edloz6QAO56Y3Hnf/knC1x88ANljN4x3EGnrdLkzkMTdpg5WarYIp1ZSjnfmaLp
    NRgPU81dJGLEPEbIZSc6JypIR/LxJRO8x6bC3MXM1qhja3DJk8Xqrb7+q/gJ6xlYa1FV5c
    f/urQS72cwAMc1gS9P5ZyHLJJLS0UHOhOFJyjTFrSUQTwLdjkhO2bsSM/LC4dVEA17A+bU
    KHBJNqM0uLXCa73dHiF/qNYvjxsNJVZsyerdHpp7uhnTVWY7aWtYKhzmBwpHgvAJS73PvK
    uVHXHbmvn6lezrdmZgCdBgkAl3Z71r0x+WQPaajCrr3U1A/xcRTR6MjiTVvUAOvFE4LIcp
    VBWdAYj3mbOXIRuCwYjVhjGhN2G5BLHRDcXFvbQ1UYe9pp/Zj9a1io6yXszg
X-ME-Proxy: <xmx:sFIIa0xyzEbGCjy3xTjFBxw9F6eewgjxjn2G67dzXaZWGnlG3B3WDg>
    <xmx:sFIIaxsoDsfU9MV-ftUsNaErVrQCJdW2z-IN0LhN_bjR-BPLbTV79w>
    <xmx:sFIIa16jiSqVBTbSU2_Td_2j5U_f6R-HOVprUpwrJngZCCpKGFG00w>
    <xmx:sFIIa4QW9GvgbJ9Fxl0OzHoTBnlNYzNuj7MnfldvSLw9meZKKwLyTA>
    <xmx:sFIIa1a-UH_AsZKc_hZldaOepLhdy-EqOgh7XyhRaXnbp1C4k4kpz2yy>
Feedback-ID: i09464b71:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 10:39:27 -0500 (EST)
From: Matteo Bruni <mbruni@codeweavers.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	David Rheinsberg <david@readahead.eu>
Cc: linux-input@vger.kernel.org
Subject: [PATCH 2/2] samples: uhid: use a non-zero version
Date: Thu, 26 Nov 2026 16:39:25 +0100
Message-ID: <20261126153925.9488-2-mbruni@codeweavers.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126153925.9488-1-mbruni@codeweavers.com>
References: <20261126153925.9488-1-mbruni@codeweavers.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Matteo Bruni <mbruni@codeweavers.com>
---
 samples/uhid/uhid-example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/uhid/uhid-example.c b/samples/uhid/uhid-example.c
index 015cb06a2..1aa5667ed 100644
--- a/samples/uhid/uhid-example.c
+++ b/samples/uhid/uhid-example.c
@@ -185,7 +185,7 @@ static int create(int fd)
 	ev.u.create.bus = BUS_USB;
 	ev.u.create.vendor = 0x15d9;
 	ev.u.create.product = 0x0a37;
-	ev.u.create.version = 0;
+	ev.u.create.version = 0x100;
 	ev.u.create.country = 0;
 
 	return uhid_write(fd, &ev);
-- 
2.53.0


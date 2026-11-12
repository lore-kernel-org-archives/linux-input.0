Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.76.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504433;
	b=bCLRrK0cr1bQWeUy/HBdMRyAMmM/KvsUtibQLsMVIcd5oc1Qo/Nj8aqD3SPzC+mw2IH2
	 C2Z2PRa6Ev+BeO9sKIdmbKWdkWvTFoB1EYGMym0EMgCPbu8wjuvNx5AjoFgThG1LkK4ho
	 3g29c+GCoUOyc++g7xHKPz5abhtlmwZT4nVwQs33xEv5dWvNUOBDeGvdSdH129csvO8Ap
	 g7zlkgrj0a8ZqxHO/clH7rr2zhNgcqgxHwtL1/uCOlPT34xAYB+c8ZjqhG42dS6xSXmL8
	 ik8lZ7WKeKwfcOYHRo1L6gxcSyJqLnur+PrKgGSARUwbUbb6dnRIGAAbPPEiuyFBOZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504433;
	h=DMARC-Filter:Received:X-ICL-RepId:Dkim-Signature:
	 mail-alias-created-date:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Info-Out:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-JNJ;
	bh=G1YaDgljhMWYy78r6ov/OYhjHLl3ERI4xtxraK2i2dk=;
	b=zo3m3Uezo1RevZnpAGdcjFx68J9tWrvfz4Oj78iLoAvpXn0ehnEfd/p9nmUiZ1vN4iyN
	 WcJ1SehjP+VFmf0j0fzQgM7i84NHcgIgUUEQUgizv7vu+KFART1frdiNhExZtKUZ92sxn
	 sQSL74pNBGT86AdWWdvG5LgNB+dLkSiQXRnx25gGzcT0lwG79ZzeReIUvGspUC53gfT19
	 QP6w9+p3pSrtmMt/ZOWXO3NTqzLxmVq9RcM85iTRr1xhGgZFNFpGKW091Tc/HPky3/4UW
	 3xmmSY62+9ZqBx61ljynL7CahrS9KyyX1oRfhwOXWdQ6TE2baXZt1soMjEGvWBZC16A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tawheed.cc;
	spf=pass smtp.mailfrom=tawheed.cc;
	dkim=pass header.d=tawheed.cc header.i=@tawheed.cc header.a=rsa-sha256 header.s=sig1 header.b=LX5Fzj1y;
	arc=none smtp.remote-ip=57.103.76.192
Received: from outbound.st.icloud.com (st-2006i-snip4-1.eps.apple.com [57.103.76.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F18E606A891
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 17:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F18E606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tawheed.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tawheed.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tawheed.cc header.i=@tawheed.cc header.a=rsa-sha256 header.s=sig1 header.b=LX5Fzj1y
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPS id 5AA3618052D2;
	Thu, 12 Nov 2026 17:27:09 +0000 (UTC)
X-ICL-RepId: 01a1d0cc-8ee0-7131-bd57-891faf1f46e1
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tawheed.cc; s=sig1; t=1794504432; x=1826040432; bh=G1YaDgljhMWYy78r6ov/OYhjHLl3ERI4xtxraK2i2dk=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=LX5Fzj1yoLam6i2fDPLpdwD8uM0IaHj4uqEbMh1UiLVss5+T+R65MaLM3p8+ApXEmR/l9n4l9KdEyhu6UPXurJmRrCJVyfT2dz6eVCrWLoi/7Evft1sNfOC3u6s/Frg2Y6lgNo3TFNDpUAW5ZC7YKx2xtJXa0YtXyIADmTvljrhYlHDrZDwpJHFUOxcByyRlkpXJboNeirQ581Sw8HXYBzB2OsaDD+IDGy4/hPaWJep/ogu5mHFkRq9TO0ydvRRyZaSZQn67UWDcWWEUemo61zFGSHqKaJaWpzQ4Q/c3O7MLIAXll+8yWu/9tqp2ZP9iegTmMIJU3GEdXPKOMgSfxw==
mail-alias-created-date: 1711150425226
Received: from DESKTOP-HUABEFD.localdomain (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPSA id 34B911804807;
	Thu, 12 Nov 2026 17:27:08 +0000 (UTC)
From: Tawheed Makhdoomi <_@tawheed.cc>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jingyuan Liang <jingyliang@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] dt-bindings: input: hid-over-spi: add the Surface Pro X touch digitizer
Date: Thu, 12 Nov 2026 12:26:39 -0500
Message-ID: <20261112172641.407-2-_@tawheed.cc>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112172641.407-1-_@tawheed.cc>
References: <20261112172641.407-1-_@tawheed.cc>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2OSBTYWx0ZWRfX+d2/9DFZPv4J
 jFGlkKNckX5IBnlVSP68mC9OJFUI0/GcGNLU6STtSQ/27Rqusn9yuoSzroNp5bLp17rzJ22tUhv
 fVa7DZNZ11CXKOcMtb3FldUIw+ZkfpgdUY3Z97lJs+ED3SlvaIH4l++A/hawvK9Yt/tZLWmwlbh
 dhssrvbK2ZAq4NsCehPrxciTejpLbTzYn6gCnqP1Tk4UyZhNpvJm4yKJSypMEENyF66b+IhlB5r
 64qPBwD8Ynlwt7aDei07+KzsLsFySHNsX+jn3wtAyVq6zLRcDYtUQWisHF+QzHRdyfOXHRaUsF9
 uA6VQ60f9LVkJj4gQQdavNoksLmeXyQLJW6ewzj3/in+ZUjAIMyFx1OCTQkB4s=
X-Authority-Info-Out: v=2.4 cv=DPIacCNb c=1 sm=1 tr=0 ts=6af5f6ee
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kibvr5HLtuNvmma_iept:22
 a=NVRLzpS9o0UsCidzZbzm:22 a=qbu17giZulXrqSllDoYA:9
X-Proofpoint-GUID: rchbc6Xd6FJgGyVZH4zVT5SrropzxIOp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2OSBTYWx0ZWRfX1rU3IKUvccWX
 jwcokhBSnueyYoTpAxQqL1hLVgTRDitfOQNRUkh6XJNXD0Xkzxww8wQNpptyuOcLZpPu8Hk1mNp
 yzHb5TxKoQ04CpCtOuqntd0sRX8LBtI=
X-Proofpoint-ORIG-GUID: rchbc6Xd6FJgGyVZH4zVT5SrropzxIOp
X-JNJ: AAAAAAABj8t4DSeqyfIq+BIrbvGqz1fyWhtx2MmKarWXW6gQc7rbbp9nNJslPXqbDsYHiI
 H3O3NkfhN1ChyoEGKBAlTmYQ5RjHEaueQBU7WXk82i/QCAsTuz7nYPMecuzgLf7r2PTvo4
 PhqQqshGQJGp5x6WG8OlXWFN1YZaa25YvcUGlJoFeRGs4ffnXMWc0QslLIV0tnGtDl1pzC
 5lrE1dEbA3iYY5mkLRJmNbGOAqgRhka1HOj/K4alR9X0oHFg9sGQ/QLWFhx9islGQQAU1u
 1nBBsbkvcUm6kKu6hYmlo5ILppYdE0VG2ydo2FAD19TK7TavKDCwfUwQ3CiBCn3RW8sLIq
 sJ7IbUf52daSjW5i4t3bxCKfHHzzNv+fOo7QIBXcwDQdYedOvpTyXURg11xOrghNSs7/bW
 /lTnFWyDF8wDo3JFHD9PjdSa55Ty0xe15UKBlqA2xWwbrKhdOshTBg6dNiVJfDrySQp0d4
 vFsgB+ue+Ep1XNGsG8/834TmWEezIoAqCIwh9sMe+op2KRGU4/rPAOxdhjmKrmATGeH1Bt
 sckmwTOPIaVm0/u13BvWtygtN+okTHUKOGx1v1i3vt/bGZ45mEjJzlfn0A7ma2mUHtTEFl
 U3M6Z7ANvXKKobrUsIfPgEFGIlTc9GMjnr0kScDrkCTNn1n0uEGGvJAr6u/RLrMrUe9MJh
 kL4jUUaV/OgoYjTgFkvHY4AHFB5sIEnmxeGMbREY2wzeI26YV/HxbsuHf68XBhAPbqrTiq
 f2yhP9D8NpXeSiMAr0mFhoE833Nlwxcwpv4hiHFqRgcDHJuajXslSKfdoNBf8yfqoHkNBm
 DhFODtwJO14VtFxl7O+3MXpSkZjeOTWVIDdXhESbjQ1t0Yh3

The touch and pen digitizer of the Microsoft Surface Pro X (vendor 0x045e,
product 0x0996) is a HID over SPI device, but its firmware implements a
pre-release revision of the protocol (input header version 2, device
descriptor bcdVersion 0x0100) rather than HID over SPI 1.0, so the driver
cannot treat it as a "microsoft,g6-touch-digitizer".

Microsoft does not publish a part number or generation for this
digitizer, so name it after the product it ships in, like the
"microsoft,surface-sam" embedded controller.

Signed-off-by: Tawheed Makhdoomi <_@tawheed.cc>
---
 Documentation/devicetree/bindings/input/hid-over-spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
index bed0746f0..beb7e0922 100644
--- a/Documentation/devicetree/bindings/input/hid-over-spi.yaml
+++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
@@ -27,6 +27,7 @@ properties:
   compatible:
     enum:
       - microsoft,g6-touch-digitizer
+      - microsoft,surface-pro-x-touch-digitizer
 
   reg:
     maxItems: 1
-- 
2.43.0


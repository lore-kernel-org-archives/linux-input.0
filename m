Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416938;
	b=aBkOBOcwVVkgl8sofjlUQkPfNcLzK5vtsGHHrnA+AsGvkUZ+2Sc9Rht9Vl0QbikHHLDn
	 FpA+bL0cjcBtQasiNY2ks/cXL5ttCJLQg3B0SfhvrH8Rcj37i12feQpJqt+6JLeylgBHk
	 WWrSRqXp7Un/m/nBhioqNRp7njG6n1kRIHhzwuMdHubbfDMDK/+8x1jeig3KOpni1dr9L
	 eZ1qWuzjVtx80IFgn3b0knr1Q9mXa6XH1rVYKZwGGKZ9FNM2aHnCX4yz5gMeFM8qYnSO0
	 fh/f0XTXpddIzfltN8SG4tsk1yIsYQF8PSFBkkheJGx7Tpv3cf5R53VCMoz/TGmoenA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416938;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=CArIVjyNi1DdLLI1Xo+6NV2Inj4tLWeam02ZRhLj0sU=;
	b=q14mJ5yrcgAKCIk4fYy0ki7kVohnyQhCz9OMawO1+eqAnQlNX8LZLAL7hQtdqkOZxdzn
	 NgGY69pueDT0Gqn+y+6y6a4I8adznz0MOSx0gATUdZj9OB/xtb4KS6+3Cv1HO1d9rjMgm
	 P9YTOsgUWR1A4PeJn1mQcd/g/VyOOj3TLU6H4Pr8h7PYKlCWF4LzEEefZ0S5PIq5m3DEA
	 vgYaUUybDTofDGn5G6gyFXn5VTRvOPBBdPAPUuBB5+TkoqKxrxawdf8GgxH0/shthP4/h
	 skWm5/1Oow+FU2DZtDtooJYxdyx4fZaHrsK9chYdxiu/pvhgRbkbOku8yrqoU+xUzCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=henri.ommer@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=bE8bEooa;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D57606A339
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 17:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4D57606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=henri.ommer@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=bE8bEooa
DKIM2-Signature:  i=1; m=1; t=1794416934;
 mf=PGhlbnJpLm9tbWVyQGdteC5uZXQ+;
 rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.net;
 s=s31663417:rsa-sha256:ZMhA/tUR6O7OE1dc5lobL9sGpaEu
   oxBHeY+usGm3lVRCsFhPlbTPj3DZaz59nHLDFzfr+0L2HplynczM3cZOsCOnxJ/CsLb48ywf53/
   mnod27ubUWFLT6ccOQPr7+AQID8drDHJ/T/8Gjny7mQOJqCgiAc/NkuRvMSlDfcCc0UP0OISVh9
   gR94UM8ADMixCbQyEi/rjiEd0lBMo4AyBEr8Fx28t8No9bAEE78lm5MJEF/XTgWJi1KAwopVplC
   +CDOMZeNS6nA+Y8r8MZidG0k7MkAPJaSnpPTqxBP0n7qzmpZnaRJGQCD9iEoP2XmKsuq+MODlHx
   cc6kdLIofJ/rbg==;
Message-Instance:  m=1;
 h=sha256:
   cyABrvZ6nXAvy7YdNlx1rdjnKmfbIKzv/4kOS5ERsz4=:
   R/D/xO9eKJZycpfyOOBKs/eVBuKuBDisXjAwbfIQ6ZU=,
  sha512:
   jzZJFyFZg/WxnqyaDwZUBuOYf1uVLZ4SL0ckevyOS6piGENlbmzEz18ILKmjB61cYHNpYSvwQNLTOJPpibaykw==:
   SR12AkSEPosM+u4tDqubMUuIQ2BIfx5+O+NQ2iU+lxRyB0R6Zf4WB0FQQAsUnl2FBnKXI4BuKROY2Ft7NgxqhA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794416934; x=1795021734; i=henri.ommer@gmx.net;
	bh=CArIVjyNi1DdLLI1Xo+6NV2Inj4tLWeam02ZRhLj0sU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bE8bEooaFj0lu4WuKIvhOAGo1sGoF7SA0HZe0iA3Y79DygJu2KtvcTkqipYmR0xN
	 MHJQ2KHHBi0qWZVBFNlfEv/cPH4z9YgXxj5CSvTwb78ACg7NoSbRcmmIfLvJ6szhv
	 9QXwjgDgNzT8C/mpQt8YI+dhpj3yGcomnrLEdBJAnrQ5MML7ZnCQFQ4Tm2m4ngnHE
	 9pEorVGc9SiwIkJnQl+odKl/HRhN61ExMhBHfi0724O1UPFg53wk2jBUiCXsRj9Zd
	 yylSiXEE10+brAK6M5TV+P/AJd5tgd8kslCBaVRdSv9+T0G7Dj1yx6YyCiMv7xkik
	 duZs6dL6UWtwIN8ixQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbgE-1xAlxZ3iJQ-00Nx7E; Wed, 11
 Nov 2026 18:08:53 +0100
From: Henri Ommer <henri.ommer@gmx.net>
To: job@noorman.info,
	dmitry.torokhov@gmail.com
Cc: phone-devel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henri Ommer <henri.ommer@gmx.net>
Subject: [PATCH 2/2] dt-bindings: touchscreen: trivial-touch: Add hx83102d
Date: Wed, 11 Nov 2026 18:08:51 +0100
Message-ID: <20261111170851.2334-1-henri.ommer@gmx.net>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PXW+kykLxlcqwnTeQZnYRQRQvhvLAHHF/uB+ddpUEabMg021n8D
 UjYYGcSL3VXYDCkvCCQKclIFm+/9nHmbQY17iZ3+fApHHL6fgbBdvi3pRqLczDmVeMcFW5I
 BqmoZqTbvnfL0QF5GCFcTgbxJ0i33lAV19leVwS3GP1c96jbzTNuJvKjfnjeAE4A/k1zDcm
 Tjnity/jpL3zZZmCyX5tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a6LFJEvVa7I=;RtDzadSFECiBy+4BFzEII2soQeR
 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

Adds the Himax hx83102d touchscreen controller compatible string.
The hx83102d is software-compatible with the hx83112b (except for the mode=
l number).

Signed-off-by: Henri Ommer <henri.ommer@gmx.net>
=2D--
 .../devicetree/bindings/input/touchscreen/trivial-touch.yaml  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/trivial-t=
ouch.yaml b/Documentation/devicetree/bindings/input/touchscreen/trivial-to=
uch.yaml
index 6316a8d32f39..d0ee79ba096d 100644
=2D-- a/Documentation/devicetree/bindings/input/touchscreen/trivial-touch.=
yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/trivial-touch.ya=
ml
@@ -16,9 +16,9 @@ properties:
       - azoteq,iqs550
       - azoteq,iqs572
       - azoteq,iqs525
-      # Himax hx83100a touchscreen controller
+      # The Himax hx83100a, hx83102d and hx83112b touchscreen controllers
       - himax,hx83100a
-      # Himax hx83112b touchscreen controller
+      - himax,hx83102d
       - himax,hx83112b
       # Hynitron cstxxx series touchscreen controller
       - hynitron,cst340
=2D-=20
2.56.0


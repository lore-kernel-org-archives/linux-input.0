Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B43A4F5C;
	Fri,  1 May 2026 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777639244; cv=none; b=ocpRABj5eBsNllHJ1n2BH5HstcW4DzysPduQFhzVjh5AZWenGgSfslrlzbvgz40Xn7bk5lwQqrYdbVa0GyH0Z7PeW1j1iNoBdXi5MvlflkoJEPVifXoqk5dIvURjmD8TtfRvYpizmLTKSVaYJJXssl5pZiRCAkaoJPsfhNgBAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777639244; c=relaxed/simple;
	bh=kkdbuU5ZmfZeUfc75/z26T1bHziufO3Mg8Ox/NZv7O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VNojfW6LWgctu2a6+MWC+J3iNBBRUcyoFHjxwc4YD4lL3xFXMRuSaaCQUCgqqVd2Fi1zUAuwk2PRWA65Mexg+AZBxNG/OzPmh1DAubXIJziiVNaXFbayT77HYulswMnvaWrEehq2U4Dtd/BCiuUojLmjIuIntkD1aqAdCW4UALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=sBvr4NIs; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="sBvr4NIs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777639231; x=1778244031; i=hendrik-noack@gmx.de;
	bh=CjsSnpQ12gvKsmGHBmflJ6WdlAazlOtfkfbklASlxcI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sBvr4NIsVB3oLLIuSKgJer3gk+gShSZ/npEaZn3pus6DRPiDd0+B1XdacnkaizFH
	 CUaOzs+mzxtqJNIlcOoxbzmoscHo2DN9m9bPR2V8I/kUdm1Ly1fLGNOM7H+IdtxYO
	 LYWaidMGwjO4CSpJLZzdr7lTEn48osA8Mp0VhJjWVch3vtlQYR3B2RkSSZpmdc/wF
	 hrv+OOhlITu0O/yJ5zqlCBDIakX/+VtHgbt5+lIj7RChGhxIjq141NScMcU4j1EBm
	 d+34rEXE+aaouKDXCXanpjtM9+tsok4UEMmIS4is+u1mXdIFBiztpRv9cqp54NhcO
	 aIU0+E5TcXPCJMiLaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1HZi-1wLWzN1Rdq-00Fimj; Fri, 01
 May 2026 14:40:31 +0200
From: Hendrik Noack <hendrik-noack@gmx.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Hendrik Noack <hendrik-noack@gmx.de>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] Add support for Wacom W9000-series penabled touchscreens
Date: Fri,  1 May 2026 14:40:00 +0200
Message-ID: <20260501124002.132540-1-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s6E7fxCYzFGnT3eu40pLGRWB5bXmNfj+Xm18cWIcN9t+WU3xaYe
 xOaeKrOYiw7KVbQKpgnT/4iCmIRgcKtKX3OLTR8f2xnI0hpg3e8EQjx4cQ4uQrCNU31acXb
 CIqu2L3DD0X9splrnSMRBwG6Jkjo71MfYbf1sHWoTKiJCktIm860tO93JzIrMPGCYTP3jb7
 E91VanzbcsrJA+GT0NE2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OwZcjJwuJ9Q=;7guZk2W2M+GuBeI3xdJdC70cwuv
 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

Add devicetree bindings and a driver for the Wacom W9000-series penabled
touchscreens.

The driver currently only contains the information for the W9002 and
W9007A, which I or Ferass could test on devices. It should also work with
other chips, such as W9001 or W9010. However, I couldn't test it on these
and the message length would need to be added.

Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
=2D--
Changes in v2:
- remove pdct-gpios, as it's unnecessary
- fix devicetree example
- adopt to kernel coding style

=2D--
Changes in v3:
- fix missing include (thanks lkp@intel.com)

=2D--
Changes in v4:
- adopt to feedback (thanks dmitry.torokhov@gmail.com)
- add W9002 support (thanks funderscore@postmarketos.org)
- add reset-gpios, necessary for some chips
- remove R-b from krzk due to changes in dt-bindings

=2D--
Changes in v5:
- adopt dt-bindings format to suggestion (thanks krzk@kernel.org)
- remove pen-inserted functionality as suggested (thanks dmitry.torokhov@g=
mail.com)

=2D--
Changes in v6:
- add info on difference between variants
- add A-b from conor
- add warning for out of range pressure

=2D--
Changes in v7:
- address feedback of sashiko (thanks dmitry.torokhov@gmail.com)

=2D--
Hendrik Noack (2):
  dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
  Input: Add support for Wacom W9000-series penabled touchscreens

 .../input/touchscreen/wacom,w9007a-lt03.yaml  |  73 +++
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/wacom_w9000.c       | 446 ++++++++++++++++++
 4 files changed, 532 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/wa=
com,w9007a-lt03.yaml
 create mode 100644 drivers/input/touchscreen/wacom_w9000.c

=2D-=20
2.43.0


Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815F27FB37;
	Thu, 28 May 2026 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954505; cv=none; b=CLL1R5C6yTyAZ2PPjzs0G5jGjZ6K40jRFZ1rwzpy4KmJYikEJVc5pM9MROV4xkd3vW+lzKE56uGkdaha2EapqGvrEhfle4NXovyWvjXy+oOhrihu5l1HO3YdRloY/Moe4vV2LWntHUYylQy71z8Lte8WMTEIW63GHkBDrJgn7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954505; c=relaxed/simple;
	bh=X4lr4iJ7jAjklgn9XmWaDi38hkHYGW0QAK3YuQ5rWhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+LJtcHOHv/wAPq5ukscdcvRHhDP4ZCobV04MNrjntEG9Zi/4GMfcPHpy9l4mjoSeN0fMocpsZSZIxMUO6kMDFwTyjQVuddwRTa9vzrkosL1iUmeC2y+PhOB2BVb9Ab7Dpaco+iPp4c+S7xT5lce5Q2ZgXhQl6aKmlrE4TnYMsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=ltWeX1oD; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="ltWeX1oD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779954501; x=1780559301; i=hendrik-noack@gmx.de;
	bh=n1UsaeBVHcgkHkYlx6rzWwiZuK7nHsF02AdKc4LLlGg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ltWeX1oD3nU6IWW0h9dYJECNlziu98UOkswXmnl+YI3Oeh174GG8FlnK/zWiXaeI
	 MRKb6Q8crVABDbxc1M/15EX5jlEvdMGSMXD9Gr8R3IHj9TPicVKgeQ07HZI20vTgU
	 XY8SLWtwa9JsRe+DSFO0/38nQ2Oe1rf5uaz7xSfq18vqUz5vPpyijcWDnl1wY+GtA
	 yJg9gAiMOajRQtBEDG7OubIH7OtmwzKdUnYXhXijGteSDLsL6q0nogQ7pogOWMmWK
	 /y9ZuU9p97uBFg8/c4ggFPLq2amcS4X+JGfj7aDMeH/QeZ9lab7dVbu7t2paOm0u/
	 9gw05UQReAv48Ei3hg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42nY-1wSVTZ23vs-0074Iu; Thu, 28
 May 2026 09:48:21 +0200
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
Subject: [PATCH v8 0/2] Add support for Wacom W9000-series penabled touchscreens
Date: Thu, 28 May 2026 09:48:16 +0200
Message-ID: <20260528074818.12151-1-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dj2rSZ4iuHdMhICkNKu8H2aMs52LJO5pMDL5F+4SSyNXVU5ir+i
 BvhI/2zKJ11Ocu1dPWPqhXZ7G0veFeSXoPW8oYRktsn6qsTsOWlbFnDevBC+CgN7sWbah4r
 h/xDb8HGJ18NIO81qvpCSm1qFkoBhD5Z69edLAaR172S84LyQ6DhOvn3SnANULu9nPd0NGv
 8hSal4pQmbJk58LgqJX1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ftWNRICDy8c=;riuD+X2KAAjzwZdducapiveegSs
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
Changes in v8:
- add regulator and interrupt headers explicitely
- adjust some data types

=2D--
Hendrik Noack (2):
  dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
  Input: Add support for Wacom W9000-series penabled touchscreens

 .../input/touchscreen/wacom,w9007a-lt03.yaml  |  73 +++
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/wacom_w9000.c       | 448 ++++++++++++++++++
 4 files changed, 534 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/wa=
com,w9007a-lt03.yaml
 create mode 100644 drivers/input/touchscreen/wacom_w9000.c

=2D-=20
2.43.0


Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41237C113;
	Thu, 19 Mar 2026 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914018; cv=none; b=dymYtUnYsv1PdTl6rA/A233CZMBrg3o9qQ/vwMrZRyCnOo5RFoOd+UT3uYh8UiU7wCXLjmYaBojtasDFP8borbc2AVN68hqQke+oSZc/X8SpvuwIrRwjUcTuB9GNu4K5nRiTWozViy2o40v9lr7HYdQG3lX9KQsj00mi+oqeOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914018; c=relaxed/simple;
	bh=mCf6TzakKWdQRfn1JaaUibux7Kr26nRJL0Rxv0fKZCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkMiOTclXVGMtmqAkOQ2VqEu5oHAgbdbHcCc8GW4yI/eX0ld3xHtX/JNShFTr0YlYl8IK7ihMyTxcKdEzi8+KM5O99ZfdTJ9eb/lG0r0PR+ROnTWFQai74nhpXrzL1ww/0YqOjzZeOXWePlU7tZmZb6WU481npSe3+w8jUCy9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=P6PQbaW8; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="P6PQbaW8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773914001; x=1774518801; i=hendrik-noack@gmx.de;
	bh=IHdZdnnjSzHh3sK2VifH9gKXBB/xhZmP1X8ox4Ld17w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P6PQbaW8RFnOavSnxb06OeqHdyQNDPCTQeAt5/dybzs1N218NUNpbFby4yZ9uPVs
	 e/4Jqs+8+LcGZxd1BQoPMiqZZI++ZgBMmR5gkkCw+s4SKgrEPbPWX3pG51nWAZebs
	 JhEFNzFat5LMin+Vj+RKAPGAGj12c46/LQfctFs87dYcPPKE2pO7LIGSN37b5YMw/
	 ItWzHzyB6KuZwDkygW9Z9BSKE49jJ0HLiJYM1MXQEiKG4INXb8bDqE6cdeXDbE17w
	 GhNuhHshs5V4FrnT00I5Cy6cT2WA+N6xmKxOM5FGcTXP7fiq2hsIOf5xvGP7FuaA8
	 g8IY4ng7w3z2ESqmjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9uU-1wK8ig3SnC-00VV9D; Thu, 19
 Mar 2026 10:53:20 +0100
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
Subject: [PATCH v5 0/2] Add support for Wacom W9000-series penabled touchscreens
Date: Thu, 19 Mar 2026 10:53:01 +0100
Message-ID: <20260319095303.19927-1-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FW6iE4xh/T9ZoYcC6Ot0YreSwf1DUiBxkhbOxTceys7T0PaqbGP
 rh4Ie7s9uDvcTgJWKYHwEe3forJLFWK6Axlf/XCdyvW6wVlyQ4+Jlq6yG+gpptHQ8jikX1O
 Sb2VTemegxjvDna5vNAXY3xEf4pOWO1kVTZbvoLuYJIJI4geX7ael3g73KDOETMhbWzVJY0
 ggH6aEhaZrfB5fFaD5DRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fFq+S2O1Wts=;8dBOsZQyUiCMZe/ZgDa5D0RgmDl
 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
 zOHFTkKPeyO871wdK7K79z5Q==

Add devicetree bindings and a driver for the Wacom W9000-series penabled
touchscreens.

The driver currently only contains the information for the W9002 and
W9007A, which I or Ferass could test on devices. It should also work with
other chips, such as W9001 or W9010. However, I couldn't test it on these
and the message length would need to be added.

The pen-inserted-gpios is used to get if the pen is inserted in the device
or not. It's also used as an interrupt so that the power state of the chip
itself can be controlled depending on a change of the insertion state of
the pen.

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
Hendrik Noack (2):
  dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
  Input: Add support for Wacom W9000-series penabled touchscreens

 .../input/touchscreen/wacom,w9007a-lt03.yaml  |  73 +++
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/wacom_w9000.c       | 433 ++++++++++++++++++
 4 files changed, 519 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/wa=
com,w9007a-lt03.yaml
 create mode 100644 drivers/input/touchscreen/wacom_w9000.c

=2D-=20
2.43.0


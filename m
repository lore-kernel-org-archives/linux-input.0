Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DA013D638;
	Sat,  7 Mar 2026 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772907404; cv=none; b=EJtJZNKJYCQS6o8oYOMbfiBvhh+f0QQjLioZsv0hwRzbt5ad1bFXkvNdjk+DffcokOowGq2Rpglh+i25oEzBKT1+EkCuZPRFok3v2c9G7dUjWU8VTsIb7L59SMKeEScwgVJmwmKZweqXHAu4CUy8pZil5eotsqi8eAIjnu/qOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772907404; c=relaxed/simple;
	bh=Vkui4HrRL5wr+zrB5Wlafyvd4WT0uEJpKL7tXzwWb24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LFmI35T9uD0ajB23w5wHQscf+V7bl7jaaVTyGKXa3Jmy0tCg1l71OS6etcvnuJWHClkqSPmxA5poQYyRos/a1LJxjaEHrhwu8zfGwYVTkr/7PVi2njO/KBq6cDX87W3wQQ8F6nPmdEmv3EV4F/SCQkjBhTbhp/p6sIqrR+lxZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=BPr0hJjh; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="BPr0hJjh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772907400; x=1773512200; i=hendrik-noack@gmx.de;
	bh=WDXKWlohpBBRkVR3G/LmxXQjorPvhP3eEe/rKkhbCuY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BPr0hJjhyNVKMTeowTeO3mh/f1GhPypcmhnczzwppiJjH7rfv6Yng7F6xZng2wCj
	 xZAMdRH+awJb/9pNNSnVpvzKyp3j4tmNg99QoOx7k4hllV5RFFQl6pQQ8FlchJUrl
	 bMV1DiKWAFseMsjfW59QDDl8N2KBfjte4YDhy+bBmpdymzjISoLn2SKvKEauXrchq
	 1ELN43XEoP84csuexvl+rU7/f6X/exzm0wBTpo70Znq2u7hrpROxcIZAEt1eq93X6
	 5q0v/r2R7m/Tt8ac2eQDJRcEiDZqt+8f6yM/gznHsH7EeO+cJNZBQ+1dFznqJn8on
	 3jnVmDiP6aD4K3jpBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1vh8Km2oGl-017XTu; Sat, 07
 Mar 2026 19:16:39 +0100
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
Subject: [PATCH v4 0/2] Add support for Wacom W9000-series penabled touchscreens
Date: Sat,  7 Mar 2026 19:15:31 +0100
Message-ID: <20260307181557.66927-1-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4k81wTUobrXbhuViWxHPKtxvnEXh6l+xPLUuUrLSlmao1WyN6gF
 1x8xZgMDrt012dVWwKrQvrJMksUn/mjmdtXzCBNkr7+MyfYjnq4R+6V3F27xjx14BL0FsaY
 Q+LmStnd/zuK2MmPbt+BRz8QdxyQx8t5GjmiQG2lrO+w96OyLQ6YSSXjp5oDoGiSCMge4ms
 7dmM+5tDwgm4TerGJew7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zHWI8dcni/w=;EGL51+I8ncquZWPJJK9LJ86YmMQ
 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

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

=2D--
Hendrik Noack (2):
  dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
  Input: Add support for Wacom W9000-series penabled touchscreens

 .../input/touchscreen/wacom,w9007a-lt03.yaml  |  86 +++
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/wacom_w9000.c       | 510 ++++++++++++++++++
 4 files changed, 609 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/wa=
com,w9007a-lt03.yaml
 create mode 100644 drivers/input/touchscreen/wacom_w9000.c

=2D-=20
2.43.0


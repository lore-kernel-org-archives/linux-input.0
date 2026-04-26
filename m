Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396B34677D;
	Sun, 26 Apr 2026 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777211964; cv=none; b=fmXEkAV5AuObe3rR75yWZhDDxUw78F94NoV82EQd8GwWNjeWIZXYo0/iMSgCohV3ilztIGUgGjepALGGDM53x/jCRTnRfvjmdjBJTT7PBOBZtnoe1gTQVhQzJn4lv1xUKiHoCVERbXf8yO1Dq7TDFmCgWYL3i2LcvK5WZK+KCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777211964; c=relaxed/simple;
	bh=psjHpO3qaHhZHbh8NOXMhopQx2RB+XiGJCoc+eUoEPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s8T+3WPqK4FjpFYTh2sxkCzERaWyGAFRmBQXCU5i8EBTutIjkA1E8ZpkCspcscJfLwSPoK273N7+BNWIWjrdd8XMGoXQ9q/0DTdTKV6b2CbxBD9TAmvvaPWeGDksQR4/+S2VHBZtUJv/RKSGZ02qor9xxOu85smNC3ZYPtni5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=FSVZjFmX; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="FSVZjFmX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777211960; x=1777816760; i=hendrik-noack@gmx.de;
	bh=PRdFGqtl2GihYY24KMvFfz94uBnoMK1MROt4yVCQKzs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FSVZjFmX5IwzlWqUV1ZCcVySqqM7OojgKkTRVyXoi8wg8DdvK66eifl82U9AXK/9
	 ziu2DLyflRYcAd/8dIdcyZWZup9r+VLZNjRqxMfxLHrLXqANp+ziwciAj/4JyMR2B
	 NlYJTfpur4LUP3AsfUZFNcfj/CvOlNfyhblXDFbWCRLylwu+doeLJClYlSbVfCsMV
	 /hzZEeoo3kMYbBtS+3flTJi1Jh3/YnYuaU0wsYmJp+e4NKZeKwfs/r0AzH5e8EmL8
	 dZUieJ1FsumkLsFgS6JBUxlAitmxAjBAFcxUBfQF7FrUtg3m/LjIj4UqnPVyX45Tt
	 YdQ+yMVt2eJOMH0pDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3siG-1vHe1I0cwy-00yGWk; Sun, 26
 Apr 2026 15:59:20 +0200
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
Subject: [PATCH v6 0/2] Add support for Wacom W9000-series penabled touchscreens
Date: Sun, 26 Apr 2026 15:52:30 +0200
Message-ID: <20260426135232.371272-1-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i1Z1T7ljQ3AUsVQBFXiDh02RZ0Vz2YFL+HBm85U9Uyp/lPg4B+6
 3D0LYXVqp+9O5Kqd/wWfYhUwSz9Pg7LqSzt8Yco3/J7Jg3CUFvL4jZgUKYLnxRE6POVVQZU
 3fZQJ6JHyxjoWmk4ar54Td9+AwvadKRW7pbsmSjhU16myLzaG22oZym+kLQrG7dxAjRTHQE
 nqLIN+TXiy1VkBfZWxoOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NHCd3rsJW0E=;qpXGdBbkqjXQsoU/wHCEacvlZep
 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
 kYPfdLhwGabe0WFs2YXMiGZf/jOyDxy8WbE4=

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
Hendrik Noack (2):
  dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
  Input: Add support for Wacom W9000-series penabled touchscreens

 .../input/touchscreen/wacom,w9007a-lt03.yaml  |  73 +++
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/wacom_w9000.c       | 438 ++++++++++++++++++
 4 files changed, 524 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/wa=
com,w9007a-lt03.yaml
 create mode 100644 drivers/input/touchscreen/wacom_w9000.c

=2D-=20
2.43.0


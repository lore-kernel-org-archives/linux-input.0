Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219881;
	b=FNRzwmEKQvSgrEAGLT2B+8kC43DZYoOjspcDcx9Vsu/Q4oVZXx1OCK5z/kkYdrMZaYmm
	 uF+XETQ+cnOAPIuKD2Mg3OmkzJH5X6XCeIkGQoI5icvrE0Z1k16GJBdTeXmn9QxdAcuci
	 a31Og7R9fR5fUmTB4xObTbpSBOF5lPIdV9PLs9kLdsFaRijbkmEL/f+6fyzKirnHkCpbc
	 X09H3JADmwFi0HOo1Atr4we+xCum4S9eIDYEumnYdQvdXb1i5h+vl42pthg+8HTvOO7D2
	 vUfPuWT8ye+bEINwSx9EUwvR84dME/cSDeC78OWh4boB7GtSZt0wVmwJ+ddKTc9Y/Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219881;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mime-Autoconverted;
	bh=3XKuvVAJ+6M98eQ1s42/Rn4WKopdsE/r+V9jUmMWZtk=;
	b=1DfUIwmsrlzZ58hl6QQURqsRg0Mcu7Wy3cOnMNtyK36fXda97LFCqmbMjI9/IwhVyOnO
	 i0k2hHxJm99mnwrGyqP7EqGToqDLak9D5PuVC5KOKjM9A916a0aZIQnRSd6kDgy4/qYlS
	 a+LyeNMGNxYxTfV6ea7PTodCDbUY33O4BtjGWUe6R81vdjZoUdxgi3Dx+aKsp3mkRN6gu
	 nwfUSePMvtgzzkFFgXDiZ8hm5Y4SGwvca/SKxl0Oun09F/ztPKME/okXPp5QFdqLyXEy0
	 lg6031rySGEQmCTEuOtMSijkaNVXYSPcgea5clbqa2UO6NPHNAFwbfY+Yrvcl+09Kgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=irl.hu;
	spf=pass smtp.mailfrom=irl.hu;
	arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 68ADA606A31A;
	Wed, 28 Oct 2026 20:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68ADA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68114.dsl.pool.telekom.hu [::ffff:81.182.129.20])
  (AUTH: PLAIN soyer@irl.hu, SSL: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by irl.hu with ESMTPSA
  id 00000000000808F8.000000006AE25D27.000329B7; Wed, 28 Oct 2026 21:37:58 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,
  Konrad Dybcio <konradybcio@kernel.org>,
  Arnd Bergmann <arnd@arndb.de>, Gergo Koteles <soyer@irl.hu>,
  Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
  phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 0/3] AW86224 haptic driver
Date: Wed, 28 Oct 2026 21:37:35 +0100
Message-ID: <cover.1793218514.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Hi,

This series enables the haptics of the Motorola Edge 30.

The first patch adds the binding documentation for the AW86224, which is 
compatible with the AW86927 haptic driver.

The second one contains the driver. The AW86224 differs from the AW86927 
in many respects, so writing a new driver seemed the simpler approach.

The third one enables it in the sm7325-motorola-dubai-common DTS.

I removed Enrico from the v2 recipient list because his email address is
not working.

Gergo Koteles (3):
  dt-bindings: input: Add compatibility for Awinic AW86224
  Input: aw86224 - add driver for Awinic AW86224
  arm64: dts: qcom: sm7325-motorola-dubai: Add vibrator support

 .../bindings/input/awinic,aw86927.yaml        |   4 +-
 .../qcom/sm7325-motorola-dubai-common.dtsi    |  11 +
 drivers/input/misc/Kconfig                    |  12 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/aw86224.c                  | 582 ++++++++++++++++++
 5 files changed, 609 insertions(+), 1 deletion(-)
 create mode 100644 drivers/input/misc/aw86224.c

-- 
2.56.0


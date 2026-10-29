Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310394;
	b=icB4v0uAbwBL2wAhXuADTO3+dwyKlqZPXfArkVsWHQTUKOEE2at/rp7LxJ02cANfgTwd
	 D2AtxjRAgJqPVuKNUYJC0JQsEuV0LwIpbbzpc6D/2/ce3gl7BdxcaMox5YHcSaFiEP7Du
	 z0Gr7TQva/A1Lb81Orag8iijTNVjO1GsQ+2AT9bi6cBgPbyElrNKkNMbaVCV4viT/6eUr
	 N2e5hBmJ/70ukeMzIKiS/2bHHtScC2pouzheW9kT47vIvYKF4fvalNDM9RfOtgP0Sg2dX
	 Ax1ZRt/m7peAxlgZMvKZn0clxl0wSfq9jQbuQbzSrHH4uUcV5fQcszF7qRbMv6FgaQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310394;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mime-Autoconverted;
	bh=04LMkDhbrL6DP7mew2dKrJK4JmZYGpbNrQFKebWxKY8=;
	b=Du0G0FOrGQ41Nxl2nweNuuml1IY4IsrehnQitLYi48MhaY8GfBtRlrMRtmEfjXmEU0ed
	 ztf/PN/Hmq6I0jOhez4RYm1KUpYOX7Ul66kW13hs/FxlgLjztrqOCGLupnwpHSIl9L7Z7
	 z1qd3raF/ANPymxiVvk6C/HpMaGnB3a6Ow2xoWHHGUObMRkSPbAyDnfvfk8FzKjzTwv61
	 dQjdCYNGzOPqV1owHU7H5TDM7YCUZ++QYu40kChjxfmRCEzpETCfvTfw+Spje0uTNSlJ/
	 FA4bvPJzPnrYYvhF7wwYm/eN6GYbHrdYJAM3unoMSb+gQEAjDerjHyUo8xOtBpBttyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=irl.hu;
	spf=pass smtp.mailfrom=irl.hu;
	arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9BBD8606A31C;
	Thu, 29 Oct 2026 21:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BBD8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69268.dsl.pool.telekom.hu [::ffff:81.182.146.104])
  (AUTH: PLAIN soyer@irl.hu, SSL: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by irl.hu with ESMTPSA
  id 0000000000080988.000000006AE3BEB2.00036878; Thu, 29 Oct 2026 22:46:26 +0100
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
Subject: [PATCH v3 0/3] W86224 haptic driver
Date: Thu, 29 Oct 2026 22:46:07 +0100
Message-ID: <cover.1793308351.git.soyer@irl.hu>
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

Sashiko found a bug in the 3rd patch, which was fixed in v3.

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


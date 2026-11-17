Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919191;
	b=Qmhh3IBE+Pe8pbfRKAjCMfAXUHViebBYYYC2VAMfyjXvsEWbF70rrSO56S/WzCQWrPOB
	 IzAvyNGo9EN0XLBuEwgGEjiSmhDCvldotGVkj9IUu/8wNwzJhDv3BxfEedeUJo/huG0X7
	 fIyDfVIrxy/1m02SoNIdfg5G+hp/Nybzlc6w/lDU+bCWKqSXN2/tjMp76ZOCvhNbyxLE/
	 vNYDsQAjY2R86sQajCiKObzwvTkqCBwxBCSfd1m97NB20VkZtnw1eREGsSHa7gtKiYxZE
	 nmVTlkxKsP37361gBdDgCr5HRBymx3ob5e9WHjd7HEFhwNelKpAnXB+JfoD5t/IV4yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Yf/7M/nDCTW8ZFPsGSaUmFFI3kKEtiDdHsd3kIU7HVk=;
	b=xK43OilOGWFd/f0kMBMr03pc6p0mMhqOWkyxe0FzMf06Q5CBMsaUdOqLyWWgDZfS/Jer
	 3iEhxifv5RJkYyewIniCT0XV4Ael1Jf5NEdpvWOnKQAblU77kqzG/blQ+2LS5d+k97pYK
	 go4tIuOBeSI9WBIW/nCjj6NzU5hs3puYqOlySqQIO3bPCqqocBTh8uKOs16wCTlP3hKqt
	 SlNt9N4cBlmQLIIRbPiLvnLDVlcC/Kbb8HYEo3F2CMNE4URpjIFicnsvEy1XWhDyhdfvL
	 CtMvOaMarqSfX9ShuyDjUQQS1E1B5fh1mzjxUwd9j6nphhPzWCn1qL8FBWDAhBCErGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Om4lJDcv;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE38606A336
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCE38606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Om4lJDcv
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so30978565e9.2
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 04:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794919189; x=1795523989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yf/7M/nDCTW8ZFPsGSaUmFFI3kKEtiDdHsd3kIU7HVk=;
        b=Om4lJDcvRTZnmDu3St2YFLuaMpP3U1G6F/IlFhPrRtbqeocCF/Dh82A8F0RIkcjYJS
         VssVIIFxYm+xPYX3l3RIOi0uY1st/9+ZuLWeF2mzpdQFkod6DqOs1aaIwvoq64K3fJhb
         B9iK/0Hvggz1k4FcxtggByjel1j0AdP/fe+JCj0N823NP1X4gwJRYMACpM4Dw+pdGQy1
         HwDFDYJobvjTO3alxk7xvANzObwpvs1r4SfbVuqshS2YOo5io4EZWa3Gy6wtWQhzpvpO
         3IBwikamk3jmLSdlOlub58OAvjN29ySqdaW2GtmUaNNT7TvPfUh8XFVftbNkpTVIYnW3
         FIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919189; x=1795523989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yf/7M/nDCTW8ZFPsGSaUmFFI3kKEtiDdHsd3kIU7HVk=;
        b=Xxs9NrysPYnrZ/aJjLNv0EIf5traSWB4KqtDxSppalMpqmv2VGeettjE26PTFGx813
         0kL4vEawblEpzj0Q+08IEiR86gKKTFDVJ3Aj15W7N2sptFA52zlTk+8eCLg3ij3zkwd7
         kwgyjqy0yXzoi8ysRJXcxBeWMlELUVg/d+R+cjBMiBUcA3A20Wqw+3xLrjqZp7UbUNXz
         4LPOGZRMNGtZEGIgvLcASEfDYDjSVaqsVWXjvdrQ9I+smwMr/hmgzXGNssbnyi32ETIN
         hEY1m5lXdow7MAJU3qRdMB7myx+Bt7JoieeL2OAc2HPDBw/PSqIvMhX4b6GSrvSmYK2D
         byCQ==
X-Forwarded-Encrypted: i=1; AL+hErFTSCcSfG0INEa0jot3rlTShYV+NjuMk8/TFMXyrTqS2saFmYm32EK0k5LiGaNgIypVuUkks1oZ9byvrg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9yIKaMx05qxDbnNhaVmG0gkd9NXLhbw6Cbof24WQBZby1QmCoE
	3QJ+tXC7KDroX0HwxTRWt+I3KCCqonMx/9vcDoyduB3ROrMKt4KnO2vs
X-Gm-Gg: AYBFou14Nw4wdGw/aOXQ1DRGFRo6OtVF6OZ+YFo1DnRsiMeb3zGPJTVM3ihALX9beUf
	lG8r3Xfyd0GG/VK3TukjjqhKsl441Z5jznl7SbRMzMgRPQo9AZfZ6aKW1V5S6Ip2Ucz+c2HtuZd
	3y8PnkdxoEo/efnEwBwD7xRe5cUV/pMZH36v6EfrPack7znegBH/fUziTY+0iyR0lDWhqlzrDB4
	5s2dgVbjSZX1cNRDV4/Mv+YGq6Z2l0J7XylIJXHkl5zlSssgw9xOwxfIZcs7Z1JRpg1G/oG/+nL
	U4tdA1mYU9xj2fiej0yrHgO7QpEv+mN5qpizEREaQ35lMbSsLILy0+O2llfv920Uc55KNmzJxjE
	uup1SNmG2MSgjk+L+BX1gQZgvqjX/g4y5O+5vlBari0YBIl8Bvp2gRDbBU+fG2hbPLSZ0I1pKSd
	ZMO3qZ0QMuUpvQFUZCrdjmq+YRtNLLm171NGld2IQ2Tl4oUJ9KppttmZkGyEnq1dlrs3/aDy65z
	6fnvcw7kpujlgtXJpBYtvNWc4dhwB8//eU8MKPyKkrllzxiUKPQSaN2Ms1EjNoy54zrFKmB7G4Q
	gqjoYpEGfIFuDRdpaz41kzcVQztszM6lBS+kCv+rgRl/Ekuu2X+GfBFrT2rEJ1h3PwG6Qg==
X-Received: by 2002:a05:600c:1c0e:b0:4bb:6f45:2a79 with SMTP id 5b1f17b1804b1-4bb6f452d4fmr166096475e9.22.1794919188928;
        Tue, 17 Nov 2026 04:39:48 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu. [94.21.223.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:39:47 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 00/11] arm64: qcom: Add initial support for LG V60 ThinQ 5G (timelm)
Date: Tue, 17 Nov 2026 13:39:35 +0100
Message-Id: <20261117123946.668557-1-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
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

This series adds initial mainline support for the LG V60 ThinQ 5G (timelm),
an SM8250-based flagship smartphone released in 2020.

The series enables:
- DT binding and SoC board description for LG V60 ThinQ 5G (timelm)
- Memory reservations for bootloader and firmware log regions
- DRM panel driver and binding for the 1080x2460 SW43103 AMOLED display
- Touchscreen driver and binding for the Silicon Works SW42902 controller
- USB Type-C TCPM sink mode on PM8150B
- Bluetooth HCI on GENI UART6 with QCA6390 power sequencing
- Storage (UFS), SD card, volume keys, and thermal management
- Entries in MAINTAINERS for timelm platform, panel, and touchscreen

All patches pass checkpatch.pl --strict with 0 errors and 0 warnings,
and the device tree builds cleanly against Linux 7.4-rc3.

The series is also available on GitHub:
https://github.com/rofikkerneldev/linux_timelm/tree/timelm-v74-stage1

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>

rofikkerneldev (11):
  dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
  arm64: dts: qcom: add LG V60 ThinQ 5G (timelm) support
  arm64: dts: qcom: sm8250-lge-timelm: add reserved memory regions
  dt-bindings: display: panel: add LG SW43103
  drm/panel: add LG SW43103 panel driver
  dt-bindings: input: touchscreen: add Silicon Works SW42902
  Input: touchscreen: add Silicon Works SW42902 support
  arm64: dts: qcom: sm8250-lge-timelm: enable SW43103 panel
  arm64: dts: qcom: sm8250-lge-timelm: add SW42902 touchscreen
  arm64: dts: qcom: sm8250-lge-timelm: enable USB Type-C
  arm64: dts: qcom: sm8250-lge-timelm: add QCA6390 Bluetooth

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../bindings/display/panel/lg,sw43103.yaml    |  70 ++
 .../input/touchscreen/lg,sw42902.yaml         |  74 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  19 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../arm64/boot/dts/qcom/sm8250-lge-timelm.dts | 744 ++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-lg-sw43103.c      | 594 ++++++++++++++
 drivers/input/touchscreen/Kconfig             |  11 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/sw42902.c           | 315 ++++++++
 13 files changed, 1846 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
 create mode 100644 drivers/gpu/drm/panel/panel-lg-sw43103.c
 create mode 100644 drivers/input/touchscreen/sw42902.c

-- 
2.39.5


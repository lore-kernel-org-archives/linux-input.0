Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575411;
	b=k5dIiI225l/NBSoc1eRKQXHOmQstEExHeApc8Ns3U/j3ZenH+rjN33J+xhDveN5rx5CB
	 XVUv4Av8ofwI8TgYYDDxz//YlTkaxa4Y4iFla0Gp1szPObnWwerkuamx34yy1oRNMAN1Y
	 wcCsX/17DCXBsgjfmuCeP62JV05puFa262RZCMf1LTCzvSinJ9uG9vVat03gIyhj1qm7A
	 a8OJnC3qWfSJVkHJu03AdIf1itRoIQdmpUGVQwmbNGfeLVbH11HHs7ivSFvsyB6Volfc7
	 oFWQdbhjmFPZ2ZmVZgUdnVuXpZDb68Wh+6CAQQ434uZLozLORvtb9fHwmrppU0XkvfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575411;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=uTOFeoBvH6Kz888RkAXPqIyrv8LvfJ/WEyxyIIBEsJw=;
	b=lIwLSyL81Yrwv1BAFlLC3DTsmcpI2zq+VkeqRrhgTKygL7uLLjhSZCPmt73JZ6hVuzQL
	 npOiy/RxIcbpSXZJ3w+Nk/28/6NIrVi2oGBKF3CfSvoIBZiF1OMsXnVdmhnrI3KPjvetR
	 DGc584ZJVOcTeLE/pmOZHR50G0T64ofIGTjctvxBmIClqPcA7QmaJc0ltF3P0Mjb4GF62
	 7OezFcYlmGhypzO49Dn/LAulWk8Aw7W4i0hywheEBeR4avVcw+FWhAJJ2BllHSmYH9CYT
	 Wuy+QxXSBegeRZ1G8pWkaPoHZjrJzg0FdqpFWM1VK9TbCT4EYoPcu8zkFjEFmm0Vd1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=zbu2sJDY;
	arc=none smtp.remote-ip=43.163.128.53
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A3606A33C;
	Wed, 25 Nov 2026 02:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B74A3606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=zbu2sJDY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795575401; bh=uTOFeoBvH6Kz888RkAXPqIyrv8LvfJ/WEyxyIIBEsJw=;
	h=From:To:Cc:Subject:Date;
	b=zbu2sJDYuurrRILyXXDQCA0hALTGV9GC3aWK4hCwyGcW2TtdiqV5Hg7tm2SnxNk15
	 fQDNg2P64MiL/WVeBh7+y3cLAu7/1oiwy3qoljwj2dccPlFC8WTiF2bXU+XjyXMt41
	 SNpiYjuoR03hk5GrlduLzkpglC5EoMeCTJbnBp+s=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E279BA4D; Wed, 25 Nov 2026 10:56:39 +0800
X-QQ-mid: xmsmtpt1795575399tvsd8pzmx
Message-ID: <tencent_1FD63C25FD86A21A8E3B7DE059FD7DBF130A@qq.com>
X-QQ-XMAILINFO: NZLtKcOEcMY+N1l5Eruu6YWBujccUXPKWmZGW1zZRegMqnqlO+8MMm334S8QQR
	 UswwIADrsaVBndEqnT4h7hdAIl9uDqb9erPQ9BvZBEf2aNpF3RZCslilrQOQnBvv+6D4ddVZUgx5
	 XHhsIu+gztQqlBuydor18qn2IB1xP8TbTQ8P5zEg6gzC1pdG8UR2eJ+FF134LRUp0PoIXpxgixuY
	 eZwP4rABhpLk/9qdU4K7Wqx7DQphb95S21JVh6Inu4e4nf1xanRvTB2tR5e3bkojduHAUob1f9om
	 5J7xSCQJDOppAkVSb76hXjvlvmtG4X/VmTJOtEtnBsQss7xEKijZUzVQLA51hMiq0mY5Zp/2hkyE
	 werMgTHlOVHfMMyiVV18miTDL7/BBIs7MXhrKvDquwzy+dk5FY8HDWJ8LrYnOGbzdKDN73P8/4IR
	 0brHd8pGs3uRAfc4yBwIm5Zjns0tH98cL/0FVExVaYIarHEPYXkbH9WrkJSprf52w/EboTDv9fr6
	 8raUngb/MyHSLFUSTmikRoqGMN7zpOsKVRLbnOq4Egv9ql7oFxnC4xXWQkVCOvfG2y7bwl3wxpkb
	 vcbHfflB0zZAxhqgH/63j4mpPUNLUYomzo7sHoS09xjIDaCLcHBDSZ1rxpIPGDZzKEjwHtN5H0FP
	 xSYcu+yaauTkawMjokdNATQcGKyMfU54hqsd85JEtKcvAjUrKSlu5nM6L4LXeSrr1VRuhNcgw5Ra
	 ejfNKVd/WuaF5lgcDFnyZGbFMRYPRJiHkKQ4fixhRG2ezOgKLi7AF5CtmQlbK0+8qV24QuT79LaC
	 kjlHqdP4BrHP/ouunAPdjDDOx7+V3Jj8SkVZjlfB7cPQaqAyFrDnFPLkXb1zwy/2a2SmHTHOQKr9
	 IlOkAzqNNuiVdSkLk8WWQLVgTv2m659MV+mz1yHPv1hiFt7tb1gI+qV306AOQSLZvi8bIYpgAqqW
	 l5AKTPNP//lxQkO2dmawXbNB6AjWnKrN+vILTWwD8qLqVtoBaOzTAKsq7wKBq6lnPFfPEj4SgMo3
	 us48ALor1VUqsmlkYSVzv6+bPXTB7o82X56o0ghhB9D90M5y8crG3ivliPWnFqEu7kkTGLku6tTV
	 VbWgVJWngDtxAGw30uBLW2vgcomQwTDK9S6/EfWptidbjxxD/RKkXsBgXYuA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v5 0/6] Add VIEWE 7" JD9365TX MIPI-DSI panel support
Date: Wed, 25 Nov 2026 10:56:32 +0800
X-OQ-MSGID: <20261125025638.1171-1-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

Hi,

This series adds support for the VIEWE 7KF82 7" 720x1280 in-cell MIPI-DSI
panel based on Jadard JD9365TX (2-lane video mode), plus the companion
I2C touchscreen and I2C backlight MCU used on the same FPC.

This is a different programming model from the existing JD9365DA driver
(panel-jadard-jd9365da-h3.c): page select uses 0xDE (not 0xE0), bring-up
uses 0xDF unlock, and lane config is via 0xCC rather than 0x80.

Tested on Raspberry Pi 4 and Raspberry Pi 5 with a downstream dtoverlay
(not included here):
  https://github.com/raspberrypi/linux/pull/7633

Changes in v5:
- touch: pass supply name strings to devm_regulator_bulk_get_enable()
- touch: avoid u32 wrap in coordinate SRAM bounds check

Please prefer this v5 over earlier revisions.

Thanks,
Hefei

Hefei (6):
  dt-bindings: display: add VIEWE 7KF82 JD9365TX panel
  dt-bindings: input: add Jadard JD9365TX touchscreen
  dt-bindings: backlight: add VIEWE 7KF82 I2C backlight
  drm/panel: add VIEWE JD9365TX 7 inch DSI panel
  Input: add Jadard JD9365TX in-cell touchscreen driver
  backlight: add VIEWE 7KF82 I2C backlight driver

 .../bindings/display/panel/viewe,7kf82.yaml   |  67 ++++
 .../input/touchscreen/jadard,jd9365tx.yaml    |  63 ++++
 .../leds/backlight/viewe,7kf82-backlight.yaml |  46 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c  | 340 +++++++++++++++++
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/jadard_jd9365tx.c   | 352 ++++++++++++++++++
 drivers/video/backlight/Kconfig               |   7 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/viewe_bl_i2c.c        |  82 ++++
 13 files changed, 985 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c
 create mode 100644 drivers/input/touchscreen/jadard_jd9365tx.c
 create mode 100644 drivers/video/backlight/viewe_bl_i2c.c

-- 
2.55.0.windows.5


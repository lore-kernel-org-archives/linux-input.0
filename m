Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572597;
	b=Ah1vf9wRUUD5Tb4jJC90Jsz2j3bG1qx5smaf3z8WX0vAe7U47ikYk7rBS/yR3Z9tDoPi
	 eB5YGhT5KaBjI0XxE7bZuGwARFXuRlbI8n6cKbX1QAF0BNhoPJvJ2opzI11vUjrO4bXIB
	 hHaqA1uNYvjb1GNfTP5MVtYFkVqxO/NvnGq2TjNuAG0v0czjvJCcl8m0jiFObLKNBa8MU
	 0VBv9Xxu32FbH4g3r6fnwRH9DqAF+ZQrMUpU0DXn5BUAQNkOVHsp8UMAXNA669YAXaz+I
	 ARAROhEgKWnjaGpA/Xp9GdcX2ESJwjtlPIMOaS4uDC7qhLizraw56b0le/8QYBODS+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572597;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/9SwPiWhiBnTiI/QEs//Qf7SOEv4t9Rs+700JULo1Ws=;
	b=sP5XZGF9ANx9hqgDeGENHuQ46aWhyJKjvF7xM+w+6RCLQ6qyPkEW+ynIC319mnJXlAVk
	 MaqXYQmxJnpGNHH6pbHjee8btTxnHFyg0vKCjwY8StmbSS4s5pXLJ+VW+t4LN0QGCMJqR
	 mD2h/vSwrt7BPD6YZD52lXJIH93SRXCO2rUfF+urj1Duu7CE5o58OWJB3Yd7cgHcXYLvm
	 PighxUy1P4/Tz8tYEYjlW1rvQ+G4xd3OVgpjsnYXVH9UO18dLRACb+iLOm/SztjY18UJc
	 6xoQKwpypTlP1isf2+aWme+AeUDgiBAWEkl6Ldu/f3c7Y0ojNpFmc73KouiHPhXKm3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GktkfY+S;
	arc=none smtp.remote-ip=203.205.221.153
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB674606A321;
	Wed, 25 Nov 2026 02:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB674606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GktkfY+S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795572588; bh=/9SwPiWhiBnTiI/QEs//Qf7SOEv4t9Rs+700JULo1Ws=;
	h=From:To:Cc:Subject:Date;
	b=GktkfY+SaYhWGlsLLPrExND6ghacT5RABJ17D3/NS5hbD/839a62wOpfxfz5GmzmM
	 c/WJR6qqBwZksP/ondrfFSB5Xyct4uYwHKMlVV7AhDlYAl0u/2THM0cy44Jmg8WQW1
	 BsS4aa5bWu8SVnPl+UwX8K/IoyqrnKdmx6xKUgWY=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 26DABE38; Wed, 25 Nov 2026 10:09:45 +0800
X-QQ-mid: xmsmtpt1795572585tkfnwwiyy
Message-ID: <tencent_B1CEBF7BA831E39D1F11561FDFFB84FA4F08@qq.com>
X-QQ-XMAILINFO: N8ysMrv1QVb8otuyQC1xOVIZRrRDFTJQpIG2BwQdvEPnCfjHJoY7vW9IGoo2OT
	 jkctPbsAhI9nh9ZM2glorbp25c4XDfLQ6SJm8uiIMMXrPVUyQ9dwWb/hs38asDXxyXd7D/12Uesu
	 ZNN+9NE4OTfcqxg4VcqJa0XzRbBM2q6lQvwMMhsaTzIg0KrJmRdc4hLVs+mefhrtv9WVmDHgLwWZ
	 bPbgoZ61hzIdPqhWRwu1GtWNq4Smc3sBWxg1M9VVhg1+P47Bxz19fvx+H9UMlWx7/h8X98/ll9YW
	 +viOIIzyihjlT6WQa8Nqvl+2P0wd/GxIGVnYSXsNLIgUUBDa8x8zpN24MOdtKnhELpgpq4zJg29C
	 TGCkugsLZep2IqDQL1EjADgSgyMy4XguDtJeC5I/OHD5RI9cVhuji5QxMHvUQRutorLuKDcwsKWz
	 d1BijXBmseAmu3os9tmvZeTtpr9+4QPIkmhJLwHBtUUalaCswGHvjLLcDWj38yCGVLobf7Sayv77
	 m6VDGNLZH/5S29udbMx4NXff15nSjeSCMsVyb/KP2rG2sYtKtwr5vlPSFAzpUpXoULXTFz5WXm04
	 JZAGaV3sOqqfs0tqJya6h4ZiNnh+mIRfqrT36CweUfyMyesEXUIqYlzvX/mW3p7sh2AB4fLxy4bV
	 f00o9QFRE5mCIk/NZZiEk7Zaz+XBHgKoaqHEGf6lXVK0ZFwsD76gcYw7WPM7Bdnlwb9tVLCy6wt3
	 80RlMa5qspPvkE6iXfjwLmXjbAO3zoNEXGvI4+gJrp1r8uGfal0//fdXJMoEPu14OQSJ8Q/5LZq4
	 iLGCG+B6L8zQBKge0bq3Zcme5gXNPJiqgHRLrga87TVPZVwVF9w5x5FMnYZyoVmnaPXV6I2TLSYM
	 uD/003ue9jJoLDsEMbWrTLltu1bM9hBVberwrm0UaQT9JUn0YgEfL+tYPEeOapX4rR/uODCUXh9h
	 6+gPq6vW/Zvsx1jHK+ElYUdx3XEwV4pAhwGbI0DHpTrdLEQpl82O+JWUYbNeIIz5TMrSfUoVC9j9
	 UOtiae6OsZ6J/0tHW8oahqYDEKZYY54uhWNL7wYi9ujEbT5polSCy9D2YTzu/nlk9ltrgNhQ==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v2 0/6] Add VIEWE 7" JD9365TX MIPI-DSI panel support
Date: Wed, 25 Nov 2026 10:09:38 +0800
X-OQ-MSGID: <20261125020944.137-1-3066883572@qq.com>
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
uses 0xDF unlock, and lane config is via 0xCC rather than 0x80. The init
sequence and bindings are therefore kept separate.

Tested on Raspberry Pi 4 and Raspberry Pi 5 with a downstream dtoverlay
(not included here). A matching series is also under review for the
Raspberry Pi downstream kernel:
  https://github.com/raspberrypi/linux/pull/7633

Changes in v2:
- panel binding: drop data-lanes from the example; require iovcc-supply
- touch binding/driver: drop jadard,coord-addr; add vdd/iovcc supplies
- backlight: use module-specific compatible viewe,7kf82-backlight
- panel driver: drop per-command 1ms delays and pre-reset NOP; use
  mipi_dsi *_multi helpers; remove redundant enable()
- touch driver: accept only known chip IDs; drop duplicate backdoor enter
- backlight driver: drop unused wrapper struct

Please review.

Thanks,
Hefei

Hefei (6):
  dt-bindings: display: add VIEWE JD9365TX panel binding
  dt-bindings: input: add Jadard JD9365TX touchscreen binding
  dt-bindings: backlight: add VIEWE I2C backlight binding
  drm/panel: add VIEWE JD9365TX 7 inch DSI panel
  Input: add Jadard JD9365TX in-cell touchscreen driver
  backlight: add VIEWE I2C backlight driver

 .../display/panel/viewe,jd9365tx.yaml         |  70 ++++
 .../input/touchscreen/jadard,jd9365tx.yaml    |  64 +++
 .../leds/backlight/viewe,i2c-backlight.yaml   |  46 +++
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c  | 353 +++++++++++++++++
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/jadard_jd9365tx.c   | 373 ++++++++++++++++++
 drivers/video/backlight/Kconfig               |   7 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/viewe_bl_i2c.c        |  79 ++++
 12 files changed, 1018 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c
 create mode 100644 drivers/input/touchscreen/jadard_jd9365tx.c
 create mode 100644 drivers/video/backlight/viewe_bl_i2c.c

-- 
2.55.0.windows.5


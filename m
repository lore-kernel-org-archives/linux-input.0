Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056486;
	b=SIHdh19JbR6D8I8zRqF41rnq0pJcAZ/pIy91i37S3KdPYQQplqbm3C/XGTYqXT4Ev1X1
	 x/IA+kQszRuCeHX8MMMK56vtXgZ84Hby5a8iYuHfj9TRap3foEatwH1CVZ5bpQG2oCuLp
	 ShXq6OY8Yka4CJ/L3RQWh+uBoDD7tU4LWqjyiRQD/MhvhTPem9pQbLVBGo9V4XyU4EXIU
	 2Chmi9ilBHRSEqePHqVefd3bHf145GAsXWWOy/j6HbyFhMmspNYogpQD5G/LsSsbUPUWl
	 to7cApNse1ivu6PWohDiL+q3t/toRQeDW/pjjRrMTJR4M8KrtqIvNe0LXzWWuoHA+7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056486;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=8BIIDtFx5PmzL3Uepd4NxUuQ5zZW+dOp5Ub913wqFiI=;
	b=B99/3/3lG096t68qwB9NP4EitgMk9Z0pGFXMGUVpob10ldeFQWFl3pPGe3b+Bwqx2SAY
	 v6mHdCSIc4DBSYsDlU3fe6p7Rmg8F7wfF1rQlH9DhYdbX4hpIphFEBo4hgJBZk8N1wMCk
	 GIZEZHLLQaAizgFQw29hidHxWPV7M+zbtKxfM2VeFC83ejxBG5dU7MiG+htAqM0u5yDJW
	 0I2tMMsLpIvcFDgmD51mcWHrzwGK3UmVgBdBb5nrsV0r8fUdH7W8jxOLsdty0E2r0Jdum
	 L37go6MVxvomHQ0evPcRRSo0EdMH4fe1uB/BD4Fgp8zVY5HEX4MypZw5jHX2adQhMrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OjI874MW;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2269A60A260B;
	Thu, 19 Nov 2026 02:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2269A60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OjI874MW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795056480; bh=8BIIDtFx5PmzL3Uepd4NxUuQ5zZW+dOp5Ub913wqFiI=;
	h=From:To:Cc:Subject:Date;
	b=OjI874MWkKWmhu+3sQuTelsugkPnIKnveqwBjd4ncHr7k/NzoZFFT3788zsFSoMRt
	 3vt1i/4Lsjt+fktnpib+xd8rElAV8J/D2zUve/0Z5FiZANbC89EN+smSaHxuBk6vt4
	 sou2FMJ6Qf9NqpL1HsmCKIn1RZgM9+WvGThDMqao=
Received: from [192.168.2.135] ([113.90.236.90])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id BFA264FE; Thu, 19 Nov 2026 10:47:58 +0800
X-QQ-mid: xmsmtpt1795056478tpnvxxxva
Message-ID: <tencent_31F36F1EEAC0B8EDC79A55CF772421CB1306@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJ821YX0vfkxhM7TMkCDgzgCFtfqNJ/2YJUvziFTw+lIDOhHNk3c
	 4zLCfW8Eo91iem4NHxsJ+yMrXhrX02w4EGziX5sKocdfpbuQFh1hS719z65t91bkRCxl4VWpEbM2
	 jzso7xe+ykcfpVMyEPBSDts0RuGY7GLQQoxPbFXqoHllOiRGrR0PJR1Wxn12h+QgOlNN0u1vu17U
	 zP4PTlkNa2NhBmT8zufgB1YjFhn9+UAH/a5ep4onncIj/IXQx4DR8aJekH9ax+VxU+YIYAxWuuQj
	 /VXvh4cQxGHibx2ibZWd3rwmwyWnXPaJrNdZvaiLTctRBO0gqT3aPTMr5/0Op0L9jnqOg4aaJMdE
	 nTj9nhHz9GggWlezn6UKUg6uBv+xRtKIN5Ie3nXq4yhx2Lu0WBov7qzzrIjLPEaKkLW/qPFs6m5I
	 XtWfRAnY9TlIBNCgsB69PLFSfEF75aWsYEmkD28TjQN164F/9q3L06AFpB7xcKVUwWvzLdQOpi0/
	 f/b2uMQHi1QThUDbFdBXolyd01SE1QvICbCW7r5rBfr/ZCELcZKBHnFXfpFWtva0TMS5g+2Tt5Yp
	 bMCbqU7IByxsbniWMDyEbKJIBsgUKZyZOgYa3gL1DIS/23qZU+i0up0Hf7L96emSKpR13G/HWiqu
	 T0v+oDWN6k8ykSwUCVhWVdYBMsVoUX6Ipw9G9YosyiTQ3P1qI0KwagK5ouDk+Z/BWqjAF/F1lbsl
	 U8E6f0xRBg/HJXtJ/zsYOsYRId9yjvGzYzzc7A8z0lP6P/InvUrIV7jGODY+w5wFDX8Q5LdYw/9O
	 kwbs+vxduIrW3mKFbpB67LNf/5pA7o4sXAx4JGsNKaTRZlln3CddP7Fdf4ggig+bskFIYBrZnXw4
	 8K/kO9hq9+rXZQmLxV9Y42HumMgCKScPBEOfgfFVy8LcZfEkG4gwO30SqLpPKsnOP46S+hMGo/4Q
	 J5+/BtWaDN2zNcOBuUHB7i5ad3k1G+F8o2omB/SkPBsnNbHFHei+I1xX6OVgMyT/ainVMCaP9a4w
	 gkMVWI9i6wn6g8vrScLovYGpTopGe66g2Hzkop1MMiaoKAwYPo7vFndXcbXwj5xk86builmg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Add VIEWE 7" JD9365TX MIPI-DSI panel support
Date: Thu, 19 Nov 2026 10:47:59 +0800
X-OQ-MSGID: <179505647943.50956.16853759149713125338@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

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

Patches:
  1/6 dt-bindings: display: add VIEWE JD9365TX panel binding
  2/6 dt-bindings: input: add Jadard JD9365TX touchscreen binding
  3/6 dt-bindings: backlight: add VIEWE I2C backlight binding
  4/6 drm/panel: add VIEWE JD9365TX 7 inch DSI panel
  5/6 Input: add Jadard JD9365TX in-cell touchscreen driver
  6/6 backlight: add VIEWE I2C backlight driver

Signed-off-by: Hefei <3066883572@qq.com>
---
0 files changed
-- 
2.47.0


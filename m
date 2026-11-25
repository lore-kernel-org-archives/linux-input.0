Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602108;
	b=JOeHE7lZf8Pzyt+TjXuOci3zdE+6SGumZfCOkr0XVIqyBJyVS3NcHWiA4zPPPKVWtWGv
	 /FTAKSm7ZWAqNfefM4MiJNFSJphGxvSNJ0mReMvvVZO76jmBmUk5mEf0eU01aQdcDvWpg
	 4UQre8almo0tTvx/Qsr9O3E8f+LDt23ptTW47S8/Q9c3kBXif2eDwgSQholH1EGvCACj+
	 9CcnIP6VQ5zb70mIVjcEIa+GgAMIwMNjiaJRVwSOERTB22JDL+ur/D4Tc8N7bvfwZ2vXX
	 wTmfogbxyjXD5OIqXqt3vk7msyRnjOFLWBEWYN3Le0LI/0MrfLcoXQAb7cyk4Gcc20w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602108;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-USESPAMBG:From:To:Cc:Subject:Date:
	 X-OQ-MSGID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=RhzwVySpil2bsJ3XRlzOZ6xss+IteEEgqAFBYLD2X84=;
	b=P/KDwvVE4c+62FOUqH/x6+AU7nAns0126eh06LM2zEMyoqYQY1KeeIauDURbYIXmBESR
	 zlLesAYwWIPlu6zsn+A1/eeBhUfpIGNmXloONXQgD+L+1V8ZWgTiKgneCgQI0Np7QLQG1
	 7PwBRzhOxENdtANJBClnmHBIbRU6wTUk0S31H0aB1/vnFXWM1pX6jhkfd/bagQfl8T1NS
	 sABYeM+fiXL1lobmrIN6yyxhRp9/UyJn/nCZro2xNK71i4qbPdgSDV/v+dhy3RwtlAc1C
	 QrEJmN5je8usKy2toMbDRaBDzC0A1xilbWRtF5YdfqQSeOuENUlkIVLpFlt3C6nZIkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=saXLmMwc;
	arc=none smtp.remote-ip=162.62.58.69
Received: from out162-62-58-69.mail.qq.com (out162-62-58-69.mail.qq.com [162.62.58.69])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5F7606A339;
	Wed, 25 Nov 2026 10:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB5F7606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=saXLmMwc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795602095; bh=RhzwVySpil2bsJ3XRlzOZ6xss+IteEEgqAFBYLD2X84=;
	h=From:To:Cc:Subject:Date;
	b=saXLmMwcuKkcnRwNvbcs9/jyJj83g39SdB5kuKGBfL+pxduFwyCtXhyxwydr7cd/+
	 4wdd8tCY0JjhbU2V8v46E7Lkj5o2fsAhj3tcwlFB0xc9eCdZ1Au4jpf1hidH8x33rX
	 SHut2iSXRU5wzt+XbgD9M80F1DGUiE0rEXqISlZs=
Received: from HF ([240e:47e:32f9:92c3:8064:1335:aef9:f3d1])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 56009AF2; Wed, 25 Nov 2026 18:21:32 +0800
X-QQ-mid: xmsmtpt1795602092t21usev7s
Message-ID: <tencent_C93E80ACC0BEB9083D9EE87E575073C67D09@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25G7reDaoii8Bn3W7x9rG8mXONCSlI+NI0LL6ZPaZRNJnIPrX2eAD
	 y3BLE4v0jPIw2ba0yHSwdxFjLD4kBHRYO2AI3DKUyIVBuYzwWrNLYygs1IoU5fpTX1ksLxQwJ+gg
	 rpBpdz8e33ornRtQYWqsy1BLwo4UfbLA0X821xug2p7Hg8Cgi3NEeB3WN1+USloO/pCeuWPWWdts
	 HwgS0GiXQuE/rFL71BpI8nu5yMN/8LGuxw/NSk7s6/q6Rss01ZlPTSnkBk/GfYPfn9bsdSTezuSq
	 xBdUlz1Xdwht9N+K+5+8QMNd9vIGpHzC4Kimip9PGVPI527cz1oO4OQZMl+Wk/3cQ3T0v2vf1onq
	 U6ut1z6Mr4p70apQ0AsB36rnNaaAjFS05UZl9N/krdo2rEyOIOdHHLkf0jju3KGX9jdtQC65R+x3
	 BIz1GpZghpJpy1W5qpKCMDLOKsweF9rsbWTpFSpVnCvznnJhTwCCib3jTPiEGLDaulLDso8A7wIR
	 qBcUE+/GEJp7ziaACmgiTN9rPveoPRIrcIoXvDSTzCPyYrjvf4kXwCHCoXd9ciz4DJ3f897U3vau
	 Mz7WE9eFCawl0KUu2/NI0W9aOlq6tivzN/w8Q6VZhGLktsj6gnG6pkp4t5kj2dhQXZ3Z1hddoKef
	 RSdAiWlYrZl4qo1VZx0iOvkaTr0jX6GHMrrdCc8htiZ0R6s55fJy40pXMWaW6svsAHd7IEctgmV/
	 6jwm8tdCTSASl4YUk1++hDLHHTSlPgiyjkLTz1Zapcqwi0bQSFH+hw13Xiqx6yqVGZt/N5jxmRrb
	 AtnE7v4xSFB51Uf8JmCH1tLawYSwamzuIBYq0V0rNYcOXh328eBMKs7sJd4VBEuKhPH/stdI7EMo
	 6FxQEkYYdAnh8vNO+U23MDndT1OWAaYagqMtY36Cb9P24afXeQxrR6yJ8Gh7IAYld5O2haBJtwrG
	 iZta+jhnlDebPN9IvA4IKzvGUl9IsvP5UoyE1UnmReVnbKBdF5BL119HDunuu/c22JfnzHVpn4kx
	 EqmscuorpvJD4VUFhGbr90mc1rufRksZrWpAbMqSOr7cZqiWSBrB4ri7OON9Xe5cXHmb4/uEbOGb
	 6gBIR5jp2NZhAy0Y9Nh0rGVs+u6Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-USESPAMBG: true
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	dmitry.torokhov@gmail.com,
	Hefei <3066883572@qq.com>
Subject: [PATCH v6 0/6] Add VIEWE 7" JD9365TX MIPI-DSI panel support
Date: Wed, 25 Nov 2026 18:21:24 +0800
X-OQ-MSGID: <20261125102130.256-1-3066883572@qq.com>
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

Changes in v6:
- Run checkpatch / checkpatch --strict; add MAINTAINERS entries
- panel: drm_of_get_panel_orientation(); mipi_dsi_dcs_write_seq_multi()
- touch: usleep_range for short delays
- backlight: expand Kconfig help text

Please prefer this v6 over earlier revisions.

Thanks,
Hefei

Hefei (6):
  dt-bindings: display: add VIEWE 7KF82 JD9365TX panel
  dt-bindings: input: add Jadard JD9365TX touchscreen
  dt-bindings: backlight: add VIEWE 7KF82 I2C backlight
  drm/panel: add VIEWE JD9365TX 7 inch DSI panel
  Input: add Jadard JD9365TX in-cell touchscreen driver
  backlight: add VIEWE 7KF82 I2C backlight driver

-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794506064;
	b=WVOFuhDPE03IbJpUx+i9CSxX+pZHk2E7NYkKN1pjQclZLBRZ9FK2pZ4Zw0wmTIWBPZCb
	 Nc3vpF1YNA30mcOsbwtHX3bjAs8uW1DGcE8aJ0GlbKpEaJGl4FTFcZ9ihWQSHMxT93tKL
	 CQTcRZjP3+wZ6kWPb66EkE1IKOFnyCB6Tj8g/w8GUsQLMtCKyvBRnLweZVuImzWJYcAH5
	 dWeHntvOjoXweQpgBjqW2+WdOTXNgs02LAm7ZcskDJPHuTTV5laOZQaH48N67qEmdL2EA
	 oQNWEojBzhmheNgECYuDHT8xdqCwV8p9v1YN5dUZxNZ3u0fQI5nbQQrLCG8c58fuGJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506064;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=2/ekIoIsbpslgBQr1hgDyBFguXw4lOn68nnIGxnrzDQ=;
	b=N4FrmGZTj87YSfXK1hp4amp6BZ9EPjuzAeufUma/WInjcvC4rck/LGy4pWOFomwSImBg
	 fP7IUYIO5d+A9DP56IPNvRedqYFKxpjTsl8YAX1OjMPREo/L1zVzuLCKvaoopsO48XeeD
	 EbStxQQPj2H5p9I/Nj6xIAP6xaijb+XvVz3EeupFJRjOmcnZznL5+za60yd7yXUb22A02
	 m5mwmazdLGOIEhqys+BnadGOAU9Op0qp1GeUeejBBJgq/w2z0arP4yBgatjZH4fwCvJCd
	 ZWd0NWequGY1bAujiiP0CHKHvHT7ordkO80gwYeWPqu7WI3D4sDmPcS1rPvPGMW67XA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=TuIhNW9S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE122606A33A;
	Thu, 12 Nov 2026 17:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE122606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=TuIhNW9S
ARC-Seal: i=1; a=rsa-sha256; t=1794506053; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a5SFaWgm6iw8LMobZZclvDDtZvrmBe7zniqDi7I2gqS/0/XWXsmxY8JJEuonw1C5TL46w+jHzOLj5bYnNVBDVDfSnYk6LyYsROQIA892LFVFfMi1hRKrDaHREGFxB/L5TotnDz825EKq/thl3+1ihukWohwRhF2K7joxC6uRAgk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794506053; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2/ekIoIsbpslgBQr1hgDyBFguXw4lOn68nnIGxnrzDQ=; 
	b=XusdBGfGmS58TcRcN63E1kjTGLXPt3ltUQ3EZTp9veTOUh10N+Ji+qXGITz94wj+diOnGe1hXZqeqwCGhdEMtHOZ4ePowQUVczArPxf3SY2+CZ4pN+DtXFQNH2L0vBu6dA1KcLGl3pGBwMcaD20FahyLRczNa0Qq8F3OK+iXPBY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=TuIhNW9StHTFg647RgMBUqPrj/m77Vt1rsmxU0nJJGIAQMjQNEeqywUNu2lOb63r7iXz+x+j/gTzQ06jr9opATnmEMiJODLsLWTGVcJwHRWrIyOjxHKU7SdqhInLbsXObswImVJp+7FetWsRa5BvEoz03eyfwNHin5CvQrMrMmqoiE9bZaKiy3hT+Jhuv8ggpUbwcDHUSDuVogkTqhp1jCLdLyvDddFHd4hPZIjrm+SOAmrYx8xP66G+qGuTxXp+ZYqSoYydtUsDomHmSMAo5+90z3wPTOZfma4DZw/3fYh32pwIB8sa/QFaIKXBaEUHIrNXNox9AmQvrqwQ7RxLpw==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=2/ekIoIsbpslgBQr1hgDyBFguXw4lOn68nnIGxnrzDQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179450605168890.86027366517612;
	Thu, 12 Nov 2026 09:54:11 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH v3 0/9] HID: Add hid-plugin framework & convert haptic into
 a plugin
Date: Fri, 13 Nov 2026 01:53:53 +0800
Message-Id: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ6DIBQFr2JYlwYQqXbVezRdIHyFNooBS9oY7
 16wGxOXk7yZt6AA3kJA12JBHqIN1o0JylOBlJFjD9jqxKgRnHPRSGysxkZOs1X4NTiNOdTAGel
 qqDqUrMlDZz9b8f74c3i3T1BzzuSFsWF2/rtdRpp3iBEmKCXsUI8UEyxLDZVgQksNN+/G/jw4Q
 Dke2U6n5KizpLd1WUkiLqoVbKev6/oDK8mvov4AAAA=
X-Change-ID: 9644469a-hid-haptic-kmod-4e8e420f8e5f
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

Recently I am working on adding HID LampArray support for hid-input [1].
I would like it to be a loadable plugin module. While looking through
LKML, I found hid-haptic, which is a plugin-like support code collection
that must be built into vmlinux. Therefore, I decided to develop a
generic framework for loadable plugin modules, so that it can be used by
multiple drivers.

This series aims to introduce the said framework and convert hid-haptic
into the first plugin, as it's easy to convert and perfectly
demonstrates how the framework works.

The first five patches fix pre-existing bugs in hid-haptic and
hid-multitouch that may become more frigile once the former is
converted. The last four patches refactor hid-haptic, implement the
hid-plugin framework and finish the conversion.

The plugin framework is designed for devices with additional HID usage
pages which enhance their capabilities. The support code for these usage
pages is called "HID plugin".

The corresponding HID driver calls functions provided by the plugin to
take the advantage of such enhancements. Without the framework, the HID
driver must have a linkage dependence on the plugin, which is not
optimal because the plugin is always loaded into memory even if no
device actually supports it.

Logically, the dependence should be reversed, i.e., the plugin should be
an optional component of the HID driver, which is only loaded when the
driver finds that the device needs it.

Introduce hid-plugin framework for loadable plugin modules to achieve
the said logical dependence. Each plugin has a unique hid_plugin_id when
enabled, so that HID drivers can request it accordingly. The framework
aims to be lightweight. It loads the plugin module when needed. Once
loaded (or if the plugin is builtin), requesting the plugin is just an
RCU dereference plusing an module refcount increment.

When a plugin is disabled, its id maps to HID_PLUGIN_DISABLED, and calls
to the plugin helper functions are eliminated by the compiler.

With it, hid-haptic can be easily converted into a loadable plugin
module, so that hid-multitouch only requests it on demand.

Thanks Benjamin Tissoires for the inspiration for the implementation.

[1]: I know Texudo folks are working on adding hid-lamparray to connect
it to hid-generic. I am not in favor of their design, so I decided to
write a new one. In my local tree, I've had an independent
implementation with HIDRAW sniff, autonomous mode as an LED trigger,
RGB/non-RGB LampArray support, per-key LED device support, etc. I will
submit it once this series settles.

Suggested-by: Benjamin Tissoires <bentiss@kernel.org>
Link: https://lore.kernel.org/linux-input/auypydfkhx2eg7vp764way4batdilzc35inqda3exwzs3tk3ff@oagat6g46zto/
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v3:
- Correct the Fixes: tag of PATCH 4 (thanks Sashiko)
- Add missing Return: to hid_plugin_register()'s kernel-doc (ditto)
- Fix the return value of hid_haptic_connected_to_input() when
  hid-haptic is disabled (ditto)
- Link to v2: https://patch.msgid.link/20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe

Changes in v2:
- Reject touchpad applications with non-force units (thanks Sashiko)
- Only call runtime methods if the event source is the same input device
  as the stored one (ditto)
- Rebase on top of v7.4-rc2 due to the devm_kzalloc_obj() changes
- Link to v1: https://patch.msgid.link/20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe

---
Rong Zhang (9):
      HID: haptic: Fix use-after-free when draining workqueue
      HID: haptic: Get rid of input_ff_destroy() in error paths
      HID: haptic, multitouch: Check haptic prerequisite properly
      HID: haptic, multitouch: Fix haptic device double-free and unnecessary allocation
      HID: haptic: Postpone GET_REPORT to init
      HID: haptic: Convert simple methods into static inline ones
      HID: Add hid-plugin framework for loadable plugin modules
      HID: haptic: Convert into a loadable plugin module
      HID: haptic: Remove stubs in favor of inlined dead code elimination

 MAINTAINERS                  |   7 ++
 drivers/hid/Kconfig          |  21 +++-
 drivers/hid/Makefile         |   4 +-
 drivers/hid/hid-haptic.c     | 206 ++++++++++----------------------------
 drivers/hid/hid-haptic.h     | 233 +++++++++++++++++++++++++++++++------------
 drivers/hid/hid-multitouch.c |  75 ++++++++------
 drivers/hid/hid-plugin.c     | 108 ++++++++++++++++++++
 drivers/hid/hid-plugin.h     | 147 +++++++++++++++++++++++++++
 8 files changed, 554 insertions(+), 247 deletions(-)
---
base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
change-id: 9644469a-hid-haptic-kmod-4e8e420f8e5f

Thanks,
Rong


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253811;
	b=ekR5Esyq1ARuLvdC+PUHIdbg3WWvKv1CyVF2pj9ZmyD94OCjZJ8AiBRqqunaMmnH+HJd
	 9cCFaUI/NR7x955K/qUtq6KoxItl8hfOaiiXT5Ithz6kZO90soxMT9y8oss8ga+nTKVm2
	 ck0ETX7XvMSfJfJO3EAvgemks3rTIfHyqxyQklR5LhhgzysramsYAqKXkZ1Kd8YBXbg+V
	 yvJ7olwny5jTBn4UH73MQLc3IyrqTK04WAs0BecuO4z14mbKGpu/YJT+xPXdAwGB8cPmd
	 yY8YA0dlQ5HJajvuAOrFyg0k9hIoq48hZ8TEDYKMr4qaVWQgWbmr6oHb9EYKiZOTtAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253811;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=jwSlYVV01vT0LPsMlnPQ8WdpgyaMaUzVAi/KKKp40Zc=;
	b=RfruSh2L6/o9c8oscxoFgjnUWJ2bdJz0DA5M07BCLIvZU+VVAPUsuePkoKdtAUGz2r4a
	 prZqsReGtXlvCSyqKIpH9r8vVzP8pp82CUlxAbTOSiW/bU277hSKd81gf8m6dAYC8z/YU
	 AiwaHvQMxUnJDsk8Objkd4IyaFF8Xoo7AP3pFE+J0zkGSL4hFAvhOunKcwBdJLAsU/N7x
	 2j+UnM5TyaHPI6TT4QVOVq/7TfDnVK2sxTaizFv1fH/rqjmeTRnGAQ5EPPn9qBmv2Dfu4
	 5d2bfyTvecpqzqzIOJyk/gB/6WeIQ/KIHkXP5e9I3W2R6sEz5x2JZWkjO8xr4WgNiRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=MvqjyfI1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E0606A31C;
	Mon,  9 Nov 2026 19:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 779E0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=MvqjyfI1
ARC-Seal: i=1; a=rsa-sha256; t=1794253799; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ko8rFlWKa/ZBwSrnzRyb3UdGghYJfRvCWOQxmLtT81p91RSb5wtJ1swhGiN1Omxy3Tp2I5GK0rm0yPPydHTu3UU0lGUx6sHWZAKQev5suEsi688JAg69Vfa8S24J1WdgRtAYd4jG9hyGlMwMg12GKBMF4t1wLdk91HfaytTym5c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794253799; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jwSlYVV01vT0LPsMlnPQ8WdpgyaMaUzVAi/KKKp40Zc=; 
	b=hz/88Tc+2xVqnYSF6yewAEEiIJMsn1RBHQsNDCk6Yg2BOKtmphMMd4hi0rSfzvndpGf2RQoQGVPDARW+KoDGQsIp3kHXDleJCuq3NF7iQITwrA4gVEAO30JQXzyNCbJW5tyirBJgnfriIDrCiMphWX+h7AS2+S7bYHSNA1gNa0A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=MvqjyfI1UZyeFLvej/rrEE9hO9AJdy67fLjxUTHzw1GQEz7u6yuaQoT1nK4muHRrdd7wVSATQNRw9q9bp4yPeuNGcd752plYh3Ar3CW4HtxrCQW48iVJsHzdhT/yvQYzu8bnqYN5zEZu8YpiEmokq6mRTY6+Bsk7JESDMRQFT3MoRhxCJumKDIvzvqCLus9HPSksEnJovzZwY37Vj8UMFNEfoy70JlgtQWbhTftVHd3WTI3g3aAOGF24ihJSjDTENWP9qB1yjQohla2d75b0sfRx/eZar/PKp7ANXbiHxWjabBcjy+t6CB74mIDvG3aLGyYr1w6mVX4JRDJcJeX21Q==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=jwSlYVV01vT0LPsMlnPQ8WdpgyaMaUzVAi/KKKp40Zc=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794253798486822.0962487134203;
	Mon, 9 Nov 2026 11:49:58 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH v2 0/9] HID: Add hid-plugin framework & convert haptic into
 a plugin
Date: Tue, 10 Nov 2026 03:49:37 +0800
Message-Id: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ6CMBBFr0Jm7Zi2lgZccQ/DotKBjgZKWiQaw
 t0FXLp8yfvvL5AoMiW4ZgtEmjlxGDZQpwwab4eOkN3GUBqttSktenbo7Thxg88+ONRUkFaiLSh
 vYVuNkVp+H8Vb/eP0uj+omfbMbnhOU4if43KWuwdKKCOlUH/1WaJAe3GUG2WcdVTFMHTnPhDU6
 7p+AZlgtIS/AAAA
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
 drivers/hid/hid-plugin.h     | 145 +++++++++++++++++++++++++++
 8 files changed, 552 insertions(+), 247 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 9644469a-hid-haptic-kmod-4e8e420f8e5f

Thanks,
Rong


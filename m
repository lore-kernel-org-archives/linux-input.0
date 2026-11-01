Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793554901;
	b=0h0OHnFB2253Z/jPs/zEGH5fSz62SoXfeS4q1JDoBZSYy6UvW5EYtEhfo/mpZAFUDVFF
	 yl6P/tS60x1h9ErgcX3j/mdjHu/KYv1C5cbj/gxqUyO5sH9a70gCw+aGXj4iat2sKQ8HN
	 BMODV2KMC85r+QU4t7NqAkQwvbdZ747ZLJOmjxhZ9gco9a7qUdr0QBc4WUb7+pmYig5dN
	 NsW0//fzvbbhO17V9Axah7X4Okjzu5HklsoyEZGNyFj5/HPse6ETwSXWG1hMSIEGEtERt
	 2GRrk+aa1EPP9+bSAtoy+t3DlBAle3jBa8rGLzyPRi2GXx2/Q2++wVAPhklnOPGOTmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554901;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=kgPzh3zVSM7KTsLkzfDtwaa/x4BDzQJnRiepd89P21I=;
	b=Lj7kLVB1GLuE70WJnwIQ/9cRNV0oXzagfdidVmO4DG4rm1s9gN/rDP9Cf51ukT9EPbIA
	 0w6szsJflaCOdVxxKZTERyhhmtbw5ZQGR18jPNhIswVtdD3u/CamE6floK8PnpNbpAZFh
	 qhyMmcc+Bt/MyJXRxGNDzomGvsMCyXi38QNk03skZK5xsfJRQLEF1BddDqFoec+oTKR+O
	 iucU+hcQFL71b1CNcU2KgiVGR1FQo16AWExq/WrhKTQjjoefK0W18Z6OlrD+1Cwi6/YcU
	 ue8VijhuYRWoPE/ULHTiBBzbw0vML1OSgzRpjzDSHtNOldrOfilIaE1m4jaBoZDuuoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=hhtBh5LP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77963606A324;
	Sun,  1 Nov 2026 17:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77963606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=hhtBh5LP
ARC-Seal: i=1; a=rsa-sha256; t=1793554889; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jXZIUhbvm1+PCshTqWjhpQJNi/fCAZ27eBOGBKYqafpLD2DnOpyvIL9YlW2mhhInvqiFQ0KGp0wR2hoB/iZFDrmFSJCb3OEhLmIWQtJ0QrT8lAFNmtNP/RrmRdgQiXhgzsGvuikm8oUc1t4NV2ILfg4O+bC02ZGpAGYeRimNQjs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793554889; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kgPzh3zVSM7KTsLkzfDtwaa/x4BDzQJnRiepd89P21I=; 
	b=hCMsTklQOB8je5KwUvQQAm8AipJ01vlBGDh+ol6X2d5m4wfKUAuyhGUN2HvLD/jcv8PgDinm2m6yS+R5LC0By6FgzpHzPWWEWWCk9FT+E2M9zfDoT4YPCG7BWKfulIy3DFGvNHc9gnnWGuEQhRswAKO3lHQcPRuKtXlAMe2Titc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=hhtBh5LPDFvDOKx/KK+2yifCFdjSSw2wTIJAmh7BYyutUoNY69Olxkzd6nM9OJeM7mFLuPpwrmQQ3CSTMSg3F5GyDfz1sEh89izXaz92I7M3e3GBPqxzvJd1ohmuVtZMcAFjkQ0ycoeO6Dq8EpcGWc6XLJAWGtDkqzE/Ey1IqaspQrvrbVil5SuDjRsCmZGbfzJIOGMqcS72wWEpeLPO9L8OsmFfokrNO/BKIXjAJgolvEMmVoaXDyDorlNH2TV3qXrGR9e9lJE8zsTGaJQhL4zcT8i7EHOUTLDHkCGjs5XMNQSgmfnKOdE9m3vWfLCAkbnVjhBuK/GfDu6SfzAirA==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=kgPzh3zVSM7KTsLkzfDtwaa/x4BDzQJnRiepd89P21I=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793554886398208.38721075708736;
	Sun, 1 Nov 2026 09:41:26 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH 0/9] HID: Add hid-plugin framework & convert haptic into a
 plugin
Date: Mon, 02 Nov 2026 01:41:17 +0800
Message-Id: <20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTuJmIEAVzEuSvuXjkYgLRoSw
 t2psvwW722UEBWJumKjiK8mncaM8lKQDWYcwOqyqa1FpG4NB3UczLyo5dd7cixoILerb1B5ytU
 c4XX9H++P0+nTP2GX34b2/QCRxqTecwAAAA==
X-Change-ID: 9644469a-hid-haptic-kmod-4e8e420f8e5f
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Denose <jdenose@google.com>, Angela Czubak <aczubak@google.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-6be7c
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
Rong Zhang (9):
      HID: haptic: Fix use-after-free when draining workqueue
      HID: haptic: Get rid of input_ff_destroy() in error paths
      HID: haptic, multitouch: Check haptic prerequisite properly
      HID: haptic, multitouch: Fix haptic device double-free and unnecessary allocation
      HID: haptic: Postpone GET_REPORT to init
      HID: haptic: Convert simple methods into static inline ones
      HID: Add hid-plugin framework for loadable plugin modules
      HID: haptic: Convert into a loadable plugin
      HID: haptic: Remove stubs in favor of inlined dead code elimination

 MAINTAINERS                  |   7 ++
 drivers/hid/Kconfig          |  21 +++-
 drivers/hid/Makefile         |   4 +-
 drivers/hid/hid-haptic.c     | 206 +++++++++++----------------------------
 drivers/hid/hid-haptic.h     | 224 +++++++++++++++++++++++++++++++------------
 drivers/hid/hid-multitouch.c |  69 ++++++++-----
 drivers/hid/hid-plugin.c     | 108 +++++++++++++++++++++
 drivers/hid/hid-plugin.h     | 145 ++++++++++++++++++++++++++++
 8 files changed, 540 insertions(+), 244 deletions(-)
---
base-commit: cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a
change-id: 9644469a-hid-haptic-kmod-4e8e420f8e5f

Thanks,
Rong


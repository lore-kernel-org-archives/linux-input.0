Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795741902;
	b=AkBdJaFT2foU2haMTUVtf1zNhEjrSKm+RkIBL6ubhZH9Z8oK5auqLwnW2Tn9CAeGQaSQ
	 ODOEviNr9IF3C7AT4KJjlJjh2eKzObr3wFWwJfUYJn0sWW+uiDiMUYPzhA9e6yK7I7SPR
	 O5ZYcNjzZcwwRTa/xgnCguN9zbALKtq8Ibq4iC+8CmLev6X6HU+4gbwmEjAhX/wahCiFb
	 Kc898yU9yHhjbVmJ+sgrFMwf4COHON7d6jHk5JYbDPdZIQ25eEzRoP9im4oK4T0tvtAQE
	 FxZxi4CqSPb0cbrfLb9/i6RfUwEBiXPzjFsVKbQOIMLLfMrt4pl1xLQzmaVDnSpag9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795741902;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PD6c8fm7urh6z4svWp1t3QnEEmMMsx7ZxWjladNA3Rs=;
	b=L4QUSg81Y21QJ22plk9uF6kuh7Eu8u2K1zWQmVNMe9wDA5vWStIpwVrqLTs3IKy61PWW
	 RPvAdFbhmdL3XFPvi7KDRaKoBmsxxVMz6gpnWPdntmzBrFEjxC1qLFiKVfJ1GoMeu6Tw6
	 khdSUc3mMOUU8iJUxDcODpos9O58EDtsawpn5B0AYe6Pv/1oq2920XyXiH4ebygGl04NM
	 Q5UfSetIAUTFS0TlkpQ68Iql/hsVQkIoR7XyLqaK9XSRfDnUuQoHefpYFWR1+OPECHR+0
	 HKEBXy9PlugoZzczvYpM/adu3HwUFZyJgwYDQVfT1F0LmAsjHFRJ/ltVeCLtv8vHMYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LrjbUbCr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3C2606A323;
	Fri, 27 Nov 2026 01:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LrjbUbCr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795741901;
	b=LIHdH5Swtnl+pB9DkJTFU7fdPg2hRk7hfOHbrcNGe+5CD6HlsY5kYOVUf6r9QOZP8dx/
	 hc6iaxog3qFvGvK4DWg06vgmRWaCN4AEdRhn6dGn9H7yfVkdZGa7aOtpTPNMjpdEQa9w7
	 6YnCacY6hoD6KGbyGTRlibLfCp8e1pjSLAwNEBXhlrGbgDNG8TNFZ3YX2CxjFqDH7f6Gw
	 B+9MMBwqqverwoF8ss3a/eUaN7Gi4+az20z1pVm2FZ4TnG7oJ/oyRNPDsWiIqrwWJdo+g
	 xIGU6pR9XTDeh8S/m+YzFimy14NzytRBniCXpdRXnUPsDU//JRgf7ET/7eTWGlU+gVA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795741901;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PD6c8fm7urh6z4svWp1t3QnEEmMMsx7ZxWjladNA3Rs=;
	b=MxG8t4LNEHdYa9t2nYyrOY642m7qeSMM5S61HMuFmtAs2H5VgkTib/ZmfKvnaLSU/XZx
	 i4OmveeSiHW7IG5L5lW7WSOTxa1AoZADR46J/e17v+p/5eYoeu3LHu6boY2TBkYK9H6Wb
	 LA87kKiEWkj/wVp6PpaQqY94OmEUHvn4UKVAGbuF2DDZ0Dn3PPs5+GpQR71n0+PQm0tP0
	 hSfMuJQHyD1az8XJJK+CneKXeQ8N8kezHqJIxC+i17EyZ8cWVcxFoXmGtgrrVvf2AXHyr
	 IRjUllIPZDTcXejVpBfKfHSfGeeQFVcq+/Lslz3Bf7PGKT0w4Jvu44chbm9FDIBDUFg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5734F1F00897;
	Fri, 27 Nov 2026 01:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795741901;
	bh=PD6c8fm7urh6z4svWp1t3QnEEmMMsx7ZxWjladNA3Rs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LrjbUbCroyAhBfOMnA18g6HGMLL/qbb4YJb+m8lKiKQ6Z+ZLbrzUIXqpe5QTmciGi
	 mrvH+CBcXyAYMcC0EcQBqdMxGBn2JsJcz7pTjOanQZiR1L9pCy9evDeCDsZCce+3Bj
	 zOB26aZOl8vMI/TfY/p7jffxtIm5NRLSSMegELLSm/yOqfKGC6wYJWMxOV90W4HyL6
	 Eza50HLkjzRsRpuUoJrOFDWsjAIDQiqNaDDjYso4fmWOwa9YljdfSDa4wCd0+ne5eA
	 oYMEZTlXwIh/V10Vc3yBp+A3CKTM+GSbgaz2BLIvBj8GFlHcRrZHx7Xr514kkZcqN5
	 aSNvzjlHQ8pFA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D7BEE4B4C8;
	Fri, 27 Nov 2026 01:11:31 +0000 (UTC)
From: Ciro Pedrini via B4 Relay <devnull+ciro.pedrini.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 01:11:11 +0000
Subject: [PATCH v3 1/2] platform/x86: ideapad-laptop: Ignore keyboard
 backlight hotkeys
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
Message-Id: <20261127-legion-lighting-rfc-v3-1-15c55d9f15b7@gmail.com>
References: <20261127-legion-lighting-rfc-v3-0-15c55d9f15b7@gmail.com>
In-Reply-To: <20261127-legion-lighting-rfc-v3-0-15c55d9f15b7@gmail.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, Rong Zhang <i@rong.moe>, 
 Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: David Cemin <dcemin@nvidia.com>, 
 Werner Sembach <wse@tuxedocomputers.com>, 
 Aaron Erhardt <aer@tuxedocomputers.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Ciro Pedrini <ciro.pedrini@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795741890; l=1893;
 i=ciro.pedrini@gmail.com; h=from:subject:message-id;
 bh=8vjJmh1Q1pUd+AgRnV5YoABPuqxBhqZmvy1ZUoX7yPo=;
 b=BjlHvY/qRCIHua/YLDfpU4XjzazxYK8k9g5E8b5ujydmzjVM8mqp7t6ti0a3g1ujqI4t5OGgB
 xN5Em1RDMaEA3UDgGLVpGd4WYEDSPMikJ3nk18D4WZx/s3t0rvKeP2j
X-Developer-Key: i=ciro.pedrini@gmail.com; a=ed25519;
 pk=TOSFlPBon1xBHfTrhODxatabgwEJdgKEzG3jMoMQcbc=
X-Endpoint-Received: by B4 Relay for ciro.pedrini@gmail.com/default with
 auth_id=1468
X-Original-From: Ciro Pedrini <ciro.pedrini@gmail.com>
Reply-To: ciro.pedrini@gmail.com
Content-Transfer-Encoding: 7bit

From: Ciro Pedrini <ciro.pedrini@gmail.com>

On the Legion Pro 7 16IAX10H, Fn+Space (backlight effect), Fn+Up and
Fn+Down (backlight brightness) emit WMI fn-key events 0x21, 0x1a and
0x19, which the keymap does not cover, so they reach userspace as
KEY_UNKNOWN. The keyboard's USB controller handles these keys itself: it
switches the effect or changes the brightness, and reports the new level
on its own HID interface. Ignore the three events, as is already done for
FnLock and Esc, rather than mapping them to KEY_KBDILLUM*, which would
make userspace change the brightness a second time.

Tested on the 16IAX10H with 7.2: with the change, evtest shows no events
for the three keys, and the keyboard still switches the effect and the
brightness.

Acked-by: Rong Zhang <i@rong.moe>
Signed-off-by: Ciro Pedrini <ciro.pedrini@gmail.com>
---
Prepared with Claude Code (Claude Opus 5.5) from evtest on the laptop's
"Ideapad extra buttons" device; I reviewed and tested it.
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index d2344dcd6945..dbb54d2c7c40 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -1384,6 +1384,10 @@ static const struct key_entry ideapad_keymap[] = {
 	{ KE_IGNORE,	0x02 | IDEAPAD_WMI_KEY },
 	/* Esc (handled by the firmware) */
 	{ KE_IGNORE,	0x03 | IDEAPAD_WMI_KEY },
+	/* Keyboard backlight down, up and effect (handled by the keyboard) */
+	{ KE_IGNORE,	0x19 | IDEAPAD_WMI_KEY },
+	{ KE_IGNORE,	0x1a | IDEAPAD_WMI_KEY },
+	{ KE_IGNORE,	0x21 | IDEAPAD_WMI_KEY },
 	/* Customizable Lenovo Hotkey ("star" with 'S' inside) */
 	{ KE_KEY,	0x01 | IDEAPAD_WMI_KEY, { KEY_FAVORITES } },
 	{ KE_KEY,	0x04 | IDEAPAD_WMI_KEY, { KEY_SELECTIVE_SCREENSHOT } },

-- 
2.56.0



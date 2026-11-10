Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342678;
	b=p9gvGPB3BXm2q92fm972wz2izDfukZRKRmVgrS06b48EjhuJzW+VvRjEAg1AnWT82Neb
	 43ZNKOPZiGjCHmkKAWXaOSntKapIVo4kN1VddU6U1hHQi2A5Ufnie5LNMVFukNMcE75yF
	 kmLX60CYt7swWLco47K0tQ3rGDxX32IxWZXAjaz902as2YmvblJqlwxz1Nn58j7fIQNza
	 xEGh6AD0ucHIHYaCipxYoiD22Qx5Tru+6f5mZAmgR5n9tuyzhqo1TktrN2DqIZMehamtK
	 1j1k9ckLojBbcZBWPYmrfYy+L1aPSkK2SgR+SQ6uLnVRuMX1HfW/wOvuZjw/lGUcB3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342678;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cv5mF2464SBHTiAoMjr7bBOGuhBF89SUOb0DI22+wZ0=;
	b=jPKA7Km+t3G8cbk1kdFCatEgdX7LmMpZDouHABKg4pXLfVKsSdgedkrRaXg9AmAdKPXV
	 G7u2EZgXw5Xt6Kvd1/EoksRFceeZ0LjUEGgK6snnpxpvqvdjUd0KP0katTCf7RHvcGgP0
	 el5780wkG3ljdTY7b2zSVs8OxnxWzj+J/49rRIeTVsvmscA3uOP+0zxCjujPpRmQ6Wi5g
	 rpXAvBdsBMOMEKwyDgG9n6bi3z0ZUPeAJwBnwfIwrSuIhWgJ22xy9zmRkLUiweXeuCSBA
	 dqf2OsP8DzBnzGflOD/r2UGAVx3ko4we/enjZ0nbCxSU2NMvTtDR7WpKEA+HXRg6aEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkOlAHNk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6D4606A331;
	Tue, 10 Nov 2026 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkOlAHNk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794342677;
	b=IvN2KYs82hgwTegB/ljZOJmNkRCwvfv53ebLbcV7AxpOnf8Fuc8Zr+UkA6Kcw4bBui6w
	 gIKRH9Hfx3CKE3F8mDIKG+AMleRXPAx9gYw9CYU7Tvs+VgbKuxEhn2HUkir/RmQCYuQCt
	 BNHIALH63MSfthNBybHzn3wK5+jumdXnfwzIHideH1DDnz9Y+Q2JblnLwEtstsOsFEum0
	 dMHBo9btuqKN/l0tWyUeHlWKnDbJZEnvLPQChe6qXX+2p5YTncLOdAlKC6UBurKGD0mwj
	 yEQFndtVPOaYGj6YkUsaZ5/RI1/t5HXmJxS0TOcVDWWmLapd5aA/WLOcTUbh4AbygYQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794342677;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cv5mF2464SBHTiAoMjr7bBOGuhBF89SUOb0DI22+wZ0=;
	b=uKVFVs0Zr+Evf+B2Y+etP9tUnKyuy1egNElcGtv05XG+GD3o+/7VNjehX1ABAfoRumwW
	 DGrMwyxoJ6RK8gwJT2BVkD5Stw39LYjqjUoi4ZZ6GlkdmtDXWkjU8izMebLYu6Wvx4VlS
	 X6fWtYUFuCKvU9NAW2+69aM/N5MOIKSSjTOqVi/ReNEduD27p2vDkzVmrG2lQEaOYiQ6Q
	 UJTn6X1JzDwZnyYoaVqA9PDaiIlsjEidR33AYyAGmCWuRLqcr44sd7vx4p7fTkbJPyGYK
	 HMJv2yZFo6YKwEVy3M+80db6g+pey0Jpm4jXtGK4kiXhV36e9Z1JR+L+vu1KfXN0D1Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1C4621F008A2;
	Tue, 10 Nov 2026 20:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342677;
	bh=cv5mF2464SBHTiAoMjr7bBOGuhBF89SUOb0DI22+wZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IkOlAHNkHVlGy2FeejfoY1htQvKsdWj76kTzYPWdqhXjn8r1WuSIqM80OTpDlZukH
	 xWU5Cm/WRZ4N6/3vyBDi7StQXcSiekKrQ7G/zML+U0AXnV8RrLaUwPAX9/fmIQFhz2
	 aw1h6GJrUYf7aS+gG+QLMi8jf59Fhry4iZ4DzxywZ5G/ENvh6XP4oW3gGpUd2wVlId
	 IaNoDoNWjljsaxU26y99JAvQXeML3LBhEyqot4NjuI8JXYYAdv6shTQaEizTUfNzW4
	 SvCpaBROMqqrAZb3Vy8TSZ9ISnRkPt8lunjiSfNctBd91cZ7M1GtdWGHPXHeCxCGRG
	 hxBSROdQE3JzQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8329248C7A;
	Tue, 10 Nov 2026 20:31:16 +0000 (UTC)
From: Ciro Pedrini via B4 Relay <devnull+ciro.pedrini.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 20:29:47 +0000
Subject: [PATCH v2 1/2] platform/x86: ideapad-laptop: Ignore keyboard
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
Message-Id: <20261110-legion-lighting-rfc-v2-1-845726afb71c@gmail.com>
References: <20261110-legion-lighting-rfc-v2-0-845726afb71c@gmail.com>
In-Reply-To: <20261110-legion-lighting-rfc-v2-0-845726afb71c@gmail.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, Rong Zhang <i@rong.moe>, 
 Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Werner Sembach <wse@tuxedocomputers.com>, 
 Aaron Erhardt <aer@tuxedocomputers.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Ciro Pedrini <ciro.pedrini@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794342675; l=1858;
 i=ciro.pedrini@gmail.com; h=from:subject:message-id;
 bh=7AFCuFhOORimBVaTct9i1sflefhIhf8+Hwo+UNCUras=;
 b=8psn2DxjjhsetxBvgzeTC4Jlsdo/RpQvtlFN0LLWfRg7WQR4okgyYI7GsAGxAs3Gs31DcU+7K
 kmTEIaljSx+D5Ihim4mT+uTBn4VVr8GuUwnx/73uS/hd4T8BUwFWPZE
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

Signed-off-by: Ciro Pedrini <ciro.pedrini@gmail.com>
---
Prepared with Claude Code (Claude Opus 5.5) from evtest on the laptop's
"Ideapad extra buttons" device; I reviewed and tested it.
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index 91a8d11c79c5..8b6c08b21c8d 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -1336,6 +1336,10 @@ static const struct key_entry ideapad_keymap[] = {
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



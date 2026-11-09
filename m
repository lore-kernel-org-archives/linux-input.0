Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794264690;
	b=Un7uI8RnEuBs0Jfp3nyL1y7eWvsw6OKjyDOL+9+H32ShWw6jRj1kOHRTeR6dJ1uN/nsN
	 xxjMjs1xXLH5HH/sSbwjlHcxUVKXzBelEOE+3gVZssG2pp1uZ8peYI7acJ8RiYd0r2ORp
	 8oh557lSKsrkbwBs4E/yZEapeT1So8b+t6AjHQ01reKmVKFDWGCoXcI5UB45w9Z2w0CmA
	 5hmjA6dJQGpaWrMXAjWxVZOtiraWmF3Aa1mHi1XhFj8Rh+ao9RnIqCyCCUO7gsAnHI9vx
	 yR6/lF4fS61LcSMJxTYNMnFaPgl6du3CNp8qTY1DsFdw6bEsS6rP0QInvXybZtYTNmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264690;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Xh/cTn4SHxtNgCCKSBrzXT1MLTrBAa30pZNt44cHkqs=;
	b=knL8Ba3zn3G+rNAxR21Q2OhWNl9V8y4e3zQ2LW0ZBCB4B2qmc2LOpXRSQhVA52dsZfZ2
	 HZHCYVtwDSGvA8/iZLZXVJvuupql2dLSxxWYu4jVQ6Gve+Q8WyHD4qe+sliCc7Ej/pKoX
	 7S8YS+cv4Sem0lW5vcdt+ZhMr5eaEdSRNQJtFnFYo0RbTzvcZDXiKszDsanc0t4R9j9nO
	 byDIEK5V86uo3558Pl1psnCd+cl06a2lJO9GEnVNjXqyEKEBmjLyYQrZ0YMYIjz04YXPs
	 OJq5P4uGPhjRodTD2V5NR7+4EkX7epxHP5jbDay3e0E9bQECTmbntGaP0ayYGgTeFjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHGqHgGg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65336606A31C;
	Mon,  9 Nov 2026 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHGqHgGg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794264690;
	b=b35aneQoJlEoazWSX3bDBdHDrytbbeSKfEqoM5gTRfv3mYxOT18c06nkH60dHC7uIEOj
	 FKIdSVz0Ab8pBCvbImZDX31Y3gdEl9ROWHyMJzMhsT5v0pKjk1nTkSxqhO/abdDLFps6Z
	 FYWVdbHMiexsrD0BktNhZniDpq1al3Z6V28wotTpWkUg5bwp9OF5FpwqiGJm1pUnA2Xsv
	 tBphd0BI6NrP356iabyREEilFrTXurDWmZORTvWmA07lNduNISxITd2DXcaaR3+Gtl8kQ
	 KZBvcMDUL5KEX6ZY2UVcnokcTa07b2CEY9b2RpZveI8DbgenoGVY65H3aAeIh4Ij7fg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794264690;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Xh/cTn4SHxtNgCCKSBrzXT1MLTrBAa30pZNt44cHkqs=;
	b=e5sWq4RopryT0rGx0ZYKy7V0Ak8066bwXIQyl8wkjat7fNTcPNVnWxCvTt5Iwnx4fMR1
	 LEr0/FdVuPf9ZyefYNjYA1jTFTFjnILCvNk6wp9wCj20elznjGFUNU/QGMTMTHjv+YXig
	 YYr8MXcFsoIaHcwrsADNNxQuLZipb6clIYnAxIL/vo6pFmbx5LA58N32OzpvFFKhGg+2k
	 O7Oz2r7UO7E1a73rft4YFEIWNM5NXgWEvCoQCyB1EVqvRDPmPhSt7a94HrLLBRdLpjDEQ
	 eDo0LAeqq1SQl/8J+VsaQ8TrSm70N2jWstelnsurh2ft92aOiw4JyT5EC+cyk65wO2Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A946F1F008A1;
	Mon,  9 Nov 2026 22:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794264690;
	bh=Xh/cTn4SHxtNgCCKSBrzXT1MLTrBAa30pZNt44cHkqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZHGqHgGgVO+TNJM/ALScEKp06faQF6SrSNSsZGzXmRK6Vxo1bq0DC3rQKEQ2e3v3+
	 VKBuq6ZN62yW25c5jwr+KnQaL6jbgjLzFMBrTfteucMIKanAwiup6CfwxG5nRk7sQu
	 p1UsagZN/um+2N0uLtY3rMgjSqfYIiYEDvldgsbQdnKiI3jrMk30czS8SuXAyCJRAu
	 iPsVe0L33M71O3P3BeqfPaARxuO+/67aSLqqJhdnc0JKfG6lraQ/lD1FAPwbn15Au2
	 TPa+cDQnb3IHYGChMkFspBh1eQ8Cn37KvQrYTKfx41w8fnV8An58b2eeLXBiqBJx9K
	 8uE3Z/CaPzFFg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 292AE486E3;
	Mon,  9 Nov 2026 22:51:29 +0000 (UTC)
From: Ciro Pedrini via B4 Relay <devnull+ciro.pedrini.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 22:50:21 +0000
Subject: [PATCH RFC 1/2] platform/x86: ideapad-laptop: Ignore keyboard
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
Message-Id: <20261109-legion-lighting-rfc-v1-1-a87e1db8c5e3@gmail.com>
References: <20261109-legion-lighting-rfc-v1-0-a87e1db8c5e3@gmail.com>
In-Reply-To: <20261109-legion-lighting-rfc-v1-0-a87e1db8c5e3@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794264688; l=1951;
 i=ciro.pedrini@gmail.com; h=from:subject:message-id;
 bh=Zl7fj9wurzonIdXlmNqfu1Wh3+5k9Rv1TlnZQXC74Oo=;
 b=R9FxoyG/QgvEAbey5++m3oEisB7lQcvb5/ZolCJ7L5vmlcQEWonjVgfrzzLr59JF6vkLJIPUp
 hz+aJFIczsWCasG8/l9hp0bS1UXiz/CDYdPBBzTTn/fNDNpJ6N1Z3cf
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

The change and this changelog were prepared with Claude Code (Claude
Opus 5.5), from measurements on the laptop (evtest on the "Ideapad
extra buttons" device); I reviewed and tested them.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ciro Pedrini <ciro.pedrini@gmail.com>
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



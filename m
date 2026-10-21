Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549442;
	b=zmSGSUcY2+S5WZsFP3JvG+DYHUbtGZnjBOUj9imVQnsmXTOwCme7cXU+oaC5OJelDh+s
	 FTyohurf9OX3I8QtNWbJbHwxB36paiJd5pVpX1YoxjZ3xK9QDBaF2O1AN4juGSD72Tqy6
	 pysYFbFEAVrcSXKUqV1u4/L0UhVZMRjUvFhb3EUATCGoVZqgNU//+k+oD1vLiKmzZUTaD
	 ZiJnp767Q32ogshymQ/xNdy7GXXDk0n6tY23jPp3m0TURRTTK/tW0YrxcoHhzrgxJYh/I
	 q7TO8hjwYOXYJHotsF9AtHx1tJveYd5bUu72JoeQTLZCNzYWNhOrvGEQpyjsDMBZ6pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bnvCdU51kfAyTXcgIjB3Wk7G+GMeZALX828YqwIPm9c=;
	b=3xMxWoXqbyZbQFOazqX6uDl+9qoaD/Mo++yuWIDdPP+Zo156zsF2mKdcjaTxKamVPprT
	 X3iZdz0pfykuOWvO8BovcAoE0poJoVl/1+3w0eRYBgVZAcrFsyRNLO0tCm4XfNOytp76+
	 L+4OlCgwsCI1DV7GXADdEBGHEnlqWNm94pmLCXrJCo+9sOvuHqU7XZK9sImlxwT3FmQyS
	 F7CrkX6ZXJaQJrMG92oNYBOZQj9oolbre97D/s3AgOKAlhYgS4PubwCy/cvUK9IDu/a3v
	 95HeELq6VIbV0YvCFldwiEPE7AMDyEkWzuq78rscgYZMREE5m/rROq90aJgxlrSCt5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p6PRR2lQ;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5B606A32D
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 02:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BF5B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p6PRR2lQ
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so511796eec.0
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 19:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792549441; x=1793154241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bnvCdU51kfAyTXcgIjB3Wk7G+GMeZALX828YqwIPm9c=;
        b=p6PRR2lQKy1Q0NLU7/1AjcF+knFkI0/JwZc+mHmX3rJME2rpFT//uKeWXdJgNms5Vf
         tWP6r8owfjJV37m2A87pydh0tWsMesDLalVYQJpdNA5aueSsjhJvq+Cc39Q4/4PoUgZW
         o9ZKSbKdLkya+iSM8hnlu0rXJevJXqCDAMkKlxlZyAC8Gws3CwmYIFrqpZpacthmb9DS
         N6U33yPvK08BnUOv/auKzL/c4bLFFgiFTgFrHMJVHt7GPcK4vQXgAqz5+wQajzOGsn8j
         KOhglHF5VVcmHoAlXNye2oQm1B8fYYokIVtnSH1hNVvSb6DUijJgiHWaLnwdg8IXEISN
         VWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792549441; x=1793154241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bnvCdU51kfAyTXcgIjB3Wk7G+GMeZALX828YqwIPm9c=;
        b=TCIrhB1yMqPXMdagjCaLh7NEoKTgJJKuT4i5Sn2eJcWxZxyrAMDCCL6zCUr4U/jFpQ
         h0uqyi7lDj9jZ10+ulM0qPkU0TVDasf9HXCuuank4KNUNiKNPWr19vNbEs5HDcfRSfC3
         xFCm6aZxzmZ5QHWXjxDFH8Lf4bL7D5pncayj1wlYtUdqTcqpTPypcwo/vbzJ5RuhV0If
         psTxdlT0zvbkeGb/rFqrq0oHNrfZu5q3IZGrKbkB8Gct2eCcSxHF0NBpSPaDGZyM0aX2
         JvP73crGI99uOY/FP0afBeDyLlOuwahsoDoEB0zxKkuQ5hktED+j8orcmoUUU4LwT4Aw
         zj+g==
X-Forwarded-Encrypted: i=1; AKwUvBwrod6j/AGF2vAj/KOdbQv5Y/iiFvXCZfkjnVlYhWYsLVmHGxPpOCPIh2X1Wbzb9x/L0WMfmGk7UZD/0A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKKYBF/32dHwS82dVQQ6/Cw+dpaGqRZEFSPHhwbSlfM9Yehvvl7
	WWSBKAbuQ6F4sxPKDWLGkc4lFJO7mN0X12PKwh5JUyXYhJfN0xGmy8bz
X-Gm-Gg: AYBFou3QrXrw8Knls2rxyOdLg2IcjqPwoOMm+vI7uPk8Ywh6+WPMzuJASLuhUS2TP/U
	2UJdbhPvdoxUa4iIZozW6ffxZCdJbHtC86GVP1qfcXG7TAGm6fT39YZp76tl5bbR9Kd9+FM/t+L
	ladTvRZWEgcN4cEgqrfub2zAw974aBpDpqNmCgnB0dm56oJ4cWywevupfBvpbgc0mUiKkO0X0gH
	Fdzb5v40WF4Abuh8N/kwV4oeRpoo1YlGtTZRMavSa9JbfgF+me2GfNM5N7BYXiVFKW3JysSLG6u
	KnRE9kw+GWkXAjKqmK/qvQ6qAIRW024wDdwdLj/8dYoXxmLkYkRiC8V7dU7U9+fAP7OPc+IiPCc
	nFKa24aHF4Y6ngNPwg7Je+WXigIqLzxsIB632rY8M9WAEHwQeyQuPrr1xPZJSbcEn0FidVpCeC6
	yQVJWrwuukbAZNGWT1lKP70fiPjZWTwUYzbrc5sFffBnqcZPMFJQC7M1i7P01j4n3MtuZN2KiaR
	CQyUpz/b1zRgnO6CoA2ES/hjfb7tkBEa3jxbbOVfwYFkq4Z1bHW4EoHLTT6O2iRRT0F6YCnLAP/
	OjUdqfPh4Xp1pS9sg42u7L0pvubRBlbk7CXyieBH9XJVo8tCVV3FlN2wxsR+CYFaDMTntE/ff3s
	U7EctJnrjpn0g2SYi9aBl0iVjWP6y8yruoBCXydmuqTTD6NCfCylVsqKWHL6S13hVSIUywmix5T
	cxczyDIvy7jzeJq8uOn2EBmgxU9Q==
X-Received: by 2002:a05:701a:c90a:b0:152:92c6:8b58 with SMTP id a92af1059eb24-190a6adaa1emr739535c88.35.1792549441364;
        Tue, 20 Oct 2026 19:24:01 -0700 (PDT)
Received: from lenovo.localdomain (42-155-215-210.ipv4.nexon.net.au. [210.215.155.42])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903d3ae06fsm2409008c88.19.2026.10.20.19.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:24:00 -0700 (PDT)
From: Miro Kropacek <miro.kropacek@gmail.com>
To: geert@linux-m68k.org,
	dmitry.torokhov@gmail.com
Cc: schmitzmic@gmail.com,
	linux-m68k@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miro Kropacek <miro.kropacek@gmail.com>
Subject: [PATCH v5] m68k: Fix atari mouse movement
Date: Wed, 21 Oct 2026 12:23:36 +1000
Message-ID: <20261021022336.2232886-1-miro.kropacek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021000338.2160223-1-miro.kropacek@gmail.com>
References: <20261021000338.2160223-1-miro.kropacek@gmail.com>
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

Kernels are built with -funsigned-char since version 6.2, resulting in
the signed 8-bit position deltas reported by the IKBD being
misinterpreted as unsigned.

The hook is handed a raw IKBD packet, so take it as a byte stream and
apply the sign to the two displacement values alone.

Fixes: 3bc753c06dd02a35 ("kbuild: treat char as always unsigned")
Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>
---

Changes in v5:

- take the packet as u8 * and cast only the two displacement values,
  as suggested; this drops the call-site cast v4 needed, and with it
  the -Wpointer-sign warning
- add the types include atarikb.h now relies on

The same cast of the two displacement values was tested on an Atari
Falcon030 with CT60 in v1 of this patch; v5 differs from it only in the
type of the hook argument.

Michael's Reviewed-by from v3 is dropped, as the approach has changed
twice since.

 arch/m68k/atari/atakeyb.c        | 2 +-
 arch/m68k/include/asm/atarikb.h  | 4 +++-
 drivers/input/mouse/atarimouse.c | 6 +++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/atari/atakeyb.c b/arch/m68k/atari/atakeyb.c
index 49a9a459bdf4..b715e2b8351c 100644
--- a/arch/m68k/atari/atakeyb.c
+++ b/arch/m68k/atari/atakeyb.c
@@ -39,7 +39,7 @@ void (*atari_MIDI_interrupt_hook) (void);
 /* Hook for keyboard inputdev  driver */
 void (*atari_input_keyboard_interrupt_hook) (unsigned char, char);
 /* Hook for mouse inputdev  driver */
-void (*atari_input_mouse_interrupt_hook) (char *);
+void (*atari_input_mouse_interrupt_hook)(u8 *buf);
 EXPORT_SYMBOL(atari_input_keyboard_interrupt_hook);
 EXPORT_SYMBOL(atari_input_mouse_interrupt_hook);
 
diff --git a/arch/m68k/include/asm/atarikb.h b/arch/m68k/include/asm/atarikb.h
index 68f3622bf591..bdf67bff1472 100644
--- a/arch/m68k/include/asm/atarikb.h
+++ b/arch/m68k/include/asm/atarikb.h
@@ -15,6 +15,8 @@
 #ifndef _LINUX_ATARIKB_H
 #define _LINUX_ATARIKB_H
 
+#include <linux/types.h>
+
 void ikbd_write(const char *, int);
 void ikbd_mouse_button_action(int mode);
 void ikbd_mouse_rel_pos(void);
@@ -37,7 +39,7 @@ extern void (*atari_MIDI_interrupt_hook) (void);
 /* Hook for keyboard inputdev  driver */
 extern void (*atari_input_keyboard_interrupt_hook) (unsigned char, char);
 /* Hook for mouse inputdev  driver */
-extern void (*atari_input_mouse_interrupt_hook) (char *);
+extern void (*atari_input_mouse_interrupt_hook)(u8 *buf);
 
 int atari_keyb_init(void);
 
diff --git a/drivers/input/mouse/atarimouse.c b/drivers/input/mouse/atarimouse.c
index b1219cc4d9a2..c5b794262e85 100644
--- a/drivers/input/mouse/atarimouse.c
+++ b/drivers/input/mouse/atarimouse.c
@@ -60,7 +60,7 @@ extern int atari_mouse_buttons;
 
 static struct input_dev *atamouse_dev;
 
-static void atamouse_interrupt(char *buf)
+static void atamouse_interrupt(u8 *buf)
 {
 	int buttons, dx, dy;
 
@@ -71,8 +71,8 @@ static void atamouse_interrupt(char *buf)
 #endif
 
 	/* only relative events get here */
-	dx = buf[1];
-	dy = buf[2];
+	dx = (s8)buf[1];
+	dy = (s8)buf[2];
 
 	input_report_rel(atamouse_dev, REL_X, dx);
 	input_report_rel(atamouse_dev, REL_Y, dy);
-- 
2.43.0


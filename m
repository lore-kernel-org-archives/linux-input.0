Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634773914FF
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144687; cv=none; b=bypM1HTpKIPIqwgeRhy70hfS0zUPMn0QjN1yN8Y3EsmldUCJDprNfKWky8OSGuWZJ0LISutOdgiWgGj1q2qtrb8YJOj15fMsFThJuRUoX3fvcFtxt+R4MnGGICVwgNENhh9WO41ADk4UccxHki8d5bo/hp3ewYQ9nfXiVqOtlsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144687; c=relaxed/simple;
	bh=gDXYl5f4DLrqbIOluEjUd2KJKz3Tf/PL0OeKByaERoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTiNVaMoVaNA4tYqxZntCbimsY1bgtRHkZw8TEtgkk7h/oe/7uG/xZ62080V6h213W49VxV2mOnEIuKEqkdscUJxAytB+ABRiuwPuPeT8r6kfrnplHpet48Zc5UiZ+9EJh3tf7+tVxJjldYksvwk/puABS9udorSj6kj82QoQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqXC6fKF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqXC6fKF"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3811074a8c5so885747a91.1
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144685; x=1783749485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aIbYkeRmMJ3qAal/r9Tkhbn+MH1/NZUDryRDlJi/XtY=;
        b=PqXC6fKFakTuhwM7eV2JU/C+8765z0SBijpCyigMocPunpk3SpSZyXxYaTHus6UlZ/
         W5przou+Im4xs+A8KJr7+taixhRzDZCwx0cJtQZMeVF/iu4pw/QlfN+iPsYMB/3DW9y4
         DPqvxj5MHR/xgg7pA9q7/SP87zZonbeaMR6lVyM/IVe4HxSfV1r0vlGGIJWX8W5fsSGr
         qwc69SAzbU+g4AYdS0epZFKga0lhitcrGnTd4q+1QIDImU01USFGq7VFCeIFKbFpRlmZ
         CWM1ZGw04dhtibQXdxsDoi5l+VJlt4yq5BXDXEUTp0oZ8tVn7VeFY2K9a1RpRibJoTro
         ujkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144685; x=1783749485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aIbYkeRmMJ3qAal/r9Tkhbn+MH1/NZUDryRDlJi/XtY=;
        b=jViqF3uLrGepIBIxI7f7vAhpuRPYJLNZRG3B4qFo1P+hCEJfpbnEQg3NqO2yZUMDTV
         N7PuQ/a0gYV/CH1/+7aKQMpev9aNZoAFT/Az5KWiqbCEzhNaXcjcqX6TOfqhH8yktrjw
         IeiH21MM7G1UDvvuKzvEuV71xjs7fUp+ZKHbHDUWGKvasvybiq4PL50TRg5JJZhkYbI6
         1/Pka7EpZtzgGFmh7w398WoG/Tv+V+mrYnNdVJhfyCNJp67e+ZKbELB3q8oKIS7g4w8l
         v0gglHTuFcmaYs+O7toQxeWseQ3hJpQ9Xft0RAaxIyfNs1xkpIWqSBSuAmwb7tBcW8ni
         BFPg==
X-Forwarded-Encrypted: i=1; AHgh+RoJMcZccBSeP4c2LEu9n60rLdyQRDidXq3fvPgHfaM/sOHXFkvB5P7m6z54dUcnwbG/c3FMDviG5/rp/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTYogBKPOW8i7zKUllq5IdkuhfqUkijHzMX1rSBCcF3A8wtsu
	VXjleYBQUfGh8ZakDwPJ0mr0H97tePudZi6IFcWreOnC5GloxKk2aGvi
X-Gm-Gg: AfdE7ck6rKzaqEbEmzoa1HpivfyvTxwMQZP+XglvQOD32Ycl8+FQdluLYelhNnP7ERB
	BdbpTTUfrAxaSbK7897bs7pC9649YjPsHyYjs2jazFjx3CgLXiga17uJq8qrYsqPbojxJUNGcg5
	TaxSHm4es7RqlkYKowpG3H7hhGu1XsQ3BJcZH54y1qjp3NOIjCJlmDCCSBeOP6rKiBpInKWsRYr
	jtrpMTDEq/OluZDARsiPAZakmsmS1KowJ9BZDGgOo6Z9Wm2C9P8pWz9N1pBk3rO8o8EUpnF68zt
	9LT/5SFmV4fNnRAS4GflB6mX7N5+8VLQX/r7xZ0Tm9ALA8k5Fc54r0lyJCM3SurwgWaxtP84X9b
	74IcV/NmgFBHO1sEhnZNlqVqzYH8PwK7ULNwvDcd6UoAGzDlhZwVoF0NdFdAgOlX4kDmGqNn8yS
	+Wpl1HILV9bn6qFFdJyAxjVn3r6xHWWxinLBdVKU9luFFCSYPCRB8d2BHLoWopZoi5BtlzC7pR7
	TI=
X-Received: by 2002:a17:90b:564d:b0:381:889a:65ca with SMTP id 98e67ed59e1d1-3829f5e7806mr2141892a91.28.1783144684570;
        Fri, 03 Jul 2026 22:58:04 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:03 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:42 -0700
Subject: [PATCH 19/26] Input: maple_keyb - remove redundant mutex and
 remove method
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-19-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
In-Reply-To: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, 
 Adrian McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

Now that the Maple bus core handles callback synchronization via
callback_mutex, the keyboard-driver-specific maple_keyb_mutex
is redundant.

Remove the mutex and its usage. Since the mutex was the only reason
we kept the remove method (to synchronize during detach), we can
now remove remove_maple_kbd entirely. The devm-managed resource
cleanup is sufficient.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/maple_keyb.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
index ab9257db7e03..aa9a4a80e26f 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -14,9 +14,6 @@
 #include <linux/timer.h>
 #include <linux/maple.h>
 
-/* Very simple mutex to ensure proper cleanup */
-static DEFINE_MUTEX(maple_keyb_mutex);
-
 #define NR_SCANCODES 256
 
 MODULE_AUTHOR("Adrian McMenamin <adrian@mcmen.demon.co.uk");
@@ -128,15 +125,9 @@ static void dc_kbd_callback(struct mapleq *mq)
 	struct dc_kbd *kbd = maple_get_drvdata(mapledev);
 	unsigned long *buf = (unsigned long *)(mq->recvbuf->buf);
 
-	/*
-	 * We should always get the lock because the only
-	 * time it may be locked is if the driver is in the cleanup phase.
-	 */
-	scoped_guard(mutex_try, &maple_keyb_mutex) {
-		if (buf[1] == mapledev->function) {
-			memcpy(kbd->new, buf + 2, 8);
-			dc_scan_kbd(kbd);
-		}
+	if (buf[1] == mapledev->function) {
+		memcpy(kbd->new, buf + 2, 8);
+		dc_scan_kbd(kbd);
 	}
 }
 
@@ -211,22 +202,12 @@ static int probe_maple_kbd(struct maple_device *mdev)
 	return error;
 }
 
-static void remove_maple_kbd(struct maple_device *mdev)
-{
-	struct dc_kbd *kbd = maple_get_drvdata(mdev);
 
-	guard(mutex)(&maple_keyb_mutex);
 
-	input_unregister_device(kbd->dev);
-	kfree(kbd);
-
-
-}
 
 static struct maple_driver dc_kbd_driver = {
 	.function = MAPLE_FUNC_KEYBOARD,
 	.probe =	probe_maple_kbd,
-	.remove =	remove_maple_kbd,
 	.drv = {
 		.name = "Dreamcast_keyboard",
 	},

-- 
2.55.0.rc0.799.gd6f94ed593-goog


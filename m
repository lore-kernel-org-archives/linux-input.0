Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E137A822
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572876; cv=none; b=jKLfxmLKqIgnjMClnVCOVJFR6nZ+5u9fd8SZAYwDN3xHJkvF2r79A0mLIYMOHwj30omYpC0d+O7Nokw6KGWN4m2JmemZPV8q2pzpRutGFhAVgTkwcMkpDNh8Lg1SjztvAVuTICkwdB/Xxmm33hRRFC9F6UWpyvwAE4tCpxiRbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572876; c=relaxed/simple;
	bh=oCSvTdXERt+oQFp/V52Il0O0Va3F3t1XTd5mQjPemvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5mz70C+WD7J38JE03+FZh3ZFcvHwzQrHV8jK9nKvcE7CsBqDqPmKuKaTZ+RIHEucy83bYlGvVIzSD08YVoPl1SRyDi49pfURfVmNeYIhstaAk2lNsQwyR1lD4ocjq5ZGOeMTiU6iRpVAhObWJbhCzPqfX30tbP71/uler1M+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7qddauF; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7qddauF"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35829219da8so3305eec.0
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791572874; x=1792177674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ByNS+o1NUbSuUxwr1m7Zp7UN3FXrFp68YUrjN0G+wX0=;
        b=e7qddauFd6/+EwJz0mbMQ7oLKQatDXXGj58FhYUOl1YZia6pB7VdTmpLehKLvIdL5v
         RIg1fxqvcoIsg7ezbAiTLMp71ME0WsSuRw954PvCkx/50yQb2dMNOvd11RPOV02GgFgw
         kRh+m6BnQUbXnwBJQnh5/bXVEYfNhwOcvgeGP4vQKyAh/djIME4b0kmbUpnF6grrpZ/O
         cm+83YqdL44R/WB5r8wUB3XBDG/cdBhL3HgM8xcQWjdIqCmubpz9KpDeVUTozWePuWhl
         Dmm3/+qibD0unQDhhv0+qi+KEaw9HUYL6QupI4M86wxM9N7kElVd2wg8KiK4FJoLYW32
         8x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791572874; x=1792177674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ByNS+o1NUbSuUxwr1m7Zp7UN3FXrFp68YUrjN0G+wX0=;
        b=oIOQ935dUDLvPGFmoFm47iZyi6j8ABxtwFkaZGsDQdR6ZKi4rhatQm40alrvEGHaOs
         zqHmWJunz9EWmwkiwvtlTJtKtAAgJg8hbqgELbryYw7eKGR5iP884qnBMhnAYhhEIC1r
         GQq7GDAmXJksevLjL0xQ4wld3AbC/IbfVumQKsxXjcJ3F2PE+3KgqzAn95Eu2Egxd8NB
         XNHCC1sPxi31mc3r9N+N0y9OAje+6mTOb+uH0hz7I92yjOMB3w02GTLo9qZZhzvHEc6i
         DLzdClC+h824edhtem6rOChwCmI4FbxGbEP0ptRAKKW5OIFCXbkC9TYK4KDLYJZNZeQS
         JeVA==
X-Gm-Message-State: AFuF++la9dHJNXRBRFaEsIJiJCMUgp8cHQphip1tqwWXsji2+vItiRbW
	WDJzpWM+PrLBmOLD9zRpoqQhMXjzHY3W+U9m2nYfmRy4K31oIvNng5PVDIFBYZg3
X-Gm-Gg: AYBFou0ViELchvtkU1db6xNvN3Wn3Xry8QV+MvJ1qL+3ZAMLFX53WSB8iXdIIMe7PcQ
	Mn0UPsQzSYhL91fSxy7342p7aYSnJVAqPikF/f56+eR39PAsGwXtq8YwvHvflbFys6Q1MdlVDLX
	qa/Bv5kS+MDY2Dmq/2W3iDi8f9DQxf75HEY1tga04Nqm6UnZ3MBOEWPl7Pr7HloL2d8jMICQkHZ
	iPphY3onGfKG1zUcD2g1L/eeCtxSYxXrPz3Sab7XVn4VHkU9wO3LOVw/y0b7bgH6zoH5EDJWavg
	B/B3aqoI9J0NMFQTnBrvhDZZMyiC7TN6Jo6yTuuCZQS9OaUIycDK/p7aMai8Wi/TGpFLrPAjK+r
	jVcAKS6EaCu8Tdl1NsZN5OcBUtA5iMmK8BsGDwQUZV7Nvd5Go6sQSjP24YSDNNsYb0TV8kVrlyu
	1XhyKpV4xPQEt2Mem4jPfRJk733vkAlOrML95atjw6l2m4MiDlUGC5TM4NpRRks52R/SIdadSiP
	GF0eUD2lDqMCXJLNXGcw2tHQbB4guzDwpo8DCu1RS8KII6kqjBp2jgG+qlVwlU=
X-Received: by 2002:a05:7301:690e:b0:353:e390:e395 with SMTP id 5a478bee46e88-353e390e66emr2529768eec.24.1791572874261;
        Fri, 09 Oct 2026 12:07:54 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8725:99de:769c:1fe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm10191598eec.0.2026.10.09.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 12:07:53 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Input: wacom_w8001 - use ACQUIRE() for interruptible mutex in w8001_open()
Date: Fri,  9 Oct 2026 12:07:44 -0700
Message-ID: <20261009190746.803607-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261009190746.803607-1-dmitry.torokhov@gmail.com>
References: <20261009190746.803607-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from scoped_guard(mutex_intr, ...) with an error fallback of
-EINTR to ACQUIRE(mutex_intr, lock) and ACQUIRE_ERR(mutex_intr, &lock).
This flattens the function logic and propagates the exact return value
from mutex_lock_interruptible().

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/wacom_w8001.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index e967f2413706..b34fcac44f63 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -387,18 +387,20 @@ static int w8001_open(struct input_dev *dev)
 	struct w8001 *w8001 = input_get_drvdata(dev);
 	int err;
 
-	scoped_guard(mutex_intr, &w8001->mutex) {
-		if (w8001->open_count == 0) {
-			err = w8001_command(w8001, W8001_CMD_START, false);
-			if (err)
-				return err;
-		}
+	ACQUIRE(mutex_intr, lock)(&w8001->mutex);
+	err = ACQUIRE_ERR(mutex_intr, &lock);
+	if (err)
+		return err;
 
-		w8001->open_count++;
-		return 0;
+	if (w8001->open_count == 0) {
+		err = w8001_command(w8001, W8001_CMD_START, false);
+		if (err)
+			return err;
 	}
 
-	return -EINTR;
+	w8001->open_count++;
+
+	return 0;
 }
 
 static void w8001_close(struct input_dev *dev)
-- 
2.56.0.385.gd3acb90ef8-goog


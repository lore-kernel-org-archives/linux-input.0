Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236039D6E3
	for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533324; cv=none; b=WG9Dr/HYyqVct5eMI3xbki2F+pC5zW8LHRHAc63sIkoE3qMD/D0kmqLO4OIMY8+wBzy3LYst1TBzDBp0JOd/aDQjuz40dR3DxTGp9ZXorNgzQ3fcciqlQaQHKHZtENCPXLow+Ifp7w3LTmMH4P1NO9TmpjrinnPID/RWw1OetTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533324; c=relaxed/simple;
	bh=6M8vIhC5eapisP8abzJ0zTYqUAp/C0pP3Z4DEPMcxH0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=erubUQQ15pm+2OTSgd5WeQyQnYq1HF4N2T+MYbw6JD0ivdUgvpBqUfREs8s1tmsuOiWg6MaPRWw5q0iRm6sqLYFtOj3JfiteIbZM7Ji5bNWQQ2YYyZ/qMUlDsV8oUykbKBEuNvBXg1qKKzanRsNzTd3ePVxbHGYueCuVEYFBIEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI2Ieis+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI2Ieis+"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-358ed696623so238429a91.0
        for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 00:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777533323; x=1778138123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPFz+mq7sl2va3Zah4DKkwVBgZIJ3y6xrphGxYzZrW0=;
        b=AI2Ieis+jb9TwUXNJlQguPaNnuHgeKAoe7l/E9kBdldGrvq6FQvmRIqe3g/QaI2kGF
         3COxRjJCtmOEdEaCyHm3KkCWWJEQ98ZnuXk6Q1na++UpXxt8ZxabBEurwzfo4wpjW5on
         /YMqyVV/5G4SmuNgNUfDbh+GfStciPCD8Fd5solgfPiplY1KKYHnoHP0hIYIWfnBDQPa
         E1RcOQi0btsiL2QWMWW0xgYdFtYLV2hVEbTM5ZpFHC4smeEzkd//QFhvj+rikmwqSo4n
         hl/a0/ifrzfQGv4SaThSyXLRyeWem1LSiZLpbmQr5EJW9LZukbzi4ELEOwf3CADhG1PN
         j1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777533323; x=1778138123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPFz+mq7sl2va3Zah4DKkwVBgZIJ3y6xrphGxYzZrW0=;
        b=XJFikNBroKGUtPmUoOjNvERdH6Ir3EWu/13Qr9ldPE12x8iuyQ0uhxwbqqwvyZHbx3
         BJ65m+6K1/iqXuNTBWZ6Y6jbg5o5c3WQSP4oWwedTYki2wFczDm7L4zzfh3eC8Xv+VOq
         Ir0GW3TMLQg4q+j1VMOIWm8/F3JR5Z4X4KdR+9W2rbdmDpfLoQWQ5u+WHhfKvARkRWZ5
         /fBQbWyOh4Iy9XnzrMjl+mwSbaprmE9DhWmbyuj8sOyEN4Wo1Ohv6gDbaG10PhZMtZ75
         mVpHyhIFZ6tg1nRP+Ob4TkNDRntx6ttZ/qGRkwDExCikWIHoyi26I6Q517tSP/a9ubQG
         xEMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MQgkVOFONcXKQNRpNjasLXjlF4QLaRcfJFSeT6/n6IdO9eDaCMjTYCdexp6CWHq5jLZJbRKOx7uB3bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRenCYl4I80NHXaup2PQGFv/h4lGRMWrNF34aPRxblKDLmur/
	YL/cFqwXGZKmJlxkQHhlQULyvL2S0C8qpstt27ai4uQUim71ERCFU+7V
X-Gm-Gg: AeBDietg6xd+MuqRJOgLxsNvinTvZQSXrWi+n+5Lpe7+HJWGqbo0emTUMwegn3WaIG6
	TKY6XxiL2VtAKT0LkO0MtFhLHIh+KAwH2tZe8CTpjoz589StXWnun9gNSCMCaI9BDbU+mm9fIr0
	xVdzR/7Do0+bUmYr+hRHJpcet8WYDZKiGcaBDBh9Fhz5cUViJ74vckEyO8w9yEbqhnn2/vt0Hzh
	+v0rIelxx97kr3u3abmpjHc3ZQk8RNDzXFCRGM2f4Xx48yVa5NsP+LHc7JOGnVtpnPEF8bxB6SD
	LmOdiThPJBmIuCI2Qj4VpiUF9QQwDEZ4hJmJ8NUXKfm8i534nG4kqNYVTA6A8x8106WRrIjKhXt
	+EhSRwzCNIn/mzLNylvM5EzKKlafm8UxYXvapDDU+HtaF/ny7rIATv+GKAfsr7GYryua4aMVsET
	qeOyi/mNM9UXwdVeib
X-Received: by 2002:a17:90b:544f:b0:359:8e5e:43de with SMTP id 98e67ed59e1d1-364c3167242mr1804841a91.22.1777533322766;
        Thu, 30 Apr 2026 00:15:22 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::5a26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364d1c70d8csm1165825a91.13.2026.04.30.00.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:15:22 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: wacom_w8001 - avoid double release of pen input device
Date: Thu, 30 Apr 2026 15:13:11 +0800
Message-ID: <20260430071311.451957-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When registering the touch input device fails after the pen input device
has already been registered, w8001_connect() jumps to fail4 and
unregisters w8001->pen_dev.  It then falls through to fail1 where
input_dev_pen is passed to input_free_device().

Once input_register_device() has succeeded, the device must be released
with input_unregister_device(), and input_free_device() must not be used
on the same object afterwards.  Since input_dev_pen still aliases
w8001->pen_dev, this can result in a use-after-free or kref underflow.

Clear the local and container aliases after unregistering the pen device
so that the common cleanup path does not try to free it again.

This issue was found by a static analysis tool I am developing.

Fixes: e0361b70175f0 ("Input: wacom_w8001 - split the touch and pen devices into two devices")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/input/touchscreen/wacom_w8001.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 45930d731873..a3b283c59cdd 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -665,8 +665,11 @@ static int w8001_connect(struct serio *serio, struct serio_driver *drv)
 	return 0;
 
 fail4:
-	if (w8001->pen_dev)
+	if (w8001->pen_dev) {
 		input_unregister_device(w8001->pen_dev);
+		input_dev_pen = NULL;
+		w8001->pen_dev = NULL;
+	}
 fail3:
 	serio_close(serio);
 fail2:
-- 
2.43.0


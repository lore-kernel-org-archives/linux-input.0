Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B2292B4B
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 00:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785718338; cv=none; b=VKmIYA5kntkdjoceGQwyxEYbk1TIMyftF89P7VQBmbU97UaT4XD8NrRA8SSABPSmA6SYF3kHZ/SocMdBC0LyYy5Yw24prUgOkzUcGOXXjVlLzfv51+vm9+9+i409+YnmjjqsiX61sSGGz0/+CRCveMisp02Y14PRTkIhPKiskRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785718338; c=relaxed/simple;
	bh=rQr4GcgUJxe+ZRdpMH+1iz0PSfpkcP/QRG7dm2SCpuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SttU4YwfUpjcu+3hVWkh4KnMMc0KlUFmma1L9dR/7NeJ4UrH/EtpQGIV+TCaG4Lk1EE7P2g0OZYQFNEbq1WQOQ2RhnkWCBKkqi1HH6RxvHjaDAR+jLDup7Vo1Rl0W1fRKu9G5Ndjqbu/4scHYgWQ4GTSL5sZc2Su0piyOBrDlYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aup5ngpw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aup5ngpw"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2411323a91.2
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 17:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785718337; x=1786323137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yj9v3rdFPmrOpcww2cdMdBn3yaaFRP67m0JnmciRc3c=;
        b=Aup5ngpwr2WiMNkiPFtWkq/xvaa7KECnLGJBRqMC06bREc7nN0DLD6ZSSmJ3lokNlV
         btvC1VLuGjEjoH4n1yPZqz2OGEpnXTwNIMjKMM9nhY0r0d4lT/3klaE+TuKWzeIp90o0
         N4QOPhRnSxLQuT+vuNq+SVEw8h9THEV8ZULQpbqnlvBKIungD5G3zttAxVWjGbiseAAP
         hKoFKyuL3wUROqo4s1M3C5l1A8vkqzo0qajc81GUHirU4qZ+N6sKTbC6QQUsO+xAtAeA
         mf/+R0jpnZnaQDjsco8Gwwy5ImIHXmMacTEXQzDL0x3PhEHDU34/hgZfPJ6czDynu/Yj
         baDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785718337; x=1786323137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yj9v3rdFPmrOpcww2cdMdBn3yaaFRP67m0JnmciRc3c=;
        b=A0JojH1jglsceuImMbMUotOmChFojDugNziKWc7OQhTwqlG/DAmWhxoy1NsFHrij9F
         GHdcZ+yHKPK9kvXKzGvyf9vNiM3pAiXtdM0PFfhFAParBaXfCOQA5ou1VhQ9ld5ma7Df
         lPpFkT9ecQTJmMetnyTtZ6hpTVuTPQdfcVVsft/Y39b+sXRdZv++XNA7cn+qQk6YUfzx
         6r/AdrrNIackbpXFV+StjKQWux7GDv5Hxy/y+UA9MDoP7fOwmN2Y6xLhNy7bNp7Ym4aC
         4LehoP1QrlnyywUufeksgBJXPsGnVnH9SJuOw2t7rAYkLpHF/inx1+zDeHfk7hNl8F4b
         QJVw==
X-Gm-Message-State: AOJu0YwHUaPcDVwlCNMyYaJxeYU7JK3IWoHkbiHwvsNlhDnkoFFkEaMf
	Q944q1t8aHbMWTZlJEwQqKzPOsgtw1piufxhA/fv20dlIPxUoq2Lr2S89qErhg==
X-Gm-Gg: AR+sD13KirUgOonYV5dt1APewWI8Aw4SQYzmh4eW7CV7HAh5H+YxMO4W5s4kAqkrAQP
	AQlmQtfMRG47qm0V5YeR2qhHzGz9gC9RU/l/4lW9+e7wnrexH6lIH23F3aqZGndoStc9IVAtrOw
	jcT9dUKU7niLoXsPxTfrIZcB8EVOXZkdSgE6e68GrSQGrA6lOq3uz8mnQb513/DQDGScL3KlNbP
	ZB//mXw54esRumJQoAS2u7zOJf98Su3aCBL5wiNetd6XpigTuO/DlSzc6J6No/dalrLHIApPrOJ
	x9evgEuj4yxinI4kj163suQ1v8aWZriXZlg3U8Lj1Cdb6huSrfwz7gy3DwIJ8nbX1DNXpdU9jYF
	IAbxn+q7UhzYs6Li0tpJthUcT0+JQkNOnkkiVxnXZzGzSHyaC5hzPi6PQRkGPW4fDOgLL5F1aJK
	ycOxjGjWa9HJrx9hnwmXAgyB9btKY1P4SCaazz6yMVainqotxYgnCzJct7zzFD1pBqCrXNF4NCX
	JhFRv0kxMSXmYdOOnTkDog67mZAH8oRduX1z3buEAtwhy+4zXw/
X-Received: by 2002:a05:6a20:c786:b0:3c3:7fff:ba77 with SMTP id adf61e73a8af0-3c92a839c30mr7727825637.42.1785718336677;
        Sun, 02 Aug 2026 17:52:16 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4d10bbsm24374079c88.11.2026.08.02.17.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 17:52:16 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] Input: call handler->start() when uninhibiting device
Date: Sun,  2 Aug 2026 17:52:03 -0700
Message-ID: <20260803005210.1251102-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260803005210.1251102-1-dmitry.torokhov@gmail.com>
References: <20260803005210.1251102-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an input device is inhibited via input_inhibit_device(), the driver
is closed and physical feedback (like LEDs and sounds) is toggled off.
However, from the input core's perspective, the handles remain open.

When the device is later uninhibited, the driver is re-opened. While the
core restores simple LED states via input_dev_toggle(), complex handlers
(such as vt/keyboard) may need to re-synchronize their broader logical
state with the hardware.

Fixes: a181616487db ("Input: Add "inhibited" property")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index e4f8c2067b84..47886a394c6b 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1806,6 +1806,7 @@ static int input_inhibit_device(struct input_dev *dev)
 
 static int input_uninhibit_device(struct input_dev *dev)
 {
+	struct input_handle *handle;
 	int error;
 
 	guard(mutex)(&dev->mutex);
@@ -1833,6 +1834,11 @@ static int input_uninhibit_device(struct input_dev *dev)
 	if (dev->users && dev->poller)
 		input_dev_poller_start(dev->poller);
 
+	list_for_each_entry(handle, &dev->h_list, d_node) {
+		if (handle->open && handle->handler->start)
+			handle->handler->start(handle);
+	}
+
 	return 0;
 }
 
-- 
2.55.0.508.g3f0d502094-goog


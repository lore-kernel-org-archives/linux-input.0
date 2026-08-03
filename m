Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7F226980F
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785718337; cv=none; b=h3zOnfE3GbMPCe13oU0CyqDX2Qra05VEAPZaOjR5eQNPxKVSfqpfw2/CjrExLH1HkvFkoA9O1NplI8DB8NK+OnkLF1AZWobG7DSUOPOoZrlAyM+NtcRChr4IqugHUfIiIEi5248FrFHHoEJ0S2BeNyELQIHq7QwsqjcjIOV6Spk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785718337; c=relaxed/simple;
	bh=Zx6n2UShfOBtWDmR+UAnFZ0U5Yk9Pjp00XYqxzcmvHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6YvCXwUU61585suPNxAkozBKvNXKclj2WsYASXjezwtFAry9gTpKUETbQR4dsWaN2JwIhdpypg7R7MTBJRo+AAe5fRDCgpfUpabpg+ckf91OmYevB94yhOSVUTk1uHej4i5Oah5G0mCrVZ/Rak4a6FeYt9vNl24kjV93LmZr6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRr6QHMA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRr6QHMA"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso1664761a12.0
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 17:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785718335; x=1786323135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PcHttzyJHWUuJPYE8Ftd5ZEVQcgfFCdow6I+AVy/DhY=;
        b=WRr6QHMAzF4dv4yziIotXDb60yWtkRN4Wku7ourKImwxIvAB/r7Qbvq1ga25WgwsNe
         5GlV7m+VH8T2ym6JGfkfmMidl14CgOUuEJb7HMkuB8bNFPtcpfhSlAWp+oG1N8bJ2vHa
         bFO65GoagevJg95kMFu3OcE4Yzir5/AeLLAWKXE53loNT19waWuK/NuH9YNwiC4ikuI3
         rsUFdZwc+y26pdDlpldj5WDE0cugyHnGOAm1amqwbsdfACrSdPy/wWyUchXBldCqVTdC
         u7F5nik9GR47GA8Iz+1B8Ia7QiFTTA82ENI42KugGQ9sCFU7NuthvRKqs+/gtJj7wuXb
         EAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785718335; x=1786323135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PcHttzyJHWUuJPYE8Ftd5ZEVQcgfFCdow6I+AVy/DhY=;
        b=A8TlWgX2bvGaAPCimF0G1FSf662BXZM+48nH61coafa5a3dWPmMXOx9IkrztClPNb0
         eN+TBdLi0pg4QuBvNvDAH6flWHFaYjeNn9ng+imHQ366kTSIJf/xTM/JSMhBdfEEesYc
         55FNxKyMDvQEIE0AMoQtcwZqv1LGc//nEilzE1WY8rO7kmA8iWzEuilr6zXwIh7CboEK
         1qQeT1UtAQ6ZUvH8Rb+hWtEWBsoct48jkRIS3DfmHLX/+0uGqvJU/cFS5mnzs5SnhF6p
         qhZlFci7TxY4vYh9MKCrD3ENNkX+ToYE1eJXIJH+fObecfUGJaWXCxaK6M28rW52GDmO
         ZRbg==
X-Gm-Message-State: AOJu0YxYnxoWimL80zqahgkwaqrhXBJ0B1LkQNPgknAs7VFeHoCuG9oe
	7bO6yKe/+f05y0dtApkJ1IgfPtRv/hzeyIOULVimRYHxR5sXriuJ1jsvY5PboA==
X-Gm-Gg: AR+sD11xZnYLjP8rgKiheBdWo45Vaawa0fmlI7chgjv8um1N1Fw83v7MvWxg7R68nEo
	jpf8Es7qDIi+GJrJD288UIOZ9odpJeS9Kch2pIWmK61Oz1i7pwZ3O1rXfAhQmHHeCwgPBFvw8mN
	w3yYGzTSgNrYFPHnG58V9dN7c0j7q60kbWcDk9bQSYQYEAoS0aWwesSKXd+jvk0UKASAIVOAgwr
	lByapBg9IAjUBb6LiqR2p4Reij/nk/8IE72xc+VOJeyJIZ/4DLTR4hDWbybNpUjHdIA/AUhtoVF
	KrHiUvJT9OXnj4tw9tHKsGiGQ9gqhcbn/pAjUqWz4xyqjOnldGDV7AW+G7XvnU6axCOlMSeVjZf
	+zgGcHuEPob5u3E7gT9vmdMeoMvCOyYMK3anJOSYk/hUlOSFwNvzw9iML5oqxKFPqDpxUuOVmex
	J6GyBlQcxzg4XSpZhSc7LVGEUYP42rnHAej5H2leYEARKlcl4olh660JcsIDLNI417zV9923Axs
	0H8uJjtvwfPy3hUqjK8junBPI5KAeTKsglyeIGe2599p7Y9n1cj
X-Received: by 2002:a05:6a21:a91:b0:3bf:6acf:2940 with SMTP id adf61e73a8af0-3c92a4c9b0cmr8394760637.11.1785718335389;
        Sun, 02 Aug 2026 17:52:15 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4d10bbsm24374079c88.11.2026.08.02.17.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 17:52:14 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] Input: clear inhibited flag before re-opening device on uninhibit
Date: Sun,  2 Aug 2026 17:52:02 -0700
Message-ID: <20260803005210.1251102-2-dmitry.torokhov@gmail.com>
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

When uninhibiting a device, we previously called dev->open() and started
the poller before clearing dev->inhibited. Since drivers (like
gpio_keys) often report initial state during open(), and pollers report
events immediately upon starting, these initial events were dropped by
input_get_disposition() because dev->inhibited was still true.

Fix this by clearing dev->inhibited before calling dev->open(), ensuring
initial events are delivered to handlers, and restoring dev->inhibited =
true if dev->open() fails.

Fixes: a181616487db ("Input: Add "inhibited" property")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index e57d1023d262..e4f8c2067b84 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1813,24 +1813,26 @@ static int input_uninhibit_device(struct input_dev *dev)
 	if (!dev->inhibited)
 		return 0;
 
+	dev->inhibited = false;
+
 	if (dev->users) {
 		if (dev->open) {
 			error = dev->open(dev);
-			if (error)
+			if (error) {
+				dev->inhibited = true;
 				return error;
+			}
 		}
 		scoped_guard(spinlock_irq, &dev->event_lock)
 			dev->ready = true;
-
-		if (dev->poller)
-			input_dev_poller_start(dev->poller);
 	}
 
-	dev->inhibited = false;
-
 	scoped_guard(spinlock_irq, &dev->event_lock)
 		input_dev_toggle(dev, true);
 
+	if (dev->users && dev->poller)
+		input_dev_poller_start(dev->poller);
+
 	return 0;
 }
 
-- 
2.55.0.508.g3f0d502094-goog


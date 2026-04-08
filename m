Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A6839F19E
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665741; cv=none; b=PNXLdHnMPYOyPfqthpcXxbwWpn0KmJT9zcuIKiddvJw++vYmOVGpI37J7NuehrbJfd8BX/ZoJHCR7HgYUsAUBATLfyShA16FeMIxntTPjmj6dY+X7rF2/fQbxRhAcIfWZzAL4q7d2E+B8J88x44g7i+YXAW3uLCMov6lqGSL/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665741; c=relaxed/simple;
	bh=dqxnVKxxEQqelt9ZmVN8qxxzJUpK6afsE76/17F3qdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kTiCh1TweWz1nwhVR0g0Tt8g9m1H63BlzS5CoQJcGmMgL7WwLqTf6r2lbM4a1XwGplRiETkX/+WgK+NuYsCd6FJ4sK9m7IxjeuYt+up6i6eSV+ipuJ5uZ7exwu9RWH7bEITIlfoOrJJfAxvb4B7e0IHwund775/7ePdsEhR50uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4+DidSW; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4+DidSW"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c742723c863so54703a12.0
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2026 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775665740; x=1776270540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KgdAcd0x/A2kXj/AwWy/WhMgCIhkhzimEAEUs1pmai4=;
        b=C4+DidSWcPbBnUOJBypThREO+wQzK1mYAqrlRgk2DnlddbMoDeCM8jcBaVrCBpS9QZ
         Z74HPAHujGRYQsH/6CeB7oL3Ss5CQIttLu9Zok5TYO/x9X+csGUQeskipwpJv4RzsRx0
         FvT8b+awqQRRCF5VTD8kcbMPSj+oz+XyUfyQIg06hWs0UILJ7ZbKEYVpMoI7zyxrTNL3
         OHC9rQaTE42iJS6JgwRad/WPx5lG9Fs/sY8TqH/JFpmM0fKaZVlrw7GUXmr6Qlf1nxNU
         t29H+f8+ZVytOWobrXiPPLohxaEmp9CdRhr+7gXzBLIy8PJMkCUgpj2PXWqnYvMTEv/v
         f8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775665740; x=1776270540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgdAcd0x/A2kXj/AwWy/WhMgCIhkhzimEAEUs1pmai4=;
        b=g8Nsg1jcYQRbQnGT+6gBL9sRbt/KEkRZ0ScZ5sEc/O1jJ3lOMIfod88ofNAWJZrXjC
         Lfhefe0foblYjVpjYkwSUczrUZMgSR3L0qeCzYMpvgLy+eOTH6KhVP0AwPxWOWnB0Vop
         iOMt7u8IldI1C08XXWBi+hjQWWRjev0nVeqpfR+RljuXqBVx3l2ZRlRTIvI0Y88cn4bo
         ZCVKLb8mWzdN5VTQsLsITFIljGvROL26mfPER3TWfSBun2uXKnTKtGn5S5zC3BwzZvfY
         xq5PEk8lNnTJ47zT0vHl6/Dp4tEyvx9lBaLUm4rilXoWbsI/DeTUXyPo8UP3kvkg9po3
         9Abw==
X-Forwarded-Encrypted: i=1; AJvYcCUrYBA+rpTU1X9Ts2KjIqgBnP8NLcOr/sjuI/KiHwF+dj9/vhQFghDb+kAl3Gr4uA1CfuuwJ5Fvp5DPlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAFZ9To3tw5ssZCmjMWUYTVf+4cRRXmWfjXuAbumxClqH+6byh
	xPginpbhE3lWmVnfeHI/C32SGWm5G80HQYggpmO1YhBa//2gv9ppebkbBHKJqKx4
X-Gm-Gg: AeBDieufRFJmIHK3Gnq8pygEsFvS4pYkNJ4B09MJxTgGF5Y91tZoIDmhzzSBWbeWeK0
	Zq0f+YLdWQTaLlr/nsUk1zYOvlJbqgZjkRJgxCE9rPT9h9LRd/T9t7ubvUbqR1TCS8cMTJ/YMw7
	tS5JX9t7+uzc2Mw3nB7xTNu+GVNWPx6KMALbxwSLn6bYOti0U/BA+uYjwwi/XTa7vhEloNIEsfK
	NaZvMwnXKX6YE8wfiPF5xrvfRKlWnDxbe7Cx/VleVKS5HEIb794eEbKcPiMElavH/RwXswAPmif
	DMom9JvGzPGSF502agx3qQnv6f6F2IllK2L4YHXz+wwzUMn1GwyWa8F3CODk207D8NtxsKWONWX
	YfOfNKdQzLF9MFKTqiud0BDAPeeDv2D0X4NEW9mvyjoe7MFXqQfGpwzZcpv3OtszoWqPLiM7gSr
	dI76BIGsFlMc/7sQ8ZqMGJkCL+ZVH4VZk1ZcGbk0YOHmORJMyx
X-Received: by 2002:a05:6a21:6d96:b0:39c:187f:6f91 with SMTP id adf61e73a8af0-39f2ee01085mr24061670637.18.1775665739869;
        Wed, 08 Apr 2026 09:28:59 -0700 (PDT)
Received: from raizudeen.. ([45.251.33.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65812f4sm19347716a12.25.2026.04.08.09.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 09:28:59 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>,
	kees@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: serio - fix O(n^2) complexity in serio_unregister_driver()
Date: Wed,  8 Apr 2026 21:58:47 +0530
Message-ID: <20260408162849.4639-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation restarts the scan from the beginning after
each disconnection(goto start_over) because serio_disconnect_port() may
delete the current list entry. This results in O(n^2) worst case
behaviour.

Replace with a two-phase approach:

	1.Collect only top-level ports bound to the driver(skip those whose parent is also bound to the same driver) into a
	  temporary list.

	2.Process each collected port once, moving it back to serio_list first to maintain invariants expected by serio_destroy_port().

This eliminates the restart loop, reduces complexity from O(n^2) to O(n)
and avoids use-after-free by never collecting child ports separately.

Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
 drivers/input/serio/serio.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 54dd26249b02..46b8faf1a46c 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -821,22 +821,27 @@ EXPORT_SYMBOL(__serio_register_driver);
 
 void serio_unregister_driver(struct serio_driver *drv)
 {
-	struct serio *serio;
+	struct serio *serio, *next;
+	LIST_HEAD(disconnect_list);
+
 
 	guard(mutex)(&serio_mutex);
 
 	drv->manual_bind = true;	/* so serio_find_driver ignores it */
 	serio_remove_pending_events(drv);
 
-start_over:
-	list_for_each_entry(serio, &serio_list, node) {
-		if (serio->drv == drv) {
-			serio_disconnect_port(serio);
-			serio_find_driver(serio);
-			/* we could've deleted some ports, restart */
-			goto start_over;
+	/*Collect all ports bound to this driver first*/
+	list_for_each_entry_safe(serio, next, &serio_list, node) {
+		if (serio->drv == drv && !(serio->parent && serio->parent->drv == drv)) {
+			list_move_tail(&serio->node, &disconnect_list);
 		}
 	}
+	
+	list_for_each_entry_safe(serio, next, &disconnect_list, node) {
+		list_move_tail(&serio->node, &serio_list);
+		serio_disconnect_port(serio);
+		serio_find_driver(serio);
+	}
 
 	driver_unregister(&drv->driver);
 }
-- 
2.43.0


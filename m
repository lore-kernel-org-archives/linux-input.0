Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4212F585
	for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784440969; cv=none; b=rDkN4+z+emd8rQTRRlJfTWl7PEwwe8rIj1uVwDpPwuku432WY5rZAdR8EWvkrIfDsFpOyiekYXT2W8bVn/JUWZwRGfeXkCXTxIoqUoSW8B/VK+t4awZTdUmsZzMnNCl7hmdkfNjqaCxl24H1H6XcwCeY+3PbFC4ipRyDanFSMpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784440969; c=relaxed/simple;
	bh=vD5HXcgVfOO8GY08Pm5p9Q/7KmP8DN1S/UnziXKx2Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1SOrFa6vmxY3P7SiR7Nlg9pA2dbqKAt1LXVQrHnS6HmTl5CKPdK4mwHBUxeDhTkSqeKl6sMW4ciVEWN2Ml8pZ4o2MGTQ/y8MBZwhUynPUY9heELOYr4fxpB7IpjJdjhQfx1o6rHGs/2aWqBZT4ll+rv/Zr7MUIF7o1PHkXzf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3XfQeEN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3XfQeEN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceab75934dso94291875ad.2
        for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 23:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784440967; x=1785045767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YM3lJKfM9kKCUSlb6/mcD4lrxRw6W3lLRRJxUYINkSc=;
        b=Q3XfQeENI6jOm4tYWeYX1rRuWqCZgJj/S4HBUbmfkwbdMCHg0HYpZCxSXyLG6UT4M2
         Mw9ndtzrBhtLVb8Q63ydjrh2gxeY9k7JR8MMdqe5ZSTTj1skgcTIQ6z17isVJOgaYMcU
         ZUBAFncNu+7Nv8vu1le7CoiHKjNpRNlFiilyNo4WKzvUyOyQ416egqqGd+M/C9rPNsU6
         RbdfqId7rjAjkVtVXqPlbuYef/N4MNfLGF1Z/nYgCQVcV2tlwi8J4C3BtEzxqFjELfhM
         al7gKdyvn8QmvKIeKGx/7JvG78yYGPeMPS85OBGp3xSiHBJXZX1EYWfODlaBbL9MdIjP
         ebcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784440967; x=1785045767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YM3lJKfM9kKCUSlb6/mcD4lrxRw6W3lLRRJxUYINkSc=;
        b=HkpT/qX0mJRwv7YS/0Cp6vEO+FgYRMPUO3iWzFp/W5cYIcO/ASP3ChjL+px3SB4mqQ
         A3RGxkNlNHvYSsL1zu2uLzg6sWBSAoMnHOqn184ocrPssy2OvJZcO66Fv4GmlIBQvW+u
         CUxu7bc/RZepLrq4egrESb67N0+DrYx5m4KdditCLM88jy0W0CjpG/fjGZogbMtApbgl
         uevUavLiOUI/UzkIYkLyw4aslKJNqyj7ixq8sRD5NjOBjfQiqtBcTu0x6hAi4h/Vt/WP
         ls+ddApjSnWsJNJmvnZOvSIoiGWAMUVXehR6EM8/NDBrqJZDA9tNvxfTF72FwjuWE36l
         /yug==
X-Gm-Message-State: AOJu0Yy48/rACYYnpxuraIPkACvA4aAKNbMFL+QSuf/AL7A3sButfUbR
	CHE5ZWcYr4bfk7DUDg5jD1x2ta1wxCq9lPdLdI6PhGbW26YceiAh6zU4bLNzaOgL
X-Gm-Gg: AfdE7cm/VAXiGxDzqNY0SezTJZiM0xVOfINNsKFzhn4ixqMZhBX2fK9psqWxEl7IszA
	vqzHVK6wQVK8wdvOxuqABozOMWTn6FG1P4+0PhLe/PlI8598Na7qaZH1G1RtrsXmR9FwGdI94v6
	VMokrGSW0uuMVo1WZBL46aPvw22akXgyKoVuht/Du4CMgI0hULr24UyHgzMRuES6SmnkLZpm7V3
	5oU4t5X3t2NI1Gc7dtzo7e4raD7pEDQnTCEVIODnNG9yLRJ6qmV8HAxFTdWj9KwJCR0DeksNUg4
	CTN0q1HAOW1+NXFLAOyfceh/5731WQgwKOD+WF/AZVfE+lS4cj9byx6KEs6yaTfcwYIlJc15UiZ
	hZ4b5sW4+ICdrFojrxLfmFiiH0i5oqXZzCuCrngdLLD06YABEeZKLe1SZudqe7iDanw/CZOBVpk
	8LZz3Q2YATdnT4Lh9yMf17tBOgEXmwVokoJLzotA==
X-Received: by 2002:a05:6a20:914f:b0:3c3:ad17:eded with SMTP id adf61e73a8af0-3c3ad947d8amr9661226637.36.1784440967006;
        Sat, 18 Jul 2026 23:02:47 -0700 (PDT)
Received: from ubuntu.localdomain ([49.43.243.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbda9sm22756214eec.19.2026.07.18.23.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 23:02:46 -0700 (PDT)
From: Bivash Kumar Singh <bivashraj750@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	Bivash Kumar Singh <bivashraj750@gmail.com>
Subject: [PATCH v3] Input: gunze: replace deprecated APIs and fix warning style
Date: Sun, 19 Jul 2026 11:32:38 +0530
Message-ID: <20260719060238.6440-1-bivashraj750@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718190040.10613-1-bivashraj750@gmail.com>
References: <20260718190040.10613-1-bivashraj750@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace two uses of simple_strtoul() with kstrtoul() as the former
is deprecated. kstrtoul() also properly handles parse errors, so
add an early return if parsing fails.

Replace printk(KERN_WARNING) with dev_warn() using the serio device,
which is the correct logging style for driver code and removes the
redundant 'gunze.c:' filename prefix.

Signed-off-by: Bivash Kumar Singh <bivashraj750@gmail.com>

Changes in v3:
  - Fix comment style: add space after /* and use NUL instead of NULL
  - Add missing Changes section that was absent in v2

Changes in v2:
  - Copy packet data to a local NUL-terminated buffer before calling
    kstrtoul(), so the comma separator does not cause parsing to fail
    on every valid touch event. (reported by Sashiko AI review)
---
 drivers/input/touchscreen/gunze.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
index 2baeb4f3b941..0e8131cad647 100644
--- a/drivers/input/touchscreen/gunze.c
+++ b/drivers/input/touchscreen/gunze.c
@@ -41,15 +41,24 @@ struct gunze {
 static void gunze_process_packet(struct gunze *gunze)
 {
 	struct input_dev *dev = gunze->dev;
+	char buf[GUNZE_MAX_LENGTH + 1];
+	unsigned long x, y;
 
 	if (gunze->idx != GUNZE_MAX_LENGTH || gunze->data[5] != ',' ||
 		(gunze->data[0] != 'T' && gunze->data[0] != 'R')) {
-		printk(KERN_WARNING "gunze.c: bad packet: >%.*s<\n", GUNZE_MAX_LENGTH, gunze->data);
+		dev_warn(&gunze->serio->dev, "bad packet: >%.*s<\n", GUNZE_MAX_LENGTH, gunze->data);
 		return;
 	}
 
-	input_report_abs(dev, ABS_X, simple_strtoul(gunze->data + 1, NULL, 10));
-	input_report_abs(dev, ABS_Y, 1024 - simple_strtoul(gunze->data + 6, NULL, 10));
+	memcpy(buf, gunze->data, GUNZE_MAX_LENGTH);
+	buf[5] = '\0';		/* NUL-terminate X portion: "1234\0" */
+	buf[GUNZE_MAX_LENGTH] = '\0';	/* NUL-terminate Y portion */
+
+	if (kstrtoul(buf + 1, 10, &x) || kstrtoul(buf + 6, 10, &y))
+		return;
+
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, 1024 - y);
 	input_report_key(dev, BTN_TOUCH, gunze->data[0] == 'T');
 	input_sync(dev);
 }
-- 
2.53.0


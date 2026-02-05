Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3543D4F2
	for <linux-input@vger.kernel.org>; Thu,  5 Feb 2026 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312522; cv=none; b=QvAlRWiR44RAc2FeDkd+HNn6042OO0uWb874arrs/1UAmLONgXnCOw6FHMGMgur3vjC5JTHVOoMhOA3zQhYBwrEFRlsveOvZTDVE5N3yzGUEvIzB0z9YjnUMT0WmCW4ohoK5wr5gwwFNl8hlCSDMTPPs6Qaa05PGpM8KOXgIeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312522; c=relaxed/simple;
	bh=ISPg1m/xtoHmadv+9qD4PF4qeTVVdwlXnG/d134LzZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNdPXrdxF93c/nueJb8lUiu7vzu0LnjrAmz59Pad8AKYywHi8DDu0IfLYZ8MoYZt6LzNSffxPpVGiAc638RnrA295Ya7Wp/08+Uoqdl3+quXyQ/bRZplhiSU6z38GkhwCTTYQM1zgf2FFvhKD0fpf7+loAn6RGESxYD8NB/RzIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGbRjM7j; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGbRjM7j"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so13537725e9.1
        for <linux-input@vger.kernel.org>; Thu, 05 Feb 2026 09:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770312521; x=1770917321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tyvs4xFeOgUlL1nJWOsM4wXcI5MSjDts4OzcTAQg/Sk=;
        b=QGbRjM7jf5jwvszCuzt60uATi21ZpJSACb/Qhjkqmu/sUjnNGmqk9Uu2LEYdnEjZzL
         kf4jO5LgBTTZhyUPLiUqOx66IpkzRlkj1Sy4ZhMJsCwxkqCIFbkw7nyF5hnvJa+tbsrw
         /fuqsMRSGnIT8NGwiAnvo/U2kJXe786jYaO79gEbyeLxzlbpOUN3VsxIDNFCb7sRLlR8
         N8rSm3gt4yYbHQoLQBNqY/0Lfg2lQvQQmIzO0DbCmYH7o0atsprmBfhVZj4J3uO2/EFj
         KkKmuISzipml30D18ARQRzOTTTxMYCqa6rq5JQ+ROaHh4OCM/i1hgkazRGYEeOQgO0Q3
         rlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770312521; x=1770917321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tyvs4xFeOgUlL1nJWOsM4wXcI5MSjDts4OzcTAQg/Sk=;
        b=jbDtv4PescX+0iHwZi/SNOA2vnPpIm0RYYFD82WozlSst6IGbOAD8OmEG54OgUvvS0
         Cac+W5uhPUCwz18bYGjIW2OJS8+XiuZG4KMvDiZzVG8ClUMfL5MFjzu+2+Y8rKFs//w6
         m0dFp5puxvTFplG1VK00OBF8uqSnx/ch0YyCDptRwlciNdumIEm5esV9KnsWIvbk51NY
         tfEUKyCelHSGCZVRFsT+reeamqjQY7+UAvmb5WaT6/nE/9mYKXNh6JFiuDG946nnzkIJ
         Fv2nP8JyHTBGPYLNKKXI1mn4hq88JDGyJZfpMvO+rPfDqYd/Qud1qH18PJnLr283tBim
         hQOw==
X-Gm-Message-State: AOJu0Yy72QApGbnT50VDZQNXN3Bf42ahmlK55q8/PfomKb0yAihJFEUh
	wbhkw5JkyASiRkikv2JJqbSngiT5ePKqggAWuV1MBXrlaIGb2jZdOLAe
X-Gm-Gg: AZuq6aJgY30r3V+OcD95z5hm2zTyrKJEMnR9oEnod6LFf84+P8iziE7U65Q0zM9tKTd
	1+fN2LfLGqt2viP1sTXxn9DGYw0W+0w5DPOKVGOJCFn3v4o50AIEi1xwkVJwrzqx2Zvl/befIh2
	sCXqXL1PPjJk7kOXMASWVsIRm7hT4kZZVUTNuEZnegLkLFlNaqogFOljGiEiT1kMrnNplX9Y1Cb
	0Q5QM+S6IdkhqTbdsEbWP/5STV6nAvS3bj2MSshp7FMFDnzGkvUJetGaD/zba4/9FwzKbz6YIpp
	TNxslVUx2YHCuyTdrYbFBRgvIVSkk5AMB+iI+ZglE3w7XWzoJ2jX2Te7O/P+s+reo9Z7pzhhqyZ
	CiUszX+ZtUzblRTj2dJo9XBZbpORCVa4RUfcNFSwmA60doi+zZ6MQzP4cg5zJk57o+2XjCB1qmf
	+I/3hGjHsSwKaG
X-Received: by 2002:a05:600c:19c7:b0:477:a54a:acba with SMTP id 5b1f17b1804b1-483202161edmr2260385e9.17.1770312520238;
        Thu, 05 Feb 2026 09:28:40 -0800 (PST)
Received: from Max.. ([46.210.204.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ffc39b8sm53628265e9.17.2026.02.05.09.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:28:39 -0800 (PST)
From: Max Brener <linmaxi@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Brener <linmaxi@gmail.com>
Subject: [PATCH] Input: libps2 - embed WARN_ON(1) macros into their enclosing if statements
Date: Thu,  5 Feb 2026 19:27:55 +0200
Message-ID: <20260205172755.25117-1-linmaxi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make WARN_ON(1) statements embedded inside their respective 'if' expressions,
to improve code clarity.

Signed-off-by: Max Brener <linmaxi@gmail.com>
---
 drivers/input/serio/libps2.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 269df83a167d..05b64277aecd 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -154,10 +154,8 @@ EXPORT_SYMBOL(ps2_end_command);
  */
 void ps2_drain(struct ps2dev *ps2dev, size_t maxbytes, unsigned int timeout)
 {
-	if (maxbytes > sizeof(ps2dev->cmdbuf)) {
-		WARN_ON(1);
+	if (WARN_ON(maxbytes > sizeof(ps2dev->cmdbuf)))
 		maxbytes = sizeof(ps2dev->cmdbuf);
-	}
 
 	ps2_begin_command(ps2dev);
 
@@ -270,15 +268,11 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 	int i;
 	u8 send_param[16];
 
-	if (receive > sizeof(ps2dev->cmdbuf)) {
-		WARN_ON(1);
+	if (WARN_ON(receive > sizeof(ps2dev->cmdbuf)))
 		return -EINVAL;
-	}
 
-	if (send && !param) {
-		WARN_ON(1);
+	if (WARN_ON(send && !param))
 		return -EINVAL;
-	}
 
 	memcpy(send_param, param, send);
 
-- 
2.43.0


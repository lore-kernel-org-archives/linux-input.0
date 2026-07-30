Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF513B5E08
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785444116; cv=none; b=Rsv9XaBARJTbY7+w+C2t+DBEDM6U9YIAJKFQVualaEOWNUN32vyds8o7OLuXP71x4Sb4TUc/Pv5iH8baW1POYpYLFxxAhHF461OxqZsit1LBnq/4hp3wX0+op6iHvTtxfY7x07cHn2EZPj84c/clDXBsTt7Mt/mC910cjHUjk4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785444116; c=relaxed/simple;
	bh=HYxoZYuwQeO6t0bZr0FMt/eeSDvXYszea8DGKlrOSPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vgl3Y2Z8LKNulRo32wjoqc+Rzlj4oER1fRVAov2sbhdILF4HyF0YcxNfq9yz3ZN9mfz9Q034NuVIZxW7cqFRqzslYdZVVYFmHF74SidGZRhxTrYnUR2K+aIIZ0/n3DrL/pBmWr/cVLPOn1RWrDTa/xiFeBU0PnMGgD3wT6/CI7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lhK85+dk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lhK85+dk"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso81845f8f.0
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 13:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785444109; x=1786048909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IbgiCBDyQUJMyqllgJeAiMgyi6jiM8Wyrk+BIn2+hws=;
        b=lhK85+dkqWgHZpN2z1y42NAP8C45x53kQVzAYwrkWRsZncgH0q1lGFIKPzFLIzy+em
         wdj+ZAGQ9W+caLsNQFa2usHK266hbT+GRX3K1XbNWbV2UMnlmPnJ6slADkWTb2iHhB9P
         cFUZd0g5hL2TGAywr+891FW1vaA5FlM/tBNtGgrtepxbV1jWYniGpQJpzDXHJ87NentY
         sBhMASNy+I6aPC+JLgLjNkBxei/hncEvuV7TqYRE9A7J/G5HtNp4M3hApf8mZ/nYk0Ba
         y5ufQPEGmMCha7iVDajIOZYE9SyzZb4h7f+BErFenDBjJV7vj/2S/bmUPML/n1A549Dj
         jf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785444109; x=1786048909;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IbgiCBDyQUJMyqllgJeAiMgyi6jiM8Wyrk+BIn2+hws=;
        b=lpnnZnzt00E+7vGMCd+iaELi3QEpXYgCpfdod0ShDN/CMBHKJQYejquHSS5m8SSXUC
         bC6sk54q9p/1BqghifPj9uXyqkjfFgP18r9OASf1rJaLPQiFEMNEGQO0n5RKZVt6cHy9
         L8QnUO+bnp6+emMTm3t9eUOffaq6H3zbEL3P29RZxRlDcrS93CL7elznIFh9f+ipKdaP
         FmJToAMRn26yk2tivMrQujZ38Y6ZYc98QZIP67PKZOCy7hvR2QggOSq8JmhgJq/5CjiA
         0WKRIHvlVYRVKe2nsT4u58r9wlIliJH4CD1y7x1RV/xadPf658pcmtC32dQk+D2IA9bg
         mSfw==
X-Gm-Message-State: AOJu0YzlfA7Ide4Cx2FxD7kH6KdyIxhTG747ZkEC3YdbnevUOIQGzamg
	i0RNNmxd4hIW1rNqQG+oc+Ayr67aMzfOUMM+cDTDJlBbrdmOnpyPLXErP6WUgF0i2TVH1/bJcS4
	WVza5
X-Gm-Gg: AR+sD11GQa41HpfrFhkxCYxlRqkNmGx6jamyMlHHK+8wYYwmKbBe/0LmvtNPn7haxNz
	b6EvedXcFloXtlrMkWFgIOXe6Yv0rdGfwFCZESvRdod5UBVSArpuWoTy/pcEYOiW14xSNRchMVh
	eejiOa708IlKuU1svVacMlrvU9c4/y2nHJVePgDBdR5sQLLrJ+0Shbr/i6nScnScgZYLvXqiinp
	anYgeO+4lF/KnlJSs0+dmROAnjpzWsZll0Q2kkxkOHWTIiT4PCVERe+Rrtd+0MZzl5RzpN31a0i
	m5K5EeSgCo1b7hgjDWWZia0JYZHQc4WUzgEbzcX2UorVFhSlLn6gv8WswMLRa8nn4ME1e0OKhfS
	wBJBVvU0UFeYENC5F2Wb2xNf8Tos3JhQVMGej8KYCNeHLmCzW7MOmQZZNxBGp9+YV2m5Te3mHZx
	QuNYJ8CnSn6NAOSxeGbV0pfjNZlQ4hvkCUxrSRvDJvaamnXo0CrEj8jqJH+vkY46iVGA==
X-Received: by 2002:a5d:5f42:0:b0:47f:97e9:fe4a with SMTP id ffacd0b85a97d-47fc81fc91dmr5933828f8f.43.1785444109447;
        Thu, 30 Jul 2026 13:41:49 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47fc88e424fsm13436095f8f.14.2026.07.30.13.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:41:48 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: Fix comment about header defining HID_GROUP_ANY
Date: Thu, 30 Jul 2026 22:41:36 +0200
Message-ID: <20260730204136.1606050-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=HYxoZYuwQeO6t0bZr0FMt/eeSDvXYszea8DGKlrOSPA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqa7cAIl9orfKdHM3BFPSaJFHouobPJhSAclXV+ aKmwnInpYeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCamu3AAAKCRCPgPtYfRL+ TtiuB/4wWZ89j6i/pmwQ7M/phXzu5odwXNwoXZdcmHaxmbVdMY9KJHmwTkH7f+h5j7vuVGAI3j+ bzCKUj7ZtPt7jA0uZJ6stJQIvBJPRTWAo0RnIIZZ0+y6OLfDXdu0S7HXWCss+e86zGN0Vwr/NoM s+Nk/XECK/pftcXjkhmwT5yW88rNRx1ZuqdKj8lx4M+er+Mz7gw3KNorDAzw71K2ez/bF1wy5Y5 ueCMYT6vCg4NkpUruvfEPNxk7PoR9QvVu/0lVAAqI+TZnmhBkZ/jMoko/tVlD9DqG4nGYhGUNIE mViWfG4ZH1aUPIDzJ8Zm9U3102Y4CQzFfYAI/ainE1x652JX
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Since commit ad428f5811bd ("mod_devicetable.h: Split into per subsystem
headers") HID_GROUP_ANY isn't defined in linux/mod_devicetable.h
(directly) any more. Fix the comment accordingly.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 include/linux/hid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index b240baa95ab5..56bd7f274387 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -424,7 +424,7 @@ struct hid_item {
 /*
  * HID device groups
  *
- * Note: HID_GROUP_ANY is declared in linux/mod_devicetable.h
+ * Note: HID_GROUP_ANY is declared in <linux/device-id/hid.h>
  * and has a value of 0x0000
  */
 #define HID_GROUP_GENERIC			0x0001

base-commit: 95d6a9ccef99117115e41e9adb271243bd5e985b
-- 
2.55.0.11.g153666a7d9bb


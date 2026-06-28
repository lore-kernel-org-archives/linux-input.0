Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F192DCF74
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665219; cv=none; b=fK6ba7BaUWF5BGyZREz1Ba+umT0xyZ38LGMxcxEAPoO6dKcIHSJQTkylukdWpF9Bz1BwB/6aRVKD+pUMoti1N3w/18jKrWitKssVow9hwkXS5tbKztXGslXttFP4VOXabTmRtHo0aKaMB9uG9DPCHEt0fpm5FfYDu8G7NtSrv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665219; c=relaxed/simple;
	bh=NQDd7aTipShpTJcS/n12Lt/5N2jpXVMDt5mnwkK1bwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5cC7phbXXj1En7eHPwVOGl14NmbBkmp1vcfi7rJpl8FQ7/z+GPoVUvkqyRQdFNbbTsFPnyh5S987YOcy2P3LV+BcOIpHBQ0S//jZG6cVqYLYtP9tW4PVj5OLc8CU7J9K/NClgD79VCoHJ3xk8KPEo/fIFoKHE09O8YLjeh8yRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO/1wq9h; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO/1wq9h"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso33185755e9.2
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665217; x=1783270017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L94599a5h3xEYD+xTPZLiwZIaocGIw8FBQJTuHEMGZ0=;
        b=jO/1wq9h1BwpU/Fi5+ORAYZJCevPtak0BopjfqJqXd8iFhs2hvS44oJZnQX/Y8U+X5
         tYJklpM6zdMWhR2SjQyMJtgI+HvvpwODEj6MJyfiLJB/BzQnuwkPgn1azJS2UeUgHSkF
         zbETCpQFkxpFz8LtoMBZAhdL200HJmKLU/8fH87oMRGzbNsJVO78e1qetRAHWKb5d/BN
         VfKPpL8mmwZdX3efQBhbUHgLqzyAhKXCNd6WBDLIDSGojD2+YJwbqqSVgQf5zOssSGmP
         kYpGPxcqqo6ZPFFZko5VAS8OCSIywK8sTWBEll/GXtQYykNEEmsNYxO1c/dwGZBJAi3J
         KIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665217; x=1783270017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L94599a5h3xEYD+xTPZLiwZIaocGIw8FBQJTuHEMGZ0=;
        b=ofxCQ6y54girOl3DoYiGYyT9IEtiC4NxYBv/vPJMLj8NlMFoq0auBXtwJjzaNGNwfS
         DxwIFNrZz2K0gWxdyzaoOo3h0CJuFk6kaVF+aCt9MNTtWpbsVW2/JaZ2xF3HTqesXXHL
         MVpacXVCXATlLaUidFBvLbazF+8AwHlM7Eop1NOdKBCyXGy9KpCe4DDVpoKJq+hIp1z3
         bBpz9VwSpJHr/72kAxlFYRe0X3Y7T8ZAE0utaz8bejkHCmsiV976EzixnlZSFyCAsHdB
         yX7XnzFiOJVmYJ6kVod79ttmgGsj6EHAzzN4UAiosGeLa0RmVKrz4jgKCrRL3zEItLFC
         0oyw==
X-Gm-Message-State: AOJu0YxfRc7M3qejoREbL4GoJtJi9JiaMuxLmRma5QItYtnwAhs3Nox+
	mtF/ZZNYHmHGPTMOrNaqPNuYz/y1nNQnV/Dz/A1c0hkfuQI14lsDM3EK
X-Gm-Gg: AfdE7cmFoui+bjlDAcDY/9lmmo6S6qMaarCKFVbsImVbdwqEm8DYiUbCWs0TtJQApB0
	iEQ2l42XjEoG2F5TxrKcTN9OmmvRRnG2xwswhX8nlJyOxiQcd01sS2r5NpyH6mWLWU8Tq3iml3o
	/gyBQfucaGe2JQ7BVqGZiYmtaPugygKpn5b2xakUFVNQfSqQ+W0n4wENcvOjkQ2XKBNCZ1itBtu
	Fxw2pIQl9BjAfkIj4EBqBORGYWiiFOR9rMrz1RzAVsqvdlHjhcUn+nl5sl0QcS6kvJ7hXgOR/Vv
	uxAiey9tz/cbK2Nyu+Y9440PojdqlmHRWsRR2vkSqT0OV1X6pT0VW4Zci0ztdeQ4DJqEW3KQ4aW
	AA2PpmbuKGm8PICyjVPCkTOnIf7dLKJivb7ipU6aOG9wvQzBrDAdpwQ/DhktBMlysPnvb5G7PQ3
	fY6tdSttRiib5+aDXiScj3TMv8mg==
X-Received: by 2002:a05:600c:8109:b0:490:bad9:de43 with SMTP id 5b1f17b1804b1-492667ca5fbmr212753085e9.0.1782665216285;
        Sun, 28 Jun 2026 09:46:56 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c285fc1sm162770715e9.1.2026.06.28.09.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:46:55 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 5/6] HID: roccat-konepure: reject short button reports
Date: Sun, 28 Jun 2026 18:46:10 +0200
Message-ID: <20260628164611.17467-5-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628164611.17467-1-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

konepure_raw_event() forwards button reports directly to
roccat_report_event(), which copies the fixed eight-byte report size
registered by this driver. A malformed USB device can send a shorter
report and make that copy read beyond the input buffer.

Only forward complete button reports.

Fixes: 8936aa31cd5f ("HID: roccat: add support for Roccat Kone Pure gaming mouse")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-roccat-konepure.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-roccat-konepure.c b/drivers/hid/hid-roccat-konepure.c
index 7f753dfc2a10..d17dee18ac2b 100644
--- a/drivers/hid/hid-roccat-konepure.c
+++ b/drivers/hid/hid-roccat-konepure.c
@@ -181,7 +181,8 @@ static int konepure_raw_event(struct hid_device *hdev,
 			!= USB_INTERFACE_PROTOCOL_MOUSE)
 		return 0;
 
-	if (data[0] != KONEPURE_MOUSE_REPORT_NUMBER_BUTTON)
+	if (data[0] != KONEPURE_MOUSE_REPORT_NUMBER_BUTTON ||
+	    size < sizeof(struct konepure_mouse_report_button))
 		return 0;
 
 	if (konepure != NULL && konepure->roccat_claimed)
-- 
2.54.0


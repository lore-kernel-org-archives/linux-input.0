Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FD836B932
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244598; cv=none; b=NNTq2n8oBc0oh95tZEHhTNVnDtK1pb+SD/xkul4JbWX/rdlAbfnTqRRO6pGowcbZtliQ+EoXUMaLxnWjokTdVW3/eDb/w1B5mV3KDT1mJ2CLFNytQGl33LvzvfpgzT1YycYA88NIUQndS7KxOpTu2BdCzu+LURnwdYiQbWQ9QvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244598; c=relaxed/simple;
	bh=5ElyCADy86YGx8LmfNKyKR9rlYrYoGai5Bk7t6+Z1uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1LVYB0iVISgVJ0Mx/eoyvuoPzAO4Ye1XLko5Zl31rMZ1uA83dbB/QfpY3R4aFIpfkPhj7PICFb6Bk0ZSogEXBb/nFDQFkeGpiZLA0dsYN7Ve4Mieune0rnd70ZGKhHv1AqRPl/zrRb0oBp1X7tVC1YNzMHuRjUfjW9fhk/iqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4BUXm0k; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4BUXm0k"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so4153715a12.3
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 23:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788244596; x=1788849396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xYHq+ZU5PMyiId4alqJVSCjs93dNyfWLqqb7EGDh7Zo=;
        b=a4BUXm0khJ3tMsvLHtPNaAregRJaCGoCReO3aeaQKT24194QrsN4zpDjT2FEdA3BTA
         aTRUc6oOrUD8aKT3S4zV75LXt20rQvZ5pwCzQuDbDtsXxakXHZKLCiEc8ZnuSJX03C4Z
         YnJO5IGSlRXOt17NX3o2YrL7WNrHb5KgnjeckVQLszwWeyGfmrcd5Qwz6wRjS5NapIhn
         mxLfkrN30zaEr3MnXhywrgcu6ccoeBqSOCtYCN6DHqp8+rniV/x3juFkDXK+hdmmKP2N
         KNAt+5XmXheGIlXl8m+qsko/VDLUxYwES20HEWFYHjWQyiD5tJrTQDaxndJef1NLh3xZ
         HrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788244596; x=1788849396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xYHq+ZU5PMyiId4alqJVSCjs93dNyfWLqqb7EGDh7Zo=;
        b=ExEmzZsj1m+CJcXqtHUCE9sZVxRdPt4wul7h+l4eg4giMkSd0NTsDh4wq3Ky+ovn7z
         zYSOWrse3wEekV/QLStTajx3bGb8iRjmREWCNQPNM6OXneNsU62dubowBS6T44QaF/Be
         Ba57cgbvFesm3IjiRjNxac5LR9OBLow+/uA3lGHdCV08OeeYIpeBTBHgEZE9ALkqUu7+
         z1VP4F/1/cJ/1hTpEmzf7fr9dPA8Wdh11SUa/yP2Tf0twirikhbYmVa3LyLUGMJdmX/L
         crUtGQOiElEx+Vx4dmY8AQ7ZG0VtgBJJi21M2S911sHAZDgCVGrL+g/QIxlEkI6iOPae
         wS7w==
X-Gm-Message-State: AFuF++nSTrkWswGaUn5T5EsLQBiYGtHhpprBFVpmV8lGw0y6+EG+43bY
	MwU4zmK9evorszH5/mY0wXFBJzmAkwSGA6bMjHZcISGBkxj0ZjH5O7N27KnsnZ/J
X-Gm-Gg: AR+sD11kZy11p1z7wsQWI0ASpvLV5kG2n9F+uRvP4g9qKqPypZxESHoM5+rzZEDGTWE
	aCkG4MP7F8MbI2DF8LOG1ftBPe52DbU/D5C4pwFZKUypo0GlaCTZZ0+pJwqqbIo9PE/XxXN2oSP
	60yOn1fU3rhiZRigM5fW2snyNSIAAkqqXUhymC282fu3G3XbdybYsApL2tG+PE/trRg0EbjLO6o
	nlxu4MxA0bfrf3pVlHJ3aY4kzPSS2eEpgJkSgUXF0XPh+l+zRIr8BA09AU15XTIqdpz3FmGol2m
	AvTyA8VQ+Kqk6nssLlVp2eitQRBorQFL5d7j7nijXstohaR+FWFzpHqRZwqwdkByLWdeYiilc3P
	jfwaSXwPfJPVk38fSCAO988YnBJwn1BlgeUgaejY5s4QOjuVvgV4klriStQFKsOb0YLW/WKdYSS
	a4M5lOy+8UvfJBXhWfKB4I8eNkFlpyflt0rxT/gdq+XnhzFWtCuV0WxjaYl0pcZVcEMYSyK7sfI
	H+4nHSX4zC1ZQ==
X-Received: by 2002:a05:6a20:748b:b0:3c3:9070:96b3 with SMTP id adf61e73a8af0-3d265a3ec4bmr37708099637.3.1788244595913;
        Mon, 31 Aug 2026 23:36:35 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.192])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0dc854dsm32694425c88.10.2026.08.31.23.36.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 23:36:35 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] HID: hid-lenovo-go: reject unknown calibration action
Date: Tue,  1 Sep 2026 12:06:07 +0530
Message-ID: <0c37a763177a5b8b45e94ac678094165cd965bf1.1788222001.git.mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788222001.git.mradityadash@gmail.com>
References: <cover.1788222001.git.mradityadash@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calibration action table includes 'unknown' at index zero. The options
attribute skips that entry and lists only 'start' and 'stop', but the store
searches the full table. Writing 'unknown' sends a request without an
action byte.

Reject CAL_UNKNOWN before building the request. Start and Stop both use a
one-byte action, so pass that size directly.

Fixes: 995887a10da1 ("HID: hid-lenovo-go: Add Calibration Settings")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index 59b457683357..a6dec5490d17 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -1412,20 +1412,18 @@ static ssize_t calibrate_config_store(struct device *dev,
 				      const char *buf, u8 cmd, u8 sub_cmd,
 				      size_t count, enum dev_type device_type)
 {
-	size_t size = 1;
-	u8 val = 0;
+	u8 val;
 	int ret;
 
 	ret = sysfs_match_string(cal_enabled_text, buf);
 	if (ret < 0)
 		return ret;
+	if (ret == CAL_UNKNOWN)
+		return -EINVAL;
 
 	val = ret;
-	if (!val)
-		size = 0;
-
 	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, cmd, sub_cmd,
-			       device_type, &val, size);
+			       device_type, &val, sizeof(val));
 	if (ret < 0)
 		return ret;
 
-- 
2.55.0


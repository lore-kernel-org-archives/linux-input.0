Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658B12E6CCD
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779532707; cv=none; b=PIJMCC3Th8EJAY4TYKWrLQ+oiJ44BqjynuaSOd65A1ppoqCQHKk8JT75o8S67iABFKc6Mwv0YsmDZ3D6uNHR24/TIvpPDZmepvOzZqu/9vweBZHhql5E5mtPcP/hQ37YynU4jfetOjMkjfZKjJDF6sY3jNE9wHQ48KBCnyWzURg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779532707; c=relaxed/simple;
	bh=Y5RigTKi0jnOF1EGyBEHsRcwaDU19A53X6y5wEjuzVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOhk6YmzlG8H9lhk0qz+H4Lk9LrbwlirsNThHJjjzohziGvGIRG+j293agCkgpZPrgVoOVJjGUp5xuE14xYNphjMUHfVJt7CfLMcRKOcYUIPmvDC0AVuhxoqMig74oH4ntrcdDqFEXC/Egk0rt0yfQBJFXAPa6DgWiIxJ3Rsnq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ki+6dTF1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki+6dTF1"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso41102385e9.3
        for <linux-input@vger.kernel.org>; Sat, 23 May 2026 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779532705; x=1780137505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TLxQqOKQ+TUZXG7U+M7H68fU/cqNh/Zhj/7HxseDuUQ=;
        b=Ki+6dTF1+SnO43XLhcoQAlowu3OoTjM84j90MRRyeq+hu8qYAq/0ffrqGNL8U77B1L
         ptzVefGSB4PEylgWIFl3OwKDfPL6EvqK4F0tZ5Di8D69HoTAHmbt5hrkOiqq02DV28UC
         LdeV1OiXTF/BrmX0pVdbqITPYIwnfrH9IXV5YqBX4mWgoNW7ErpkLGo4jRrF2Nxonjyh
         B5OnWrNdJ4VPrM9FDtbJb6cFlITD+gwbA7DCg6y6M2i9ivx8nx4O2qTApcJd7lirAyHZ
         JCKLNPEfcpzncJpgUS67VFzSETWivUWQ/Txg3I2pSLMvircJC7jh5DOBsdT/XcY9LiV9
         w36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779532705; x=1780137505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLxQqOKQ+TUZXG7U+M7H68fU/cqNh/Zhj/7HxseDuUQ=;
        b=RUDJdB6Gb3YS9mE+UhUQ87cnECWu9INswkGSODA1t5KIS2A3W1rO7hahsKIhx4+F07
         lcfgFH3ha6eiMVY9llEamrmI4QXu4l8L/qICaSEja0lJUn03EOeReMmayg6JFqIBNoKr
         BaboLU8HzgKhiV523tJEKpY+ewQvnE2H1ZHjfnfv7IXGjZG3c3jLDTjuMSuwwbkxXtJX
         lNRJZ7nxcETPM9I57gGfOMn8VAOClaBKWrjY1IfaR7SWQWo2b51iiEs7M/1fXfBZQS1A
         HGQEP6F2xq3f3zTzc2m7FWfZUY1NLw574oF+vS0V7Xk97bZOry790stOtFUAEbphmSvd
         KDFw==
X-Gm-Message-State: AOJu0YwVhjVNxqgFf1V87liu2RVxeW7DHxmxnQoullbd17RjFWiAcZnS
	ctHiN9MOxJsxRmEfHniqpbKjl1KnNHbHdK+NR5HU5DmCnWtiAUjpDakW
X-Gm-Gg: Acq92OGSYFMGq7AWhUFQAWQzDkdPXUtzdFUNLpSNLW94Bd1TdZ5vlh6UqIiD+UMNDWP
	ljVZaWfk4ZcD4VRk2FyobS51sKvYq5t8fPXFFLCzu2iblMVpE0GYkac5RMZxJ8cu0lLfIQ+vHcB
	T+GAr912ZSYhjcjGvRmZRFpQB5s3jVtlP9pDuniu1WePk/iTF/dfGBzNVj3JRGN3COo85AzVOUt
	L3JAMKNWPgPc62sdhSvwavTfokapAFcwM44C2uH8rQb8XTYQm9r9TvaBodYoQXFV+dkqq4UXVk8
	/Dgj1scPBbA+H6SyfWBMi2Xqrro6Mafjli50Cbd1ytlH40onSTzH9Fqe9qSX/1iHpD8Mz8m9Fun
	H11b0MdORo3Smaut4hEUCkybN/cG685ak+JzG+7GX6ZfLyPLKQtp5GFWNcGOhtqNmbj+keJ5YQQ
	aHo7Lx+RGrMl3AQMcM4tvd8nhuX/afnrRwHZ7nXthmgbi5KVGpgui1ri3lCH4=
X-Received: by 2002:a05:600c:c059:20b0:490:31e:d6fd with SMTP id 5b1f17b1804b1-490426d3319mr82422435e9.25.1779532704786;
        Sat, 23 May 2026 03:38:24 -0700 (PDT)
Received: from teknoraver-mbp.local.lan ([195.182.211.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f58dsm10796534f8f.5.2026.05.23.03.38.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 03:38:24 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH] HID: core: demote data shortness warning to debug level
Date: Sat, 23 May 2026 12:38:06 +0200
Message-ID: <20260523103806.60480-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
bogus memset()") changed the log level of the short report message from
debug to warning, flooding syslog on systems with devices that
regularly send short reports, in my case an UPS:

    $ dmesg |grep -c 'Event data for report .* was too short'
    35

Demote it back to debug level.

Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 41a79e43c82b..76cfed8b93c1 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2050,8 +2050,8 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		return 0;
 
 	if (unlikely(bsize < csize)) {
-		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %zu)\n",
-				     report->id, csize, bsize);
+		hid_dbg_ratelimited(hid, "Event data for report %d is incorrect (%d vs %zu)\n",
+				    report->id, csize, bsize);
 		return -EINVAL;
 	}
 
-- 
2.50.1


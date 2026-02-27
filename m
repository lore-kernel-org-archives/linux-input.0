Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01C547886F
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225709; cv=none; b=XeW9RCM0lIRuf7kwNC5XELKVJErP7NldewAvQ48kbjvMxEUvoWPDUrdprRMOs7SR1sXsOBJIxmzNns4EhURG22oiy1O013L5CNi/YZGF7I1wf/CHoW/CefN7Y6/meJOUBX+xfLrO5+IowJBGfe/QdaNRrvaWzziNmuqswoiKZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225709; c=relaxed/simple;
	bh=Pi+esKYrGjsWzhvVHo5NYiRkb7XCnD/2Gqdfov9W/UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEol3xPiTBsvb5jaYLG6dHx8tc30vOlHCRHN4w6YHzWYBWf02By/psS95xXkkx0TlwKB5VL5NBxnVT79whc+81i0WYGjBpIUVy8nFw1yOBsF6mAzKP1Dw3PC2OVx2fLUylF4LDLKViJMZgnQ4ZQb4AFQApctEm9G7/iBfvm3nUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAk6jBdX; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAk6jBdX"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64aea64bf15so2205565d50.2
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 12:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772225707; x=1772830507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYk748M1s+aXNXFsEvtd3WtBPcm8lSLvdvOHU9p2Wqw=;
        b=lAk6jBdXoleV6+me9SFuEWo/fgM05iOzwV3oSsPXo5z1RH3hO+uCrltqMhusTYURds
         4GgZIWWl61tI/yVQS2sT38NJ57ooY7OLTIqTXYfJrMe0W+Nie6LQotYE9HkvQoY9mNYk
         cIkSrpuIXWR3VXklyhtYHez8whsXE9sE2F/e1HiStZtLSYWrRIAeHRjwuTa6QYeiNAxh
         mcB5wDXGq4+J1AqW1I0WWfFoiArxNNZWR/vkAlW2IrRTiKt2ox+CPdYIb1lP2lb3TArG
         EIlmSLJELaMRncb+jpTckRf3VScJxUgPmOqqHIAv4Alu4B5PLGbyqbJhOEViOrzWy3U6
         0NHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772225707; x=1772830507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OYk748M1s+aXNXFsEvtd3WtBPcm8lSLvdvOHU9p2Wqw=;
        b=lBz9xYwpOOGsHce9ieNAjNLQ+aioBiXCGt2xarnCkzyKgmJ7SkKBrGO5bncx3nh83g
         /lCsmO10EzsrFSTyOp7zJrBNuKf+pXw9D+mkMxcqY1z4ySc80wl2oDHFRC7Z308MDVz9
         XcSBfI/jEueByJCmv8K/RzSUCOLRLIAPFrZwAF/Jf0AMX1w+//0zCvHBNpgSR/jYEWlT
         s9uZiqwEsjMLKoEi/ctPtEK9hZ3vvl4Gts8N05+Z2CQgY+vnujgp/8+N1IyVfOFS0hIX
         wyJVkSrWrc6J5TFGJayqcFs5yuYXlpCfmjlmyn0Vir9mk57XKb6U8RBloR2F2cSjrAMf
         hUMA==
X-Forwarded-Encrypted: i=1; AJvYcCVBPyJCsW7gR9IiF7Ae2toXY03HA/3m/ybstaI5Gittl9ztUrv72Qy700Yau0V6o6NcyJSLLL+Q/EVTig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJthpapGORpC5JNbys3F5YVnSi1nUd+Y9DJgBNDeKcIL7q3KuX
	IGyZOZgIjkGVd3ia1hL/3u1kPt825xOfyb0WDzqTcSUM6qB7FtUtP1Kz
X-Gm-Gg: ATEYQzyj4b9VTbvAdE1O6EUpKtYgAGzinbHNjMBxzY6CvZ21OxFiSbzHDC6QlSosz/P
	4oAAiZ/UKt6HJJ311IpYdj7ItPPfG6HZPlX9rJDl5pIhbfa0m+svWAym/qJrykvmhBhBo90BK9i
	eFGIK7WTl7eXcs5sJ6JzBMwAIuIswFbOaJgu61SKiNgjsX+NoiOOKdDIyeGaTSQbAW0JMHYXZbk
	r2j2/sRdwDfbeHeaJabhOxexDPNQoD0E7lRTLSpw124HCd3wbn0SldnE+o0v12by57g5/107Tsf
	lCJ890qmLPDyCwscXS6/vHvnYrffOp12aVI/crmlQTlXAnMjGEk2L1NGGDCer0yA5/xku+dxAhN
	n6cfX/BgWMAkLGXex5yu/7qd37nCqTwD7Xd51mw9bMDjY1hLx9kcUOQel9dkqZRi+M7PWNlgcZU
	UzcIthehzldrtdFG6wCmRqUY1Q5RTTuH5CbK/9BoSqx2cvsl6hNz/DwdpRgbCcbDxzel0Ygvzgh
	VFk9XWOisawo4M6F/9jgdB3
X-Received: by 2002:a05:690e:150d:b0:64a:ec39:dd64 with SMTP id 956f58d0204a3-64cc22dda60mr3473706d50.43.1772225706826;
        Fri, 27 Feb 2026 12:55:06 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb7571e00sm2805811d50.3.2026.02.27.12.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:55:06 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 3/3] HID: hid-lenovo-go-s: Fix positive promotion bug
Date: Fri, 27 Feb 2026 14:54:44 -0600
Message-ID: <20260227205444.1083103-4-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227205444.1083103-1-ethantidmore06@gmail.com>
References: <20260227205444.1083103-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function mcu_property_out() returns type int and returns negative
error codes. The variable count is assigned from it and checked with
(count < 0) but this check would always be false because count can
never be less than zero as it is size_t.

Change count to ssize_t.

Detected by Smatch:
drivers/hid/hid-lenovo-go-s.c:583 gamepad_property_show() warn:
unsigned 'count' is never less than zero.

drivers/hid/hid-lenovo-go-s.c:583 gamepad_property_show() warn:
error code type promoted to positive: 'count'

Fixes: 14651777fd675 ("HID: hid-lenovo-go-s: Add Feature Status Attributes")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index a24737170f83..4596c18037a9 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -573,7 +573,7 @@ static ssize_t gamepad_property_show(struct device *dev,
 				     struct device_attribute *attr, char *buf,
 				     enum feature_status_index index)
 {
-	size_t count = 0;
+	ssize_t count = 0;
 	u8 i;
 
 	count = mcu_property_out(drvdata.hdev, GET_GAMEPAD_CFG, index, 0, 0);
-- 
2.53.0


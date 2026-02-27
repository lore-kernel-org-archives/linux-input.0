Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7ED36C0CD
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772234248; cv=none; b=fy/l8zkFL4tr7W0XfFr1wonF5sEHRKYhbKUlS/l30F3u8LQ7tHExCPyTQYbL0xFQ+J80sd9Q9W5eaht/DJfWqloDME7X2d27FDB1n/nxNsW3rXD/7eKBGzhMOlFl/B1NEPpq3kBSzoq1KHMmfAjrqCPp9CNUB1yEqblobWb1Veo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772234248; c=relaxed/simple;
	bh=GVLJMA3GGrhSf/iJqPVBOLm5U7ULMbsoNhWfdAiG+Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YT3k3IZSy7HT3sWOgoet0eKZWcRIMxQ9qu3ibutWRu2RwFu6KzMoXAXGTDhSVkKQn+hKcfOLgxyD1UNUBo/XDwD9YL05sKnmnUnCVtVgtTo6Lv6eDhEYhyL9C9C7ggyJ/K8vAlUDBBedHwbJOzW4TW4ntKpb0ScR4BUNPx5Vh0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiDjsdS4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiDjsdS4"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so17200355e9.2
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772234245; x=1772839045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tf5BsDzyZHlIIGQLAFzNJuW7CZ862XMnhMQbP/B+AUU=;
        b=KiDjsdS4jlztwhy903GQ+eYosYmUfW3cxSI4+fmet7kT6l0y/GN8dIi9yw1lFDfcte
         8qdv+zE9AhJ7HFDUGIZLFCwWA9Q+Z7LZ/BdMmBw53DF539ehUX4bTZhRWqchdwG1E2BV
         SXk4CHZLaTuu7ZFsrDsFQOdhUPUXk7ozGIWZY2cjVxD/T8as/WNacMjU3fsE+gjUIX6T
         R4hsfO91jnJwGaEXiGgxSHVC0EBtw7lQPL3qLJ8/EuiyEA7pamgn3BjHATXAxY0Ko/NW
         o4fPQMRI0QOIWTnptkVET5qrpw1b75UI6YjIEPZpFPoKLYwafiDK3bPLxSf6QSl7wfS5
         +ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772234245; x=1772839045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf5BsDzyZHlIIGQLAFzNJuW7CZ862XMnhMQbP/B+AUU=;
        b=XOr2ASWiI5pBvMH2yRiwGJxaD0GVX6y+9kqnxNu80F66cgSfCOoA9TuqAjomzjCK7+
         OnK4YMRl+x1mz9OlOk2SxmDbH+T21QBlWwxMO0igcLuxmGRMd/LqE2r7WtxlHV1Jsl/w
         178JeR9JfJN8npgekuSgqsT5eRBXW4J4j6RVrnEcn4QgvIAWIV4u7Qxz/6qqz5x6KrgI
         MNAEk7HMlkidUYZDgnWi0coHZjE8ZlgG/4YMsrSqkSlw9c0fWy/CpJdbazGCB3/zmbcR
         +Zdfvt0bx8WllnyDyryZ1RKNN95rt20mBbfEpy+OML8pCcEAbl35GB0UiltNSw42GmlQ
         cTrw==
X-Forwarded-Encrypted: i=1; AJvYcCVfEmGhr/53w47TFToq36kZJ+mEFaNpBYOI9ijSM+9DmtAKfmslspoRoUy7nxaHERoN6cVr+N6YqwZCjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVzBu0LsI3Jqo93b09Ibbu92KCD9eKrsNAvax8y4RktjJCtZgC
	RRZR6xfEizCREPRjl8BTZrvt1ByOENO3s2CHNeiyASiemesWPFmpgyOE
X-Gm-Gg: ATEYQzyqzNw9avdKsvAPm4kW5h8QjUf4ff/AqoGbyNyMTEnR51ruYux6Ama3H0/CJa4
	FxyQiV+q8idsesU9d2KPHC7H7m4M95S9fccmYsU1A7ONkA+ggpGbrso3pZIwRq/SeoiZjfPANal
	nnRFez1DAE0qvZX8NY4xmKnZ+XrnT9BsvoaQCEWXHsZGZioFrHgjArmjWdABQQaEmEezMIO2+XY
	AIWUNF2sLb1+SOmjpKFBzSAobrpSWHorQfOf3g7dNgv8O84wenU8wHUJ5BQcpHJlOqa0lIjcOl8
	mWkahEHw8CdkNg609keU8sL4i1rhx7BptXlYiwBD8bU5ecM7tEqWR1XCDQmPlmypL4DzM9oq20x
	ybdkyY+xQqkNsXDGCmsizg6nlXWcQR++Ub/HcOT7d+5wFuiJwosexE/LijF16PdHyAQA9lxxZUP
	K1LIjecaHQ+1WDrmlhw2aB0nckliK2XCxw
X-Received: by 2002:a05:600c:8106:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-483c9bb6559mr71896955e9.4.1772234245150;
        Fri, 27 Feb 2026 15:17:25 -0800 (PST)
Received: from localhost ([87.254.0.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3474dsm126995695e9.1.2026.02.27.15.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:17:24 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] HID: hid-lenovo-go-s: Fix spelling mistake "configuratiion" -> "configuration"
Date: Fri, 27 Feb 2026 23:16:05 +0000
Message-ID: <20260227231606.421263-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err_probe message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index cacc5bd5ed2b..dbb88492fbba 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1401,7 +1401,7 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
 	ret = devm_device_add_group(gos_cdev_rgb.led_cdev.dev, &rgb_attr_group);
 	if (ret) {
 		dev_err_probe(&hdev->dev, ret,
-			      "Failed to create RGB configuratiion attributes\n");
+			      "Failed to create RGB configuration attributes\n");
 		return ret;
 	}
 
-- 
2.51.0


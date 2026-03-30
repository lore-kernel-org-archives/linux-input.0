Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CC23D333C
	for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877369; cv=none; b=p9yZOY8MhUkUVd3cqTiz5aeoCgCKqTIWBnrIvP+nbSd/7EfCW4vS7a+jDyhcYjfu6YfpY1DLZgbAGUqI7HqTLiy5XZeo3CXHjnpkLWsmssvKZW4FYYcoMWmMCIceoYv8Arspl71x3hxp4SDNhv7c2sqv5c8yXxKC44kHzQFih30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877369; c=relaxed/simple;
	bh=HMPY83hDOtEh2uH8sesLzoJ/Zhf64/JSuRtvJ9f2po4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQMGk5e/5RI2lbWRFSdEQ4y3M06UkyJCZ8MOMzL0X13WPOldWSinTh19V24iUb8hhWbYgX1XRyxbjh50ZEEQ1DY4PZBOdFoa8bAUdifxofxCGGtzkvYm6VeIcE+7eCSiF4EEdZkH2pESU77+HxHxvaVL3eZ5PO5pg88dO5Bo9gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwxvW0uV; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwxvW0uV"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56a9076813bso2317086e0c.3
        for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774877367; x=1775482167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=26QADu2V5kInSwvDprX/X5k3HI6g/YNPM7XdH9A3Fig=;
        b=pwxvW0uVskulGYZtE7CZVzUfPj3e1yDwTiMO4bFq7V0qVX3jOkLUQYljhY6K4zwCh2
         /ZuNPDjHVfnQMCldyDPhWKtFxM+Z/mrmQ/OoyBpGTo3SqL0k/d5AHdWQRS1rk7BltB8p
         /RLdGilAA+f99F+QXJavlaYM5+kkUQS4FAvnkBfO+hj025/4e+n3FkZGaoNASiDNzSeA
         nD/4g84s2oGyzTDAEt2cFdhzu59dg2t/ltggYeqlgQ/WKijNjypFnQUWxNKEpAPRtvKP
         PCUk6khYeZ77o0RrDx4fU8jKRXFrgRFC724o+gHjuNvFJOgmcKuHh6vnJpzZ0lv1A45i
         gMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774877367; x=1775482167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26QADu2V5kInSwvDprX/X5k3HI6g/YNPM7XdH9A3Fig=;
        b=Muz6nI8l5DPTCwAEejaIE6X4c6z2PFHA6JjZ9XVigYEl24RquCYxcCV6UQBzACaO7n
         wDy4l2Xb8ovGRimb2+LY/ig6HNs+hKK7eFowjkmpf53Jbkxs+Sbv86pIOfDH0kt0iSab
         28oIuZCkmdUexXZ5DO8kQd677JuFRYpSz4vvbt1AWabLBMu7o0501U6lNyrEZAFtzyUY
         JbXCzt1GTQx5iAvKpzLusZTOhvDkP9exCahRxZ9hteru6PAj+U9tpw93X+m/eBaYACjr
         v1/Odb/YMWIPhB0dMfqnMgQUXpE+3PHQjwdHKIzVl4p3ZVmWkNDz/Rg5GZjA3SM9GOQ7
         tfrw==
X-Gm-Message-State: AOJu0YzfHasPbBcEjfxP8TXkkLf7nyYljtgMXYkVW28D2hm5HwEptBWH
	KKtvAQyG1eIEfYS8WWRztj1f79thSutwyKRT+bUnrTENtZE+18SnUMLgi7LF9cqjpvQ=
X-Gm-Gg: ATEYQzyg+aJ5/uJGwZ6JdAN897uUmcBCBLdvaHB3CxqdIjLNJMKbHl3W0lcQ9cgEPy+
	Y//siGXgEmcvJvbs/HnM4EysdWAY2C4JpF4ZSeV8U0P2SaiefYN1ft1Thx9VVX2e7rtQ8P2wKye
	6hScMAy0eRsldhxT9lgDgQGJwkvPUsAZcNzs3MHUX2tDWnATEbpEJnzP9ncK9TyZANTxECNDnwd
	9G4XVEoYFMRmKsK3HnL2Nn8ZzGkgrVwwjkKZo/K81Snx4wu1aYpKysykx+gYZS4iOr2f58fBsih
	g0RRDArWAzN3CEx1gL5oMzBQElzYMQvkzlW64JozY1uJ1oHvSNnYpMIZrUR5Z88OSXt0OR+YRhx
	0wyKxv+q2/LM15dKdnb4PSWLM0rMwXDlMbhDgUCql0xYyEsY90fOFLeQJaroveBzT5gAD1eeuGr
	derqWeEwzdhwOoORfDOpUAnfk=
X-Received: by 2002:a05:6122:1801:b0:56a:9841:9f81 with SMTP id 71dfb90a1353d-56d4a51961cmr4233767e0c.6.1774877366946;
        Mon, 30 Mar 2026 06:29:26 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6d9:aa::11:1d6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d588c4016sm8333474e0c.8.2026.03.30.06.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:29:26 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2] HID: mcp2221: validate report size in raw_event handler
Date: Mon, 30 Mar 2026 07:29:22 -0600
Message-ID: <20260330132922.827503-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mcp2221_raw_event() accesses the data buffer at offsets up to 55
without validating the size parameter. Since __hid_input_report()
invokes the driver's raw_event callback before
hid_report_raw_event() performs its own report-size validation, a
device sending a truncated HID report can cause out-of-bounds heap
reads in the kernel.

The most critical access is the memcpy from data[50] into
mcp->adc_values (6 bytes) when CONFIG_IIO is reachable. Other
unchecked accesses include data[20] and a memcpy at data[22].
Additionally, a memcpy with device-controlled length (data[3],
up to 60 bytes) from data[4] does not verify that size is large
enough to cover the copy.

MCP2221 devices use 64-byte HID reports. Add a check at the top of
the handler to reject any report shorter than expected, and log a
warning to aid debugging.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index ef3b5c77c..770c305d8 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -850,6 +850,11 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 {
 	u8 *buf;
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
+	/* MCP2221 always sends 64-byte reports */
+	if (size < 64) {
+		hid_warn(hdev, "report too short: %d < 64\n", size);
+		return 0;
+	}
 
 	switch (data[0]) {
 
-- 
2.43.0


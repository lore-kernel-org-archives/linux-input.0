Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D36653E0B
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780718632; cv=none; b=HFQh4x8Zw5jo389X8UVP0xW4cfZqvXpVoN9y6Rr6jMzkFyawQe23KtsX67XLsAQBAIEJeCmckv+bhICjFoC/2Jxm5clGJ9l83e3O7mowOo0JCVwbrtXJ5xBxgnjbTpcPdSx0txnvFaK/4jP8hAZjYSjptPOhnWvFuaJRqNvGrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780718632; c=relaxed/simple;
	bh=PJZaKrNLcKFNSBS3+lZJyHsqZOuxOCIw9rmM2PCUmqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQHl9sgiJ6BWzaMEYfSAvTGXvfIyd7PtiUlPS9YyZyTStJKeSQ4StkMa7kukGB+blpJUkcn23uO+0lPVVVimRCyfnekbcJyCwjidGM44GTSHuej7ow10WvMUTjIBkCRyRy6BLtgkvlp5KowWVTrBgpqwZLdebuzsqC7aWG1q4nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=av/EnC63; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="av/EnC63"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-841882f8f4bso1111838b3a.0
        for <linux-input@vger.kernel.org>; Fri, 05 Jun 2026 21:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780718630; x=1781323430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=feEB0mp+4JAx8mDdmQI5mQzY8bj6H93J6FR9tBKbgY4=;
        b=av/EnC63oMoZULFbVcbQaaU7vPmI5UV9IFMj3inpDmTRu25cWssT1TEkjbdbLhbLKp
         +o1jhYqxLT/ptVE+cZq0+regbPCFeMAM3JDFVJUTSmRMhTFHTSNoWnMHY9ZX1nprFn/D
         aT8U/i8ykiPFmkTs+cXGbVzAhS9BMH0yUm8FtLTEhlgs7KBHD3uL8o9rO4QXMCMaSiEd
         /Y6g2xGAtdnCgPjT67g1tjWCbawpfwDVRzPDHzEc+3wU1De5UYRZ5hJkYHprWZnkv/Vu
         IRcri7B+IhSAjNFCW3M+irAyOvu7qzNW6J9EWUdB6thaBahuAmK596fzi3HYIc95E9IL
         zVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780718630; x=1781323430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feEB0mp+4JAx8mDdmQI5mQzY8bj6H93J6FR9tBKbgY4=;
        b=oJ6Ay4pgzoJ65uqCxtSxsylsMGE5s2UlPkpx5QNmHTTDTwgi93jY3g2aGjd1wIHVS2
         rOBgdf66NvPerErswZSOwk7Hbx8fu+E5d5lK8o4vAbvtwtyd/Svu53Sv8t5K722GZLUS
         GCDlsF5aRPMauLbup7eVcxpetbx7kzDSE0Gx5aN+ErzzEe8PN4yAEW5xSBdpI3Rj260s
         IJxtZUfnnec9MSts6LiNQrUgXoMTBf+BpK2deHOd0PGJn+vjqInR8FuZ6me3ObGtSIrJ
         aWVb6Mbe5DhIRXtY6pnKVIkRn3jkWCDNQtWEhFm+VxtEhgGGGknqkr9zoMbt0kfBexYn
         vnLg==
X-Forwarded-Encrypted: i=1; AFNElJ/YYFt/YtENE5uQNJmZ2CZdPAV3hN0q00TF2iOo6ljU8k5Men/yxhBBlUwezcK11zCH7vqXT3XCZI1dzw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+2xClQq2Nl17HN6F42qOD31rPXJ1zyLs7X9k6n6ehsmyQ5tD
	fm/D9owik+GYjUPmq1RUAq3n/YEPurDGgOCtyTsXc06vIgHO5ZX2vjbp
X-Gm-Gg: Acq92OGk8VeSVuqxyxFlbvwlNuP+1GLIg4XejfJdrcVoEOnelUav8iBeTWhU9VjToHR
	LUXpCYZpXBSXpVrjvSa6vnNvA9FVRY3YIlpUOsgW5h4BdRe88GBZDsgp8dJgpF7idd4hqCmJ/Ab
	aH0yc/NFLQR1eU2jLjWoP7k9ZafG62Nl7YY/r9R1yAubrYNGzPhpt0Nozpw6idoshEasoRmYhSK
	QsBNhFy3EXYQ//RHxreOiaZRNYuP3XTMDkOg3o5up8aM2Lk8ysHj54M1Xveqw6BUIZxMoTnfYD8
	tlwzTtytKZt90SpI/sloGXkKqgpukTLiM8Frjne3lvYTuUIQUFxoIx+J4jaqf92G6ahVfHj+kLM
	DapRBhTfE3VMXfp2LOkuiKPhyojlwqDrB+V8AWi4bSUT3X4zPTprdysLw7Xg4aaLQKDdygU2q1O
	p4x4upJDN0Yz0p7WPUtPJYwzxoHIdIkgDl9Q5OZBgumr0WITlRiion/Q==
X-Received: by 2002:a05:6a00:9a6:b0:842:3aee:12c0 with SMTP id d2e1a72fcca58-842b0f4d125mr6930145b3a.23.1780718629640;
        Fri, 05 Jun 2026 21:03:49 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:967f:7ce4:ec98:f08b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e02f9sm10782031b3a.48.2026.06.05.21.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:03:49 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>
Cc: Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] HID: wacom: handle kmemdup failure in Bluetooth IRQ path
Date: Sat,  6 Jun 2026 12:03:44 +0800
Message-ID: <20260606040344.4-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_bt_irq() duplicates the input report with kmemdup() and then
uses data[0] to dispatch the report type. If the allocation fails, the
switch statement dereferences a NULL pointer.

Handle allocation failure by dropping the report. This keeps the
interrupt path from dereferencing a NULL buffer while preserving the
existing return convention for ignored or malformed reports.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/hid/wacom_wac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85625d..c42af15e7dba0 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1206,6 +1206,9 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 	int i = 1;
 	unsigned power_raw, battery_capacity, bat_charging, ps_connected;
 
+	if (!data)
+		return 0;
+
 	switch (data[0]) {
 	case 0x04:
 		if (len < 32) {
-- 
2.34.1


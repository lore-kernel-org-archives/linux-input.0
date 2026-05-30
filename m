Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC382C11F3
	for <linux-input@vger.kernel.org>; Sat, 30 May 2026 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780156776; cv=none; b=XPKMWMQ38yFoX17ZO/xqHYfJg35tM86tESkulguMpsB3LrlhkEzCEEkYqMHwxDJ+b+F55gR0n1V0K/GrXawC+br4Jzd+5ATU+FUwGnzc58uCEoIv5h7egtriUt/1nQz/F9Z2d3gElvTrSXmwiiE5BscuK7UfmmpL77qZAkuUAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780156776; c=relaxed/simple;
	bh=ZqY9+9AxGyC/ye74Rz/F2gbLiidC9axpzQweMBEGG3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S+9/fsICdQVmo7/j/K93hma7jvj8MX4tDpelQV4LRFiMPNI5PC5aDQyZNaqE6GFMiBVOaTw7zSLFpFaJHQuvAw61uRDxWZjV8JEjIqeSuCyMwGvKQMpbu8fD5xBr3v73gLyGxMvt4TJepO9xI2XynzkIm/K+9dnSne+DcbRb5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiP1tY4G; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiP1tY4G"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso794914a91.0
        for <linux-input@vger.kernel.org>; Sat, 30 May 2026 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780156775; x=1780761575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TAgj73NhO/Qgky2vRa5up3EF0NXAk1X9eWrQb+RpU04=;
        b=PiP1tY4GvLzoRJZ1KFDryraLfItH68wPY+t+8KHirnD1pzY4/wkAo5pNcDm+EAR3pf
         bV0FAB2t+M5PdgsQBqPrONsKojvGzQ7CjZFIIN2GdWQlJqYCO5uJrq4uqZiEi2kwG5RM
         TznFMMmNAoY2O0JroCra19t8VHDI+LX9H8fS4OdvN8JBbfU0Ewo08eF0elSyeNL3o4ih
         XhITUGz1h4GOsaBgTEYJRdTBabgYZhQXgYVr3cdNof6A1G0syEsv4rKBadgIFGbsSVTz
         IBjJdBOcy6ItKfdxuLQ/lXa7/GNu/O9R1d1AoAhp9pUJYV0YAeqGAXNO6f3HACgPP/NS
         XhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780156775; x=1780761575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAgj73NhO/Qgky2vRa5up3EF0NXAk1X9eWrQb+RpU04=;
        b=kqcijyrQAY+a/I2+ruAn4MDshuSGCgkmkH4Muaw1XhCNdxaxpm84sJUsrSqK2OfIYV
         Yizc76l6LKBp9zLpWSLMq3ddjiTSDDH+XO32746UIrtt+TAwpBsPemfptX/wqdXBcyxL
         mNENwjTzr7Ou12FvpXSlvW+NcYnJWrzFUnKqxxpu9xnMvMDJBT4TxeaPn3Dgrf/6Jmvd
         uhP5PlAR8i0mct6f6iHOq2zhvRiIfyCMlbt6EzGocrFf8tMYnsS/sTGC1eormzeb1HI5
         2OBfPNKHutxJpoPi1QtFwJdjuVkufRtV0V4hOGrDvuEyhewagG9RL3EqG0kcIz5aYHLI
         0yMg==
X-Forwarded-Encrypted: i=1; AFNElJ9jlN95IwNNmrAjb+5XQlX7Gcb3BgawNixLeGMj7Tr53AIFmAmZSGaB2Olqb2/KyeDS9aNOnHeh3UVnNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFBpr/mwIr/4iw8QtmK/hENl7oQmCgkHsszzoYiI384UJIIre2
	Kbms4eWfrFjf7Og3BQYarx81+8DOlCYNj1dsKS/cDc95YKMInjwK47zehb+Xvs04j74D+A==
X-Gm-Gg: Acq92OH6q8IPjtOyj9xacRJJLiTIPtoPhA3qmAWgXg4f4jCp7ppinkNcDI0pOtkPN1u
	PR0i77mKqswtO2Of4MC6kmw9VQ1Ua32xjYFaXFfoSDfYzReE+egcOKpasigojgU5+2O81lLP91A
	CjL4OM6Fy+tY9ugl9p7pk+KEQldk9N2pWYpetquurg0UxMW0agA+78Vq41DJw85nclanmPtVng7
	jfU4XdysPl56pLQPjY6Euxq1wRikyd5Q4dPfbnGUPIyMfjIxp9Lm9naLfqhuo5Etyvq5cfY334g
	GMX19PG4XdkciwnpH5i/PACLHWheR6pEX9KmqI4Ma82hdE1GqSF8tlcdA3usudtYv1Z2rdXhIUb
	pDXjvJecA6faVaYRi+ESpfjoKHZzmfKIlffQqlKvT1lnfzcz94l27HcIR8+EjAtHOXb+iHs505a
	TVUaLlkaZ0F7eGR5+hkIvbuV6hWwerVRWZ2rT28CKSyzXKXkyIbt291OZ5UNc=
X-Received: by 2002:a17:90b:1d4d:b0:369:f48a:f21f with SMTP id 98e67ed59e1d1-36c4ff3559amr4144848a91.6.1780156774849;
        Sat, 30 May 2026 08:59:34 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc0befe7asm5776983a91.11.2026.05.30.08.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 08:59:34 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: wacom: use GFP_ATOMIC in wacom_wac_queue_flush()
Date: Sun, 31 May 2026 00:59:30 +0900
Message-ID: <20260530155930.128183-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

wacom_wac_queue_flush() is called via the .raw_event callback
(wacom_raw_event → wacom_wac_pen_serial_enforce → wacom_wac_queue_flush).
For USB HID devices, this callback is invoked from hid_irq_in(), which
is a URB completion handler running in atomic context. Using GFP_KERNEL
in this path can sleep, leading to a "scheduling while atomic" bug.

Use GFP_ATOMIC instead. The existing code already handles allocation
failure by skipping the fifo entry and continuing.

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Fixes: 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a32320b35..2e237bdd2 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -74,7 +74,7 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 		unsigned int count;
 		int err;
 
-		buf = kzalloc(size, GFP_KERNEL);
+		buf = kzalloc(size, GFP_ATOMIC);
 		if (!buf) {
 			kfifo_skip(fifo);
 			continue;
-- 
2.53.0


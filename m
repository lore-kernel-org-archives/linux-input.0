Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BEE35F601
	for <linux-input@vger.kernel.org>; Tue,  3 Mar 2026 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546320; cv=none; b=GIBM9XYvHOwii0k8V5792lTfC25jb/uDM2cMCOsIV2BFm0ztmqLNu6Otm+ymIK6Nq/B6B0CbGvzj9ZdWsQZLm2dCcsw1CfWbmKg+/ZhDL6Sthh08v19HDEX+GAMP34x4NdIoKjBJcD+ra4JRbIB8qq2NZPpkDJMhkUlmiNtZRwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546320; c=relaxed/simple;
	bh=JgPY28IqOyO4a/z4K1x3H8dmp9PcfrJXoPXNd05wdyk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GuiXURpLNIpIrIW/JCrR3+w2NxGQmfjQ1Gn62FlwOLEHiJvoutuOPLbkutZLoQ5wqMcO0+Z/lVuQ8dyyCeIiDtKgIlNrjih3yYt1nPejnOGj/6gzsWMsQDE+flqoc0t3vMKabrMyco1eO0YYq07Xu20hMlLH/Ab61fsMN4D6X2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCyatcZs; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCyatcZs"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-65fa9f433bdso7177281a12.3
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2026 05:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772546317; x=1773151117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sBQkY0P462iGzNoybAIeEY89Pa87GfWOJS/rxXvzzC8=;
        b=NCyatcZsNIAOlu6rZDLqW3Rp8FafdX6hGM7VzIoUQCa4AfjBKIAeiMxwCFqxNA8Nh1
         11gJtEBcmOxUUdS8aMCvuVDZfnEFU/XmXXCdkI8/P/Gmc4kNko36MkS89KKottWj706L
         ASGo3qRN+Ogb5tdkhoTiUusaYWx12h7gkdj38+3CJQFUPSu+JoPCsdGbni+aNTJqbf3L
         JcLdPEsYGyB9ekQGHHrPIgW6VnPYmItYfjq9n/I6ehOcgrcjpzDD7XlbhJPqRGP4pp4B
         eN/FsRsmJU3d0vxa1/hVk1RLqohfQU5uvBfkLzTKiFHVzQ1h9cstI7ympn7IyKPeLSUa
         VfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772546317; x=1773151117;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBQkY0P462iGzNoybAIeEY89Pa87GfWOJS/rxXvzzC8=;
        b=XqKO9PFkdTJR5IT3ndQqyTJLngqLspmV1jBVbNkFL48aLXQrEmTTf6Ue9Iob6b+LAN
         rcO5gkZilzHBMVsWJ8IPqxorNm7Dd5dViNjVGanjLI7edWF26I7b1jJOnx8idL6bugeq
         SRRQlrLz+fElu5tbSzYz3jWcomVxBDiiJiJamgZu9huef+dNS6s0Bprz7HpmknIc0yz+
         4cRZBHqRLztVdCJF3kPROITe3z3TszD9UM6TPCPYivgFGTgDq3CY0dDqhkXvDE5xGMMw
         KHv4vhAQVfrLzQqA/SiM6uWnPlc/bD23RZyropd1Rgy/ayp8Sz+3ww5R0UQtP7lfOngS
         CMpw==
X-Gm-Message-State: AOJu0Yz8LVotd939p/dEuRlf6CrqER37HnzTm3LClHjwdedYh8BdrxjO
	FE5c5uOTUxc6ckakgGtebiQclrTm5CglHpnIyIO5ZzgtvuZFu7y3Y3uKHmk0o3Uv69hJyPfWQAd
	Eq0vMNpBcIg==
X-Received: from edev17-n1.prod.google.com ([2002:a05:6402:a2d1:10b0:658:6265:19e4])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:518b:b0:65c:5a7b:bd99
 with SMTP id 4fb4d7f45d1cf-65fde4cd4aamr9382146a12.31.1772546317172; Tue, 03
 Mar 2026 05:58:37 -0800 (PST)
Date: Tue,  3 Mar 2026 13:58:28 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303135828.2374069-1-bsevens@google.com>
Subject: [PATCH] HID: wacom: fix out-of-bounds read in wacom_intuos_bt_irq
From: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
To: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The wacom_intuos_bt_irq() function processes Bluetooth HID reports
without sufficient bounds checking. A maliciously crafted short report
can trigger an out-of-bounds read when copying data into the wacom
structure.

Specifically, report 0x03 requires at least 22 bytes to safely read
the processed data and battery status, while report 0x04 (which
falls through to 0x03) requires 32 bytes.

Add explicit length checks for these report IDs and log a warning if
a short report is received.

Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
---
 drivers/hid/wacom_wac.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 9b2c710f8da1..da1f0ea85625 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1208,10 +1208,20 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wa=
com, size_t len)
=20
 	switch (data[0]) {
 	case 0x04:
+		if (len < 32) {
+			dev_warn(wacom->pen_input->dev.parent,
+				 "Report 0x04 too short: %zu bytes\n", len);
+			break;
+		}
 		wacom_intuos_bt_process_data(wacom, data + i);
 		i +=3D 10;
 		fallthrough;
 	case 0x03:
+		if (i =3D=3D 1 && len < 22) {
+			dev_warn(wacom->pen_input->dev.parent,
+				 "Report 0x03 too short: %zu bytes\n", len);
+			break;
+		}
 		wacom_intuos_bt_process_data(wacom, data + i);
 		i +=3D 10;
 		wacom_intuos_bt_process_data(wacom, data + i);
--=20
2.53.0.473.g4a7958ca14-goog


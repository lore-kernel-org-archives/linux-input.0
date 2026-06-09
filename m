Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF9C41B347
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016818; cv=none; b=KI0HdJTMP5BpM+YROOPtkyZQOh6lF12m+oxe8uBzgZrfnOW2+OXSee7zqPeozTw9kpJbRt8LlHGF9a1dAbmD2drBtySaXrbFs7zxUs4fzU1K7JnZUKLGoi9f9HB5OprmBuXD0F5FyDjBGGZIe1sHcBZhBXdkG0HxqfK97Xud/Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016818; c=relaxed/simple;
	bh=s7OLrgT3Hb1SEHf7u2EAaQBIPNtHDm3OKzcDeVOjTaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ql/H+8LDJ3xnl3J+8NYekjt+2nJRtrVFbDU4UEe+xBOXouaoaKKMk1kBSfe712pTlHwY4aP9R2vW2LEmszbILJrOZO69mkZ53E8lh/Fysd+WaAcly/AuGHe/e01XkXXbHTzVZgJnOK0I9Z47DK5dXAF9qeRzJzPo9qqS04kJwXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DKJ8HeZe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DKJ8HeZe"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490d1e54b3bso19533145e9.1
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2026 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781016815; x=1781621615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nXplWUKsBAvN+F09JwFUYoZH2ubeX/tac2JmmyitKSI=;
        b=DKJ8HeZe0UnszSn/9nliBijCuJW7MIDzGVNyhKXUimDVWYqHxJOPiNKRNRbWS0D/6t
         Y9EY6zU5fsregetIXVePHYyiRpqPHDP9sAs57jeEw5YnZOQ9sp3tLrw/mass0pJbnhSK
         kfduXMTv8aUcI4L/BMc525QYzCJJ+W+rwniw7fCTg/g786XTVTybauYfcQUelS5gQpwQ
         rVhoSr3KpJfkZrKYf8LBXKpZRGLS4vyWRkapyBaqqAjJOLAKQ1pVoiVYh4fOabq6FWoc
         KGOU2mwD+qly5zIYi0YATVD90GU/qwN0L8mX2jus0WugKbJo7nfTIeiaeXyPJxGR4RLc
         6t6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016815; x=1781621615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXplWUKsBAvN+F09JwFUYoZH2ubeX/tac2JmmyitKSI=;
        b=ApzPcVsRAMhF/f+TTizNwzSl4R9aC0qijJarMlAcB7WNwyZiHxOkvua9rsVYrfPGWF
         YAFkMmr9iPnPqSe0awqzuxH8E5oipHaQW5/m3kMpQr7/s2yhu1kSJzB1UIXhSHbkD/FG
         CaQlHqvCMG13Xt6tGehbnJ2o9Pk//85BTAqGgx3uVQV06bZgI4WSjWBj15dDGCKoecJv
         8etlT0xFJ9eWoDkTx88rfSvgHtqOcxUQA+2Le1nE+G7UN5t/DizrIzYWL2g8ofShT8/3
         7EKwjiaKilDOlK4KwwhRal+Aze5GixXfCTliRaPdKSJlp16Kc4kfFlQSQ1tnj0Pz9yrM
         axTg==
X-Forwarded-Encrypted: i=1; AFNElJ/TGWnf1kzGurCMCbLO2DIn3FLh3oPyISFGD9I5Twx8xEAauwCxy1gvsy/3FMY3igBrrkellFvF4pkWvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlvQpHTmF9G/xQ2KytGZXI+KortQqSadPur8tHwpesTf0U5Pyu
	Zq4WrG0daHFCOYwBvDAl5x8/gHjR2sv1lJAXfao0FTGUtjcaJcY87x9ccyYoMSZMeAM=
X-Gm-Gg: Acq92OFuQAdBE+eEj9yJvah4ZVX3yM8Z4lJlWd5wbtnNzbSHS1mlW2IIlvL1rVcCuYW
	Jov3kZNAw+bR6kO3R0HtdU0y49/PKJE3oVw1WzUlPQIZGLjaWR7TBOF2c5og4/fF2tRZZ8BMwWD
	QVIs+4/sOEKAQYbOAFjsKJAzlQi8/JkSlOnVjfgd9nyi+4201ewbh6H0KTCAJKkrpHZtNVau5Pr
	RNdkwyxTbqkPrvM1MLHK58lxopR9ZWjjctG/BhKVGTL7pAbbrX8a5xwtcti2xCE7tzBQhZJOMKA
	Quqo5/vGGPwXEkz3QDoi9m5/jqfNALdbKrfeOUmjhoKL64UT5rSchef80C0/KaVVzG1g4rYe5Uz
	5fmyMr7OIDDN051fwqinKDUorcGV9IE5Ws3XrQu35a+dhOS5xvx2VH7Wlh5xpvP3f4TnSEc5Egb
	/dMHpqMF9eYhAZxdcTQjqzBbTXtRjF+I3ZtvsXhYZ777E91XHyjPNcB35a3nAhIVI/rpagzOzq+
	e3+oXw7kQAq7F6ei/qsweQvQw==
X-Received: by 2002:a05:600c:3e0d:b0:490:4663:691b with SMTP id 5b1f17b1804b1-490c256049emr340215255e9.7.1781016815035;
        Tue, 09 Jun 2026 07:53:35 -0700 (PDT)
Received: from localhost (p200300f65f47db045b0dbdd314d8a71f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:5b0d:bdd3:14d8:a71f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f35fb24sm66790780f8f.34.2026.06.09.07.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:53:34 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Christoffer Sandberg <cs@tuxedo.de>,
	feng <alec.jiang@gmail.com>,
	gongqi <550230171hxy@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] Input: Drop unused assignments from pnp_device_id arrays
Date: Tue,  9 Jun 2026 16:53:25 +0200
Message-ID:  <f987c14dea1d3236d3889e5cf96c01eef6a2445d.1781016727.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5539; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=s7OLrgT3Hb1SEHf7u2EAaQBIPNtHDm3OKzcDeVOjTaE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqKCjm0s9BvWOtm7CW67zBrhzNXDDE4dz2kyNC4 pzufNQJCg+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaigo5gAKCRCPgPtYfRL+ TujZB/9GYxA/KpYSDyfOBVCIm03zHBu5PssaMaymELi3TzfVIKGU0cnWzRv8n/jJHV7fs0yLjRm hHBMceMXUhIKFVerVCVakE0B81AB6a5xpG8PnTOOfpxXKNKeDg0ZJbMReRDmM/Y+DZrY6daqlPc xrG43Y6/1hlXjcSvbJ0J3lhU/+MdX0jP1mYjTRryYUS8QHqE3pVMJs1HdSeAhhSinCrNZVSy1fY lSolGtXwleoGstgs05ud8XYJFLnRZkEyUYRsNjXQtMLHdMxMTJcSOK2oLBoCnAdFpkOsGX4Hvj5 /0V42b7j0w8vM3hLlKhPVeoE0N/jbxZ6a88YXkVgC3vInxZL
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Explicitly assigning .driver_data in drivers that don't use this member
is silly and a bit irritating. Drop these. Also simplify the list
terminator entry to be just empty to match what most other device_id
tables do.

There is no changed semantic, not even a change in the compiled result.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/input/gameport/ns558.c        | 46 +++++++++++-----------
 drivers/input/serio/i8042-acpipnpio.h | 56 +++++++++++++--------------
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
index fdece6ec1df3..f70a96c4f1fd 100644
--- a/drivers/input/gameport/ns558.c
+++ b/drivers/input/gameport/ns558.c
@@ -148,29 +148,29 @@ static int ns558_isa_probe(int io)
 #ifdef CONFIG_PNP
 
 static const struct pnp_device_id pnp_devids[] = {
-	{ .id = "@P@0001", .driver_data = 0 }, /* ALS 100 */
-	{ .id = "@P@0020", .driver_data = 0 }, /* ALS 200 */
-	{ .id = "@P@1001", .driver_data = 0 }, /* ALS 100+ */
-	{ .id = "@P@2001", .driver_data = 0 }, /* ALS 120 */
-	{ .id = "ASB16fd", .driver_data = 0 }, /* AdLib NSC16 */
-	{ .id = "AZT3001", .driver_data = 0 }, /* AZT1008 */
-	{ .id = "CDC0001", .driver_data = 0 }, /* Opl3-SAx */
-	{ .id = "CSC0001", .driver_data = 0 }, /* CS4232 */
-	{ .id = "CSC000f", .driver_data = 0 }, /* CS4236 */
-	{ .id = "CSC0101", .driver_data = 0 }, /* CS4327 */
-	{ .id = "CTL7001", .driver_data = 0 }, /* SB16 */
-	{ .id = "CTL7002", .driver_data = 0 }, /* AWE64 */
-	{ .id = "CTL7005", .driver_data = 0 }, /* Vibra16 */
-	{ .id = "ENS2020", .driver_data = 0 }, /* SoundscapeVIVO */
-	{ .id = "ESS0001", .driver_data = 0 }, /* ES1869 */
-	{ .id = "ESS0005", .driver_data = 0 }, /* ES1878 */
-	{ .id = "ESS6880", .driver_data = 0 }, /* ES688 */
-	{ .id = "IBM0012", .driver_data = 0 }, /* CS4232 */
-	{ .id = "OPT0001", .driver_data = 0 }, /* OPTi Audio16 */
-	{ .id = "YMH0006", .driver_data = 0 }, /* Opl3-SA */
-	{ .id = "YMH0022", .driver_data = 0 }, /* Opl3-SAx */
-	{ .id = "PNPb02f", .driver_data = 0 }, /* Generic */
-	{ .id = "", },
+	{ .id = "@P@0001" }, /* ALS 100 */
+	{ .id = "@P@0020" }, /* ALS 200 */
+	{ .id = "@P@1001" }, /* ALS 100+ */
+	{ .id = "@P@2001" }, /* ALS 120 */
+	{ .id = "ASB16fd" }, /* AdLib NSC16 */
+	{ .id = "AZT3001" }, /* AZT1008 */
+	{ .id = "CDC0001" }, /* Opl3-SAx */
+	{ .id = "CSC0001" }, /* CS4232 */
+	{ .id = "CSC000f" }, /* CS4236 */
+	{ .id = "CSC0101" }, /* CS4327 */
+	{ .id = "CTL7001" }, /* SB16 */
+	{ .id = "CTL7002" }, /* AWE64 */
+	{ .id = "CTL7005" }, /* Vibra16 */
+	{ .id = "ENS2020" }, /* SoundscapeVIVO */
+	{ .id = "ESS0001" }, /* ES1869 */
+	{ .id = "ESS0005" }, /* ES1878 */
+	{ .id = "ESS6880" }, /* ES688 */
+	{ .id = "IBM0012" }, /* CS4232 */
+	{ .id = "OPT0001" }, /* OPTi Audio16 */
+	{ .id = "YMH0006" }, /* Opl3-SA */
+	{ .id = "YMH0022" }, /* Opl3-SAx */
+	{ .id = "PNPb02f" }, /* Generic */
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pnp, pnp_devids);
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 8ebdf4fb9030..412f82d7a303 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1539,22 +1539,22 @@ static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *
 }
 
 static const struct pnp_device_id pnp_kbd_devids[] = {
-	{ .id = "PNP0300", .driver_data = 0 },
-	{ .id = "PNP0301", .driver_data = 0 },
-	{ .id = "PNP0302", .driver_data = 0 },
-	{ .id = "PNP0303", .driver_data = 0 },
-	{ .id = "PNP0304", .driver_data = 0 },
-	{ .id = "PNP0305", .driver_data = 0 },
-	{ .id = "PNP0306", .driver_data = 0 },
-	{ .id = "PNP0309", .driver_data = 0 },
-	{ .id = "PNP030a", .driver_data = 0 },
-	{ .id = "PNP030b", .driver_data = 0 },
-	{ .id = "PNP0320", .driver_data = 0 },
-	{ .id = "PNP0343", .driver_data = 0 },
-	{ .id = "PNP0344", .driver_data = 0 },
-	{ .id = "PNP0345", .driver_data = 0 },
-	{ .id = "CPQA0D7", .driver_data = 0 },
-	{ .id = "", },
+	{ .id = "PNP0300" },
+	{ .id = "PNP0301" },
+	{ .id = "PNP0302" },
+	{ .id = "PNP0303" },
+	{ .id = "PNP0304" },
+	{ .id = "PNP0305" },
+	{ .id = "PNP0306" },
+	{ .id = "PNP0309" },
+	{ .id = "PNP030a" },
+	{ .id = "PNP030b" },
+	{ .id = "PNP0320" },
+	{ .id = "PNP0343" },
+	{ .id = "PNP0344" },
+	{ .id = "PNP0345" },
+	{ .id = "CPQA0D7" },
+	{ }
 };
 MODULE_DEVICE_TABLE(pnp, pnp_kbd_devids);
 
@@ -1569,18 +1569,18 @@ static struct pnp_driver i8042_pnp_kbd_driver = {
 };
 
 static const struct pnp_device_id pnp_aux_devids[] = {
-	{ .id = "AUI0200", .driver_data = 0 },
-	{ .id = "FJC6000", .driver_data = 0 },
-	{ .id = "FJC6001", .driver_data = 0 },
-	{ .id = "PNP0f03", .driver_data = 0 },
-	{ .id = "PNP0f0b", .driver_data = 0 },
-	{ .id = "PNP0f0e", .driver_data = 0 },
-	{ .id = "PNP0f12", .driver_data = 0 },
-	{ .id = "PNP0f13", .driver_data = 0 },
-	{ .id = "PNP0f19", .driver_data = 0 },
-	{ .id = "PNP0f1c", .driver_data = 0 },
-	{ .id = "SYN0801", .driver_data = 0 },
-	{ .id = "", },
+	{ .id = "AUI0200" },
+	{ .id = "FJC6000" },
+	{ .id = "FJC6001" },
+	{ .id = "PNP0f03" },
+	{ .id = "PNP0f0b" },
+	{ .id = "PNP0f0e" },
+	{ .id = "PNP0f12" },
+	{ .id = "PNP0f13" },
+	{ .id = "PNP0f19" },
+	{ .id = "PNP0f1c" },
+	{ .id = "SYN0801" },
+	{ },
 };
 MODULE_DEVICE_TABLE(pnp, pnp_aux_devids);
 

base-commit: a87737435cfa134f9cdcc696ba3080759d04cf72
-- 
2.47.3


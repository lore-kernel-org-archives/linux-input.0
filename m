Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5F374A1E
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781383848; cv=none; b=Z2TbgtKm8OxdoRTaQj2UXQlGfKJ7bmk3Em3FQ0qKXDh6ktxYQyMwrBlHj4oeG4qLJuWoB43XJMmA5t3Fwg+ohzhZi3lMIQkE9qLURzHjkVf70JiwlrgvFV7j9FqQVMOFwDWIOwCI9QkkQja9vUDVzNzEmXK1q/5SbEJ6stj73sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781383848; c=relaxed/simple;
	bh=HjHmqDqv7eqPNg2I1vLm+fBIOmJIBtgT+I5PCvqxiEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mb6wzKl+dqqLZbYyPiWeIYT9PuorrjLkLp/2vdcsDVP/XE8fGgBnR729tgI5S88BS0qyk2gSqf/xlQhrXCMl0Y70LbLMGr2IPqrQRlSMTocbizuuRiTuxgeKvQipf701OWY9nYzj+0mtZiz1vYuR9a1OO6GHGqWJC3i0rVoCIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAbormM2; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAbormM2"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-137dd523634so2733121c88.1
        for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781383846; x=1781988646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qCtNva8ySuT59OfQ3Y5RAPKxbWe24nb3d1bxz3zGO8o=;
        b=IAbormM2URAKAHfg/CiMc+EJWX6pXFsz5pESAR/NbNTxLxd3SxewQqKXmKRTFsXBdf
         CL/yzmRCqvP6LwbtxkqTWIIvHkuVEb/xXul21bEF+zBKXipW4S9SSW0hG+bHzHYfca7G
         /gLPdwdczQ6uKzJ9XmwU+Jz72d87jS7GEFOVXznRaZe6gC4Z8tUb7k2JGZtMHf5gUJUD
         9W05c/g1AKJoHOKuMEC+Lxu88tCBzlDe3DkyaFA46aaLTumQXfww1Nm2LYf4bsaSTUgn
         KKKcHGbp+RBL10rlhpOqoY7LbpPDJFcwvvhiBzhxM/2rBBI/18KnF/TvTZsOvhd0vDn4
         l6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781383846; x=1781988646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCtNva8ySuT59OfQ3Y5RAPKxbWe24nb3d1bxz3zGO8o=;
        b=Nzfds7B5vQRfgdXReWGQNfXw60gq+OcVbs3kvYaAgPfgC6m/QoR9ZK1BDWkQibK2Yp
         fNTVWosl4E4orLzxVYsPa3uHMo3G9gPxgpZuW1pp5aumF90j9V/Qnh5aGqVUxaOdnDS5
         HfEznI/MvvtGJ9lZZDnb2zfEU5lz3+1pBjinTL954sOMhyB/6kmHPiGJHmwTuuz3wQFh
         L0T2TkVoeNKsKLNeZ2h0MYqYYqS39P6AYKaCAdZ2NIstoxXnbXI+k/66gddZ1+TdSOI7
         xHCh7pGkmA5Y/qcgSQcz5IHcybh9Kv+UENSMrxY9MYi3xodK8b9CHU8ai8gR6x/aSC5d
         JOvw==
X-Forwarded-Encrypted: i=1; AFNElJ9LsIvhUsrYtbBUYTqlylmZxMUI+8HKh4P/ljY5TnKnqedJk/JriM/UfpNnaZeJeF3fu7qZ0GrY2DAlIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfqulsPnTW6lH6M+uwMQW2sZa5UnT0c8/6vWDG326OLtdSQ/rZ
	D9AwYdj0m6ZyHxD4S9RuCamlpJr4Pkf/tFbh8DruL+KRDanp2DHsCWb1
X-Gm-Gg: Acq92OFexkc6X6T2J5a2CqGhoO/ZKinE+bZeW0RN0TstqJH9i80opzTZ3GpFWqcYeHs
	9TvxkQ3KOETgLSHhc6WsUfvgH0ZpOXia8gX1WO2bGvBS9bbBNprGvWrIkYkCDyT5UgFlNOoH4gs
	99Tnil0qqARE9EKhs63s/38A4mILxTnMjRwPYXhW19+f0XBFEEgIIk69xTL7D5kepxiu/HvxXT+
	C3NI8NTHVySE2YsWC1GQRpX53+DPTVpJmu2DVfMKhdj1pB715YRNEr4jMwVCy2jbYB3rtCWOdqq
	yJhAIsfKTY4ETlIjjNdj7sCAp8kIaeWQU+bsa5YqXhW2jM1HRUCQToPIc7h1A1xouCNkBuHe6FM
	MTbh+vzQECqTL0TuJv3HkcIaeXA94RRcj82c7YkbXS1e/A9usRErh/836qz7juqOUmffTs4o6cn
	zU89QF9iRo50IlPPCLQ5+XV2no48VAjiDjrub79QGAjx3DDq870ECJ0SsPx2MKLrpB5263twcw5
	L/DT4i2fmzzeveuPtTCXxaEPyvbpMGTbRBO32w9zvC8EC93gT9KDfQLhYCaPVe7qOUkGwifLbln
	/sF6eEF+Hm67ZYvckg==
X-Received: by 2002:a05:7022:b9f:b0:138:44ab:75e6 with SMTP id a92af1059eb24-1384bb69554mr3373718c88.17.1781383845686;
        Sat, 13 Jun 2026 13:50:45 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48c3dcsm9167084eec.1.2026.06.13.13.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 13:50:45 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH] Input: edt-ft5x06: correct CONFIG_DEBUG_FS macro name in comment
Date: Sat, 13 Jun 2026 13:50:39 -0700
Message-ID: <20260613205042.80181-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment in the edt-ft5x06 driver incorrectly refers to CONFIG_DEBUGFS
instead of CONFIG_DEBUG_FS. Correct it.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index d3b1177185a3..410be061965e 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -825,7 +825,7 @@ static void edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
 {
 }
 
-#endif /* CONFIG_DEBUGFS */
+#endif /* CONFIG_DEBUG_FS */
 
 static int edt_ft5x06_ts_identify(struct i2c_client *client,
 				  struct edt_ft5x06_ts_data *tsdata)
-- 
2.43.0


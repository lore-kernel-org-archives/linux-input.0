Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD9408617
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791707862; cv=none; b=C6mWDnEUNUP1vmVlD1CBK2cAMdB5iWlcq2RqDR1NT7Y7CzsKZDf3K3JCuWaNxT8OUx24YfFzi/A8Zlq0payVgUBX1znoGwTF6zbmAMDgzR87MRcMRmTNpwOF9ZMUEGWV4eyClfRBO4b/D6bESMowJZinUhgK3Ko1t0p/cj0Qb5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791707862; c=relaxed/simple;
	bh=gVUk1czZh1CYbiNnfJ8xcA04w6TsIEmL/PeCwQGc/hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7ZqfjBRgImrrswRGwhcdvHGp8/8yPG9zIWGeWurgXHLfaxzuPYJHDakNOM4HpkewNxFWrCg+6/7MH1/aQOSOVIUftUkNBJHeOOODI2oWUFyWA8WH1mPpbVY3Akt+yqSLw5GDic5A2AyE5WgZtzuAtswO8hMqWMxcPY3xa9CbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nlclf9A8; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nlclf9A8"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1517bda04a0so456370c88.0
        for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 01:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791707860; x=1792312660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mMGa5KwLb2lEr9yWq6m3Px2R7I7fTIcZLi1vTcYLg7Q=;
        b=Nlclf9A8ptolNHhwb4qThqp42+8xGZnoxQtcij8DS/herZLRX65GvdbPHzzKOv2Hht
         N19NHh5GhC3bt2C8os50V4XWtMUCjXOmXD2bLycTpXZ3/wP6AU8IG4hjt0Ir+5GfC7Bh
         nJms8mSacrkMeG/oY1O5vX8xqPP76Bl7rYO2/GxutuQk8kA8ZorEmivnX0LooITQAtW4
         yLodvmQoBVUjHxsPp4Ttk/1k2YcDunDROY1POV5pOkFv1TS8+GPnj3MvJDEpXNIN/s+W
         TssPwKxb9Dn5dTKNRLp7g+bGcPRgi1y8Za2rrM1MzsRiYWSKsuLwRXYoLE3cFSxCH+Rw
         u4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791707860; x=1792312660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mMGa5KwLb2lEr9yWq6m3Px2R7I7fTIcZLi1vTcYLg7Q=;
        b=pPNqstXZ13/JXcCc0/go+jbP/fq3vhCp3y/s1U6XT61+M2IvxsLMKp1d5gxJL1aZaW
         BRWGwkT0iaGHd6EuiCR/8QPUttKh6cmhhysYzP/qQMbhD4kv8ONUCkoobKCpP5brP34H
         Rnp9HSuk6I2qxL6dN8baX1QndDriuVhw5MF+Um0J110c9YzS7d8EV9lwtmKmyFjzS+gR
         sNBrQpL7BcEvNnWbPJVlNeCTo0Z4KdWM8KLXA0Mb7y2M/DAXI0HdTDIWUe8Ws4XC/f/5
         /FVADbOToXW2o2107/N/TzbtJlJ92Uap9izbgPOX4Dt2ZoptZ3rtutD2bMZMemN8FUWk
         EuJg==
X-Forwarded-Encrypted: i=1; AKwUvBxdSaK7BKSqboW8T4t5erkSq+ShLGlezfARCjPlQkjxnKIVHISVdPgeMCpAWXobgU2RjCzgrJ6gRF6k3Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKB8T6xk3clVCQwJsVHTweEmqLbV5V8bXgKlc04kgRxkdh3TprT
	dBZbscp6LleV6d+gt2vrkuE5vrFTFPnqhzF5Y5nQVbw26V3nRLUyqw4T
X-Gm-Gg: AYBFou3ik3vHp+15QTITyBG6k9TDsgUbFNxD+YK+TYK9oR0Awg4Id55YNre6GHZQ8xm
	OdSpWP1yj2OBkiMmM3qgm3HWbsItdqrvO3eUnsRX2N3l2fb+OVExf9q3t2abgfMlsGvPMvjW7mc
	yj7l8M1qTEhnrxHC5lhD8H8ss2EKlV8eSVahdtKVfZdqinPpis11X1GgeZ6155V4rA6OPMC/Bzp
	ICIfggpcAUJTRAolgMeeNVvJM4Rgrp06tS8IjPWL1Eb1UJ67Am/j5HKd5ydfWxvLegO0nSK+kET
	0t1QBF3ajIRwrAdBmCE+v/ToAEqqcyhSYeF7WD152wcFxC3FlrrJfHYziIqefnQp7lb5ujpSLnT
	q4rO/XK/gMfdhC0hLcBxVrkrF5Wi/fXz50D/qYtBGpT8yJqUyNlf7w0c3T6uP1OtMQU0a/N7ueR
	G9sdS59AHY7DplRL7ycUdAIsFOcp2UvQADYBxxNr47QbqIf6vk+MwTjEbBRwh0MPwJUos3RC/3o
	zuq1ERFy9NFtrTWIPuhTS8RioZTgReLr6+WLTdLZAnrP17kX9f2vSWwX+gAt+2AelLkI+BkPeRd
	0dOA2w==
X-Received: by 2002:a05:7022:296:20b0:159:aa67:2893 with SMTP id a92af1059eb24-16a5d642d08mr7696058c88.30.1791707859923;
        Sun, 11 Oct 2026 01:37:39 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a42407e7sm20186473c88.15.2026.10.11.01.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 01:37:39 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 1/2] Input: synaptics-rmi4 - reject functions with more than 6 interrupt sources
Date: Sun, 11 Oct 2026 16:37:27 +0800
Message-ID: <20261011083730.223083-2-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011083730.223083-1-98lawweijie@gmail.com>
References: <20261011083730.223083-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt source count in a PDT entry is a 3-bit field, but the RMI4
specification only uses values 0-6 as a count; 7 is reserved to mean
"more than 6 interrupt sources", which the driver does not support.  The
driver takes the value as is, and a function claiming 7 sources makes
rmi_create_function_irq() and rmi_unregister_function() access
fn->irq[6], one past the end of the array, clobbering fn->irq_pos:

  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:183:10
  index 6 is out of range for type 'int [6]'

Reject such entries in rmi_scan_pdt_page().  The check has to come after
the RMI4_END_OF_PDT() test: an unpopulated entry reads as 0xff, which
also decodes to 7 interrupt sources, and must still terminate the scan.

Fixes: 24d28e4f1271 ("Input: synaptics-rmi4 - convert irq distribution to irq_domain")
Cc: stable@vger.kernel.org
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Assisted-by: LLM
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5d49a9021c7d..443ba4106352 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -526,6 +526,19 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
 		if (RMI4_END_OF_PDT(pdt_entry.function_number))
 			break;
 
+		/*
+		 * A count of 7 means "more than 6 interrupt sources", which is
+		 * not supported.  Checked after RMI4_END_OF_PDT() because an
+		 * unpopulated (0xff) entry also decodes to 7.
+		 */
+		if (pdt_entry.interrupt_source_count > RMI_FN_MAX_IRQS) {
+			dev_err(&rmi_dev->dev,
+				"F%02X: invalid interrupt source count %u\n",
+				pdt_entry.function_number,
+				pdt_entry.interrupt_source_count);
+			return -EINVAL;
+		}
+
 		retval = callback(rmi_dev, ctx, &pdt_entry);
 		if (retval != RMI_SCAN_CONTINUE)
 			return retval;
-- 
2.43.0


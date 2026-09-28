Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C74EBAED
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612798; cv=none; b=KYnyOjJPGK+0beEajBmNp3tJYL7IAATmSQUh2vgFUjTUaMsL1SoEq8XNNmp69JcRTTug4hFSP/rrOm/tD5KPCxYLN6tVitSbtK6+jRa+a2au/tp0+jorqOUZTx3X37jjeeu9zJ2ol3OPIxmM/hJwQDihN8f5dPuo7gGkcuyiD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612798; c=relaxed/simple;
	bh=5qMEBYIqzSpO8j+a8K61dlz/uaJGGIy0JV+7Qm1pdBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5wnZdedXWJyVCdWH2pDDOL7Hj4fkrVQTXHC8TV6ILbYf0C2icRtalfTEobGV0TIn07T8eMIfBMyyY4ih7eSAewwA101p+hR2YlgQuK3FsfLeFUrpZcynJea66k6+vnY1DZJKpqEdNESfO49VcxlEjpEgetxGSg7T8EpaIjtF9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WskxdnTU; arc=none smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WskxdnTU"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aae7b7fe22so5556138a12.2
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612794; x=1791217594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NrGBtoUEdw4iEkbuZg8N5yagEcFZ+faHEQSH2lP9JTc=;
        b=WskxdnTUSXPrMeGNZEJs/lt1ZnT10wyPxn6Z0Og1hXpeLfuaXmYgtQ55vtSnQq+W9I
         3CFof7iT7Ui/Ptamsi+kgBQFmC40N18CdpR9/ImxkbK3FQzJf3r9oBKthdT8j+bEp7u7
         2spmJY7+OQqKBSbCT45rJrVoBXslvUCNxDr0B0lU0lezKP1i46F7t0/rs23PL218AOgT
         E5SMU5pg8Jv5Z6T1Y79bTgTxhX9ffPGUMNr0xONHoPndlmZWm2vu1x6/z8Dm8QvuCGkl
         ikO8T2mJGgQmZugYKxRlH3wQo4z2oBlKIm6EZl9OdVkh6XAlc9Iivc2KxCIgOZ++HLft
         9k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612794; x=1791217594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NrGBtoUEdw4iEkbuZg8N5yagEcFZ+faHEQSH2lP9JTc=;
        b=KgV0Xz0ns9DFX7ElprUlAh14xp0y3k9xVotmwmA7IptycNV7KIANxSCBu2IvGRroGE
         c9jlRAxgfXSJtOOYvSobkoMY7p4qb1+U+fPz9BVum8SZljfYt0IsscvTHLd30sPG6o6N
         ibclxHRfrSuc8JWfgRJOvlC0EXiDljqGA2IhxTM751OraBfQBOMDYL52PtwlxCPFHkie
         OEhuYl1rmj2j2zS25bvmm/8KwqbuwURcxHoYnX9va+mFW5C6+ebusXiU7/9IzYxSdlDs
         7fwd7qhtHtXhm5hET/lQNcvK3oJOMBEoImoPNC1d+89NWDJC+/k64qDkS1TkTTQDnDlE
         oWiA==
X-Forwarded-Encrypted: i=1; AKwUvByLpp9c7SY0r6U6vo1425WuVQ84aZF/f2HHavb87WqRssnKXrMOQMyx5Qvf41xVUb58Lz1FCCwySjLd7g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIkJkMDRyjBix8F/2/v2rvRv+xMFIBNsTJIMy26z3TY369kOZ5O
	Kll5WYnN+fEvl0uelZ+2U6snE2CZ7+t2hCApQ/dTCZv4CKfeMHx0xWYf
X-Gm-Gg: AYBFou2qTW8O8/lVEs8C/PqkDV6CbgQ3kHsyRT3QCQCDJxzfuY+ddcB5fi4BuPWsU2E
	A0BzipBsQk0qjkn6ISu+TfdUkL1ppejtegf4CGplhvA+1vwn+WqD4ERiExdSwTH0fwOZHIG5xN6
	YRoM2tfpjysnlWWzQ9kyUJBWNF1RQBl6QkGyaewhY+HDnMMydhgWfOTQJKqp749knltSG3R7gpX
	OGkK4onvEpd5dwNIIGCs+h+mrxP7InTWzvm7j3LdlUyDAemKOTyIuPlLLGAV/LIsYoz5Wo3nSkV
	icid/R93EFv6UYCnfK3nadCjqbbw3EiTlu54gJbplGVPBirglQF6ETJr28tJjhEICiX17IOgtZN
	9D1S6OWBU8IHMVPs2wKcTDxhCR8o4oUBH+UvbdIGKai7QQeBCMD9WNvHc9LmpBay5Lrvjdk+C5p
	vnduAGum/d3aWs9PDl8kBzhxfVw/dnzvQd/c0mgrTu85YBhNM1Sy8Nmd730muJqcuHsQAs+3k66
	n6/rk1V3eR5goVrgu6V5I8cFN4z7eWGAtR8IOM6A5gE/PiTjjzI3cO/FlRhDdCOWOtUgwsMMip+
	gU6rxqzpGyg=
X-Received: by 2002:a05:6402:5405:b0:6aa:a7c9:8c16 with SMTP id 4fb4d7f45d1cf-6aae8f4dfe7mr8167788a12.35.1790612794366;
        Mon, 28 Sep 2026 09:26:34 -0700 (PDT)
Received: from localhost.localdomain (84-216-182-59.customers.ownit.se. [84.216.182.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5cb9a72sm4277474a12.7.2026.09.28.09.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:26:34 -0700 (PDT)
From: Pooyan Azad <pooyan.azadparvar@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	Herlangga Maulani <w1zardsec@proton.me>,
	Rob Herring <robh@kernel.org>,
	Jeffrey Lin <jeffrey.lin@rad-ic.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] Input: raydium_i2c_ts - validate report parameters
Date: Mon, 28 Sep 2026 18:26:16 +0200
Message-ID: <26ac42dd18a98c4928cbe7f6b6adb4b396be4c8e.1790612085.git.pooyan.azadparvar@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790612085.git.pooyan.azadparvar@gmail.com>
References: <cover.1790612085.git.pooyan.azadparvar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The controller supplies packet and per-contact sizes used to allocate and
parse touch reports. The driver trusts these values without validation.

A packet size smaller than the two-byte checksum makes report_size wrap,
allowing the IRQ handler to read beyond the report buffer. A zero or
undersized contact size can cause a divide by zero or make the contact
parser read beyond a record.

Validate both sizes before publishing them, and reject reports that
describe more contacts than the input device has slots. Return main
firmware query errors from initialization as well; otherwise rejecting
invalid parameters would not stop probe or firmware update.

Fixes: 48a2b783483b ("Input: add Raydium I2C touchscreen driver")
Link: https://lore.kernel.org/r/20260728135127.48971-1-meatuni001@gmail.com/
Link: https://lore.kernel.org/r/20260927114425.442803-1-pooyan.azadparvar@gmail.com/
Cc: stable@vger.kernel.org
Reviewed-by: Muhammad Bilal <meatuni001@gmail.com>
Signed-off-by: Pooyan Azad <pooyan.azadparvar@gmail.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 23 ++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 0256055abcef..03ea0ae62999 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -64,6 +64,7 @@
 #define RM_CONTACT_PRESSURE_POS	5
 #define RM_CONTACT_WIDTH_X_POS	6
 #define RM_CONTACT_WIDTH_Y_POS	7
+#define RM_MIN_CONTACT_SIZE	(RM_CONTACT_WIDTH_Y_POS + 1)
 
 /* Bootloader relative info */
 #define RM_BL_WRT_CMD_SIZE	3	/* bl flash wrt cmd size */
@@ -332,6 +333,7 @@ static int raydium_i2c_query_ts_info(struct raydium_data *ts)
 	struct i2c_client *client = ts->client;
 	struct raydium_data_info data_info;
 	__le32 query_bank_addr;
+	u8 report_size;
 
 	int error, retry_cnt;
 
@@ -341,6 +343,23 @@ static int raydium_i2c_query_ts_info(struct raydium_data *ts)
 		if (error)
 			continue;
 
+		if (data_info.pkg_size < RM_PACKET_CRC_SIZE) {
+			dev_err(&client->dev,
+				"invalid report sizes: packet=%u contact=%u\n",
+				data_info.pkg_size, data_info.tp_info_size);
+			return -EINVAL;
+		}
+
+		report_size = data_info.pkg_size - RM_PACKET_CRC_SIZE;
+		if (data_info.tp_info_size < RM_MIN_CONTACT_SIZE ||
+		    data_info.tp_info_size > report_size ||
+		    report_size / data_info.tp_info_size > RM_MAX_TOUCH_NUM) {
+			dev_err(&client->dev,
+				"invalid report sizes: packet=%u contact=%u\n",
+				data_info.pkg_size, data_info.tp_info_size);
+			return -EINVAL;
+		}
+
 		/*
 		 * Warn user if we already allocated memory for reports and
 		 * then the size changed (due to firmware update?) and keep
@@ -352,7 +371,7 @@ static int raydium_i2c_query_ts_info(struct raydium_data *ts)
 				 ts->pkg_size, data_info.pkg_size);
 		} else {
 			ts->pkg_size = data_info.pkg_size;
-			ts->report_size = ts->pkg_size - RM_PACKET_CRC_SIZE;
+			ts->report_size = report_size;
 		}
 
 		ts->contact_size = data_info.tp_info_size;
@@ -428,7 +447,7 @@ static int raydium_i2c_initialize(struct raydium_data *ts)
 	if (ts->boot_mode == RAYDIUM_TS_BLDR)
 		raydium_i2c_query_ts_bootloader_info(ts);
 	else
-		raydium_i2c_query_ts_info(ts);
+		error = raydium_i2c_query_ts_info(ts);
 
 	return error;
 }
-- 
2.43.0


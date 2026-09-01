Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4CD37AA91
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244595; cv=none; b=HMSdp+BCttzoAncpkt40POmJ/8aqygz2WHeKscEKSc4uXNn0OorMnltMHR7F4+2+4/59NqdO6pKVBvWVLItoKYKnrqaAQV95430CdNcnAJhfPtLuDkwsQ8L4gdiv1vhzqY/o89EDY7mJKb81thR/fddufFGa1zR96BkBWyzZ68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244595; c=relaxed/simple;
	bh=jp1mxh4u0k5EkhsGC+WkntxjcMOROSMx+LhpJ5PkGTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVLJ9T2lp8LzWFKEH/OZ3BRa3/dKnB9Q4E4TKq873dKIy0sYnwoKBIvokS5rFDNX4vssrOqeThSLWou5A/620WiETQfNqwOC4gZPZxYp58oYzNOav/5cRcSwa1VJfyQdvOcdqF4P4LnHOAFxeEfRolNTupzOFWAxl6EScDtK/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrRM9oaO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrRM9oaO"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-39927410578so213161a91.1
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 23:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788244592; x=1788849392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=daPhvcx3JqOGViV9zMVaZQKBED8orEBgOrh4gs4v0qM=;
        b=PrRM9oaOD5oibbwf4boNBo6qcrkcXXq4jFqPpvjpgz1wZDdRmVru618TzQffasaUxb
         eaSuap16qutCl6uY7AalIBEQ8uypSfm8XluG6jsBsdyvBasPwX4Mfnyic/F0y2a2yesT
         vpnHeDEvMRfe+PIVtwtWTAwnFhMjWQ2KvOvoeianbltbMA7ux/Fh25hecUltdHWJzr4J
         AzwUjp3T+auuaHjxlFLZo0mHS1NJMkh0Nm8yzgCJkkjCQ9WMaiAFLETlE3ABi54Lq3q+
         QOWhSsZPQwqaHqkwkUpLuCDdiXbcQEz5zai9t4d3uUslHOZ/rRNwvZZhViuj2LqHzXlM
         7PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788244592; x=1788849392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=daPhvcx3JqOGViV9zMVaZQKBED8orEBgOrh4gs4v0qM=;
        b=cX0TeyNAklCF/7JXatqxZ7ZRb5bcbQEZspbCkPon170lU6E1yndj2EC5OFsA1idSnZ
         tbSLnmk277ktg7Nu9CQImEJxkI8LeNfGr7ySTciSN2BPTe8RdbOur7BzApuoYcGQiP5A
         2ztjZAhEeusIRay+qIWBvGZoPvZl8yCo1Pbg/dcwldqjPKD8EL/UPQ/fe5Kkt5DRrcRm
         3WuDgHMdgBvDOfLTiPUjGl1yziMllNt40nt+cRxasvKco+MrXWZu8fgxWJyCc0miQ/km
         RnaTrwxM1hzaxiichYt5YdyksurgP7pPa1TRgtkl3TtCCUrsppE/H7nzw8RCsLL/8R5j
         fEsA==
X-Gm-Message-State: AFuF++ncpwKwTzzmNNIAszNWsOuafofx/ZVw1a0uR4HG+bznPsSt+lWA
	YDf5w8iYwB56JL5WKc2Azvo98hcSvbkaMaJao9I62yxr1b7EN3RYIk93
X-Gm-Gg: AYBFou24OXY2IL9cRHPuMqIp5B9hpkLXqVVA9GVEOTv1CO1tX5KaoVHnEU+aTIJnxP7
	bs1YthIeKQ7MIy0UsAXhKn2Npc3haJRMKHmZS5dEaQBoeSNYNlnx2BhLgM82VAyTqJd/qFoC+Go
	wSZDER8Feusq7Aos/gWHaYDVrVtCxg9KbtOkBk7xpYkNCv/FjfMMtTSyGP63Upz4wsJ3V8qCpZM
	O7b2r20LYGHrIeVOG5UuWJOUD5uWu3In0RirmrBY2YExM8Hv0HAxB4mhzODiHCv5YLD0QEdiIlC
	wGplm0qjUiwYXx5qZF8cIH9vYc7Il71lwJRqhWtTlEZL8F5J5iti4rwPuMQgSz4oNIP/y0VvPEs
	y3+JL0fMmn4859lUmHw+aBh+ptQIXqPuUHNl/tUWqmXVbg8ywMghzE9v9ut/Gwy5LlHmbXbuDGy
	eew/Bw1GsfVxPfqMWwiPwmbycfN6kXD5opSMSUNmzYL+1A/rhQTCYitGjBekbRYUZUiDSCWCZsq
	Js9JCObDCMi4g==
X-Received: by 2002:a17:90b:2e48:b0:398:e969:87ef with SMTP id 98e67ed59e1d1-39907ec6baamr9076075a91.24.1788244592502;
        Mon, 31 Aug 2026 23:36:32 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.192])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0dc854dsm32694425c88.10.2026.08.31.23.36.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 23:36:31 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] HID: hid-lenovo-go: normalize calibration failure status
Date: Tue,  1 Sep 2026 12:06:06 +0530
Message-ID: <49b6e07395d2fe555e844758bd8ccf34ac0cbf0c.1788222001.git.mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788222001.git.mradityadash@gmail.com>
References: <cover.1788222001.git.mradityadash@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver stores the firmware result byte as an index into the
calibration status text. A Legion Go 1 returned 0x08 after an idle Stop.
The status table has only three entries, so a later read returns -EINVAL.

Keep the defined values 0x00 through 0x02. Treat larger result values as
failure before storing them.

Fixes: 995887a10da1 ("HID: hid-lenovo-go: Add Calibration Settings")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index deed7acd2dc4..59b457683357 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -648,17 +648,22 @@ static int hid_go_light_event(struct command_report *cmd_rep)
 
 static int hid_go_device_status_event(struct command_report *cmd_rep)
 {
+	u8 status = cmd_rep->data[1];
+
+	if (status > CAL_STAT_FAILURE)
+		status = CAL_STAT_FAILURE;
+
 	switch (cmd_rep->device_type) {
 	case LEFT_CONTROLLER:
 		switch (cmd_rep->data[0]) {
 		case CALDEV_GYROSCOPE:
-			drvdata.gp_left_gyro_cal_status = cmd_rep->data[1];
+			drvdata.gp_left_gyro_cal_status = status;
 			return 0;
 		case CALDEV_JOYSTICK:
-			drvdata.gp_left_joy_cal_status = cmd_rep->data[1];
+			drvdata.gp_left_joy_cal_status = status;
 			return 0;
 		case CALDEV_TRIGGER:
-			drvdata.gp_left_trigg_cal_status = cmd_rep->data[1];
+			drvdata.gp_left_trigg_cal_status = status;
 			return 0;
 		default:
 			return -EINVAL;
@@ -667,13 +672,13 @@ static int hid_go_device_status_event(struct command_report *cmd_rep)
 	case RIGHT_CONTROLLER:
 		switch (cmd_rep->data[0]) {
 		case CALDEV_GYROSCOPE:
-			drvdata.gp_right_gyro_cal_status = cmd_rep->data[1];
+			drvdata.gp_right_gyro_cal_status = status;
 			return 0;
 		case CALDEV_JOYSTICK:
-			drvdata.gp_right_joy_cal_status = cmd_rep->data[1];
+			drvdata.gp_right_joy_cal_status = status;
 			return 0;
 		case CALDEV_TRIGGER:
-			drvdata.gp_right_trigg_cal_status = cmd_rep->data[1];
+			drvdata.gp_right_trigg_cal_status = status;
 			return 0;
 		default:
 			return -EINVAL;
-- 
2.55.0


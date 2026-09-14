Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB18379ED2
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426392; cv=none; b=p7y5iY1I7dxJ5Tbv7kdrd6gilyj0M/IkBrgTzAGZgtFELQpnqXmx+yAHTsRrYmuW9Z7GuWCqiD0O+2CSceRdEBnDfbwhZLeJwdS/9piLd9dvTdm+ADAWyl/1Xm7pjAaewzEG42NMSCyhOdc7Id+/Y2f7mHRY7ktCtNO/6U0brYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426392; c=relaxed/simple;
	bh=B5NcsJqiM6ca6zoKCCSiRnmiGiK51EUO/f+42QeBqzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNKsjMWR+Ap+VsSXwOog+WAF0TOH+2wZSJ17UeW+cm4uGuvZ6AmdNij6/5OussXJyNrY2+iLg5IQG7yRUh6JU0Vwzk03ARMcBWO9GQ9ADPrkY4Z4f//uENmtfn9ysJ8xM18Nrxi1dZxek5f9n9fyAdXKmi9upIjl6FxyrfyMtg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPRZmjAZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPRZmjAZ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-853e2610bb4so257436b3a.0
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 15:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426390; x=1790031190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cket7DPZv1j5YnyOIveBa4NpPNYaScJjvnuFzxjWh88=;
        b=fPRZmjAZsPsmNpwQY3WlqF6D4LWwNE4X1Z3K4VbTZwv/KOC1Gh2wqMK9IE8jVWZTaV
         izthCVBd9+kVlO+nuylxmOYUxuZkWX//HIAs/pJpXAXHXy6VnuGJ1MM8i4g+tzrelmv0
         2natDsx+Dl2kL8YdNhVmxvGVt8uSHFIgDVT3OPKT2iO15alDvYNhPZSoInE0vG+66V0m
         lBCIChItBTP4CzfG4mBO87o/3H85VHNjXxkxTnBtpPy1mhxOp1c1hZIzXaC7ACKQGRZt
         aurg6TgmvfDG7U7z/a5C6Z4qCHCBtbmicep1LOXimuaoCyO9MAoPvFKkNYvhEQO9I9tR
         rcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426390; x=1790031190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cket7DPZv1j5YnyOIveBa4NpPNYaScJjvnuFzxjWh88=;
        b=abnRaud661ZgDz6STENE3XEPkTjTPRHxchme0xDWFLS55cif26O18AufEEkjp3YGoe
         bUSnR9t1x3mKEni0FnQuSqQgJGrNczMQvmlcOnQizDyPvVASV2ozr3hFsJ6HMe9VpFa5
         SIwsLETMJSMwX+2ITLQIxYsxCKYiIKKhwbLKpvwjA8jgBeQdd2Bblntf5m9gdbfCkSh1
         Ag4RluE0vW6H8HC3VZGmryGbGAAKRZIzrxRf64sv1zZsIaHkj/FQggPGWAIb/wunn6Q3
         RWEdFFsz5DvmVCaRP4gE0kzoYSsG9ACqf+bONu7zto0fYiFt2eS4D0XSK5oF0JUbNZlr
         F8lw==
X-Forwarded-Encrypted: i=1; AKwUvBwJjBIcrRAR/2sfpO+dKBtEIjFRbX+YxhGAvGhRr0rfwSqWQslJh4aIb+O9BHhZxcodETi9z6Njy3PvVg==@vger.kernel.org
X-Gm-Message-State: AFuF++kuVQcP3OPJCrvhWGljJ+PantiewOpAB1eWtd4VxBZ0aaV/UwhB
	YE7jbpiDgnPWpt7mvaC7y4QrIXQeZsVkX4Z92EVKQ3qsR5mUFz7q6H/a
X-Gm-Gg: AYBFou0XCnUEuYyBmCAOSPR9kgpshFeG1qpffXTkNTRhIRge5dFw5EnOFWmV4hdTlIF
	oxxsi5x9prhXEHPUGPeINtveeSgqC8/Lqcjq2iaf8QoCsDFNgKygfweFaklQqi5XaQH/sDLWEQI
	27bCS++y/jvP/W6TCx+F7I2u6dpEjRB09vAn9kKx7S+fJpM1i5/S26kcXtIDUt5jqnWA+80bI4O
	Co3Q9dalAEqWRmmesgBKcWnXwKfm4msmZkoiSt1O37vvxldTqoTsRhqCq9gxE0ba0TNW47+3rpC
	Z/6Byp7acoo6vGovrsqWluAEy/iWyjKNvJHqUFlUvefBk56zM9YljCMizl0/CTCOu1DOlzYb5Ey
	MoDwpbZuBVVwNqPJCP06ZXeeprdL6PXEkNn8ALEO1CbKmetMSUO/lLAdBJHfQTghUOB53uFYBQw
	0CZyYNEHEggOO9cuO5mIph1vcs9mdNFI+rttOn4gi5rDyEK63TrrS0oooqAz/CpWHqEPaBjMXi7
	ShfkzufoLCXaXQTcZc7N0iu/WieXDlq5i4gLGbLLp1mAIvdNNyv
X-Received: by 2002:a05:6a20:4310:b0:3d3:aed2:6f20 with SMTP id adf61e73a8af0-3db50019fa8mr1791026637.20.1789426389991;
        Mon, 14 Sep 2026 15:53:09 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm14924296eec.27.2026.09.14.15.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:53:09 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH 01/10] HID: hid-lenovo-go-s: Return ret instead of 0 in mcu_property_out()
Date: Mon, 14 Sep 2026 15:52:54 -0700
Message-ID: <20260914225303.868569-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914225303.868569-1-derekjohn.clark@gmail.com>
References: <20260914225303.868569-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mcu_property_out() blanket returns 0, discarding the ret
value and any errors with it. Wait completion returns a positive value
when it is not timed out, which would error on all successes, so if it
is positive return the ret value from the raw event handler. Only if
it is 0 set it to -EBUSY, otherwise pass the actual error.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index a72f7f748cb5..68301d4c762a 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -38,6 +38,7 @@ static struct hid_gos_cfg {
 	struct led_classdev *led_cdev;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
+	int cmd_status;
 	u8 gp_auto_sleep_time;
 	u8 gp_dpad_mode;
 	u8 gp_mode;
@@ -435,7 +436,9 @@ static int hid_gos_raw_event(struct hid_device *hdev, struct hid_report *report,
 	dev_dbg(&hdev->dev, "Rx data as raw input report: [%*ph]\n",
 		GO_S_PACKET_SIZE, data);
 
+	drvdata.cmd_status = ret;
 	complete(&drvdata.send_cmd_complete);
+
 	return ret;
 }
 
@@ -474,12 +477,10 @@ static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
 	timeout = (command == GET_PL_TEST) ? 200 : 5;
 	ret = wait_for_completion_interruptible_timeout(&drvdata.send_cmd_complete,
 							msecs_to_jiffies(timeout));
-
-	if (ret == 0) /* timeout occurred */
-		ret = -EBUSY;
+	ret = ret > 0 ? drvdata.cmd_status : ret ?: -EBUSY;
 
 	reinit_completion(&drvdata.send_cmd_complete);
-	return 0;
+	return ret;
 }
 
 static ssize_t gamepad_property_store(struct device *dev,
-- 
2.55.0


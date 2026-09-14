Received: from mail-pz2-f35.google.com (mail-pz2-f35.google.com [74.125.228.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642BC3CFF44
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426392; cv=none; b=LfcwlgBV3D0iKxDuU0yqUKIJYa7o34YlcL2Hv3bjg43mJaxKmLCrzZjrDmksNs53Y+uf4l0MTk9kU0qVRt3VcW4/McOjXRU2iOjLMS1JK+VTYonUV7v2IQKe0tNPXbsy/oYI7kS96gm8FuTMvRJgnGSCsNO2FnzyRV1HSm5Jpv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426392; c=relaxed/simple;
	bh=sQJ/u2rNyU4WncAchMkJyd33mci0D0EaX8SmWcggEZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu38Uai1EBuxZnZaR4Nc9Y/4T8SX7viq/AlmCH+4cl2JSgL9wSHKLfeIejmplYRMvqBw9i2/WEh3pWO6yyIoGilmZ5LT5+DP9ZeDwpwn9cRpbDbBXPRAtUsul1gAh0NjrSDtoVR8Pz/Wjo007BvCVq5uTD1SXCWS8lAGvOdtYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qt+vZ2ap; arc=none smtp.client-ip=74.125.228.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qt+vZ2ap"
Received: by mail-pz2-f35.google.com with SMTP id 41be03b00d2f7-cc4bdf8abdfso1921122a12.1
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 15:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426391; x=1790031191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8UwDJJPT/BxnAm3lVbun062kxESY5uvQ+2QAo4pBXeo=;
        b=qt+vZ2apH6fkvr4RlVP9L2UE0yV9X4g8qRG+Ox8I4T5WkYLisWJAq1rbUBEI76h8db
         /DbbNVHlFzKmOwl7/9E9yEt9HZMqBWWRVT2kbdbpoPi67SM1Xx/ZB+QIHbmcYUh/L2Y6
         ezQ2ImBfYByerusbSz6kUEXsUKk/4IxFr8j4MoTYMhSyLvFhH/D5CW1EoY8fw/5Iu8Uy
         MPuLxzpVEV+WdGl07W0EvQmVtRxNFDYFBmyfUFWzPfaDkpAbuAIe+xUjwD4ZMXtWa5ZE
         mioU3rDi50xGe8mNhfAPefbk1lMZ02koX+IcpvsynjU5k1xUjxjOif1anZvMhljpEs5X
         J4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426391; x=1790031191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8UwDJJPT/BxnAm3lVbun062kxESY5uvQ+2QAo4pBXeo=;
        b=JMmJwmuKsEIdT7IdEOuWEuaibv6AZkYG41EcDekFPr4/4Bx2FrU9X1ruhCXvjUH8sc
         GZWf6EnVCKX4TerV/eyoPz341ORiyJPGFYTzzbHVy9xaX6XQj+zUFBJ2SRMkDR9Y5TXe
         AxfBoYt6zfzcbFidyptPM3yNKvKiiCc3IECW+wG8JbablG2T74dWRN1yxuSXDPjXZ1vy
         3eLb8kkbWDx2qWnqhEujhpM+UOGv9zxs2/ut/8thNi+M+beoEjNyVg+XNdRMXMnLoL7W
         byMZnZNdKDQ8ed7+CrgTO+ozkRtlA3RATyJyJB1WEprOMKl2SaQegfObEajRFOvKJCcd
         nU/w==
X-Forwarded-Encrypted: i=1; AKwUvBwBJOMVLmUAyUMz3ziZACAUUgLP0euQaSYfiud/7EBokF7/tK51QEYqXBLnoHdS/OfiQjemJdXMydX++w==@vger.kernel.org
X-Gm-Message-State: AFuF++ltkHYa36R5ayL+C682fcBkLx00MPJOzhmRBvC4mTsyTe3G+d1b
	xYShJjftTtpzaonBRrpbzNG9A3zG/Pvimm/YZIUnNqhe1ttfDyRyI5UZ
X-Gm-Gg: AYBFou2msGIAtkyJgidkEvzjysFlcBDSamqDIvgb1gTnH8Y0Sx2IvJUIP/JSKmBPO5+
	DBOqVvOjvS83LbCkq6vMBF7oWypHKP4z+M9M7rogoW4kZ6EGLcFUuxWpyufJVCF6YIN9SDebUBb
	W+piTStRJtwpDsemjApLGaY+/Sp43taKZHSTLBMaXZ8U/t/o+uoY9lVzbeqBRM+6u4QwIe84A1G
	f/5wSrJeB0E2OY1euqPbIbaqMk4aLpVqwsU4LeCBK4wz6qT2kupiDHNqFkWi4WWHWAMf85rkqgs
	DLvGOomH71FXDIgS1ENvjcxZdkYR1NH9om3ikz/QE8Jk5yio/hGovohhRjsXDebgZEHSJUYk8tT
	WEmlCg5AXQPiKA7++0l0c4hmgWgGaXHsUq+JfKswHcHvtaoi79Ktq/LWMm8AQeJKCuiSk1clPVo
	Z8Q1W9dEqBimKMjSVLY1XXfcgEUIUj5Niprl/Uhr4O8F0hgyd18XUXaGz+im+OkUzapG3R69C9N
	6h0XR9SC6wlKc9weZMx93tWlkuk4t4tzEV/SHo2JXSUxszFtmEz
X-Received: by 2002:a05:6a20:d28b:b0:3d3:ae0f:5269 with SMTP id adf61e73a8af0-3db406d1734mr9636215637.21.1789426390747;
        Mon, 14 Sep 2026 15:53:10 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm14924296eec.27.2026.09.14.15.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:53:10 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH 02/10] HID: hid-lenovo-go-s: Bound stale reply window before reusing send_cmd_complete
Date: Mon, 14 Sep 2026 15:52:55 -0700
Message-ID: <20260914225303.868569-3-derekjohn.clark@gmail.com>
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

mcu_property_out() reinits send_cmd_complete immediately after a
timeout is detected, before the next command that reuses it is sent.
If the MCU's reply to the timed-out command arrives after this reinit
but before the next command's wait begins, it silently satisfies the
next, unrelated command's wait instead of the one it actually answers,
handing that caller stale data with no way to detect the mismatch.

Track when a command has timed out via cmd_orphaned. Before the next
command reuses the completion, wait a bounded 25ms for a stale reply
to arrive and be consumed, then unconditionally clear the flag and
reinit the completion. This does not fully eliminate the window in
which an unrelated reply could still be received, but bounds it to
a short interval right before a new command is sent. Behavior matches
the solution to the same problem in hid-msi.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 68301d4c762a..36505d8402ff 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -37,6 +37,7 @@ static struct hid_gos_cfg {
 	struct completion send_cmd_complete;
 	struct led_classdev *led_cdev;
 	struct hid_device *hdev;
+	bool orphan_ack_pending;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
 	int cmd_status;
 	u8 gp_auto_sleep_time;
@@ -454,6 +455,19 @@ static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
 		return -EINVAL;
 
 	guard(mutex)(&drvdata.cfg_mutex);
+
+	/*
+	 * A reply to the previous command may still be in flight. Give it a
+	 * short window to arrive and be consumed before this call reinits the
+	 * completion, so a late reply can't be mistaken for this command's.
+	 */
+	if (drvdata.orphan_ack_pending) {
+		wait_for_completion_timeout(&drvdata.send_cmd_complete, msecs_to_jiffies(25));
+		drvdata.orphan_ack_pending = false;
+		drvdata.cmd_status = -ETIMEDOUT;
+	}
+	reinit_completion(&drvdata.send_cmd_complete);
+
 	/* We can't use a devm_alloc reusable buffer without side effects during suspend */
 	dmabuf = kzalloc(GO_S_PACKET_SIZE, GFP_KERNEL);
 	if (!dmabuf)
@@ -479,7 +493,9 @@ static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
 							msecs_to_jiffies(timeout));
 	ret = ret > 0 ? drvdata.cmd_status : ret ?: -EBUSY;
 
-	reinit_completion(&drvdata.send_cmd_complete);
+	if (ret)
+		drvdata.orphan_ack_pending = true;
+
 	return ret;
 }
 
-- 
2.55.0


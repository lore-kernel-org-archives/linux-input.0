Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AAA383320
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201211; cv=none; b=Fn4rZip5jHhbBKmEWGakEs1q0i/NHEKS+Mi7kB9U3FO3WzzslgGVREjx7evDssNQ+stZJZPr1PjkwlAma5nxrhxSk63/f2UJC8ZimzkyVlxnK9lItAJ/ltPnvhPxjQ3qKf3nvyAeZZR64bzwJUX/kxvW9Jo+tmE+Ora7e4ZchFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201211; c=relaxed/simple;
	bh=iWPIgwZiSSJDvPN/BDAEQWDZfNRx8o+Iugnbq3iWHKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxwIOcLP0Q02ZuoIN6FnCg8+IeqBGtK60WM292eyE7bKSYh5kVfVBrt2Qg5NIU81YMw/eqCg6LDU8fDZC3tYWOkLNFmuk2jFrO/06Odn+M5OhVTlkLpHwmCDN32QVP8eSCD7IeNCsPzEZzYSjAoyx6J9xKuXuMuAlRBeE2WFptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hg+opl3s; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg+opl3s"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35f1f76ea84so760323eec.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201209; x=1792806009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eVggbgf1DVbCfSFIEdIxjEkzriY/RWOqsYw3NeM2MYQ=;
        b=hg+opl3sjSJ85lEQOpMGa2809GIJl5m0htQ8cupsSevpRde32wqABENo+EzyKJa91D
         KqoEBLK/clPpHmRDoc5IFokx7FgIqirE2aPjAAIphP4TxXzfQ7+h5fg/2I3G3qNcHvri
         jSlqhiBqwAfsyXi+pq6DHyswlX/iPK5og4QDKHi5t66/gpEy21qeLm1ZxFDHfSuqGQmH
         sSkqNxZmKJYxx0ts6pR8TKdPL9U005SnMkFXa8UMUn+YHKoZBOZoV3NdW/isxxn6NTXS
         7FW+7mNllNOAX1DFv3FeYIy/2l+Djw7ipRDDg6/NMscF3OOm69sXfP1RdyJaE3YqMmy7
         3uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201209; x=1792806009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eVggbgf1DVbCfSFIEdIxjEkzriY/RWOqsYw3NeM2MYQ=;
        b=0vx3WScskrVTR1zuwat0+2y7QlUNswjxbBktDNVVs3jJEW91AhlWPP8CQ82LwR5FVI
         icT2E7Axv3CEGLl5VA6PohQk/SAiGBiR4UZL4exB60EnlJ9DHrC7OI8Z3H4NfxYzTIil
         ntvARpJsbXfigThmKmw0lW/eG9nwI+Y3BDNUtFIPYgoQHLVO4Ucrb8KFOQUl7KDNzoXP
         bf426fuLt7h6HGP8DFm2Jov2A9zKEiUKbx+SRLxwXXUpTzNuiWDBVVi8XRarwo9sVtos
         v9ZjE+2npFAYR/5zkJT4OCGXpavMAMvh6avuaA6ABUHb10oPgoxn39xRInPw7HQxbaNj
         XlSA==
X-Forwarded-Encrypted: i=1; AKwUvByeOZwkj56dO8gak/atmUWTA+o0lo3f6Yta4lYQ1yqAnmJ6DQAV0t5n4xVeQmhnNgKnARB/9TQAKwXOCg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJzTt08p9vZb23CKkkT+hzyoq87AnQ5Bkm6Jp1V+VPJUa/N9u3k
	NWmjCUWyH3dhML1jMSLKnkNVp9htiY4yVObmP/SM00o4TADBkYGVH/EM
X-Gm-Gg: AYBFou1DvahndAOS4dPb1vI10W3RN1xb1GVCaW/fwXaXbqz3HE3I8tcpBxnZf4dcBgl
	DWPq3vIFRj12rIzY5IKnDluf4kq49G06d3Y3o2kBGV7GEfbvI7cTNVsGFt+Ki4Bsb4s1MTzNHHA
	CQ+lIzBenz33ngdpPRmtAiTAQq/sMXx6b8RAfXlz5Pp8NWkKCrWxC3Km9C3iYMtCUbzSmhXGthN
	vrtFCfYWdB5Th5jipxGSh7XLVpRsmp89L8F2yVTZfRC/8CtifXds/2jLrsNGA+nMsEWJuwmmLV8
	rCjh/8Efwn9lW8dQqH2gy5YbPQ7yqaBQGpo5bUAkYcPykPaGXD91mlR7N4CgdTRMwXI1Z3Ceb1w
	pLdw5hyl7LtB/6s3184nD/tDq4sXXbU9ddYZoUWgi4ZaMM5Y9bI7Im7gt1ueUsyqqHbN2eqp7uQ
	q1J2FvT3RvwmeAMksV6KSLTnqjqmF2YQez5axPTXcgKKKuiX6l1FSEyGZAsQMKsCfVmpm82Sw7v
	wlVS+KfKLfImfFYjlKrnH3DYWHW6CIbYycTf4yVssTfVXpWyD4P9asTfNonHjOAw94EptyYs54=
X-Received: by 2002:a05:7022:170d:b0:17b:6c28:8be1 with SMTP id a92af1059eb24-18513e7b183mr1934994c88.23.1792201209154;
        Fri, 16 Oct 2026 18:40:09 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:08 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 02/11] HID: hid-lenovo-go-s: Bound stale reply window before reusing send_cmd_complete
Date: Fri, 16 Oct 2026 18:39:47 -0700
Message-ID: <20261017013956.2440130-3-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
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

Track when no reply was consumed, i.e. the wait timed out or was
interrupted, via orphan_ack_pending. Before the next command reuses
the completion, wait a bounded 25ms for a stale reply to arrive and be
consumed, then unconditionally clear the flag and reinit the
completion. This does not fully eliminate the window in which an
unrelated reply could still be received, but bounds it to a short
interval right before a new command is sent. Behavior matches the
solution to the same problem in hid-msi.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 68301d4c762a..e979527ece8e 100644
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
@@ -448,12 +449,26 @@ static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
 	unsigned char *dmabuf __free(kfree) = NULL;
 	u8 header[] = { command, index };
 	size_t header_size = ARRAY_SIZE(header);
+	long t_remaining;
 	int timeout, ret;
 
 	if (header_size + len > GO_S_PACKET_SIZE)
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
@@ -475,11 +490,15 @@ static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
 
 	/* PL_TEST commands can take longer because they go out to another device */
 	timeout = (command == GET_PL_TEST) ? 200 : 5;
-	ret = wait_for_completion_interruptible_timeout(&drvdata.send_cmd_complete,
-							msecs_to_jiffies(timeout));
-	ret = ret > 0 ? drvdata.cmd_status : ret ?: -EBUSY;
+	t_remaining = wait_for_completion_interruptible_timeout(&drvdata.send_cmd_complete,
+								msecs_to_jiffies(timeout));
+	if (t_remaining <= 0) {
+		/* A reply to this command may still be in flight. */
+		drvdata.orphan_ack_pending = true;
+	}
+
+	ret = t_remaining > 0 ? drvdata.cmd_status : t_remaining ?: -EBUSY;
 
-	reinit_completion(&drvdata.send_cmd_complete);
 	return ret;
 }
 
-- 
2.55.0


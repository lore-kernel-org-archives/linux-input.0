Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E522A4D6
	for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219365; cv=none; b=tLipYp7/CYqV+acPMj+VOMv52gWgmFaWfV78Ns1W9pMSh8lbjAN/4HXmD58bjjS5YoLtMFH5o9TqYYU8IN6skaSDm+eie1dZlrEkbrWwnnimlE2cacpid0DVWd72isPDdBukO81e9Z0HYWbZcYaU5P9QB9MUPtpDSrCogZGN9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219365; c=relaxed/simple;
	bh=GPHNlP+i5kClaBF8b/aV82UQxUbAdS3uGeajNgNkvow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcZCuvttIO2tG7InqaMW8LQmqy/gyT/W0MFC3iI2Tp2mHGYJBIBfZKd5VK8PIRlvdWpSadkrA6r0HE3ZW3LLTsfqznGGZA3+pqaqSnP12DITsEv2aBdpjKynKsKo61fSnnlTQaIcWjq3DfyBbwS0Io/lqV+IOTBcFkqEy4ZZfEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCMosbFC; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCMosbFC"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4540812eec.0
        for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 17:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769219361; x=1769824161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwMqD/JxDTChJj/0URSAhzNpbthbnAQ4R2LI3Lm7E3I=;
        b=UCMosbFC3PJrkCtmElMkJgYUuPeqOXE9jvyFlGzhrhWDU4Fb5u4jNITGSfUnfiEpcG
         qSFoADjj/eAG46BEfsQhzBuGAmrSEEgu3OY/AJdBUOAv2PDUncaLgfFCoptutvXr8P4f
         +W1p/SvQG5K4xsh+kNIfXOjTjq6AZsNL5UuOXOjWgN2qOGLTI3YiD5y7gp+gq4nbtPob
         7kz9J+ORu+L/ApobSEYAc63LJsOveEQ4h5FawavEzEfzrB2/ZUx1RLZkvnIXFlHvYX1I
         e3wNXVqSKf8kbeZb7FlU5HI8oMRLQ1o7vGwedxaXGOi7UKYtch8pMMBZ7SXh0HJmkQPv
         AyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769219361; x=1769824161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AwMqD/JxDTChJj/0URSAhzNpbthbnAQ4R2LI3Lm7E3I=;
        b=pVuAB1hgip3OGE+v2I5FdqAKnlXGFwlwVxyfQD+lqfONKrRBHFA4MjHKN75gwIaW9K
         sgup1ihmpCtMtcJHEgzTwrG6SDa81VIbpObCXseAO7xQYuOmQMW4Yr+O8huMoJUm2wcK
         jga0a5/RG1DzanIixtZsuiBfrUAykIRiIlshy5X0iKF+5hwyZJ7OqNb+5JTVQRjAhmQL
         gcvPXZdcp4IiG7NDf65qjrO9D/+AVjjB3mIH9BL0UQ5XMwxUDCtzRRzj2m6/AN3GTWhx
         mkMyryXfbtMEbLevNbSs9nKOBcpBiyNj7jtwhSSPJdbe0Svun3/PRdBi3NnZkjvwgUc+
         TjRg==
X-Forwarded-Encrypted: i=1; AJvYcCWfVgo4shZStZSSFRz6MwoB6qHftfFNdOSyVSUCf792GXp6YlTXjUCMsgAdOmxPc1OMLe3xY7nQzztDag==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyaby4fvVOUGnyLCF0QmIelkjJwVlsDuYB/zU5d8F9cN868tOq
	GGL36aSv7BIXtGkTG3gMG3VO/CRZ3+P5k09PYftK8gxNyTaVaJnTl06E
X-Gm-Gg: AZuq6aIHodKRqsqYW3vOVr7+Njj4r8wMfMrXPU4Sg2PhPd09Bhtk0+6vf50hDdVExrm
	DyYpGZuRlNCs1vvP7GSosV8m07VdqqWrqss/3DbEF6GDF9lN6a+M3LrDT2360oBlCg87D8NtEgr
	LpbMyovSsQ+bu8Rb2Eg/mmxPXnWQtJO/pZewbePpCoMh/B70qTl4zEMV3UAG81nVg9yy6mo+g50
	MN3AlCIVUtb6bjwmcS7G3wmDvCmKGUDwjJKwQdVNaFwPumJU5wf6X+ZAAkEzFzx7krQU0tsO1yZ
	tr8Ver4p4dm0F8QHQUtOp6Fk6pobEyG7690AsEHinC4SBmNVEqQrd39H+PHmiiYMuLfCqVqdp4d
	z2xTcmdoF38MSt7Negs39zvFjnDdPCXjsCgkDpElKRKYcVAnMb0eJWdfO/2rR8+2UikbtVLGYnd
	BlM0nM5jZN/pB6DaZCFxf6M/SVZ3Iryoy8miXez8KDKimtzOjsjmAgTktMbH+RWmY=
X-Received: by 2002:a05:7300:80c2:b0:2b4:706d:4e23 with SMTP id 5a478bee46e88-2b7397aa1c7mr2039019eec.0.1769219360957;
        Fri, 23 Jan 2026 17:49:20 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa22707sm5160014eec.29.2026.01.23.17.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 17:49:20 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/16] HID: hid-lenovo-go-s: Add MCU ID Attribute
Date: Sat, 24 Jan 2026 01:49:02 +0000
Message-ID: <20260124014907.991265-12-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124014907.991265-1-derekjohn.clark@gmail.com>
References: <20260124014907.991265-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds command to probe for the MCU ID of the Lenovo Legion Go S
Controller and assign it to a device attribute.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 3e9041e746df..36cee6c3d4cc 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -17,6 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/printk.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
 #include <linux/usb.h>
@@ -34,8 +35,13 @@ struct hid_gos_cfg {
 	struct completion send_cmd_complete;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
+	u8 mcu_id[12];
 } drvdata;
 
+struct gos_cfg_attr {
+	u8 index;
+};
+
 struct command_report {
 	u8 cmd;
 	u8 sub_cmd;
@@ -70,6 +76,14 @@ static int hid_gos_version_event(u8 *data)
 	return 0;
 }
 
+static int hid_gos_mcu_id_event(struct command_report *cmd_rep)
+{
+	drvdata.mcu_id[0] = cmd_rep->sub_cmd;
+	memcpy(&drvdata.mcu_id[1], cmd_rep->data, 11);
+
+	return 0;
+}
+
 static u8 get_endpoint_address(struct hid_device *hdev)
 {
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
@@ -103,6 +117,9 @@ static int hid_gos_raw_event(struct hid_device *hdev, struct hid_report *report,
 	case GET_VERSION:
 		ret = hid_gos_version_event(data);
 		break;
+	case GET_MCU_ID:
+		ret = hid_gos_mcu_id_event(cmd_rep);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -160,10 +177,41 @@ static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
 	return ret;
 }
 
+static ssize_t mcu_id_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	return sysfs_emit(buf, "%*phN\n", 12, &drvdata.mcu_id);
+}
+
+/* MCU */
+static DEVICE_ATTR_RO(mcu_id);
+
+static struct attribute *legos_mcu_attrs[] = {
+	&dev_attr_mcu_id.attr,
+	NULL,
+};
+
+static const struct attribute_group mcu_attr_group = {
+	.attrs = legos_mcu_attrs,
+};
+
+static const struct attribute_group *top_level_attr_groups[] = {
+	&mcu_attr_group,
+	NULL,
+};
+
 static void cfg_setup(struct work_struct *work)
 {
 	int ret;
 
+	/* MCU */
+	ret = mcu_property_out(drvdata.hdev, GET_MCU_ID, FEATURE_NONE, 0, 0);
+	if (ret) {
+		dev_err(&drvdata.hdev->dev, "Failed to retrieve MCU ID: %i\n",
+			ret);
+		return;
+	}
+
 	ret = mcu_property_out(drvdata.hdev, GET_VERSION, FEATURE_NONE, 0, 0);
 	if (ret) {
 		dev_err(&drvdata.hdev->dev,
@@ -187,6 +235,13 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
 	drvdata.hdev = hdev;
 	mutex_init(&drvdata.cfg_mutex);
 
+	ret = sysfs_create_groups(&hdev->dev.kobj, top_level_attr_groups);
+	if (ret) {
+		dev_err_probe(&hdev->dev, ret,
+			      "Failed to create gamepad configuration attributes\n");
+		return ret;
+	}
+
 	init_completion(&drvdata.send_cmd_complete);
 
 	/* Executing calls prior to returning from probe will lock the MCU. Schedule
@@ -207,6 +262,7 @@ static void hid_gos_cfg_remove(struct hid_device *hdev)
 {
 	guard(mutex)(&drvdata.cfg_mutex);
 	cancel_delayed_work_sync(&drvdata.gos_cfg_setup);
+	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 	hid_set_drvdata(hdev, NULL);
-- 
2.52.0


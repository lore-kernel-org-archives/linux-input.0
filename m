Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB9B334683
	for <linux-input@vger.kernel.org>; Fri, 20 Feb 2026 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771571169; cv=none; b=lSeKj2plSrrK9+YrdExi2Naa76kUvTbgERmuXPdCjSCaNBH2nv7TLztuGYe0x6p77CQ80kzBz0si7GVqT2mMuYVdTD46pL4T80diE8//NIlaqa0AGuzM788+EU5lWpMFybY5g5u6FPJFLQfiaci4ev3FW91gaIVNjbzzi2aOU9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771571169; c=relaxed/simple;
	bh=KdCh9zJQLpSdDTZM6J9VhfrHq2GUKWp1PL8O4tMF0Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjbLiMboZ3yoWHrSEkg6Cu6ivN20qMMSmZuEevgu0iHcaglonMTkbwSKtTy1vdkG3ozhsy+VivYaG+I+eRGpFIlOhwwBsN8++ddJVjGWb1JYWm4qP3KPxYx4MAjI0EWTt4S6lOvrJIO+KfEokRwHQYMoJs9NFlzY30CAIkuuxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6zX5APc; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6zX5APc"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b86671f87eso3427861eec.0
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 23:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771571167; x=1772175967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2RTMkBWMa6cd5JBc3xaI+nYZ2JTuzryHpI6NlmsJjI=;
        b=j6zX5APcjI992y10m3tYH+X287OYidxL8lIvJOu3ditprMJJWwONezPUdNrQeZnm2U
         mQzbumLl2cFIfzZg8CIUcWRGYIY1tfZSkelEvveUf3XK9FK2vGENJnLwoZD7PPNxT2d/
         4stJ+VduBF28fN4LaJdhREH4CPuJFVvrTHAZeGM9ErPMtDh/gk9IY6QlFePIwrnMrMsr
         FCsrAjagDTjVJroBAixajkSZRcrSzoMh9GpUadhkmRzsRRDI3raI95YgDR2DPEmuT+I5
         2HnHuyErdzVzoSvjdBbSqSu6VnTmn0mxEDIUoW+DYkEHKh2ifoiZNVZQCu9SaSU8vB3q
         z2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771571167; x=1772175967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X2RTMkBWMa6cd5JBc3xaI+nYZ2JTuzryHpI6NlmsJjI=;
        b=pa9lhq4g1Nsn2f9KiDYSPb6N8CATKa0ygaaX03nBVAlgnxw8tpp3s62TKm0XHDPcGx
         iJ1L+lHMTFZLXlNr0lbv+84VMKKdZosKU6R6CgtpX/DII5lv+WapNQaFTyX29onhemWJ
         DNz1rsLnfxkRYiqYuQ9/rR3UIFmyWlvEgHZVAyeHFdO10EPQC+qFh/zJEe38eBmY6yxJ
         GuCdyqafTlnnfrIsPyXy/h2f4X4oysXhBdQK8ndEClGUuAQrHHTzlX9j0oVi15R4/FdY
         CLcF193HjLK7tYNgE+AAZtH0n2PxRrSB3nxRJcJjmqUUpvK4F+SDvTsYbNozMkuGFkRJ
         w7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHkRZBGtRfFyRphUhZ7eGQGSI9pitq++5k0c2KP/xOOjeCiAjhBb0ZjrOS7PBcEABi+MXGYNumDD0N8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxY4UG2YY555JmKjMvvtWjmgGyrHp85ys1qC50/U3s4yOAHsDyJ
	vhRmj7ugdcQIA8TM1uRhsDOeugPultocNZYz2ep0AMC+m2AFtGO5P04A
X-Gm-Gg: AZuq6aKA52GNiWN1peDeUPz/TV+pJe96C56Sr5Vlid2ACvp4j2n8w+3kqi1++5N0z/9
	x3nBj18pcAjos4EIQW8j1zboQJO2COvT6Y7EgBh/jOhZYnBD6erUHv8Qe0G1Hnx6Ep6DlMn3yue
	kvSRiW155KMX0+9dNSeTSSba1Y8EwULiv9p4WwqA1sNk5yO3VGbCC4m6hstuF1+W+8PJOa76ekW
	KwMLogvgGn/H1JTN+/gE0jVBioWDnwei7X8Sw9NOBnSIWQTd732KhO/bjGs/HNzJP5xaWK7yYZn
	jxpZgHAhB7vTpggrGER7Dw9zw1RhIBAETP+cFXloinjWi9ufK7WDv0ZYKsGLK2X8PVMRELuStdZ
	c1Sz85BighPHuoqxPG0vL4YklmpU3FyV2bs5GUoRDDvaY9Ev0VGVwTd5iYSZ9RYa2Fk26XHMKDQ
	gUJUkRLEiCXDYNv1AADXjRtjlDIWfHiKFZDDq3qchrQ9v3+bpALJMK6QRTkC/9/TGf+7QZptlSR
	FL4SRJ/LMeXPg==
X-Received: by 2002:a05:7300:dc88:b0:2b8:2946:72c5 with SMTP id 5a478bee46e88-2bd733d9d29mr300901eec.39.1771571167211;
        Thu, 19 Feb 2026 23:06:07 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb669f7dsm22163335eec.23.2026.02.19.23.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 23:06:06 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Richard Hughes <hughsient@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/16] HID: hid-lenovo-go-s: Add MCU ID Attribute
Date: Fri, 20 Feb 2026 07:05:24 +0000
Message-ID: <20260220070533.4083667-12-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220070533.4083667-1-derekjohn.clark@gmail.com>
References: <20260220070533.4083667-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds command to probe for the MCU ID of the Lenovo Legion Go S
Controller and assign it to a device attribute.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 20eb472d7a247..9dfc7a6ce84ce 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -18,6 +18,7 @@
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
@@ -162,10 +179,41 @@ static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
 	return 0;
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
@@ -183,6 +231,13 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
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
@@ -203,6 +258,7 @@ static void hid_gos_cfg_remove(struct hid_device *hdev)
 {
 	guard(mutex)(&drvdata.cfg_mutex);
 	cancel_delayed_work_sync(&drvdata.gos_cfg_setup);
+	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 	hid_set_drvdata(hdev, NULL);
-- 
2.52.0


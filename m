Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5F26738C
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896753; cv=none; b=jm55D8gqCOi4hJDMCqQ2OB/GDZHXHYdT2b8Q4zDA3Cv2ox/U9xqZO+Mmfnu68IZb/dL7daeG7TMxW/vnEusoB03qpjQI4IT3fODIbPrR7tc3oU303OvMBJu3tzBs7h19fXkeoig3gHu5JW5cx8VoHXtLLJBB8KGGH4k5h8h/aPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896753; c=relaxed/simple;
	bh=r+E+unKyli7xWlqC1C59HfhiOBjmHQp6n1+NlQofa+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/sYDrpU8xjqSCXRrWDOMxPoP6uaCR/jzhS02KEjYHTcsQy4tiBXHQbTsSRQ9iTJQuXLiMxV80DEDEpCPGrbDlNRgjoGDzkrHgwnilui3YniGHJDFYLw8uLNL5gbA5e5siG/e7FKzosHeDjifeqj+agpcw0/jzUNZ/HnxWkmvZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it8w3Avh; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it8w3Avh"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba94dbf739so5433092eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771896750; x=1772501550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyS44T5wbslTYzP2PkQi9qgSAlOK18ePJOg81jkekr4=;
        b=it8w3AvhbiXViEmx+ktTnrZMacm4r0F3YCW0P6/tOn16+50Xp36gsZTZx8DpNJmd2i
         wvmNT5VKlE9F2Hl0HHkxuAysYYbZ2071IG8J1mqSpSjtSiesdjsCZ8OsNy/1XVPjPbKi
         8wkPVTGdvxfUYaPIbtu1Q+EgSwThtSLV7ZtoP4b4/8gueQUcpI/9LCKvZOBUv857Gd3z
         H4gzOO0JtiiIozxBNTBqVr95EbIg3hxGxjCEvPN5g0baAOKiG+yPL2vB6q8FVyrrWcLV
         usgYNoeNOxm/YL94H/FN0zUQ0VCmrAFb4JoUBcEBTET24XvlWHIX7gYOwwWkklonc3e5
         lhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771896750; x=1772501550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NyS44T5wbslTYzP2PkQi9qgSAlOK18ePJOg81jkekr4=;
        b=jt2+NAINgNsEwZ+0LJrey3IwMmwXWyNwjxyc7e+jzM8c5Z80vQFijvqIZEDHXGrZtM
         G6h2SHsqYeEJpid8MQ1QnFks4ehqARXEzvXxmoJfrmPG3fHgKQujauxXvlX2Xp6/vUoU
         /QSi81eVA+f+OmPpXZ9zyjByu7LawyJ6K81DnhGfsjl+slyb8l/NRshj6KuFRxGMK/fE
         77DAGGl5bAbT8T7Ve8RRW+vknyPqR3643aB1pmj9soGmndUIyYKdKY8ldov1ojaz4kmI
         HX81BxrJ7nrMCVDC90KSn0m3Qcozs4eWGIYRnMuojglzaimUSXAf9Ioe4bZqar1mrAp/
         tlXA==
X-Forwarded-Encrypted: i=1; AJvYcCXAx7L8JMgmYBTCrpns6N/PnK9eSvoeG+soYkqRL2RWNvmblAhvLrrTQDoSYeXjda04xqXCNjJRWOmhoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvaBQQjWBvCe7vPfkAbsRLN0kfnijqA9LtpSRh2Pkp6+YEw6tn
	jcrrCslPw4p+Jm5fpg4x99bT8S5baZsWjyYxMD8t36JuGH5CSJWEPqrg
X-Gm-Gg: ATEYQzx+PnU1Dp42xmiT1UJe0tEpXv/ANqw3xl30eUMdOfl2jZZqJ+0wlR004Tbp7VJ
	XZhyom+lMrxaTKCeMPgKG76Zrv3ZEaxyuYrM4kgHJBmvQ3PPBay0Zn+k9oTxWJ4JAp2seoePFuU
	EgtPBq8wrGhZ2+W96jvNMDwZ/IG77q7Zmj19DY+uzR5FAVQGpU9StwupNYLNDEC0muNvq5r9BrY
	4ztGVNaDjYdCQ5K4kIvKo2nlb9OMbClaII0hAmf/fEExes/6x2xhzebjhLgB8FVlclW2KqUOgwj
	gVEWelYpueODNRLLZ47JBp81/HAq2NXgyV7RVZPVMCDwOOnoDbpOUjXXp5ncJ+Lj/ADh/p80wp2
	lW/pc1XUIuy+udgxU5SqrhlwLPXeNZUH35RxAiUPPioNrKEfv6XCvYL22qv6M9+mexlMQXzf15J
	+VVY76K0qq0obfGsBvBhR/dqAsTYbwoflmCdbaAgMMgzydBLXo7vwU16ScH7vMvaikYM5oxXM4M
	eo=
X-Received: by 2002:a05:7300:190a:b0:2b6:fa0c:6c44 with SMTP id 5a478bee46e88-2bd7b9f05d5mr4123876eec.12.1771896750328;
        Mon, 23 Feb 2026 17:32:30 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa027fsm6485015eec.9.2026.02.23.17.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:32:29 -0800 (PST)
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
Subject: [PATCH v5 11/16] HID: hid-lenovo-go-s: Add MCU ID Attribute
Date: Tue, 24 Feb 2026 01:32:12 +0000
Message-ID: <20260224013217.1363996-12-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224013217.1363996-1-derekjohn.clark@gmail.com>
References: <20260224013217.1363996-1-derekjohn.clark@gmail.com>
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
index d8d32a9c90512..cea015330c2b6 100644
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
@@ -157,10 +174,41 @@ static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
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
 		dev_err(&drvdata.hdev->dev, "Failed to retrieve MCU Version: %i\n", ret);
@@ -177,6 +225,13 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
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
@@ -196,6 +251,7 @@ static void hid_gos_cfg_remove(struct hid_device *hdev)
 {
 	guard(mutex)(&drvdata.cfg_mutex);
 	cancel_delayed_work_sync(&drvdata.gos_cfg_setup);
+	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 	hid_set_drvdata(hdev, NULL);
-- 
2.52.0


Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60C3ED104
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127793; cv=none; b=eixhBrsjU2Y3rKWzvUUWW2gTKWwrJ10A0Fg/UAwtVh61K36qsmmqujUka/NCu8zjF+jggajTKoqMjBCYzZ1bc+dJbvASU95uiPd8050yL8gMcC6fh04Z6RDvicAb2AVSvczih/z7Vey5NJB8u7M8gmLjjrdOlzRwJJg7KVxzd08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127793; c=relaxed/simple;
	bh=yWkVa/Jth/oJdDOe1ihirkRp8Fbw+pPWZBYFbTWg034=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6uP6NZ5mfDFAGt5z26Q6CgcMGU3nFXs3o/IswGvdkzuI8Au38Tvuxj1js165uWeAVE63Ci46bK7zAalMW3ZZv3k6uC2HDdTvbM06jP/ZmDVoBTRcK98vn7XLyLIQZoNKAOS0YLpsCocpJ6+s0K5Kzri4luWaJ/cMDhfDsaI73A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy107Vtx; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy107Vtx"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2be1c918173so14212427eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 00:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773127791; x=1773732591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPGAxlsgnQwH8V6ZIVfcEYRPqGnb7Td9A0j4ncYAqN0=;
        b=Vy107Vtxq8++Xkgtbs6Y3PSL11sp7SFTvd0ZhHtQjOHezOuhN8KWTaOdpSjuRycNjL
         ww4FgP+sxpuxFdbDXEk2uW/seDRjbzxUWWHgg8dUMlPyGGNddVBHi9FRTVbxqUZEhsiM
         ekX4cjYncpsym7wbHiEFUoAJZemfmlpqYzlaCN14OAUnCAiv56GX1SzmyiTeyem2fVf8
         cbYwUPh+SIBadMM2iRpRrC249yQIUFyfKEMRMK4Q9ZdGlaPeAEk3W1JOGeIAa4Mwxqyx
         EPrAqLFqFAaXSMfE9TX58MqMnTcuyN9cCXEGlcgPlRIC3bJhpoaX8ysgtDduHzLqflal
         NWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773127791; x=1773732591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UPGAxlsgnQwH8V6ZIVfcEYRPqGnb7Td9A0j4ncYAqN0=;
        b=AG2rmz7l48B0cl+ccyYTMsBjZ/fuMyiJ9skFjhnnukJgrEVyB+rlczcsRt7J8IxRMO
         PnsmYa33uw5HWozeA1FtlBtp6htnZKL/1mQ/xw0ezWgrQa//vBxpfl4PRR+qNTmqPDUk
         060JN9ONkVW7ScNiDmdydkubV+VO6WEu2x53rKsd7vTGkJ1vXHX7sNGizIygD9jbZs5Z
         7BCRAGty3uT1/kAkvhmGqY04xrQ7kLwAesfM6LIuCJyTjWrruw4hIRlV+iEEiPJa8/1R
         Zr4dJWDgMcw36TXjEv6F0zgjpj36+3+laCaRZ3bzDNT92E3UAI3ytQOUnmOM7MJazhim
         J/xA==
X-Forwarded-Encrypted: i=1; AJvYcCXE3YLj6Vfl0XaxLj7E2WvbQxHaCeCPSxNICLFeg5vXpfy1n4rTlDqI1uRzNYNRQgZteK7A3eAzyTq4yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIoFFz8NlDCsXgwjV+7xzwshxWWcW3K+XAr0lPFl+W8iBvVTmR
	A1H62FLMtcEavfXoBf2LtVDuz66EmpzHfVZUl0CveOeKxLkBfDaot7yu
X-Gm-Gg: ATEYQzwpGNkWt8kP3XHUcT6kncaPLPq2+c11UD5TPjAuVPBek6CeaKQNLd83nOZIy9e
	rrBPb5gJgq3+JHjhY8VclDlVEgxhEhJUNkzfhc3vEtxI7DdmayHPOvNQYosvNNafoNJUm/x/vgP
	3pzQTzFsTlF8kbD8prQwy5J7bw0k+MUv5DIuIKS1pm56veJU9nqThSp+8eag1UxcfXTywPgGRNp
	E8orIyA+28dB3QRLnl1fnmRpE0Qvx64WlcGR+ylGSZstN+zOw+J7RhTmU/nzTOA+DdNjXJPyOmp
	pCJkL2X0sd0MpJyQAXI0kxLnmQWMV/Rbx2Jqgjim1nQYV4dflPKpfCEnwzQo1zbHaOG54OKj1Vo
	C4kvhFxL1y92trSx1gbbiFibQsrCI507z93fdMWTHYnv3VAOnHV9ro5tjyre7r9XF7X/6mVtebD
	SATNzMh4GXVPWakASRpG+To8/i1rXmr+z0nADP/D7J+Z63Fo44vP8y6hzaFK0My5Q2bx8VT4bx8
	aSs2TlLrRVeVSE=
X-Received: by 2002:a05:693c:8087:b0:2be:6f30:f2f9 with SMTP id 5a478bee46e88-2be6f30fabemr2064806eec.26.1773127790942;
        Tue, 10 Mar 2026 00:29:50 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be81209142sm721925eec.12.2026.03.10.00.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:29:50 -0700 (PDT)
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
Subject: [PATCH v6 11/19] HID: hid-lenovo-go-s: Add MCU ID Attribute
Date: Tue, 10 Mar 2026 07:29:29 +0000
Message-ID: <20260310072937.3295875-12-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
References: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
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
v6:
  - Use NULL instead of 0 in mcu_propery_out when there is no data.
---
 drivers/hid/hid-lenovo-go-s.c | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index c9f57dfa145a..8ee75f724b5b 100644
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
@@ -34,8 +35,13 @@ static struct hid_gos_cfg {
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
 static int get_endpoint_address(struct hid_device *hdev)
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
+	ret = mcu_property_out(drvdata.hdev, GET_MCU_ID, FEATURE_NONE, NULL, 0);
+	if (ret) {
+		dev_err(&drvdata.hdev->dev, "Failed to retrieve MCU ID: %i\n",
+			ret);
+		return;
+	}
+
 	ret = mcu_property_out(drvdata.hdev, GET_VERSION, FEATURE_NONE, NULL, 0);
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
2.53.0


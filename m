Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228563E959A
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127787; cv=none; b=NxBs+VHdzt7vHfFimTN8wxHg+asgZsBoyNXJXnV0434UC3EN7hIGeASvS1JAkgtjyx8sH22y3qCa8e8m3JcCl/DlgU8v9CxQJoPquDylZ21TpObSqcS9H+6MLWc5h7NFDkzlBiOs7wZZK9RUhumGB8hY07S4eQlYhgbM/3/uWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127787; c=relaxed/simple;
	bh=akFvcySx2qtpMSSr4YkidwPl/PnWdnvEe1ChDcvUnFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVac9zqC0hOW22Dh7hFCPEsFbvrTHlnnAYQ3/738KqH1QTDgKaSgx79TxPtFUhHMZYMcdCDlcA5oXGyqHvsQBE2uXrVm0+WQMJ8AltEpLct+cykfUIjbpL+knK7HTwMh5Lraiqdpkrlft/dcef53qeKkjLY5RdfUdm2vKTh2Oio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH17nJUc; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH17nJUc"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba895adfeaso10542389eec.0
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 00:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773127784; x=1773732584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0FyZLQ4D0JfML3/RqbwC4ixUWu6cfpE5AZW99yvfRg=;
        b=jH17nJUceyvnUg9T6Tu/jfnP6cL24lUVE9OULPINGXgOdfNw30uqJFByOw8JJEDwcn
         HxpOMEwxZ13v1EIb2akr+0CCCl+XbUef9W8jYt1/lZwrtm2c/ZqO8/+KlVj5P2NcHXJz
         wP6isi0BCEDTW9vb1IooHH1cG1bXrQACQTbJdEX8Qa8YWCQgULR4X8c0x7jJk3j/tOC7
         SWzRkx9twhwWxSk9MerCL6CQxxuJPWqXKpcfMTLJDXdA6zW0tMhpnQN3Lks+JHpAwwPo
         Ww3vbyRYBTw6ahLtEQ2sXSy/Bo/bLxtNlIz3uVA/eQTOjjvWsbRgDTqQISh6/3A34MjY
         HuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773127784; x=1773732584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h0FyZLQ4D0JfML3/RqbwC4ixUWu6cfpE5AZW99yvfRg=;
        b=gVUvRVEra2HjUcyOATZ2l6AA0haH4WPoxED+WRAXnHzhHIO95DcILVK5lkDpMyn8Jc
         150yUu5SFDT+zBWcf2M6IvQ/VsdHTF1xpdMAItKGFKKodBshcsy5uaxLv87F7QlclKeZ
         BxZe495N1NLjh88ewER+Zf0pMC8+ILZgZtbeLMWATwdHF2ZPEhCh7ESROR/53jDMazj9
         vQ0EvLc1B9Z4QNA72Ys8exrDj2WQjWyzR0ge6khIXZ+mh7LedL9YHbRRqxAkmuIDhk+6
         Plkz55+0JCVJ8x22fMMCcPlLQxdtX72TQGQGi7dTdRhDgzjJVIZt1kZIlQXJssnOZOhU
         t7QA==
X-Forwarded-Encrypted: i=1; AJvYcCWjiInAiKDPLdgKxf/dL3lf9IcczSTlcSI2cOz0oTcOV2ZCTD/eKQ//dk2BR7M7irWCIUt1GIxgzqmclw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCg4WxRWZnw4zLaXL89RbB4czdNPyKkgHZFBmFf5fUA3ZroxBD
	MQFcxIm2+DGr/WcHmeRtcq8KenEMJKcABSPyUh3PVJeVWfv7lU9reqa+
X-Gm-Gg: ATEYQzyvhdRtlZfJDcsQyBKt03n958urGZx29lpp2N/DX+syVPuuoWOrpEdQLewJwVI
	1WR5IN9F7cpWzFlBMiYU/kOQy5Bfk3cqRGW4OUE2GaGhSlLa6MPetusF1OCN+qAuOLJAvVVo6u+
	4sbSUK7PadHjCA+mOE5imCOnM9FIo2kg5ao10QnKAUPDPq9FazN+ub1ja2SzAq+X3ahcPlGmKvx
	u6sbC8Emc2JTJ5c/ICSoB09P4eSlmU5QjkBPB+UdZtDaqsq0hBn97haVxY27aZ5RK0+qGWLrDkB
	AN+bmqCpRdhPqKOplzeAQKUlIhjAuULn1322v0Q70Ii4qBE3lfTIVPTbNatoUkQM6oBzn+CIWNg
	my28N2B91eNHi5ww96eHZtqoquDWnK4k5pm/v93Moh9/GkjtnuXEt58ZHfNphw3z7rV8MusY7N3
	KiKm+mge/OzNxjaUdaHNyDdBGC9CAYwI71YkGgw/A1NA6CrT54dmhVeR8JkXVvKrxEujpYx3p/N
	Uqc
X-Received: by 2002:a05:7300:5723:b0:2be:833c:14a7 with SMTP id 5a478bee46e88-2be833c19d5mr37980eec.1.1773127784235;
        Tue, 10 Mar 2026 00:29:44 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be81209142sm721925eec.12.2026.03.10.00.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:29:43 -0700 (PDT)
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
Subject: [PATCH v6 05/19] HID: hid-lenovo-go: Add FPS Mode DPI settings
Date: Tue, 10 Mar 2026 07:29:23 +0000
Message-ID: <20260310072937.3295875-6-derekjohn.clark@gmail.com>
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

Adds attribute that enables selection of the DPI of the optical sensor
when the right handle toggle is set to FPS mode.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v6:
  - Use NULL instead of 0 in mcu_propery_out when there is no data.
---
 drivers/hid/hid-lenovo-go.c | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index f2a54865cfbb..24f9444c93cd 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -67,6 +67,7 @@ static struct hid_go_cfg {
 	u32 mcu_version_hardware;
 	u32 mcu_version_product;
 	u32 mcu_version_protocol;
+	u32 mouse_dpi;
 	u8 rgb_en;
 	u8 tp_en;
 	u8 tp_vibration_en;
@@ -220,6 +221,8 @@ static const char *const rumble_mode_text[] = {
 	[RUMBLE_MODE_RPG] = "rpg",
 };
 
+#define FPS_MODE_DPI           0x02
+
 static int hid_go_version_event(struct command_report *cmd_rep)
 {
 	switch (cmd_rep->sub_cmd) {
@@ -427,6 +430,16 @@ static int hid_go_motor_event(struct command_report *cmd_rep)
 	return -EINVAL;
 }
 
+static int hid_go_fps_dpi_event(struct command_report *cmd_rep)
+{
+	if (cmd_rep->sub_cmd != FPS_MODE_DPI)
+		return -EINVAL;
+
+	drvdata.mouse_dpi = get_unaligned_le32(cmd_rep->data);
+
+	return 0;
+}
+
 static int hid_go_set_event_return(struct command_report *cmd_rep)
 {
 	if (cmd_rep->data[0] != 0)
@@ -477,8 +490,12 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
 		case GET_MOTOR_CFG:
 			ret = hid_go_motor_event(cmd_rep);
 			break;
+		case GET_DPI_CFG:
+			ret = hid_go_fps_dpi_event(cmd_rep);
+			break;
 		case SET_FEATURE_STATUS:
 		case SET_MOTOR_CFG:
+		case SET_DPI_CFG:
 			ret = hid_go_set_event_return(cmd_rep);
 			break;
 		default:
@@ -1016,6 +1033,52 @@ static ssize_t motor_config_options(struct device *dev,
 	return count;
 }
 
+static ssize_t fps_mode_dpi_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+
+{
+	size_t size = 4;
+	u32 value;
+	u8 val[4];
+	int ret;
+
+	ret = kstrtou32(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	if (value != 500 && value != 800 && value != 1200 && value != 1800)
+		return -EINVAL;
+
+	put_unaligned_le32(value, val);
+
+	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, SET_DPI_CFG,
+			       FPS_MODE_DPI, UNSPECIFIED, val, size);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t fps_mode_dpi_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	int ret;
+
+	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_DPI_CFG,
+			       FPS_MODE_DPI, UNSPECIFIED, NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", drvdata.mouse_dpi);
+}
+
+static ssize_t fps_mode_dpi_index_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "500 800 1200 1800\n");
+}
+
 #define LEGO_DEVICE_ATTR_RW(_name, _attrname, _dtype, _rtype, _group)         \
 	static ssize_t _name##_store(struct device *dev,                      \
 				     struct device_attribute *attr,           \
@@ -1087,7 +1150,12 @@ LEGO_DEVICE_ATTR_RW(gamepad_rumble_intensity, "rumble_intensity", UNSPECIFIED,
 static DEVICE_ATTR_RO_NAMED(gamepad_rumble_intensity_index,
 			    "rumble_intensity_index");
 
+static DEVICE_ATTR_RW(fps_mode_dpi);
+static DEVICE_ATTR_RO(fps_mode_dpi_index);
+
 static struct attribute *mcu_attrs[] = {
+	&dev_attr_fps_mode_dpi.attr,
+	&dev_attr_fps_mode_dpi_index.attr,
 	&dev_attr_fps_switch_status.attr,
 	&dev_attr_gamepad_mode.attr,
 	&dev_attr_gamepad_mode_index.attr,
-- 
2.53.0


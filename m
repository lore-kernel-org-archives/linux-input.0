Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB92C375E
	for <linux-input@vger.kernel.org>; Sun, 10 May 2026 04:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778387722; cv=none; b=BjUBEXYK/PFdY7mDNd1YiD99dh2K6ayKTwRW+dAX4rXF1HQtybUB6ffXSp2+tufhXnyn6XHv8wKwNOCgk2MIG2j1l8vWYPbVx11sEXvoHrsbkeyQ0FjD6AcU0cktPkFBFQFrSMzRL//Zo6T1LpVu2QuoxBVCf/bCKGSC/QV3ldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778387722; c=relaxed/simple;
	bh=FAOkFs8X/R5/5IEnqSvNpaSToQ1zQw0+Tg6WMsit6LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pA/w/LQUU5AltqCKM7lizEn1Fe/1eI+nJlSBVkVkr/TLGemmnC2aHp2BAYQLhdE7TcH6eX8PqI1xbwpzBZg+kLoLqi2rG9ifUeih9baRQa57e63HJJulygNWUOIYu6kWEsJQG9vsCLxXFzJpZMi+T/DOT5X4dUUH81a7NQ25icA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq219Q/D; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq219Q/D"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ee990e8597so5754630eec.1
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 21:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778387719; x=1778992519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EGUJdZkAXTYXhJtuXt7hGQ/eEs1hEecVhStNhxjmFI=;
        b=Xq219Q/DLpuwrJlIQlszjgYKKFAiThqflisJUy/EpW+G6P3Nbkro5b8wz/SRxhhS5y
         5cvNJx/RaottwaV6B5TzthRG3B+FvXp/Fa4rrQEnwI/7EsF+0dfrY65lhuE5thaxYl4W
         zzG5ogyZFoVqa5gIvYtjl8/M1Rn4maXCYZwD4RJn7emnVxL+DeIdAjH0EePGNiSE/cw+
         tkI6zAAXGBpVwUwpgjwbAusIv8hcJwVIy/qVgIctJf6aZMQ1O7+GygJOK7Vbe/n5+i9U
         zb+KmCkuy5KayAQyrIe0nm/BqcsowhYKddi0v0/1P3pHZA2tarLfbCIvs1VO7y/g/HLP
         8dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778387719; x=1778992519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EGUJdZkAXTYXhJtuXt7hGQ/eEs1hEecVhStNhxjmFI=;
        b=mIjc+6sHKtsl7Y1bD46QeMkELrCVnM9d+blBFd9HKRUI8XEIitsXpgD7SvFoi0Nry2
         v+SY0oEfVCAhD4bX+0P7TeA1pqssOVdlNEs4CQXHrGOT+4GlPtDMIOswc3gXBRXrq35m
         9/M08adnbtp9CQk9gWe1WUSU4yUhQU6xOVClBmL6DQC69rKFGlcUjdJ0b/NCbZgf/d0M
         D2iUDzTUVaxJc4MWJ6iv2HrPwehnRn2IIcYlvGQptgetwpgl8uf+aM1UX5f06//w6opm
         NFm7FCvyuX2Mj1bkwpttzCC3W4Xh1BsS6TRgpDVqTUsRYWNnDW43VQFco+auQKqRXFy1
         N4mg==
X-Forwarded-Encrypted: i=1; AFNElJ/f4B0W9sSgtDpPpuYPHleDHmnAi36GfDTXVp+Det7Y3kjBbzfgogRw/hFE9pBiv9RGYkqUxCSAVCTo3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAfzyIAyIJ1kr44/hexcNbIUq0vP7klROlTjlDgtvtAkVdlFG4
	v1xtoHWx+cSsJx28R6AK4PT1ciH91Vy0IwlO4ezDATu/Vz5e5P3xioQS
X-Gm-Gg: Acq92OGy1K1VpVLkl61SL5Bsh7EFFtlGUGGksrlSmjxGgJ0Z8ZUbgShXmK2OZBF54Au
	oUInXabAKUNhFmO18dpNMp73etCz+MMvrspxGWVzf7NRPTgfXgs+hl4DlSoYrSme66ZTYYnRC7o
	cDDNjgNE59pUdx/eKqlbj8yOH+IrnpI7IywA6+pf5c5XJAzQAzBQjZnEscCb01xjzjJLED4Nbhj
	TNECoI1CjUZ9U7Jz6sDShSO70KTtXh+cnH4N4oRMz7dB4Ard4fxLJCuAOlql55xVjJIc1C60R06
	iTEpEtNCh9sQRQ1TfooylCHH1VZLz/VJYpYFAmxbxNqwQFFQXzLe8LVQgk2e8V04Kqi5rTB2P7Q
	MUpo9izpzcPyWQX4iVtxMG7jRRAVBLwTUk90TgRf/iRy7JHGHBe4SREw/AF1yiHVMhw6h4FW1NS
	m8yAYD0iZylECPaYij3c5WJShUIJ1tbJeTkXRYXnNYbRyHMyOJ9eU4j+rUdEdYFnQQbqBA5Y+H8
	BKL6ys5BUFRr9U=
X-Received: by 2002:a05:693c:2c97:b0:2ed:e15:c926 with SMTP id 5a478bee46e88-2f54be949a5mr10343672eec.34.1778387718923;
        Sat, 09 May 2026 21:35:18 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88885be8esm8667953eec.22.2026.05.09.21.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 21:35:18 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Denis Benato <denis.benato@linux.dev>,
	Zhouwang Huang <honjow311@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] HID: hid-msi-claw: Add Rumble Intensity Attributes
Date: Sun, 10 May 2026 04:35:10 +0000
Message-ID: <20260510043510.442807-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510043510.442807-1-derekjohn.clark@gmail.com>
References: <20260510043510.442807-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds intensity adjustment for the left and right rumble motors.

Claude was used during the reverse-engineering data gathering for this
feature done by Zhouwang Huang. As the code had already been affected,
I used Claude to create the initial framing for the feature, then did
manual cleanup of the _show and _store functions afterwards to fix bugs
and keep the coding style consistent. Claude was also used as an initial
reviewer of this patch.

Assisted-by: Claude:claude-sonnet-4-6
Co-developed-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-msi-claw.c | 139 +++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/drivers/hid/hid-msi-claw.c b/drivers/hid/hid-msi-claw.c
index f4fe74a784c2..6d089f49abdb 100644
--- a/drivers/hid/hid-msi-claw.c
+++ b/drivers/hid/hid-msi-claw.c
@@ -76,6 +76,8 @@ enum claw_profile_ack_pending {
 	CLAW_M1_PENDING,
 	CLAW_M2_PENDING,
 	CLAW_RGB_PENDING,
+	CLAW_RUMBLE_LEFT_PENDING,
+	CLAW_RUMBLE_RIGHT_PENDING,
 };
 
 enum claw_key_index {
@@ -262,6 +264,11 @@ static const u16 button_mapping_addr_new[] = {
 static const u16 rgb_addr_old = 0x01fa;
 static const u16 rgb_addr_new = 0x024a;
 
+static const u16 rumble_addr[] = {
+	0x0022,  /* left  */
+	0x0023,  /* right */
+};
+
 struct claw_command_report {
 	u8 report_id;
 	u8 padding[2];
@@ -308,7 +315,10 @@ struct claw_drvdata {
 	enum claw_gamepad_mode_index gamepad_mode;
 	u8 m1_codes[CLAW_KEYS_MAX];
 	u8 m2_codes[CLAW_KEYS_MAX];
+	u8 rumble_intensity_right;
+	u8 rumble_intensity_left;
 	const u16 *bmap_addr;
+	bool rumble_support;
 	bool bmap_support;
 
 	/* RGB Variables */
@@ -396,6 +406,12 @@ static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_
 		memcpy(&drvdata->rgb_frames[f_idx], &frame->zone_data,
 		       sizeof(struct rgb_frame));
 
+		break;
+	case CLAW_RUMBLE_LEFT_PENDING:
+		drvdata->rumble_intensity_left = cmd_rep->data[4];
+		break;
+	case CLAW_RUMBLE_RIGHT_PENDING:
+		drvdata->rumble_intensity_right = cmd_rep->data[4];
 		break;
 	default:
 		dev_warn(&drvdata->hdev->dev,
@@ -795,6 +811,116 @@ static ssize_t button_mapping_options_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(button_mapping_options);
 
+static ssize_t rumble_intensity_left_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	u8 data[] = { 0x01, (rumble_addr[0] >> 8) & 0xff, rumble_addr[0] & 0xff, 0x01, 0x00 };
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	u8 val;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > 100)
+		return -EINVAL;
+
+	data[4] = val;
+
+	ret = mcu_property_out(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA,
+			       data, ARRAY_SIZE(data), 8);
+	if (ret)
+		return ret;
+
+	ret = mcu_property_out(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL, 0, 0);
+	if (ret)
+		return ret;
+
+	drvdata->rumble_intensity_left = val;
+
+	return count;
+}
+
+static ssize_t rumble_intensity_left_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	u8 data[4] = { 0x01, (rumble_addr[0] >> 8) & 0xff, rumble_addr[0] & 0xff, 0x01 };
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret;
+
+	drvdata->profile_pending = CLAW_RUMBLE_LEFT_PENDING;
+	ret = mcu_property_out(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, data, ARRAY_SIZE(data), 8);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", drvdata->rumble_intensity_left);
+}
+static DEVICE_ATTR_RW(rumble_intensity_left);
+
+static ssize_t rumble_intensity_right_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t count)
+{
+	u8 data[] = { 0x01, (rumble_addr[1] >> 8) & 0xff, rumble_addr[1] & 0xff, 0x01, 0x00 };
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	u8 val;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > 100)
+		return -EINVAL;
+
+	data[4] = val;
+
+	ret = mcu_property_out(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA,
+			       data, ARRAY_SIZE(data), 8);
+	if (ret)
+		return ret;
+
+	ret = mcu_property_out(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL, 0, 0);
+	if (ret)
+		return ret;
+
+	drvdata->rumble_intensity_right = val;
+
+	return count;
+}
+
+static ssize_t rumble_intensity_right_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	u8 data[4] = { 0x01, (rumble_addr[1] >> 8) & 0xff, rumble_addr[1] & 0xff, 0x01 };
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret;
+
+	drvdata->profile_pending = CLAW_RUMBLE_RIGHT_PENDING;
+	ret = mcu_property_out(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, data, ARRAY_SIZE(data), 8);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", drvdata->rumble_intensity_right);
+}
+static DEVICE_ATTR_RW(rumble_intensity_right);
+
+static ssize_t rumble_intensity_range_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	return sysfs_emit(buf, "0-100\n");
+}
+static DEVICE_ATTR_RO(rumble_intensity_range);
+
 static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct attribute *attr,
 					    int n)
 {
@@ -815,6 +941,12 @@ static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct attribu
 	    attr == &dev_attr_reset.attr)
 		return attr->mode;
 
+	/* Hide rumble attrs if not supported */
+	if (attr == &dev_attr_rumble_intensity_left.attr ||
+	    attr == &dev_attr_rumble_intensity_right.attr ||
+	    attr == &dev_attr_rumble_intensity_range.attr)
+		return drvdata->rumble_support ? attr->mode : 0;
+
 	/* Hide button mapping attrs if it isn't supported */
 	return drvdata->bmap_support ? attr->mode : 0;
 }
@@ -828,6 +960,9 @@ static struct attribute *claw_gamepad_attrs[] = {
 	&dev_attr_mkeys_function.attr,
 	&dev_attr_mkeys_function_index.attr,
 	&dev_attr_reset.attr,
+	&dev_attr_rumble_intensity_left.attr,
+	&dev_attr_rumble_intensity_right.attr,
+	&dev_attr_rumble_intensity_range.attr,
 	NULL,
 };
 
@@ -1286,9 +1421,11 @@ static void claw_features_supported(struct claw_drvdata *drvdata)
 		drvdata->bmap_support = true;
 		if (minor >= 0x66) {
 			drvdata->bmap_addr = button_mapping_addr_new;
+			drvdata->rumble_support = true;
 			drvdata->rgb_addr = rgb_addr_new;
 		} else {
 			drvdata->bmap_addr = button_mapping_addr_old;
+			drvdata->rumble_support = false;
 			drvdata->rgb_addr = rgb_addr_old;
 		}
 		return;
@@ -1297,11 +1434,13 @@ static void claw_features_supported(struct claw_drvdata *drvdata)
 	if ((major == 0x02 && minor >= 0x17) || major >= 0x03) {
 		drvdata->bmap_support = true;
 		drvdata->bmap_addr = button_mapping_addr_new;
+		drvdata->rumble_support = true;
 		drvdata->rgb_addr = rgb_addr_new;
 		return;
 	}
 
 	drvdata->bmap_support = false;
+	drvdata->rumble_support = false;
 	drvdata->rgb_addr = rgb_addr_old;
 }
 
-- 
2.53.0


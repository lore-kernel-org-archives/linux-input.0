Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010461;
	b=qIDmXxbsdJyLwa467dU/ffVD7TaX2pgtlfYYLMZQ3MqaQx4JXLRlK3OY8hZ/Tx0Eyfqe
	 buAbn7A0TM0ZDsQfJirAW7LK2W8O63zVHPnQ3wMBbh7Ma5Vhsva1SZV51IfIyP7+KdoZK
	 sLAYEoQHAmmIvpQH99zlAW0jXy4Wi/b8Pt36F2B+gpl39GoGjfgUSDxQEl5Xl11d8gbE+
	 dWYfv9WELaB1iNdpPf2YBE4prJhyJMSdm55v1hX9pynaGUuDORWF95BT9dqQTF0R7AW3r
	 mzdsDxgPOveQyFgfo0SGXLt+zcDY5xRwa6tRhjFBtmggtnLBFLXv6ADc8xxiePIRZ/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010461;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bB37u7TU8GJPnF/CvhRIQ5DB+xkA6gUZN9fI0MT9YRE=;
	b=agB+FyPE2XweDvOxvcN5rC3g14tufvxJkZmV31eAGHjr73bZ3vWIXaZnsdQ0S1HrrBDw
	 f90H1Aa+ulHXMFUppUQzKwO1C59mJ6ZEDoE2W8vwcDRbHQfUVc/8Az3okNAL0jDqaF1gR
	 Uc6Y/cxTSGiwrBm9hcvAi/gYBKiq11D/GTcUJmLJDmfWj21s74oYRkUhXvSwTNkStD1st
	 fHfH9KVpVWZBp/W22ajkf2EN22iTk6bQ+ikQAVkidYWC53KzeyQffqerRpLdap8OhQfjJ
	 Fa0tht70kN5ZSiQG/wP7LOp9XKkjlutJpt/U5qk4mCdxT10t4WEcld7vDrP526k3wUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=JrlZGz53;
	arc=none smtp.remote-ip=51.250.60.163
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [51.250.60.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FA8606A31B
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 10:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29FA8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=JrlZGz53
Received: from mail-nwsmtp-smtp-production-main-32.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-32.yp-c.yandex.net)
	by forward103d.mail.yandex.net (postfix) with ESMTPS id A5BEBC0086;
	Mon, 26 Oct 2026 13:27:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-32 with ESMTPSA id SRdNtKli7mI0-cETEBYSc;
	Mon, 26 Oct 2026 13:27:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1793010449; bh=bB37u7TU8GJPnF/CvhRIQ5DB+xkA6gUZN9fI0MT9YRE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=JrlZGz53JqJ4Nk4voF6ovG4hjg1T52hFiLNulRLBH7qwW/vO9slBVl43+c3EVdN4d
	 PVQqa7fT/EKUBr1qYFYnhuANqjQynCHDX97uLhhOZJtf5cYUCOX//wOlg+lCfl6uQh
	 2Mf+fLKk6+jT6jjZ7eQA1ECNCO8FW5g9QZkZ44Jc=
Authentication-Results: mail-nwsmtp-smtp-production-main-32; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] HID: core, drivers: cleanup sysfs handlers
Date: Mon, 26 Oct 2026 13:27:27 +0300
Message-ID: <20261026102727.128574-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefer the convenient sysfs_emit()/sysfs_emit_at() over
{scn}printf() in sysfs show() handlers and drop redundant
str{n}len() calls in store() handlers, respectively.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/hid/hid-core.c                |  2 +-
 drivers/hid/hid-ft260.c               |  4 +--
 drivers/hid/hid-gt683r.c              |  2 +-
 drivers/hid/hid-logitech-hidpp.c      |  2 +-
 drivers/hid/hid-ntrig.c               | 36 +++++++++++++--------------
 drivers/hid/hid-prodikeys.c           | 12 ++++-----
 drivers/hid/hid-sensor-custom.c       | 10 +++-----
 drivers/hid/hid-wiimote-core.c        | 34 ++++++++++++-------------
 drivers/hid/hid-wiimote-modules.c     | 17 ++++++-------
 drivers/hid/intel-ish-hid/ishtp/bus.c |  5 +---
 drivers/hid/wacom_sys.c               |  6 ++---
 11 files changed, 62 insertions(+), 68 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a71ddaa810a0..46eca399474e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2287,7 +2287,7 @@ country_show(struct device *dev, struct device_attribute *attr,
 {
 	struct hid_device *hdev = to_hid_device(dev);
 
-	return sprintf(buf, "%02x\n", hdev->country & 0xff);
+	return sysfs_emit(buf, "%02x\n", hdev->country & 0xff);
 }
 
 static const BIN_ATTR_RO(report_descriptor, HID_MAX_DESCRIPTOR_SIZE);
diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 64c9c940db46..3d0e78f357f3 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -870,7 +870,7 @@ static int ft260_byte_show(struct hid_device *hdev, int id, u8 *cfg, int len,
 	if (ret < 0)
 		return ret;
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", *field);
+	return sysfs_emit(buf, "%d\n", *field);
 }
 
 static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
@@ -882,7 +882,7 @@ static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
 	if (ret < 0)
 		return ret;
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", le16_to_cpu(*field));
+	return sysfs_emit(buf, "%d\n", le16_to_cpu(*field));
 }
 
 #define FT260_ATTR_SHOW(name, reptype, id, type, func)			       \
diff --git a/drivers/hid/hid-gt683r.c b/drivers/hid/hid-gt683r.c
index 29ccb0accfba..fa453de406b9 100644
--- a/drivers/hid/hid-gt683r.c
+++ b/drivers/hid/hid-gt683r.c
@@ -90,7 +90,7 @@ static ssize_t mode_show(struct device *dev,
 	else
 		sysfs_mode = 2;
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", sysfs_mode);
+	return sysfs_emit(buf, "%u\n", sysfs_mode);
 }
 
 static ssize_t mode_store(struct device *dev,
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 27d83b8bbaaf..20cd5c5f5811 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2778,7 +2778,7 @@ static ssize_t hidpp_ff_range_show(struct device *dev, struct device_attribute *
 	struct input_dev *idev = hidinput->input;
 	struct hidpp_ff_private_data *data = idev->ff->private;
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", data->range);
+	return sysfs_emit(buf, "%u\n", data->range);
 }
 
 static ssize_t hidpp_ff_range_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 2b31756b549e..e88be902703c 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -172,7 +172,7 @@ static ssize_t show_phys_width(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
-	return sprintf(buf, "%d\n", nd->sensor_physical_width);
+	return sysfs_emit(buf, "%d\n", nd->sensor_physical_width);
 }
 
 static DEVICE_ATTR(sensor_physical_width, S_IRUGO, show_phys_width, NULL);
@@ -184,7 +184,7 @@ static ssize_t show_phys_height(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
-	return sprintf(buf, "%d\n", nd->sensor_physical_height);
+	return sysfs_emit(buf, "%d\n", nd->sensor_physical_height);
 }
 
 static DEVICE_ATTR(sensor_physical_height, S_IRUGO, show_phys_height, NULL);
@@ -196,7 +196,7 @@ static ssize_t show_log_width(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
-	return sprintf(buf, "%d\n", nd->sensor_logical_width);
+	return sysfs_emit(buf, "%d\n", nd->sensor_logical_width);
 }
 
 static DEVICE_ATTR(sensor_logical_width, S_IRUGO, show_log_width, NULL);
@@ -208,7 +208,7 @@ static ssize_t show_log_height(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
-	return sprintf(buf, "%d\n", nd->sensor_logical_height);
+	return sysfs_emit(buf, "%d\n", nd->sensor_logical_height);
 }
 
 static DEVICE_ATTR(sensor_logical_height, S_IRUGO, show_log_height, NULL);
@@ -220,9 +220,9 @@ static ssize_t show_min_width(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
-	return sprintf(buf, "%d\n", nd->min_width *
-				    nd->sensor_physical_width /
-				    nd->sensor_logical_width);
+	return sysfs_emit(buf, "%d\n", nd->min_width *
+				       nd->sensor_physical_width /
+				       nd->sensor_logical_width);
 }
 
 static ssize_t set_min_width(struct device *dev,
@@ -255,9 +255,9 @@ static ssize_t show_min_height(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
-	return sprintf(buf, "%d\n", nd->min_height *
-				    nd->sensor_physical_height /
-				    nd->sensor_logical_height);
+	return sysfs_emit(buf, "%d\n", nd->min_height *
+				       nd->sensor_physical_height /
+				       nd->sensor_logical_height);
 }
 
 static ssize_t set_min_height(struct device *dev,
@@ -291,7 +291,7 @@ static ssize_t show_activate_slack(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
-	return sprintf(buf, "%d\n", nd->activate_slack);
+	return sysfs_emit(buf, "%d\n", nd->activate_slack);
 }
 
 static ssize_t set_activate_slack(struct device *dev,
@@ -324,9 +324,9 @@ static ssize_t show_activation_width(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
-	return sprintf(buf, "%d\n", nd->activation_width *
-				    nd->sensor_physical_width /
-				    nd->sensor_logical_width);
+	return sysfs_emit(buf, "%d\n", nd->activation_width *
+				       nd->sensor_physical_width /
+				       nd->sensor_logical_width);
 }
 
 static ssize_t set_activation_width(struct device *dev,
@@ -360,9 +360,9 @@ static ssize_t show_activation_height(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
-	return sprintf(buf, "%d\n", nd->activation_height *
-				    nd->sensor_physical_height /
-				    nd->sensor_logical_height);
+	return sysfs_emit(buf, "%d\n", nd->activation_height *
+				       nd->sensor_physical_height /
+				       nd->sensor_logical_height);
 }
 
 static ssize_t set_activation_height(struct device *dev,
@@ -396,7 +396,7 @@ static ssize_t show_deactivate_slack(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
-	return sprintf(buf, "%d\n", -nd->deactivate_slack);
+	return sysfs_emit(buf, "%d\n", -nd->deactivate_slack);
 }
 
 static ssize_t set_deactivate_slack(struct device *dev,
diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index bf5add40d3e1..17f731e7ee45 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -95,7 +95,7 @@ static ssize_t show_channel(struct device *dev,
 
 	dbg_hid("pcmidi sysfs read channel=%u\n", pm->midi_channel);
 
-	return sprintf(buf, "%u (min:%u, max:%u)\n", pm->midi_channel,
+	return sysfs_emit(buf, "%u (min:%u, max:%u)\n", pm->midi_channel,
 		PCMIDI_CHANNEL_MIN, PCMIDI_CHANNEL_MAX);
 }
 
@@ -111,7 +111,7 @@ static ssize_t store_channel(struct device *dev,
 	if (sscanf(buf, "%u", &channel) > 0 && channel <= PCMIDI_CHANNEL_MAX) {
 		dbg_hid("pcmidi sysfs write channel=%u\n", channel);
 		pm->midi_channel = channel;
-		return strlen(buf);
+		return count;
 	}
 	return -EINVAL;
 }
@@ -132,7 +132,7 @@ static ssize_t show_sustain(struct device *dev,
 
 	dbg_hid("pcmidi sysfs read sustain=%u\n", pm->midi_sustain);
 
-	return sprintf(buf, "%u (off:%u, max:%u (ms))\n", pm->midi_sustain,
+	return sysfs_emit(buf, "%u (off:%u, max:%u (ms))\n", pm->midi_sustain,
 		PCMIDI_SUSTAIN_MIN, PCMIDI_SUSTAIN_MAX);
 }
 
@@ -149,7 +149,7 @@ static ssize_t store_sustain(struct device *dev,
 		dbg_hid("pcmidi sysfs write sustain=%u\n", sustain);
 		pm->midi_sustain = sustain;
 		pm->midi_sustain_mode = (0 == sustain || !pm->midi_mode) ? 0 : 1;
-		return strlen(buf);
+		return count;
 	}
 	return -EINVAL;
 }
@@ -170,7 +170,7 @@ static ssize_t show_octave(struct device *dev,
 
 	dbg_hid("pcmidi sysfs read octave=%d\n", pm->midi_octave);
 
-	return sprintf(buf, "%d (min:%d, max:%d)\n", pm->midi_octave,
+	return sysfs_emit(buf, "%d (min:%d, max:%d)\n", pm->midi_octave,
 		PCMIDI_OCTAVE_MIN, PCMIDI_OCTAVE_MAX);
 }
 
@@ -187,7 +187,7 @@ static ssize_t store_octave(struct device *dev,
 		octave >= PCMIDI_OCTAVE_MIN && octave <= PCMIDI_OCTAVE_MAX) {
 		dbg_hid("pcmidi sysfs write octave=%d\n", octave);
 		pm->midi_octave = octave;
-		return strlen(buf);
+		return count;
 	}
 	return -EINVAL;
 }
diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index c2b425afd951..4b4e835d4a57 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -317,9 +317,8 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 
 			while (i < ret) {
 				if (i + attribute->size > ret) {
-					len += scnprintf(&buf[len],
-							PAGE_SIZE - len,
-							"%d ", values[i]);
+					len += sysfs_emit_at(buf, len,
+							     "%d ", values[i]);
 					break;
 				}
 				switch (attribute->size) {
@@ -340,10 +339,9 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 					++i;
 					break;
 				}
-				len += scnprintf(&buf[len], PAGE_SIZE - len,
-						"%lld ", value);
+				len += sysfs_emit_at(buf, len, "%lld ", value);
 			}
-			len += scnprintf(&buf[len], PAGE_SIZE - len, "\n");
+			len += sysfs_emit_at(buf, len, "\n");
 
 			return len;
 		} else if (input)
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 9168b8502918..1fdb5d8eb71b 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1649,24 +1649,24 @@ static ssize_t wiimote_ext_show(struct device *dev,
 
 	switch (type) {
 	case WIIMOTE_EXT_NONE:
-		return sprintf(buf, "none\n");
+		return sysfs_emit(buf, "none\n");
 	case WIIMOTE_EXT_NUNCHUK:
-		return sprintf(buf, "nunchuk\n");
+		return sysfs_emit(buf, "nunchuk\n");
 	case WIIMOTE_EXT_CLASSIC_CONTROLLER:
-		return sprintf(buf, "classic\n");
+		return sysfs_emit(buf, "classic\n");
 	case WIIMOTE_EXT_BALANCE_BOARD:
-		return sprintf(buf, "balanceboard\n");
+		return sysfs_emit(buf, "balanceboard\n");
 	case WIIMOTE_EXT_PRO_CONTROLLER:
-		return sprintf(buf, "procontroller\n");
+		return sysfs_emit(buf, "procontroller\n");
 	case WIIMOTE_EXT_DRUMS:
-		return sprintf(buf, "drums\n");
+		return sysfs_emit(buf, "drums\n");
 	case WIIMOTE_EXT_GUITAR:
-		return sprintf(buf, "guitar\n");
+		return sysfs_emit(buf, "guitar\n");
 	case WIIMOTE_EXT_TURNTABLE:
-		return sprintf(buf, "turntable\n");
+		return sysfs_emit(buf, "turntable\n");
 	case WIIMOTE_EXT_UNKNOWN:
 	default:
-		return sprintf(buf, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");
 	}
 }
 
@@ -1682,7 +1682,7 @@ static ssize_t wiimote_ext_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	return strnlen(buf, PAGE_SIZE);
+	return count;
 }
 
 static DEVICE_ATTR(extension, S_IRUGO | S_IWUSR | S_IWGRP, wiimote_ext_show,
@@ -1700,20 +1700,20 @@ static ssize_t wiimote_dev_show(struct device *dev,
 
 	switch (type) {
 	case WIIMOTE_DEV_GENERIC:
-		return sprintf(buf, "generic\n");
+		return sysfs_emit(buf, "generic\n");
 	case WIIMOTE_DEV_GEN10:
-		return sprintf(buf, "gen10\n");
+		return sysfs_emit(buf, "gen10\n");
 	case WIIMOTE_DEV_GEN20:
-		return sprintf(buf, "gen20\n");
+		return sysfs_emit(buf, "gen20\n");
 	case WIIMOTE_DEV_BALANCE_BOARD:
-		return sprintf(buf, "balanceboard\n");
+		return sysfs_emit(buf, "balanceboard\n");
 	case WIIMOTE_DEV_PRO_CONTROLLER:
-		return sprintf(buf, "procontroller\n");
+		return sysfs_emit(buf, "procontroller\n");
 	case WIIMOTE_DEV_PENDING:
-		return sprintf(buf, "pending\n");
+		return sysfs_emit(buf, "pending\n");
 	case WIIMOTE_DEV_UNKNOWN:
 	default:
-		return sprintf(buf, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");
 	}
 }
 
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 199589cbf2b8..013e815a3d80 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -1445,9 +1445,9 @@ static ssize_t wiimod_bboard_calib_show(struct device *dev,
 		for (j = 0; j < 4; ++j) {
 			val = wdata->state.calib_bboard[j][i];
 			if (i == 2 && j == 3)
-				ret += sprintf(&out[ret], "%04x\n", val);
+				ret += sysfs_emit_at(out, ret, "%04x\n", val);
 			else
-				ret += sprintf(&out[ret], "%04x:", val);
+				ret += sysfs_emit_at(out, ret, "%04x:", val);
 		}
 	}
 
@@ -1807,13 +1807,12 @@ static ssize_t wiimod_pro_calib_show(struct device *dev,
 				     char *out)
 {
 	struct wiimote_data *wdata = dev_to_wii(dev);
-	int r;
+	int r = 0;
 
-	r = 0;
-	r += sprintf(&out[r], "%+06hd:", wdata->state.calib_pro_sticks[0]);
-	r += sprintf(&out[r], "%+06hd ", wdata->state.calib_pro_sticks[1]);
-	r += sprintf(&out[r], "%+06hd:", wdata->state.calib_pro_sticks[2]);
-	r += sprintf(&out[r], "%+06hd\n", wdata->state.calib_pro_sticks[3]);
+	r += sysfs_emit_at(out, r, "%+06hd:", wdata->state.calib_pro_sticks[0]);
+	r += sysfs_emit_at(out, r, "%+06hd ", wdata->state.calib_pro_sticks[1]);
+	r += sysfs_emit_at(out, r, "%+06hd:", wdata->state.calib_pro_sticks[2]);
+	r += sysfs_emit_at(out, r, "%+06hd\n", wdata->state.calib_pro_sticks[3]);
 
 	return r;
 }
@@ -1845,7 +1844,7 @@ static ssize_t wiimod_pro_calib_store(struct device *dev,
 		wdata->state.calib_pro_sticks[3] = y2;
 	}
 
-	return strnlen(buf, PAGE_SIZE);
+	return count;
 }
 
 static DEVICE_ATTR(pro_calib, S_IRUGO|S_IWUSR|S_IWGRP, wiimod_pro_calib_show,
diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 44db90ad5495..1b003003a4bb 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -356,10 +356,7 @@ static int ishtp_cl_device_reset(struct ishtp_cl_device *device)
 static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 	char *buf)
 {
-	int len;
-
-	len = snprintf(buf, PAGE_SIZE, ISHTP_MODULE_PREFIX "%s\n", dev_name(dev));
-	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
+	return sysfs_emit(buf, ISHTP_MODULE_PREFIX "%s\n", dev_name(dev));
 }
 static DEVICE_ATTR_RO(modalias);
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 628372ab818a..3757f40f7a9f 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1112,8 +1112,8 @@ static ssize_t wacom_led##SET_ID##_select_show(struct device *dev,	\
 {									\
 	struct hid_device *hdev = to_hid_device(dev);\
 	struct wacom *wacom = hid_get_drvdata(hdev);			\
-	return scnprintf(buf, PAGE_SIZE, "%d\n",			\
-			 wacom->led.groups[SET_ID].select);		\
+	return sysfs_emit(buf, "%d\n",					\
+			  wacom->led.groups[SET_ID].select);		\
 }									\
 static DEVICE_ATTR(status_led##SET_ID##_select, DEV_ATTR_RW_PERM,	\
 		    wacom_led##SET_ID##_select_show,			\
@@ -1167,7 +1167,7 @@ static ssize_t wacom_##name##_luminance_show(struct device *dev,	\
 	struct device_attribute *attr, char *buf)			\
 {									\
 	struct wacom *wacom = dev_get_drvdata(dev);			\
-	return scnprintf(buf, PAGE_SIZE, "%d\n", wacom->led.field);	\
+	return sysfs_emit(buf, "%d\n", wacom->led.field);		\
 }									\
 static DEVICE_ATTR(name##_luminance, DEV_ATTR_RW_PERM,			\
 		   wacom_##name##_luminance_show,			\
-- 
2.56.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0847D936;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019204; cv=none; b=Tiz1GtB1WqOFd/r6FNCmL0gF+/T2faVHHTubOjsawcnPD/zD0SwWtR6NP2c+NIpc7f05FBkn7hmUUGucw6ukilOEPUBiMppyTbGJBwIn9ruZiQeCntf78nddSE+zCPkPZv+zD4mpP31RAalE0myCZFmUbs2lo4YWM/omRjYnTd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019204; c=relaxed/simple;
	bh=G5ZjpCMc41koCIu50EVHnP0iTN4/vsCvxrW/ycokfzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlmDDxSTR9GWaD0xHOME6lWhpuhB+70I5kcW1UZzEnrqzaHYZNgGIJbyzCtKYqyaY1JEU0G4xd6BWFEjDvfbnTdi4sYJX9wVRKGX7VhQuhZh8xQf1p5ShHc9x2DNwIBoHb7a6n9vV5MXS5ruFKiff8ol9Q9Fhq2jKiV5TmB0r9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UawJS8i7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UawJS8i7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C58BEC2BCFB;
	Thu,  6 Aug 2026 12:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786019203;
	bh=G5ZjpCMc41koCIu50EVHnP0iTN4/vsCvxrW/ycokfzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UawJS8i7//fZW9c6gHoSaEV/5uYY3fK8RXn+E29YxqYuBTO2crmfbwSg9HOOyVjoO
	 24nY53D5U9vbE6QlkTdtZ07KurS/EvaKCG5+YT+T3Dbmj15M0RNcJY0fs+JTZBkzKW
	 el7Vl7LceBp8H855YYitA/q60H+UApp3pSLplq+Dm6fujF6iig4yZvcSjtiWT2Xytq
	 yDixPprKz+B/K2Mh5yxtTGOcTNXd2zZHWhAvGOwcQCwxKXr5B6NelagMcg+UK4nMIZ
	 8ohfY9PAXbtBvPfoIviTNB3f6arDKkYWhH8K8t6n2Tqaf+2zR2o1IK+LPaK7cVoGdq
	 wUQP39yG4Lz1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38C4C5620A;
	Thu,  6 Aug 2026 12:26:43 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 06 Aug 2026 17:55:48 +0530
Subject: [PATCH v5 02/13] iio: hid-sensors: introduce device managed API
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-2-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Zhang Lixu <lixu.zhang@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786019201; l=2481;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=XJmRzPXaqhKqM4yIeSm5h1wY7VWEZl4o+Whwft4tGS0=;
 b=Hb7yChVALMw6zcc9nYcHY72DoLLNrKRXSIdvM3tNa3tEGjb8AqhlYC6GbWoPWuu9VdZFjEUpK
 YG+3LAZNNRFBPiiv+0GamZ5J7vTer4MV1xj67v/W8ERkwun7D6AJSXL
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

hid_sensor_setup_trigger() is common API used for the HID IIO drivers,
prepare devm API devm_hid_sensor_setup_trigger() to acquire resource
during setup and release using device managed framework during drivers
fail, unbind or remove path.

Register action with devm_add_action_or_reset() to release resource with
devres framework.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 18 ++++++++++++++++++
 drivers/iio/common/hid-sensors/hid-sensor-trigger.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 6e6adc501602..df6c07d6a6b7 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -301,6 +301,24 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 }
 EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID");
 
+static void hid_sensor_remove_trigger_action(void *attrb)
+{
+	hid_sensor_remove_trigger(attrb);
+}
+
+int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev *indio_dev,
+				  const char *name, struct hid_sensor_common *attrb)
+{
+	int ret;
+
+	ret = hid_sensor_setup_trigger(indio_dev, name, attrb);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, hid_sensor_remove_trigger_action, attrb);
+}
+EXPORT_SYMBOL_NS(devm_hid_sensor_setup_trigger, "IIO_HID");
+
 static int __maybe_unused hid_sensor_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
index ee17d5cc2437..c4b901ca4879 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
@@ -17,6 +17,8 @@ extern const struct dev_pm_ops hid_sensor_pm_ops;
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 			     struct hid_sensor_common *attrb);
 void hid_sensor_remove_trigger(struct hid_sensor_common *attrb);
+int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev *indio_dev,
+				  const char *name, struct hid_sensor_common *attrb);
 int hid_sensor_power_state(struct hid_sensor_common *st, bool state);
 
 #endif

-- 
2.34.1



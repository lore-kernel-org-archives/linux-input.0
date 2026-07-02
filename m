Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DD430C165;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009084; cv=none; b=k+adGjP85BtQftFWPFhaDnHhNVzX0Uxg2TtpkMUyP2WYBRiBjOU1pwIaLsuzN1kiGUHwhSHQ1/fs/P7EsQ0kEFvy6HFZScYfAg95xXzYmYmLpFx6k5jXiezvd/hVi3vDwL0GsD0XObp0SYGXIGm6Z79jXrDDzh72kj7/LJZPMCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009084; c=relaxed/simple;
	bh=iLigWsZBTZ5l9z1lCiNSuBcspMeyU3wy6XPZctVcaQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tFom7+zXY5VIEFjFrGWcDggVDiEa16VZ0b5J+cBmHkbcYne/jMpUnperygWVMyW6FP4nBz2tUKdDRV45MuIDrf0maSamHyoyuS57ibdipPo+n+NLYo55HRhmG6hQxqmf20atAYWZoaP2YlRvOVUAI0mYEMFX4JV3/Dd+bfUL6Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ons6BeGX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ons6BeGX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B008C2BCC7;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783009084;
	bh=iLigWsZBTZ5l9z1lCiNSuBcspMeyU3wy6XPZctVcaQo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ons6BeGXbkfGQHnsUkKw+va6uHhyzdFF9Kpz7W1We3ZdWLjXUfKL+GLe04Rj+XNYq
	 6wHHrRdQztTtZ77i5PbvHPI9zjVyV4JLpl7KN9GewqgCLVCcAT5K7Uin5HpnMFMz4A
	 4bkhhbBDAMAbEUcEgjncx4T5U/Q+DIPYbHsBU89LYLBHFRzXnWdsHmcQRiex9nNe0O
	 5+ohx0maPTy8ymjddhBYqsBhvh1knMBFGZ8D2Nm0oFwZsUyKR7kBsmNRMwxMO9+LgE
	 jnOEhmMEVCfSCiqu5/SEpG7aeMriccLXqzyOduZUxBerQ03prdNMzyFFKFyWB/YxZt
	 7rT4GitmjS7sw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD28C43602;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 02 Jul 2026 21:47:58 +0530
Subject: [PATCH v2 1/6] iio: hid-sensors: add/remove blank line
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-15-jun-hid-iio-alignment-v2-1-b87f01f5efbc@gmail.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
In-Reply-To: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783009082; l=1830;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=3Enoj9jEiclPFYijQYLqZvd7azUOyB0jQ+jDFbEH2EE=;
 b=Yz2HWwNYxByOhXaoJjz9V2uZhFhGVkWjzeJTtpzrefC7F1mltkkr4ibGxtIVfMGm+OT/2BsMg
 ceMjoQr6SUGB5AqSL/TdackM2YSAaat30xu+r7/Dt1hESYMZxr6+TMi
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Add a blank line after variable declarations and remove multiple blank
line across HID sensor IIO drivers to improve readability and align
with kernel coding style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 1 -
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c    | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index c115a72832b2..2f0a1ea42f48 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -282,7 +282,6 @@ int hid_sensor_read_raw_hyst_rel_value(struct hid_sensor_common *st, int *val1,
 }
 EXPORT_SYMBOL_NS(hid_sensor_read_raw_hyst_rel_value, "IIO_HID");
 
-
 int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
 					int val1, int val2)
 {
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 417c4ab8c1b2..c8ccf96f3d03 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -314,7 +314,9 @@ static int __maybe_unused hid_sensor_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
 	schedule_work(&attrb->work);
+
 	return 0;
 }
 
@@ -322,6 +324,7 @@ static int __maybe_unused hid_sensor_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
 	return _hid_sensor_power_state(attrb, true);
 }
 

-- 
2.34.1



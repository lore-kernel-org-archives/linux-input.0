Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B923B38B5;
	Mon, 14 Sep 2026 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429078; cv=none; b=IWsaXvHYTJAMQWbsPoOOyYl7O7rhLlll+nleGUxY/1VVT30LTxJdadFwE5UvPXCwvsigg50Dj1kKgxP/m6CgkG+1Zeur5/fUDtE2wxBffyV/2M72GAjGKWOHgwXYsSHJwEBZMQwZNtMH5IQQvXFUW3fiaAtN9s8t40L6veR/XQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429078; c=relaxed/simple;
	bh=/piCQHWynLJMYlEKRDmxYhMXbGX5DC4ax41GYe7gL/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6M0V3c1r8ciu0cMYg18NJmomkrSHYDt1LJEtoc/L7kwdvNy8/yHozTnY96ZiOrG7XP7aVtthWLhoCP7kr/izj7xTCTY5wkUGOH1uqbgaAs5Lf1HQJolXyzFS3SNhN4u2UsyBcHDrF1umof4iJ9nSQYp49Jne6QQWtrrJo3OVDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vasily.cc; spf=pass smtp.mailfrom=vasily.cc; dkim=pass (2048-bit key) header.d=vasily.cc header.i=@vasily.cc header.b=GiAsiS1Z; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vasily.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vasily.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vasily.cc header.i=@vasily.cc header.b="GiAsiS1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vasily.cc;
	s=protonmail2; t=1789429071; x=1789688271;
	bh=XYDhupGIvX56tzutwpJ8Da0yVLb5FcjQ1xOgf2r+n1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GiAsiS1Z4NWedVAsxKfantIxopq/kqpEnktHNCGm+vlLU3qmBSbpe9tKSTuRtcNdf
	 Wgwgfr1zcAZDcCcdxW2GfVggd4mRdmCDyELt0585henTi2rX235+0UI7VYKmEomoKl
	 +eymGYD0B3KfnS0Akf7edxREuJef8S9lQK7qFadue0+sKyb9f2x9JRwLpH+9YTaYTV
	 FdSQ58Jo/KG59GAhbHtbt3zs2R8z7wI+DiTFbj46bPaoBkftmM67MXS9R42NgfLKhT
	 SboPrJT8xkWvVFY4n1CPKWP6PvdcDOcnkmTTlukwfoMK4Ngh5BoakhZooPOAUqiaIX
	 LNTqNInrmsqGw==
X-Pm-Submission-Id: 4hkM5S5DLtz1DDXF
From: Vas Zayarskiy <contact@vasily.cc>
To: linux@roeck-us.net,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Jack Doan <me@jackdoan.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 2/4] hwmon: (aquacomputer_d5next) Avoid truncating scaled sensor readings
Date: Tue, 15 Sep 2026 02:37:26 +0300
Message-ID: <20260914233728.22725-3-contact@vasily.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260914233728.22725-1-contact@vasily.cc>
References: <20260914233728.22725-1-contact@vasily.cc>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

High Flow Next power is reported in watts. Multiplying the 16-bit value
by one million can overflow both the signed intermediate and the u32
cache. Store power in long, perform the conversion in u64, and clamp to
LONG_MAX. The other existing power conversions fit in a signed 32-bit
value. Return ENODATA for unavailable power instead of exposing the
stored error as a reading.

Widen the shared current cache to u32. The Aquastream XT calibration can
exceed 65535 mA; clamp its negative calibration results to zero before
assigning to the unsigned cache. This also permits devices with scaled
aggregate currents to store milliamperes directly.

Assisted-by: LLM sparse
Signed-off-by: Vas Zayarskiy <contact@vasily.cc>
---
 drivers/hwmon/aquacomputer_d5next.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 1ca70e726..9178ac4cb 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -19,6 +19,7 @@
 #include <linux/hwmon.h>
 #include <linux/jiffies.h>
 #include <linux/ktime.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/unaligned.h>
@@ -599,9 +600,9 @@ struct aqc_data {
 	u32 speed_input_min[1];
 	u32 speed_input_target[1];
 	u32 speed_input_max[1];
-	u32 power_input[8];
+	long power_input[8];
 	u16 voltage_input[8];
-	u16 current_input[8];
+	u32 current_input[8];
 
 	/* Label values */
 	const char *const *temp_label;
@@ -976,7 +977,7 @@ static int aqc_legacy_read(struct aqc_data *priv)
 
 		/* Calculation derived from linear regression */
 		sensor_value = get_unaligned_le16(priv->buffer + AQUASTREAMXT_PUMP_CURR_OFFSET);
-		priv->current_input[0] = DIV_ROUND_CLOSEST(sensor_value * 176, 100) - 52;
+		priv->current_input[0] = max(DIV_ROUND_CLOSEST(sensor_value * 176, 100) - 52, 0);
 
 		sensor_value = get_unaligned_le16(priv->buffer + AQUASTREAMXT_PUMP_VOLTAGE_OFFSET);
 		priv->voltage_input[0] = DIV_ROUND_CLOSEST(sensor_value * 1000, 61);
@@ -1070,6 +1071,8 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		}
 		break;
 	case hwmon_power:
+		if (priv->power_input[channel] == -ENODATA)
+			return -ENODATA;
 		*val = priv->power_input[channel];
 		break;
 	case hwmon_pwm:
@@ -1426,7 +1429,8 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 			priv->power_input[0] = -ENODATA;
 		else
 			priv->power_input[0] =
-			    get_unaligned_be16(data + HIGHFLOWNEXT_POWER) * 1000000;
+			    min_t(u64, get_unaligned_be16(data + HIGHFLOWNEXT_POWER) * 1000000ULL,
+				  LONG_MAX);
 
 		priv->voltage_input[0] = get_unaligned_be16(data + HIGHFLOWNEXT_5V_VOLTAGE) * 10;
 		priv->voltage_input[1] =

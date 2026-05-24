Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51911306D2A
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650480; cv=none; b=VnbBSDr5hmtHM22DP1RoAKbCrIaic+mS9/T7+xxVN3K8ysdo8/nzJCHmfyIfC1lHw9FB4+rw0RP/socfyX5RVD3K3+fmmsD66Dekb0pZFA5UXuumsAOXeuCs34gpRmb73hO0sKdDb390gwAPbsChbDYZK3waJCyzF5TM4z9wg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650480; c=relaxed/simple;
	bh=9uhax4q2rGQbpqbcJk3KVDZqiUQogDJSXsxjgjQuG8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iuGkfCff+NUEoNQBh5StXFBqi1GZKlTHBeUrhxCyKjKQScgkxbrZKzlGRgB39RydqD1VjseoGmTXGvyUSc1XDEYlo+OPW6rzaiAmqOz8czRpmPN5le/BHjnxVGOKKyVaC7ni1uym4L0MzmbClOS48LLkgUjSGLNczk9cxivTp78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUjhdkST; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUjhdkST"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso7257416b3a.2
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650479; x=1780255279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCgsae+qDTmuIw6l4PzkInHNCEWSiAzO45jvcrCltYM=;
        b=cUjhdkSTlXa3+LP20MYJTt/iCXntlyD2mnzLPqj3g0KFLebsO4Jvhj/dDeqJBcHvz1
         ecOlx0woLJzlPOAUMdzj9vJGAHRcJeD4fXEc2X06+CbP/Xy6fxXbSpW7Yi+iuDoPCQG5
         /D2wtlN4SAp1+fHWTsMEeklEEIgnQqyuFN5HSPYOF1oiCKHShgLbC4CiHohE9eMbzCd6
         DNdVy852l40VevabEIxR0sLmBZxd+1oYUNiAdplXvreD2q7Zm8IGtknlWq5vVsX60uUn
         ROU+mZ32hkVmzf+yKl9heOpTbiCypWD077gzXDN0fc3+4A8Ey7aWoHlqBN9nEpejydlH
         irOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650479; x=1780255279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RCgsae+qDTmuIw6l4PzkInHNCEWSiAzO45jvcrCltYM=;
        b=ZaNmVstvcY3UPGP90QRKDEGTz5pqh8Af9fO4pQNgUJU7KaY43wzkK0362z3ApEgjck
         zK2yjWn1l69Qv+0jgDRgjTYSG1fCX06PtyDP53zUNIv8rlkh5YO5EwXgu3eX6uRlI9TK
         9wwBoBC0BWomk2lgj7UOIRqIur3G6v698FAnDtr0Eu9FRtaHOVy4dF/evIQIgjpoYcy7
         489Z6R8FDqSvjo5O0OhGt4e2XP/zAjzQKUpKTPAP48G727Y4q4NEgdnp+KMKaV/MbeGf
         KWhn6zi5/AQCq2j7gn2dqofY9otX2JT866fWLAbu1mcFE1NEHUpJB0t3/qk1MnRGcVPU
         9BRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Xzj9bD1a0d9PnNyB+w2jJQstE1vJFu9r90kiDv2hpYIriv27HlF9K+5K3tAniGQ8hM1LCNzUEEU7QJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwe6qgM6MIvC3BBKllqQl3nZNeUlwSWeehSPK+KTKZLfPHfcL
	MO05ztf6CD85bmkrtHe/2oQtajAvK53Gtv5gc1v3ox7Pn4GMi6XOOJnX
X-Gm-Gg: Acq92OGEVGWASun9rJ972ps4s6BV4OZytrH5ckJX/GBCgFVI4C0UjA+00yDU7XNZCRG
	T1rkJRxEX5fg2ZAxbJSosNbmG5aD1HtnGe6Mq5M7P4cfJM7Gp+AmMU4B85iWvPGNTKPDY3HYv2W
	uYceOfq/0AYNoiUGLGsK8MdVYw5c6HyrW0Dc8QRTAl8P1ik5vMQpasOiPKWizsU+d08bTeZo1uG
	JrZoXjaE282nplKjip1JGWTBI0NE1QbsndQTMjMRDzDRG5M3HcFmfAU7dXHTKujfQyaZT+3hyPv
	rvrcpUuCVJfN4NwjxgArsjvV4Wdxjp57q/B2imaNX5q9t/TmR5VuPl/fMROZ1AtrUo9hRbVmYad
	tu6oczFQ3sMY2HdUD+qmR+1ZFdmJ87OvJ03tSFdCia1Rcg2HaqPGdXmFHJg/R5po32CBAiOKl+p
	ipFVHqnK0tjZzjttddK2eKDfre2rBaX7reN1J3908GGqBq5KN7
X-Received: by 2002:a05:6a00:1817:b0:836:3f6a:3e77 with SMTP id d2e1a72fcca58-8415f17db99mr11156443b3a.17.1779650478457;
        Sun, 24 May 2026 12:21:18 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:17 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/36] iio: gyro: hid-sensor-gyro-3d: use u32 instead of unsigned
Date: Mon, 25 May 2026 00:50:25 +0530
Message-Id: <20260524192059.1193716-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192059.1193716-1-sanjayembedded@gmail.com>
References: <20260524192059.1193716-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' variable to improve code
clarity and consistency with kernel style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v4:
- Use 'u32' instead of 'unsigned int' as driver is already uses that and respective prototype has same data type with input from David and Andy
- Link to v3 -> https://lore.kernel.org/all/20260509101040.791404-5-sanjayembedded@gmail.com/
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c340cc899a7c..020812639947 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -187,7 +187,7 @@ static const struct iio_info gyro_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -209,7 +209,7 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -244,7 +244,7 @@ static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int gyro_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				u32 usage_id,
 				struct gyro_3d_state *st)
 {
 	int ret;
-- 
2.34.1


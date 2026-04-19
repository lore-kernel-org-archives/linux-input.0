Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8426F29C
	for <linux-input@vger.kernel.org>; Sun, 19 Apr 2026 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776621956; cv=none; b=a+PmHY1kY9gvrNEDsHwfeypL1O3OfUE/xr7YGPE3TM3vgFkIb7KEx/+857X5yGQEJw6yiwFb0nWcAS85DPaKLDUx1E3zvJOudxVwBGFCMdiCLNbc4KGNf4R9U6uF3TqAB6u+yvRDbDZ4S94QYOrVCv1pwkdZLIOCHL2oS/NyDEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776621956; c=relaxed/simple;
	bh=h8c6KWYSx2qYQtRw9RHF5rYrIdnVminbpAKG+xia53A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iLY9+QMS50aIWVBkyfxJX5CB7RNS+va45o+ZVuCkpNTUzSkm4z0PXbvM2RcUSQ9zXRSr4IprCLDkGEudx926l/3H914e0e66sruvKdhTANrPiQo6go0SmUapQ9VcvSK8G/XlA2yALB+IhS0J4m5B2pzr+pCRYk/hU4G1Rl0xQ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab0R5wF4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab0R5wF4"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d70c30767so1827418f8f.0
        for <linux-input@vger.kernel.org>; Sun, 19 Apr 2026 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776621952; x=1777226752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xuqLiO+tZUtflw20035WjCFl3ZnyOB0TyhLknS3UQg4=;
        b=Ab0R5wF4OCbPWI8OuqYAZIg9yJ4XPj0fBNDDanZPOKrPUcAwYmJXkWVC70V4DICaYD
         cz2/urNtaeSoLlgPbhCynLVto+lLBMcNKsImR9kVvEVGhkjq5m8/KMc/IDkGXrLt1DZr
         8joReVXDDlz9MbdejveBKTptKypwNBzxPZeIgnCxrkrD5rA1pKTJhnXdfGH22/ZKALAn
         HrXOahOeDv6QnNlDGGyHglGI+rmL5OnPAZi3HuNlQIBuco8WW7WW3Ht9bvyAUAiKuun1
         NITVC71GiBu6b0ExkN9AYCc1bqsQbos0E/hGBHU6GLLp4/juN/G1bQ0k3Uwo5kBtLu6X
         Zi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776621952; x=1777226752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuqLiO+tZUtflw20035WjCFl3ZnyOB0TyhLknS3UQg4=;
        b=Mx5u5c7jkp4EFadNMaeGSpJQQhaZgZXLS4G6XjOYpCDWMYxm287zffieOuT8e/ZzYu
         GK2AUPYWI6TrhzxcYF5rjHgvLRVQKEG7xMsboy0nxM2Yq7UubHmLfzPh1+Wffusl6U5q
         bSTRJMvERXlCYuTLPSX5ofcqlLR1Z9zfkDs9H6qD8x/gek74Ef77NRqE3XYf/+PDjhfy
         RU2fJLjIL6fL1+MPABhO++Xzqb90QUfd0+KpeYZ7EFRoz+Uy1v4mKr9uqKOWfjwvyB3r
         N13zPj8yFHRgL3E234yxIDVqnZO5vb8MjzWAVS2W78Ywb7tLzNRZsS8iioZdAwGPGJAy
         n3gw==
X-Forwarded-Encrypted: i=1; AFNElJ8lFGKZmHaKBwUpxt/lFyHP6AwxJe7A3u5dI4tiX3UUFl4xdDLnM7lpU0DyyXw7tMrPqxGy+/bHcAW4zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ0W3DrKrxNwyoF84tl4qEm0mZlZiRSaSRLN2xG0L29AaI9jaz
	e282RJ1JwIUXY3TAWol91XwHN2/9uASTt8k6+5G2/2egpAyz6bN+fWZG
X-Gm-Gg: AeBDievLEkWeYIh25Q5/XmCI0KYGaHsI/t07TeubfUmoegutoRu9/4Awm1rL6yglWz+
	ZWELBgkxNgEXplFHMdJIbNaOuUgq2JJOBlnxo/R5QT5DXxR8yDMh4SiTeeXgiPARAJMWT3O2Hpe
	f2uGc3Yof7ui8zd6ph0aATuitOEIQAxQ0duBwP8vkdYvgdXyFHvLG0SOvj+Ph8aF7F0rp8EJULY
	6jiPm3g5I9P+EVAwnUQ0+RXd939itkN25so2UB+VM3SdeGVvWh42gLQn+cMgIB0EimhOVoAUEFr
	usbluW3T/9c5LZ9sKuc//7mn3BLkgkdo5oanTF0YbSCtZIwwMxP162FQ7W2lNDAoo0DZ439zq3t
	ZA9YCCDm7a2JgYwRJdeWIlFbMONRBChkeCwfTOwQPO+VcxtPYEO1/0uaQW9aJEF/xO8vDuGOFWa
	ORs6fBnIvmm7Zwcg7+a6dsgk4lPJK4Jw4qlYxIlUmRph/v3Pc2mG9ucAuiZ2JdR2wLjdkVfrIsz
	3dgSsFepRYh9D8z/3b2iyDJgxgyuvAh83sCcozt4NvSrnlw2AVb5WJYPOyxx1GsIVCXCihrrg0D
	TAOP+D2BWQEHMoiABTayjGyOeiZK7716iKPNHd7l+or0b4PC54imTkkbwL1wJO4pN6uP8Ci+5cq
	zGzcCB2lGkYPShvDiKrfJ
X-Received: by 2002:a05:6000:228a:b0:43d:779e:afa8 with SMTP id ffacd0b85a97d-43fe407a7e5mr16800025f8f.16.1776621951557;
        Sun, 19 Apr 2026 11:05:51 -0700 (PDT)
Received: from localhost.localdomain (ip-86-49-249-181.bb.vodafone.cz. [86.49.249.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc26a3sm25685556f8f.15.2026.04.19.11.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:05:51 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2] iio: magnetometer: hid-sensor-magn-3d: prefer 'unsigned int'
Date: Sun, 19 Apr 2026 20:05:23 +0200
Message-Id: <20260419180523.37396-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'u32' instead of bare 'unsigned' to resolve checkpatch.pl warnings
and correct type use as defined in the hid_sensor_hub_callbacks struct.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
v2:
 - changed 'unsigned int' to 'u32' per struct definition

 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c673f9323e..b01dd53eb1 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -280,7 +280,7 @@ static const struct iio_info magn_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -302,7 +302,7 @@ static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int magn_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -350,7 +350,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec **channels,
 				int *chan_count,
-				unsigned usage_id,
+				u32 usage_id,
 				struct magn_3d_state *st)
 {
 	int i;
-- 
2.34.1


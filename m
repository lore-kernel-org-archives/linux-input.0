Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.124.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091168;
	b=gB70s9AMCVc4BNoDgab5emnWAWyl7MSW7UCaMHYk6he8yjJAIU7AQ6RkU8auVK+huNaP
	 RWyxik0rXQ9S5wSxMzPC1J4hk8iQzhhaBYo8HrX0TFEvrwJNpVihIlIOir+VdrL5hpSXf
	 RkvgabCSQAyoFEpMHGXXt/Bue54gqO2CLfccP2pGVs7JV1efJKuZH6aOotuTZOgIuw8f8
	 Kh2PRg0YrlRS61bEeP0ruDSys2NHzV99Oq9rryOkODwUJM4Lap7iQwPSw/mhrq/+jPw+Z
	 uee8GCkrPCE3WHuDhexYuhHjgb02njSKhmf+B9s/dsPun1VO+qkYjGKcv0vCmRDZxSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091168;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DAVtBClVe4SVhPYmaSsYLwMt+WU9YEmo+VdDPhId7kM=;
	b=XSuAS5JebAHVlejfy8es8VVA4/PpUu+Fik0mSJdXLZFHQALRloNKxYussaPp2nssVeIG
	 qWo7Cn1c1gMDD6xcJrVnj0Eup6e+hPIgdcRKUAR0LiI9bezO2ZsMXas9GcJOx/4Q7QNVi
	 nv1g7eCmdTSfbbmuIQQmU8qOb77EMngmszFbmjcToqs+Q3BdOTn7rmiIHcfW1OVpNCcl4
	 fAj++16lPcc+lMVk1m7Jew8zIpXxIl9xq/2vxtoDifCZje5DhQ5qqFTAhdpcNTXYp2XU8
	 KLxiyqmmn6XOjY47yNcaHBw+lAhXygJS+ySKk71aMltOt6s0Ko1PatGK0MqwHeeOlbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b="Tlt/w9Zf";
	arc=none smtp.remote-ip=51.250.124.99
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [51.250.124.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D7606A320
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 12:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 291D7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=Tlt/w9Zf
Received: from mail-nwsmtp-smtp-production-main-77 (mail-nwsmtp-smtp-production-main-77.yp-c.yandex.net)
	by forward103a.mail.yandex.net (postfix) with ESMTPS id 83C03806AF;
	Thu, 19 Nov 2026 15:25:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77 with ESMTPSA id uPaOb69go4Y0-quTnpOHf;
	Thu, 19 Nov 2026 15:25:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1795091156; bh=DAVtBClVe4SVhPYmaSsYLwMt+WU9YEmo+VdDPhId7kM=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Tlt/w9ZfnClt+/OgweSAIQAzieyNcYQqb3yr6V1lDrh0KcJgDptmCYbpURrBYMIyT
	 B7PFIVObu6WhAmXg58wbtDAvON78xRMe5Zm5Ilh8TVIkq5z70ELe0Hlt+ncv53yywE
	 lI36C3z/s5tWHuTqHnpppykuATVk1NBYmu4HiI7I=
Authentication-Results: mail-nwsmtp-smtp-production-main-77; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Sandeep Singh <sandeep.singh@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-input@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] HID: amd_sfh: drop redundant calls to memset()
Date: Thu, 19 Nov 2026 15:24:30 +0300
Message-ID: <20261119122430.494125-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.1
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

Both AMD SFH and MP2 descriptor report functions zeroes out
the descriptor buffer before completely overwrite the latter
with an actual descriptor data. So drop all related calls to
memset() as redundant.

Fixes: 1434f9fc0e47 ("SFH: Create HID report to Enable support of AMD sensor fusion Hub (SFH)")
Fixes: 93ce5e0231d7 ("HID: amd_sfh: Implement SFH1.1 functionality")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c | 5 -----
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c             | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
index ef1f9be8b893..ac7bbd6e05f3 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
@@ -33,28 +33,23 @@ static int get_report_descriptor(int sensor_idx, u8 *rep_desc)
 {
 	switch (sensor_idx) {
 	case accel_idx: /* accel */
-		memset(rep_desc, 0, sizeof(accel3_report_descriptor));
 		memcpy(rep_desc, accel3_report_descriptor,
 		       sizeof(accel3_report_descriptor));
 		break;
 	case gyro_idx: /* gyro */
-		memset(rep_desc, 0, sizeof(gyro3_report_descriptor));
 		memcpy(rep_desc, gyro3_report_descriptor,
 		       sizeof(gyro3_report_descriptor));
 		break;
 	case mag_idx: /* Magnetometer */
-		memset(rep_desc, 0, sizeof(comp3_report_descriptor));
 		memcpy(rep_desc, comp3_report_descriptor,
 		       sizeof(comp3_report_descriptor));
 		break;
 	case als_idx: /* ambient light sensor */
 	case ACS_IDX: /* ambient color sensor */
-		memset(rep_desc, 0, sizeof(als_report_descriptor));
 		memcpy(rep_desc, als_report_descriptor,
 		       sizeof(als_report_descriptor));
 		break;
 	case HPD_IDX: /* HPD sensor */
-		memset(rep_desc, 0, sizeof(hpd_report_descriptor));
 		memcpy(rep_desc, hpd_report_descriptor,
 		       sizeof(hpd_report_descriptor));
 		break;
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
index b81a97dbb1b0..b92e80035652 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
@@ -30,27 +30,22 @@ static int get_report_desc(int sensor_idx, u8 *rep_desc)
 {
 	switch (sensor_idx) {
 	case ACCEL_IDX: /* accelerometer */
-		memset(rep_desc, 0, sizeof(accel3_report_descriptor));
 		memcpy(rep_desc, accel3_report_descriptor,
 		       sizeof(accel3_report_descriptor));
 		break;
 	case GYRO_IDX: /* gyroscope */
-		memset(rep_desc, 0, sizeof(gyro3_report_descriptor));
 		memcpy(rep_desc, gyro3_report_descriptor,
 		       sizeof(gyro3_report_descriptor));
 		break;
 	case MAG_IDX: /* magnetometer */
-		memset(rep_desc, 0, sizeof(comp3_report_descriptor));
 		memcpy(rep_desc, comp3_report_descriptor,
 		       sizeof(comp3_report_descriptor));
 		break;
 	case ALS_IDX: /* ambient light sensor */
-		memset(rep_desc, 0, sizeof(als_report_descriptor));
 		memcpy(rep_desc, als_report_descriptor,
 		       sizeof(als_report_descriptor));
 		break;
 	case HPD_IDX: /* HPD sensor */
-		memset(rep_desc, 0, sizeof(hpd_report_descriptor));
 		memcpy(rep_desc, hpd_report_descriptor,
 		       sizeof(hpd_report_descriptor));
 		break;
-- 
2.56.1


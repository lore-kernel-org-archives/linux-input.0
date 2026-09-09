Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DACB47127B
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946785; cv=none; b=p7XavargSZ8hUq8kv5VzFpeUq4jotTsPdI6F2Mr9Emvd3X6Kmjemmncgxf1OhH6radLdJS9KCPTRy717h9rmT9Fg8ST8fJNh6XUqVoPGNi+36JgJE+tuuIN+KVYqHrQaJxpYsXr8iJhxOLjUiM76KkieV/CdJc5LDDhkRStyHqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946785; c=relaxed/simple;
	bh=IrhlDnu6UqVr6ZzUV11lZIiY71/Cbeg6Wqd7x/5D/8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezQaUH3qmjPtEIprHMSQsTac1m28fRvFetdsyfScpYSsR3mA3uJgszeCxS2reybcVufS0zCvPRTBl7JSRLD17Kyif7T2V5jDwu7nmrSva7ENjZ8M7KvLWQBl4XoWTuxKNdqgN3wYJl8Y3Vk7eHVXOgej08dGkK5Ep1c2b25VQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MQdA5dsL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AcunoqMj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MQdA5dsL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AcunoqMj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6896rAb1045619
	for <linux-input@vger.kernel.org>; Wed, 9 Sep 2026 09:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=23pCnDlotWgSDzZtGBECCQKx4TDiJuMFHwx
	4UVLT8O0=; b=MQdA5dsLmyug73OiXCBvXc0RBgK5rXAg8rpfqTXsw14auOEyaFz
	H6h6hGCqukQ0vS87e9LwvRD3uDEaXFh9/zLiNf8ZpFJVlqbq3yDKzucfr791xCzu
	t9Sp1BVVFZFxb2bhcgWqUKrbfbCN3RSrJ7euVgMPmr+4dgG4zklz1gnLTV3U097v
	8S0VohIb50ziU5BJbun6cRi67Otw33JPxRxHlFl5MzhK4csld5N1onavYCaFBm0A
	NTgwfIcFHAKocw2xnQPI7ievmuUC2cV6llAaRBIk6tNtRWGvySsEmQdzhHWr4nc2
	Nf6b2dirBPMLRn3rGOoZMTGtx9eHbip8Urw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqewk9gv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 09:39:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9390a2c895bso1144016885a.0
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788946777; x=1789551577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=23pCnDlotWgSDzZtGBECCQKx4TDiJuMFHwx4UVLT8O0=;
        b=AcunoqMjky2bf95zoNgcettbURN2ZFsXZfKXFQ0kJjpiBn5zB3DOS2Grxoz4EkYjJ2
         xeF3ohi9B9NUAhQUcfMMUtbbEJQIJ80Wp/BmCcn54SVlSrhFSf68vwk3C1cybPf2BH9Q
         qd6zcANasnyT5a0d+EhgvtNEhZBX/U5VbmrljqZFx17cQIq+DEm3UhnubJDpiS3FBtzP
         mDOPVgViq97z34xh0K1akhfClKhmO2+xYgBmWP+Tcs8AyZN+4TWkuy7TtBjYHJ03impT
         xrFfmg0kHROIdv2viCnFSn88OyzN2h08F4BHT+pxTK3siQzGGxw43P6grzZaUJqIFGpu
         1W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788946777; x=1789551577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=23pCnDlotWgSDzZtGBECCQKx4TDiJuMFHwx4UVLT8O0=;
        b=gmFIwF6vWiZ3XfFVqk7d6j9/qGXTOwcxK3AC1cBCtqdaeLIKqWPiXwsqlooryZ3SL8
         cBDKyeUOFY4c6WKUqNAnq3qS9dEcLLVg//awS7HkMS1UfTxWN3VG132oONRu1HA7xxaa
         hxC4yDzszObzwresFiiDpGRwquGkfK2WiGtTCIXttl9hNgIVwZb0AX+f2x8Cu4/mvos4
         EHRFYHZFNXN0biDY8rMUbyT8JYrQjdcVLQRbYWSe/4MNj6N7I9rKdImAqVHfzmSZ0agU
         ytIU/UjRTyNKz70Dr5vFTXo2/aEf/RgUwrWVHus69RFjz+hR/dY+5QrUTVe787k3QG3K
         fvOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHkMeS1HMvBXW696ctjDI7lwgfSCMNX1kvco2suTbW+4PK/nF7h2KSej6ELBZExNYgvG77Fdb9SVO7qA==@vger.kernel.org
X-Gm-Message-State: AFuF++mPeY8PkIrYLpxc0Cf1Uv/dh9yyVIKeXKvkT0fawy5D9uuwizvr
	9BUbXcrzs1Mae+u7PCSMxxl2u560DnNQJryywIA9S3V+AwoQknape0nccTrvZ9WHfqNEOp1R20Y
	vxpbmdRoyWGAekDQtMOgxF30YKPXLSqKpxK/NgyV5lS3sz7XJEpRL9SgFvXusPkRXYbLU4RE78Q
	==
X-Gm-Gg: AYBFou1f2+crnHWx45SPqk5OoyEkOSlhKhq9mYXrUPHH8V2HaLCMnIM8hcDnfU8QRGN
	M6QX+XnuYO5il621B7JJQUuN5sHICiwpT/r66AvQK/AvdUy0oIlawhArDp/dz/znxuUSM5gcG7y
	cRX8tuglTuQRMe4Xcq//TMmpa5Nfg2e2BEAtpg/nE3O86VIdoazhDRkkkaLDzK0HnPWRYdHl6v1
	OwB1XwgLc8OmchWvV//aXmZBm6CGmFOW0bVQLWsQGi/zNlcTQz77PjQ7ahMbhCT3K//IaMrg+6/
	PzjS5cBpJEkflUKRBoJCh6jc3Q+Wtnc1nk1A8V2tnBiwy/uAMEqGS4BfrHtTLQLYHNTaImwg63j
	HdLIZDW3ZkgzNqfobJ1+GnaxYcovIlciQQD2SYo6t23GONJapfwEOF+u5edoXT/w8GR6VLH/ZyH
	stUQ5VD7W+GBDCVjM=
X-Received: by 2002:a05:620a:3199:b0:939:7f6c:fdf with SMTP id af79cd13be357-939805e9ed3mr3740260885a.15.1788946776680;
        Wed, 09 Sep 2026 02:39:36 -0700 (PDT)
X-Received: by 2002:a05:620a:3199:b0:939:7f6c:fdf with SMTP id af79cd13be357-939805e9ed3mr3740257885a.15.1788946776288;
        Wed, 09 Sep 2026 02:39:36 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68a6e19sm6387800a12.10.2026.09.09.02.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:39:35 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        stable@vger.kernel.org, Sergey Lebedev <lsa.uz@pm.me>
Subject: [PATCH v3 1/2] Input: soc_button_array - fix MS Surface Pro 11 probe failure
Date: Wed,  9 Sep 2026 11:39:33 +0200
Message-ID: <20260909093934.29411-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cpirVV4i c=1 sm=1 tr=0 ts=6aa12959 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=wgnLJeN4XU_MoIAHw-4A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Ig1Q1niuWKXjAwyGufqRGbGlGsfat7dW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwNyBTYWx0ZWRfX7EzwpXnKQ6Md
 NptmlcH2nmZXMf9Kp4Hs/IIfTqupaE7HiWnKhXJ6g0jQ/mUomHrNFUG0mivnIWmJ9so9qMarRJq
 N3Y+TVKtbvDgpNk8A5GlEXn3e6VLlO4Taazs3RJsZ2n5VfbzB0xfQSYSJO4paG4Nze6DndUlgGL
 IvR502ki+iK9+qqLmWNQT7z+BsYExTu0k5FThfE0tws5kG1M0NdNKz4nDcNAQFeRsjAOZ26B0Ah
 sDqbWgjovlDCkGDx9u1wwmh/xJlVkC4uhDm6xgeujE1ZpUB5qQ2RQxWfubbypwnfMBA7p9lX5hw
 oXYr4lT/s9JCr5Rkz4DUdEajaxqrB1zrWRIFtLAMZacEhHNBsYxrLC1+oqijSTAQKq0WAlY/IC+
 KkAswG1QWygHulm22GiiqY8F3H7ZgTj+Q7Tj/1ULcQjErCGwmfVaLzUnfuiI3HttO7NAl9qSvH6
 DC17TqJXFW7dpOFeGsQ==
X-Proofpoint-ORIG-GUID: Ig1Q1niuWKXjAwyGufqRGbGlGsfat7dW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwNyBTYWx0ZWRfX8VPGjK/c6FIs
 pq8H7+zLwjDkLtXgfCwC9mMmn3QlWqA9p4G8Qa200MlsZ2e7MrMMk+Un820jXWRKYbWcf6wVxna
 seREBOSSXud1T28gkGtsBR5t6aYwq9Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090107

On the MS Surface Pro 11 soc_button_array probing races with the GPIO
driver probing. If soc_button_array wins the race then gpiod_get() returns
EPROBE_DEFER, which should normally take care of retrying later, but
the soc_button_array code deliberately ignores EPROBE_DEFER causing it
to fail its probe() which causes the volume and power buttons to now work.

The ignoring of EPROBE_DEFER is there to deal with a problem specific to
older Bay Trail (BYT) and Cherry Trail (CHT) tablets which often use this
driver. Modify the error handling to only ignore EPROBE_DEFER on BYT and
CHT platforms and propagate EPROBE_DEFER normally on other platforms.

Fixes: bcf059578980 ("Input: soc_button_array - partial revert of support for newer surface devices")
Cc: stable@vger.kernel.org
Reported-by: Sergey Lebedev <lsa.uz@pm.me>
Closes: https://lore.kernel.org/lkml/20260830141355.55898-1-lsa.uz@pm.me/
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
This series has been tested on a Bay Trail tablet which needs the ignore
EPROBE_DEFER on BYT workaround because of a PMIC virtual GPIO.
---
Changes in v3:
- Add Fixes: tag
- Initialize irq to 0 (invalid IRQ) so that the new irq == -EPROBE_DEFER
  check does not potentially check an uninitialized variable (Shashiko)

Changes in v2:
- Also check for irq == -EPROBE_DEFER (Shashiko)
- Drop #ifdef X86-ified soc_intel_is_byt_or_cht() helper,
  linux/platform_data/x86/soc.h already contains non x86 stubs (Shashiko)
---
 drivers/input/misc/soc_button_array.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index b8cad415c62c..264c41f80d2b 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -16,6 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/gpio_keys.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/x86/soc.h>
 #include <linux/platform_device.h>
 
 static bool use_low_level_irq;
@@ -160,7 +161,7 @@ soc_button_device_create(struct platform_device *pdev,
 	struct gpio_keys_platform_data *gpio_keys_pdata;
 	const struct dmi_system_id *dmi_id;
 	int invalid_acpi_index = -1;
-	int error, gpio, irq;
+	int error, gpio, irq = 0;
 	int n_buttons = 0;
 
 	for (info = button_info; info->name; info++)
@@ -191,8 +192,9 @@ soc_button_device_create(struct platform_device *pdev,
 		error = soc_button_lookup_gpio(&pdev->dev, info->acpi_index, &gpio, &irq);
 		if (error || irq < 0) {
 			/*
-			 * Skip GPIO if not present. Note we deliberately
-			 * ignore -EPROBE_DEFER errors here. On some devices
+			 * Propagate -EPROBE_DEFER, skip button on other errors.
+			 *
+			 * -EPROBE_DEFER is ignored on Bay & Cherry Trail. Here
 			 * Intel is using so called virtual GPIOs which are not
 			 * GPIOs at all but some way for AML code to check some
 			 * random status bits without need a custom opregion.
@@ -201,6 +203,12 @@ soc_button_device_create(struct platform_device *pdev,
 			 * we do not have a driver for these so they will never
 			 * show up, therefore we ignore -EPROBE_DEFER.
 			 */
+			if ((error == -EPROBE_DEFER || irq == -EPROBE_DEFER) &&
+			    !(soc_intel_is_byt() || soc_intel_is_cht())) {
+				error = -EPROBE_DEFER;
+				goto err_free_mem;
+			}
+
 			continue;
 		}
 
-- 
2.55.0


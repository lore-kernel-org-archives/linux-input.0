Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558A4A0145
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903857; cv=none; b=LDztPqduQjHrOZFFH+bCHZ+0/WqSv8q6Lp80olpE3MH7x9atisvvEJ1ChyIXk+ZpWjzAU1uxYZNH6xbaHWHp75m+NYzRMAaUKtVRuMqtM/1hr55MyBdO073iUkYYg8qFbgys5nDKKOdHn1Z0afKVbQOI+EgKWFpEU+SrUciYnMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903857; c=relaxed/simple;
	bh=2dcs3QudVmcvMbdV29fKyRaEWun6j5+/AGxr5wEgT2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8oeqhJhWhSvIcNcyycsPugt6Iy+ZAVEF+O5l39kyLkS7DdpwFkbCJ+m5g0TV81e2nU5GBlr1g4gLOWwG2trTYlWwTdNc4pfSg4aPHd3WkndQzLyA4TJ2c+p9G3hHea3TMBu8ItJmZpwtloJgH/R6D4DJGSeg3QkzreyHFnKW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i8JzIDGP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VFBvlxoE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i8JzIDGP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VFBvlxoE"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FduRj2770709
	for <linux-input@vger.kernel.org>; Tue, 8 Sep 2026 21:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=EE9LBvsMzOCWGBTgLFvH62d5vLdoOJlhdPF
	YwxqaNTY=; b=i8JzIDGPFw26GQlWlGOMIhsg/u+FiuRgWJ+WDG4eZU3CeTeaIGj
	QjHuwtSC5vqx21kA35E/mVR/auS3gL3JtDasjak5lkmsPgCtTTIlAzS99wRbiu3o
	K3kTo1pLi15Stsx+FpRK4Y2J3OXeml0AjP08GwNa80iN/RBdnbz6Ew+0ElIExEXs
	bRdFFyg/yTRIdIVTqm7jykBb3litHTszLSxx912S7hlLnfTqxn7298c3S1APzZRE
	eR5B8qbqeJnhWJ9QXcQbwRplUgrIze54rL9+jCWNsCxgWdPuDevw0dCrgS5PlmxQ
	bp2ZXlEkmynF/ayoqeSWJ67eQMzsbsVigeA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjjvujdnj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 21:44:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9399b66e0e7so579041185a.1
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788903854; x=1789508654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EE9LBvsMzOCWGBTgLFvH62d5vLdoOJlhdPFYwxqaNTY=;
        b=VFBvlxoEFM0OXa6pKt6XJSF6caqpCTn5gGw2RcW0j30BTVAbiuwqnX5Z0P0AFeHRa4
         qx50WWNExMoe5WRz35bekD8AiPYl7hmp3GEeM5TMR06DNlw7tAWyvJ6V0i6RPwkHGN7U
         YXGyZwqPatKJECizWrw/F9/6qG7TUmdwGS6A4erqGJsfeJsn+TA+X4iR6h8J+nseLTy6
         +RW1Sbjzcfn0K1uAckL7YB0237nihJ8mEusvFbogDJupmV9laFjA/yv+1/Ojw4JL+RSp
         z1MpWPkPDCYWN9vcuVBlJlSjesufpT6yIUjhYKKQxz/ghT/Uuar89upqMeB04klCYeKu
         DPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788903854; x=1789508654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EE9LBvsMzOCWGBTgLFvH62d5vLdoOJlhdPFYwxqaNTY=;
        b=j/AOB5iDOGsDZje0ZKproU9h0Vd7SbPcPYkNfr2lRFmyxoy9Tjzttn/2ZW+eTIXcVb
         FjpzleTTZGvHDPCFN3IxkvDzDKULPs+fk570iaT7Kd/j5iuXsJV29ngOElr/MKtBKacL
         TE4N5vCvJvXEYLLA16//IYmpRKg1rQg2vqSMGEV2vkcZDbvavhQbr2Oz1AYSpuEO0S5r
         +q/wtP5FQpU4otWdHMBLOIp2zxDe4SIV2OMkb5G+m6K3fIFEEpKSwkkN+FgzMbvTXD6j
         yQCAoyPuuPOkC9w//kjfXCoIy3wFlk68A6RyykODAuCouHUQ/PyKKl6oC3zjJVb6j5Lp
         FB1g==
X-Forwarded-Encrypted: i=1; AKwUvBxvwvvpwkyiLFl4M78EdTuXPqzcUCqBDVE+X6Tg1oe5wMl6tk3EZ2UAhzVmYjn/2KIs04lFwLN3bcfucg==@vger.kernel.org
X-Gm-Message-State: AFuF++kJH2QIRCcbBTwZjFMaHK8JCQfSAEVuq9D2GyW/cCSzcPaT35Ve
	m6icBLMdNvma565IQX7s46UX2OzEtzt0jBI2N0MbaVNcb0cfwWnAYMfzJY2uCCAtMsd/1o+Z1HA
	igBdZK3uyzQNpH2KA6DECAZrtYkaQpLCHgcxVvllYOEpTVxlJSnBLvqB7uNXO5kEpbw==
X-Gm-Gg: AYBFou0TQfTXtO3MCPmNqJFz2jRGixTx8gTf5fYyUv3SJdIAasE/6MiS8UMzKkJCcTT
	vdggJYKNmqPwZ+/ZfmNZ1Y79j1ryJyDDr04Ll1gHmLlcl0BR9RXXJlXMlqnRXhsFf3h4EKdHORl
	vjBxCpaysKtjTSbeiUIrMo2uVG77omH/W5bliz5keVd19lSBf3Ez+WaPzkggs2vg8bvnKpXNVd7
	bsL8QVr/1aRasYQ91cDtUwE4K6ilg9AN8ZRLLxNm4k6ew2+STXymPOAecMrXD/DBVb3yC2bkq3X
	E0PaAxGgnv33wtl+q2UwQ1R6plaIIa3l2Q6iUobk5ue6MWzlncpWxVo/ikmjzgvfU67P5IukwL9
	Jz8utK0a1pRJQDDFsJM667cmZrR4nhDZx2LFo9kiIcDBipv1jWhbFpvOj1oieyka/0ZreufWotc
	Ui8RR713QmBATpSgw=
X-Received: by 2002:a05:620a:454c:b0:939:6dee:4b09 with SMTP id af79cd13be357-939804ec4demr3330029885a.51.1788903853981;
        Tue, 08 Sep 2026 14:44:13 -0700 (PDT)
X-Received: by 2002:a05:620a:454c:b0:939:6dee:4b09 with SMTP id af79cd13be357-939804ec4demr3330025785a.51.1788903853442;
        Tue, 08 Sep 2026 14:44:13 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d6e1c93sm673546466b.63.2026.09.08.14.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:44:12 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Sergey Lebedev <lsa.uz@pm.me>
Subject: [PATCH] Input: soc_button_array - fix MS Surface Pro 11 probe failure
Date: Tue,  8 Sep 2026 23:44:10 +0200
Message-ID: <20260908214410.70422-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OAlpueroZEB3ZxGjxDKwqMsQwIUuP_Zq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIzNiBTYWx0ZWRfX/JBDfpF/XeuY
 yx7ebs4EOLbyxhDgNyxUVcmXYmNPcOV6MyDkC37FcNRpQQqrrZePGUEsSI6HnlyxcrhzL3soz+J
 Y5Z/g+DiGM2/cpOckMJhM0gW0up2BwjqcudO/VpumBIq2HfnWezSBL9tct9z12lOH5c2HFahIrt
 mGCRONy7m9hAbX1KFtug37HRZ0XCWiDeeUaBHzzcBuFeFbMRJjrr7CgvygjWsh44gGFPrwTsUKq
 0/vv8ngWx78TQi1lBlwOvwMzxeY84fhbQ9uE6IJgAIDrEnU+YX3TVHjZOzmkhV0H+zbsZCbCnlQ
 Z2WCDUC1mhMqtIGmYofvZjzcX9bNY5sg9GBi6ekyWyV6IncoybVfxDfYkncOPHo0LUVh7c1vvh6
 pqFfMwx15HdKPPIA2CwtHce4EgWlstrJhkkPIqpvD1pNmB49/cFFTNk/QjH6wtp45C4srKGvltv
 2Nblwtp4SsWT4IpYb0A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIzNiBTYWx0ZWRfX2owN6pcdTXlH
 XDPo6AaBl/byDwtGUbe9iPQ91d6ZuVg9Eo9O6v89DBMPk4lLrPvBkikriONV9ddzHHcM4tEt49q
 Uiqh6i8aNotfljB33HjdLBneq7KwNIU=
X-Proofpoint-ORIG-GUID: OAlpueroZEB3ZxGjxDKwqMsQwIUuP_Zq
X-Authority-Analysis: v=2.4 cv=X8hi7mTe c=1 sm=1 tr=0 ts=6aa081ae cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=icoHmF83wIaDLuXB8S8A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080236

On the MS Surface Pro 11 soc_button_array probing races with the GPIO
driver probing. If soc_button_array wins the race then gpiod_get() returns
EPROBE_DEFER, which should normally take care of retrying later, but
the soc_button_array code deliberately ignores EPROBE_DEFER causing it
to fail its probe() which causes the volume and power buttons to now work.

The ignoring of EPROBE_DEFER is there to deal with a problem specific to
older Bay Trail (BYT) and Cherry Trail (CHT) tablets which often use this
driver. Modify the error handling to only ignore EPROBE_DEFER on BYT and
CHT platforms and propagate EPROBE_DEFER normally on other platforms.

Reported-by: Sergey Lebedev <lsa.uz@pm.me>
Closes: https://lore.kernel.org/lkml/20260830141355.55898-1-lsa.uz@pm.me/
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/input/misc/soc_button_array.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index b8cad415c62c..6ed32c622d53 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -149,6 +149,16 @@ static int soc_button_lookup_gpio(struct device *dev, int acpi_index,
 	return 0;
 }
 
+#ifdef CONFIG_X86
+#include <linux/platform_data/x86/soc.h>
+static bool soc_intel_is_byt_or_cht(void)
+{
+	return soc_intel_is_byt() || soc_intel_is_cht();
+}
+#else
+static bool soc_intel_is_byt_or_cht(void) { return false; }
+#endif
+
 static struct platform_device *
 soc_button_device_create(struct platform_device *pdev,
 			 const struct soc_button_info *button_info,
@@ -191,8 +201,9 @@ soc_button_device_create(struct platform_device *pdev,
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
@@ -201,6 +212,9 @@ soc_button_device_create(struct platform_device *pdev,
 			 * we do not have a driver for these so they will never
 			 * show up, therefore we ignore -EPROBE_DEFER.
 			 */
+			if (error == -EPROBE_DEFER && !soc_intel_is_byt_or_cht())
+				goto err_free_mem;
+
 			continue;
 		}
 
-- 
2.55.0


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C245DF4F
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944847; cv=none; b=HQQR9Br5jrSytN7XSSmOKnpadUgvb0PWPf9g+u05sH5Ihq7ToZI7gZAGXejwwEpMxMNjNOWiZpOHC09GKYJsAfCzVnoLQ5YTHEqBJtUnx4AyvyxvgEwVGG0y0uI8IJHoTCP8oumXfbPVyZ5YyKObJdFd0pnIzdoLN7kQRoCaXpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944847; c=relaxed/simple;
	bh=GEo+KLNuYWD470niKMt1m8IwniIXTQrURaOkhkXR58M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dVpUpYzyVdu0NziikMbz/GGQNENoYZ1QkYSP5N1yz8rXSLKldmxBqBWCJy1rZxliIk9VyZFdRuLoJRZjdTG5gerggimoMFJdND8g8ISDeLorldtPZyHvqjdOl8ntZ/E5pQbBNrikgSkrE2lK/MjPWEZ3bvqrvoiVY6aa4VlVz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DrCOgCma; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GbCjYaRF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DrCOgCma";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GbCjYaRF"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6896LBis481991
	for <linux-input@vger.kernel.org>; Wed, 9 Sep 2026 09:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1GUsIpfmqVZXnIdvllICaLTdJvFQPvOL7hK
	5SbmLcew=; b=DrCOgCmatfzuKvdMutYS+sgTKbHHmQcwiNiJl9UK+K+vEq9nNJ3
	dakhjbGIzXOwDQMW44U0uTE3pmYZJ+Z2YUAfPlM94cuWLDZk5oq1Kfvs1uggonSd
	esRODBYW3qxsSKE2YYOsz//y+kJaKxTg9wCVhgJcyjRb4gjAyB1vMfWmjOkimQQu
	NBldgKrq4WXjEp0D89KKQvR+qEsBN1fG0YmrPu5uwerJ1JngR5rOTHdaB6JDgZLq
	hId5pdJ5njw6uiCucQ4DFRWS94Ocqzj2qQ8ox4SlgSyij7QFqqJinTBrlJHNn7QL
	soVMMqkpBXMP55/l/pGmGK8JdBuRlzuqmeg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqf1k55t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 09:07:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e4f946461so1008934785a.2
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 02:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788944844; x=1789549644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1GUsIpfmqVZXnIdvllICaLTdJvFQPvOL7hK5SbmLcew=;
        b=GbCjYaRFRiUIuTTiv4i1beVi0Ayt4GBNEx8x9PuR2WyN2yqg0GlZG420OGQxwnty3N
         GKNuejM8iMbXKoTk7+maWe1dyZR7ntqjHCjanoeM9eBeE9JTrGt7lUp6gRZmMAKjV0G8
         aqGtxn20XpJCYOrnjs4K9h/f+hswIapjWIjCkUJJMYlEjBI8Ia6pzqXIBUBHuIch6m9h
         Rpw0X6zjORYTopKlXisBdvM13CAmgwLD0kG/R/7SaVodgelgQSttaYsYmIh8CdZ1NnFv
         3dg/nzfcU7YbKjo//ZOKeHvIiyMJ5tj4hxxKfXYREdpz9VlQdJvEOfQ4g+P/dD/nFTFe
         cG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944844; x=1789549644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1GUsIpfmqVZXnIdvllICaLTdJvFQPvOL7hK5SbmLcew=;
        b=JNs2Xx7cpGllUQkX2lGqRD6RAfgegl0DitN6e2qopP01oXU4OlvMDnzKAEKcF8paz9
         FomWdloeanUe3U3pFGscK6ZKixXRrm++2BoxoFOZQOJ42KMKj60iKiK2S1IuFaEJk27v
         ZLQkP3b77NBGwxX3b/qgbM87JSlhg3NY+Apy2LDbELjaqIaF7PkAo8OXchd/hpIc6Q2K
         kxxMCr7cxv6Q0/ZsQEnN9wlFW/oqvFV8h0Q0ubAc64svsU8LMz1WYesLVaKnMro1xKUY
         8nDIfw9Vx0KKo9a/rQ0Tp7wlMQoe4uI5RqPVXa9zerAfyRwMFgWrgDEF2vDzYIhljosG
         NrrA==
X-Forwarded-Encrypted: i=1; AKwUvBwLyyx8vLBk5FwL80uPLiMib1JXxEI45EpdIGflbxkCjuTLOnxVy0ChhtyVqNEkYXlX8YfiTyZxmu6Sjg==@vger.kernel.org
X-Gm-Message-State: AFuF++kn/YnAmWR5F86cZd+jLlxf763yih9R2sCoub8i7sRGu216C3vN
	d+MQEQQesfeke9E4wt+RHqMBL++xrtc+eBX2YGxvk9w2HewaJQariEJgKjRKeo/JVkrty9i0/MB
	EfCuMzhD+NK53Ind1gox1R3NfjD0tnVlsaJ/vXzxSqzuFkErN08wbH1QQVImfOs7ipAVLZ29JNA
	==
X-Gm-Gg: AYBFou0vRgQCczgOrnLHDEvmsPAHIuWug+mV0oa2hyxADk/urWrppidT43TLYm4TPNc
	alR0t5wm/IHwkSiRfSEfAGbjT22q5D9WhZVHSloFLrmBOo/w9WG7tQBWRNk95GkrUhWeVZuciNx
	G6/c78bXeYeU5GI6NgXN6aG6WVMM6/Y0vM3MPN5iAmq+Ip1/Zhi3ZI7DzgKhfUlksUofxKTCh7D
	BoxR6oW3MoAvrG6eKtyE5/UQIzxqfq3vdIxLcPgeyfAKz7SozcB1BFVZg80qAmsx/hbx6dZBnDk
	Da80qaCpa0C8iO05sy3eO+qXuSxfSrBuiAPMpgAGsiQOHxv4n++K70qq7WwtGguohWdnnLQhbAr
	Hxtc1yac1MrcNoFf6DL2ooLSZ2zfJ508N3P+xzXf3iCEmaKxdYegPgHxQ/TRVUkrCNCixplHZgT
	H7XV3gGHrAXlKwfXM=
X-Received: by 2002:a05:620a:280e:b0:937:6d2e:d023 with SMTP id af79cd13be357-939c94a6e84mr596491885a.30.1788944844117;
        Wed, 09 Sep 2026 02:07:24 -0700 (PDT)
X-Received: by 2002:a05:620a:280e:b0:937:6d2e:d023 with SMTP id af79cd13be357-939c94a6e84mr596488085a.30.1788944843654;
        Wed, 09 Sep 2026 02:07:23 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4aa166sm722851466b.16.2026.09.09.02.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:07:22 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Sergey Lebedev <lsa.uz@pm.me>
Subject: [PATCH v2] Input: soc_button_array - fix MS Surface Pro 11 probe failure
Date: Wed,  9 Sep 2026 11:07:21 +0200
Message-ID: <20260909090721.20869-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwMSBTYWx0ZWRfX0gr9ml8yuPno
 n0yW0e/YL+r4ckHzFvqRSa0HRbGVdHFBrf3vGYXBoBDrcP8A7Hkj7AfCcEG3BVCy94J2eTMCVU7
 xqW8XufvaWwymQLAGuMQopg/RXLEeaWiZwiZunrq2q3P94b7Sxxt/kAPFiLjwG01x+Z0Mo9SD5c
 fYwQ2PcDMmlvezzdPWiNoZ99phu+EMbpAqyNnjwBqti6qSTIr/ijp3eISxY6igVsJ+fCYCbX3qX
 LJY/21pzA1I5NTR0b7ZYew50H02tSESR5bwGAtifh6mNoNeJlxg6VloYUBQibSjmo03mMqTQ/kx
 iXMCkycpkH6rOvVTZlfmD2U/fSntOqX+SRHKAfJiQe4zTlKEZe4ocb6Zg3C7yAnMJdk79zZkJ43
 XuClJeDQnEzwVOTDwmxdTN8UuwDAiy56EirQ/oEZezvrlo4llb0p7AgJjwWhRgZ3TEmhgXf5qC3
 roSCbhaTXM+Y0H1+q3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwMSBTYWx0ZWRfXy8FUm1i+j6kd
 15q7vkF2RegUfuMTtbIeyapvqgJJSogzPbjLskmnqam+Nf9LBq5HUivk0fmSE0GazfbYQ9yF4CI
 XFcly7EOP7jVKx8QTIzfmJdm7v5ojCk=
X-Proofpoint-GUID: 7o-Z0bIDn4KlCC1dqppRa6DIK6hdjwO3
X-Authority-Analysis: v=2.4 cv=JY2Ma0KV c=1 sm=1 tr=0 ts=6aa121cc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=icoHmF83wIaDLuXB8S8A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 7o-Z0bIDn4KlCC1dqppRa6DIK6hdjwO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090101

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
Changes in v2:
- Also check for irq == -EPROBE_DEFER (Shashiko)
- Drop #ifdef X86-ified soc_intel_is_byt_or_cht() helper,
  linux/platform_data/x86/soc.h already contains non x86 stubs (Shashiko)
---
 drivers/input/misc/soc_button_array.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index b8cad415c62c..f838b7d72e49 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -16,6 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/gpio_keys.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/x86/soc.h>
 #include <linux/platform_device.h>
 
 static bool use_low_level_irq;
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


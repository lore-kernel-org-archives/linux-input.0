Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59244746B4
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946786; cv=none; b=SBQC540of5k4A8OYMva1RZ6JL4QStgFFXNAA43yoYfXU0DxehoyKiB83QrwQwKlY8oGPmPui/brezLrnb5KTfc0nN9V9SnL0jwdNTpWmUwA/Q0RNWL3gKvYG4ACuqxeow/FWPxKce7Z3PouGQIj3z2gIS01Qy2GyGc73Hyh2O90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946786; c=relaxed/simple;
	bh=w2vep/69OYe1Fjz3Pz5QMys34XOdM/k6R5vqYZm7NTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvqTQMJIg+puTXyZdo3RDpHVux3vl6vPyxfzeUpKD3paXGil+ntpyf6s8Q/WekoXXMQa9emw5KXfH31soXA2wPiwg74jRviKNmNiCD408kF60QkvqZ3dxmRF6ntX1cyMES6NqdNViEv+BGFIyJzSUES3p94yl6nuL0BPWNYTe7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e5AL6wqv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rbv5HMfV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e5AL6wqv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rbv5HMfV"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6896Xcb71274451
	for <linux-input@vger.kernel.org>; Wed, 9 Sep 2026 09:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VRkHmq5v0Xm
	mKj/bVTSxCtIOk/+XAtwEkO7O7C7PJDc=; b=e5AL6wqvCIlCXJUjUoAJyGMTG3y
	SGuoGcAw6uDhzl8jVeiT93AVUyMdbTMfD5lm8oW0Dzz5t5lMZnKUmQqBmuhG2W1/
	6T73E1aEFrf5XIMpCtD8yGigIV79cTjaZicVFKTAhhv1rLvJAt61UF60AVNs54N4
	lcyLT5D0aU/5t49Q1h8L1pRpnzR2UPBdsWHf0oB8sQgYyvJefVH1rWrD9Rzm8AMq
	S4keP7VrILx4jwNhqT+crkABAZaER+eCXvx+PH9OLsd9MmAZAUxeMm9K2Bajkh1z
	vX4s6sEZIT/6m/Eq75k6RoJiNul8wz1Cln1UEruXSalXrpay54xDMej1i4g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqdw3e2k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 09:39:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93915f50a5cso1328652185a.1
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788946778; x=1789551578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VRkHmq5v0XmmKj/bVTSxCtIOk/+XAtwEkO7O7C7PJDc=;
        b=Rbv5HMfVIk7Ft2bjmAbW2OkvCW50z7XrjrVK2WNzS9Icm4pMW4nuSH6OWxRcmgyfgD
         YpSf3CrT/G4X4pWI+NIBKfc3Nmop3TLmqHH5/zK/n6uXxIv/BtpuxAsJ+kuTG872NOOl
         IIODOilVLAoCCT/9hfU5w9Lh+0DJIrXvgWDqiYm34vghC2jFIf+zrK7LY/eZSFfdPThJ
         mAXdvfBCVEKuwHk+sUmYZtEIZ0NPXLr0ho6gxHz+hNSwydV4kr2toO12w0eTY0Zj+lUQ
         J/yBkmPevQ++7O8z5sTDkETyQp8D0sqG7jHe/4wpoy8aoEGmrb9kmqFb5Zq7PByS8rEn
         FFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788946778; x=1789551578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VRkHmq5v0XmmKj/bVTSxCtIOk/+XAtwEkO7O7C7PJDc=;
        b=e/It/NKur4XeCynuytqvtuYW3s/jblAVRZ7AiF9Hb4F9bYutGh/VFpffzVHoNhTt9u
         ZDPXwrY+9OVXcOsFUW5uQEwHm+Fe0xLzwCOSMV8fhSzHX/dKAgZV/8n4Fcl9tvDnPJEA
         cN5umVU3+3+A7LvZULQkiptunb0Ev1pqvSCjC8EVfpUQm7kQ4Ue5mK3XzRPoLJSq0arT
         NN5vmFZ+IA8sGtT8XnZ+X32dorDkUaAfoO1RD/A9UdypbJmoD6DaMUu/P1F4lEw9kj+E
         weJAUG2bpNhoRT8/RWeWoBcZ2AsRobJ0XXR0y/vjVrLv8PXAEdzw6KhiAEkq5jDqteWi
         oC2w==
X-Forwarded-Encrypted: i=1; AKwUvBwLJ+cAZyj/3Jpuico5I2eunrAjLgYbqousv1lyyPs9wCJXIvOq6xCFpu1NR9QmSLdk72y504cTLea4Eg==@vger.kernel.org
X-Gm-Message-State: AFuF++le2F6rSkYuc8zwryWlr4H2eqW2OH/foIDu+8zpPZ1BqWfRQIVR
	yKT8Ui4w1yyxgsHi/ph2A4tSi4PxGE2EeRqUSQ2gyqmvsXWDXA5LcroPI8CRKijWdwKETrpF+Us
	PD87X+bVGpLYZtOUPcKdz+dcFvioaDRl3GAelPNQgqBLdboYG+Q422BoAgtCnSzrEoB5TV5KVzQ
	==
X-Gm-Gg: AYBFou2AluMrxdbsYa7Hlh5689JBAg7WRRmIVdH5Qhlw6WwdP1w9b0jYyOA8W1C74I9
	AuRU72YYHbtSHRr0KUxZZvAl2VMjOyNDQgvOgk037fspkf7kSk0IktVvrgqviWLRsTAz73Rfvjz
	x0SWSIlNY0wSRKAvxOSZGnVK52XswPN5P9CmlqwdJs1+W02bRJGxDJLD9VJosnKi5ohclzqxhqK
	S+e73tqMtYlfp2J2IWjKKwJEyzty5+2r3S5AxTjIvbNFKv2hmpS83XT0uht36KnKJ1Gz26qgJcQ
	wELARvGoQlGc51TffWzLzZbpYI8gvwakJrJsLj5980bBJ1kG3Qoa4x6LAxUcdLc/GJE/veK4j8G
	2UNVYRmOwAlUASZ5/dp+nYYFe03Z9DxOZL7N48zV29D/djojGbX93tEvXGbfAdJQW7cRi11K2+n
	akNmajtuF9fz7V8pI=
X-Received: by 2002:a05:620a:4857:b0:939:5d22:d1f0 with SMTP id af79cd13be357-9396dead4a3mr2695844085a.2.1788946777976;
        Wed, 09 Sep 2026 02:39:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4857:b0:939:5d22:d1f0 with SMTP id af79cd13be357-9396dead4a3mr2695842185a.2.1788946777560;
        Wed, 09 Sep 2026 02:39:37 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68a6e19sm6387800a12.10.2026.09.09.02.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:39:36 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        stable@vger.kernel.org, Shashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 2/2] Input: soc_button_array - check btns_desc->package.count
Date: Wed,  9 Sep 2026 11:39:34 +0200
Message-ID: <20260909093934.29411-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909093934.29411-1-johannes.goede@oss.qualcomm.com>
References: <20260909093934.29411-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 711J85dbl5Mlzb3RnFDdrsvDb18Elh_-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwNyBTYWx0ZWRfX9DFe1ekGphHF
 ptPz8cl57hJtEcI9Qf1hk2qeS5gA+zagO3wZAfm986FD3UTUAUbrzOvUqF4rqipoj0tkVmsM0qr
 2jEoKCdQa71+Q9P+8dtcZP5j8BhlOVY=
X-Proofpoint-GUID: 711J85dbl5Mlzb3RnFDdrsvDb18Elh_-
X-Authority-Analysis: v=2.4 cv=Bo2tB4X5 c=1 sm=1 tr=0 ts=6aa1295a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=3jGYf1cGefsEezAl_3sA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwNyBTYWx0ZWRfX9MHPcWnTZmhD
 fnCsNw4Zs2oST1ThfnkPMUEbJNC6oewzpwNUlVZeqKbTwpbA5szHAydBsKYeR/RU5g5lJDO5yuI
 dIyFMwmu4YbhkSGhao90pfuXhqVcSLH2t/9e1pfzEPbThsEcQgWPX3TGedjxBbn9bP0EKYJYAbX
 GfmLQRCmJg4e9Cr1hYESUqnH0MEdn5ofdCJKK7Pau3AwjoARdapC04OuyQ6snUDDZqUzGVKm8mN
 R3GDERBg4i3YDYsW32wAvWqy6uwZUMIJ5iHknHmBsLYM9mjPvz5SyHPyNpjupho3ib1uxrQxCfH
 NdjkvLD2++rKZSfCQrMTaih3tEnVHfBYGESjAeKVl9AvytsbGUlc93T/vHy7BNriSU8o5ALAOZ7
 VDnzJ5TzfEhZaSfeHg+Z6qoNWWhLrBkrHt+rvjhmYH54VXQvprQdBKm02ybgQ6nBCFJyu8PYLtq
 CP1hwLdBEBTwM32Vw5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090107

Check that btns_desc->package.count is not 0 before accessing
btns_desc->package.elements[0].

Fixes: 4c3362f44980 ("Input: soc_button_array - add support for ACPI 6.0 Generic Button Device")
Cc: stable@vger.kernel.org
Reported-by: Shashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-input/20260909091440.3384C1F00A3A@smtp.kernel.org/
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Changes in v3:
- This is a new patch in v3 of this series
---
 drivers/input/misc/soc_button_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 264c41f80d2b..f08e29af531f 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -377,7 +377,7 @@ static struct soc_button_info *soc_button_get_button_info(struct device *dev)
 		}
 	}
 
-	if (!btns_desc) {
+	if (!btns_desc || !btns_desc->package.count) {
 		dev_err(dev, "ACPI Button Descriptors not found\n");
 		button_info = ERR_PTR(-ENODEV);
 		goto out;
-- 
2.55.0


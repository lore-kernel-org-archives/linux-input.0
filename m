Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB865378812
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643434; cv=none; b=lodeliTPmRkvToqPHbkY3XwVc8eBIQ0ZcRabn+ylOOt/RjZpuP0rQ7/7yUWgOQpxb4jiJTAxcT6ElKPNDOdbIKgZ59xZjIC9ph/l1Z3MVRE7fBJbHbCZV62nSLqI5I9fy1Y/MpldB6sneSieYE+fTATAbeQCWmGwzJV9/6yLg9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643434; c=relaxed/simple;
	bh=+/Gu/bOzREMsyojxtBLS2rrsVxBEz/1x89UZ/kvwe+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q7q733S5JV1WzscKVA/QTo4h8OP2X3ToExqc8rBEE4i6L0bNu+5ZMZFaYIMCyvkf5eBl6DDgIWGcUuomO6Bp6/mHNWOJOxNYhzTqoRPdZPv2mwCJptMHGPw2REyYIDMmO7CYnpiX8FAd8aQVcs7rqLFHaZyxKyEQpg3hWZFsEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N4oGc/+Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=grgE9hK0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N4oGc/+Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="grgE9hK0"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619BIB133252134
	for <linux-input@vger.kernel.org>; Mon, 9 Feb 2026 13:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kINSpanPXinEKIu6zisValx81lzCgphYv7gFKnGPwhI=; b=N4oGc/+YVA9tE7mW
	TeXnadCkGD4wa9mhFhhvmFtHrXOVXala6+5F9h83IuikT0bUVnSW2Wm6i+BwUz0P
	LaZXPtrPmFmzi9NikJAhWVp65g3ssUp0bzwJ7CZYdtecvAh7aIzVbkh1ZQwl6J+l
	noBjNQU1YvwbhtA3Cj2xIq7ZDWw7WjLSUuVK8Svhi1+h/mNnT1H6URbYpfKYpspE
	3Y34qmDshzC4BIQnNgWKVmqKqhRrwkGZi3Cyj58jL1yBgBkLerb0Jcf4omQvVITn
	0ZERfB9JTy8qIqpLQlM1b33DllqbljCDGrWF/L4kb0JWCF/u/Fz5XKrcJ0SyNkAZ
	UtZUDw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c79f69jke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 13:23:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aadeb3dee4so46479275ad.2
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 05:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770643433; x=1771248233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kINSpanPXinEKIu6zisValx81lzCgphYv7gFKnGPwhI=;
        b=grgE9hK0SX0XHSOOYxSr5Pb+V4rkq49bT+i0GAjc2oBVt7BT6N/2x53ggV/btOQEtZ
         qJ55La7WvjMMV8OkQjqsNrRCEmFEW2TFekvJ1voxDLpapBWdUI60c9AwuFv5mo2LnnsV
         bgGz2hzvICBEm4Hf0HoWEfFx3NK/uZoxKMXor9HdbScjuuBV7q24OT8Vs88bBC5CBJyw
         Wmxiu3pyWPIwQV0fWAV/U1hh/NZ87RdA8nz+rnvaoB4TIVLFVhoiNLC6eM1G+MD2wGjw
         eWcsXXKix65laSPtcIJW5BSKP7NmlHqEyJkP2z1BlL36mQ4blxsnLoBMUGCZXeJ9gTod
         VVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770643433; x=1771248233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kINSpanPXinEKIu6zisValx81lzCgphYv7gFKnGPwhI=;
        b=M3JQ3ArDXqqwmJfxo+Cz4CxKC40esddj+dNhcIgBSO6oxSCGkIvffE9fHQjx3Ay0rv
         fQVR0SI1R/jfcK7PR57mgAu+zSsEO1HKX/3cLZoLM9EFRNPW5ork0fx1rd1z/8NtHgHn
         ZpxId3jqSApA57zbdH/Xxcc5rKuTJos30GinTrZoUENSflDQo7mw1tmmQJYUgX3S+MaU
         s8Di539vHawh0qY8A/GFylJLyzj27ddg1YG1kGXmaVRE8RX9qKdy9DoSpvn8G/G/ywRv
         FWyPDF2sz0A1Ad2ULrTUTUR2MAofQr+OnT82U0Uc5dW4vOo9mgwitpspK1lw4poBbGXc
         XmeA==
X-Forwarded-Encrypted: i=1; AJvYcCXAk1BeUot9H09pFvBeFcks131ON+AhEUKXKUU60Hlk2FfJmsNlNkM8xDWR37Hhtiau7yapeqXETTApkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt74qGlpsNwnKMbK99ijSeYPVtaCbUJpRAez6HC7UBm++gx9PZ
	G/1+tfw8oGc7ds0T+24GsnfS/qwoiTFEs4Yw/PkGNY3f0/rVq4ARYXylSEZnEmB60eP8JubCCJi
	dRa49KZ0PwsrsT1E0mzUq7TwCnjxzT82BCP7L8mSFN1bl/FWrR4Kff2cXN+o4MuUE
X-Gm-Gg: AZuq6aKEYBK7fRZ2blw05pn7G2WiMvaGoND97J3P7TG8tvbKpS8gUXFq7V3zD1jdZsF
	+oQkLhvpFfQ9xgMfcxyXcyxGo5ifdkqJrKCjvlzt2zvDCRCL4PYZz86+hWnF54tMMMoFBZFJAVe
	F9YfvwNN+nzB2xspO2Pi09HRVocGXemHNjhXZDRc/M7sjUtB6qm92GGX00pgntI47ZfG+E5EpEQ
	mowOBcO4//nNnt3z31F352U9AOEid1UlMgTaeA9gw8zzzd3kccBIaKA9lhd7buC1w31z+b82IGX
	MFZwz7zyYN3nNfBuzGm/Ue156l3kWhaK18i1mSX7Osp69ZWHg8gR9F+B48TM4BNP30SjuU4VEi3
	vfhniObcFAZ5gedclv/VnuGQKB5Mo/2l3HZ7XLco=
X-Received: by 2002:a17:903:1b04:b0:2a9:4507:3e86 with SMTP id d9443c01a7336-2a951627cf0mr111516875ad.19.1770643433347;
        Mon, 09 Feb 2026 05:23:53 -0800 (PST)
X-Received: by 2002:a17:903:1b04:b0:2a9:4507:3e86 with SMTP id d9443c01a7336-2a951627cf0mr111516475ad.19.1770643432877;
        Mon, 09 Feb 2026 05:23:52 -0800 (PST)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521ba245sm107895765ad.47.2026.02.09.05.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:23:52 -0800 (PST)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Mon, 09 Feb 2026 18:53:37 +0530
Subject: [PATCH v2 2/3] dt-bindings: input: qcom,pm8941-pwrkey: Document
 PMM8654AU
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-add_pwrkey_and_resin-v2-2-f944d87b9a93@oss.qualcomm.com>
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
In-Reply-To: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770643418; l=1331;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=+/Gu/bOzREMsyojxtBLS2rrsVxBEz/1x89UZ/kvwe+U=;
 b=ijX3YIvOnRyfVlnlkeN9NfEiJ4B1RPQghZcI/UnOiX8PNUgwUqTz+cxU6/56oV6kerN695nLL
 e8T9xaVApd7BPznSzph85uZilNnxZZpl7jbOvuPdoGLKhRzPZLaj9fB
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-GUID: Q4sB3NsbksC4DgNtjKcrLuVnLhp3oO2g
X-Proofpoint-ORIG-GUID: Q4sB3NsbksC4DgNtjKcrLuVnLhp3oO2g
X-Authority-Analysis: v=2.4 cv=W581lBWk c=1 sm=1 tr=0 ts=6989dfea cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=Jjn6TvgLJkZUgEtuktkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDExMiBTYWx0ZWRfXy/hd9PgFuW75
 JwPdSUnJFdHfZgT83+f635JkVVLMKEaAcyyyRLrLShpSuCq4wWaGMbo0K9BQR6coqSfi6JgAle6
 7FWXU5Tit4EgVB8XBpJ4NT/k4WI7yqy4IZYpfC9q0HCWoWzaV5K0Ny/5N3FaoX9vBC3eeXnbtfH
 u3qy/sd/JZJKjBSTzn07HqpzpMZpYIb7hFrlqH9fvvdMLl9JusNbsdWtlURkotWhqeXO4Ex1HGG
 DpAUoCFsafjG9BzJpqs7pvLHNqmnZOVHeZQjBpuoWei9b9w/0vmivbYI7KhMcsGN9YbDTtEsy1y
 dk0EiecZlFQthWqT6gtBiq03VptSeeUlZaTNDrto+YdxBMpTkXIGW/Yg6l2Pi3TBI5OESKLwJBk
 p4uMpyV3G3EcempX4gG0yKNGxepCgq3DA9yYUc2KeLh0VAFNLymwVDzQeP2RQgD3/8VwQMWqUHE
 sTNSTpW5tbXRdPSNOKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090112

Add compatible strings for PMM8654AU power key and resin support.
These blocks are compatible with PMK8350, so use that as the
fallback.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 .../devicetree/bindings/input/qcom,pm8941-pwrkey.yaml   | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
index f978cf965a4d497cb7a4c670cea368c3ac70b67e..f2543d6faefdc42c36c4b9851e0f9532e73dd02a 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
+++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
@@ -12,11 +12,18 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,pm8941-pwrkey
-      - qcom,pm8941-resin
-      - qcom,pmk8350-pwrkey
-      - qcom,pmk8350-resin
+    oneOf:
+      - enum:
+          - qcom,pm8941-pwrkey
+          - qcom,pm8941-resin
+          - qcom,pmk8350-pwrkey
+          - qcom,pmk8350-resin
+      - items:
+          - const: qcom,pmm8654au-pwrkey
+          - const: qcom,pmk8350-pwrkey
+      - items:
+          - const: qcom,pmm8654au-resin
+          - const: qcom,pmk8350-resin
 
   interrupts:
     maxItems: 1

-- 
2.34.1


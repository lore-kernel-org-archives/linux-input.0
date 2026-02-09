Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435A378825
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643430; cv=none; b=JS85OkylWWmNGVwEeAyR/8YE7DurjoAy4i3UguB2eJz7WD73R1k9fF9pkUvBumhPxpskCh3EoQrz+gx8gcl37PG0rzQz9GDFjEVh5T3MOxFPuB+xb+BFJko9KTkocTDe/lAFcGOIxpXuKd7xItMyYU6XBZk5pUPrCo3bu8r9cxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643430; c=relaxed/simple;
	bh=k9lauc3Hh3BMFWnRniOQyvTXx6hD1H70MySBsc54Gj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HGbSWjvbpttt+EqAwbXhi/qFvzAJrTJwm8gPTQc6xpubDieqvqtz+xB8mQb/YdZwXH0KtV+qwzAxxlA3hVwYsxzqgTLzA7+sZbp/NUG2Hf29M090k+KShShnpZLjR4wHI2Di512eCB4wQb7SipsGYjd2O30tuNPxll27ZGO176U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=biUs5iCg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ur5EHJ4l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="biUs5iCg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ur5EHJ4l"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619DF7iv857023
	for <linux-input@vger.kernel.org>; Mon, 9 Feb 2026 13:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pd0Oue+f/5oWenlbME183+SziTsorttAb17UtJLe9IE=; b=biUs5iCg34hhY/Ll
	EnBx9Se4wYIGGgdNZXIEYKntw3zkRqNm3rLpRghBfFzMS+M9BY30aNYoOfVQwdC9
	9Ild7MQvuol1ZgInUb1+YxnsAvLJef+Mncz9cB3aFU5VcNdhR05xfh9ua6fRVLIj
	sF2OJrbTidu9Qw0fYW5L6hRKTSsrlaMNzGBUb0FA5QTY5enIbzENDzehsGwp5V30
	dGp4u5C3ofGkH6KQ+DQFU1CrjDfJAwh3eySirwxjO9mpQgQWcXd+UZyxBNV19ogc
	WOpuxwUJDyGM+3e77lBin2VFxSHSdvLy2eiomBnqma0prNq2SWbFyghYbP9A4vko
	C69zIQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7ga600xb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 13:23:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aad3380076so12853595ad.1
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 05:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770643429; x=1771248229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pd0Oue+f/5oWenlbME183+SziTsorttAb17UtJLe9IE=;
        b=Ur5EHJ4leRkcQSnyzNv16YcVgnj9AZd2WDOELJC7PjUAnvzpGiGQdcTUpBo9UrfKiV
         YFf6ejMJ+rfr/FgM0RsatRxrJa8eC3iJ/iQreO9P1rqFiBtmkD0/CDIv5r1ng7mAyzev
         p9PVOH0q1Xd29yLNP9rgTA8g5wnA2ITjBcHTZ1WB1uED2Hf0ikLjpzQY5+x9GK3ZIdNp
         hoYv0QJnjCSQ1q0dV2U5vUpF+6F8ZI1lXRaIrwCJoRXzJe19/Vc9eiQY0ERXifTe91Ud
         mrqeIlmM3yHbN0D4rEibl2EOvRMtT/8M7srzJzbvPNgm8QFWPC2JVsrxjw1aj8IKhAuP
         Xq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770643429; x=1771248229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pd0Oue+f/5oWenlbME183+SziTsorttAb17UtJLe9IE=;
        b=ET63HE9/6B9+kEZSOqPK5lZiDlWIjRpKDc2npKEoN9B5S3NiBh0w457MwHyKHx44R1
         toB+aV+L5OmQF2PvgO7SlV9sUxyjyYUw0eusDHyPWlpOjgHE/eQu5Of4Bl4/zEuxrIPG
         NaTjTBO/r+So/amONHpNIVpl5uLAGVtGxx/6FMahjE6naz5aRct+PsN944BQVl6BYXvS
         iGRty5muXJWcdJJrtxYZetkn18gQEWMeuDc3EFjDy7b7SavwKgCBJkhEWaR+icSS8tRN
         /+4+5Dz80zhqEL+xLV3J1XSD+FoGSKHb/Jnl6UNyHDyOI1OcnmjyGW4N3aRSdEjj6Gx2
         i+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTeUf+JlY562wgAZorgvIN/eympH9al5g2HnHtNgQjVYFL/OmK+kgm0y6Kf91nWg8i8hk1b1CNKFCIBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrsxOPD9ziBmXpSTrsDEiR61m60DSoZVOrblLrQEbSc6XWVloi
	pCQoj9DOnMmDo6BBrafl9wthST9AmV4g36s8fP1xWMj8r6E1GRp4aT9MKCwByY+xN28BUrWWFo6
	WlPn7Grs84GiuF8btZEG1Ti4hlXu8V9wy3bSw45B0uQaGg1spbjJFQZ3NYHMfhXEG
X-Gm-Gg: AZuq6aIFEQpqM7XVH0wa84HHZ+syRYA5CYkt9lJk+ve/4IciMF/FYVZEd5CU6vBPt88
	3fCmxuACTdr14vm8rGbtv9UvVKXhBcOB+IYiBvinS2JpgeXCFsPhj8gH8sb0yPpUliyM3D2OMWJ
	7Wl5xXj9SQKRWbakw7UCgzacwVHq8xWcj9ETPIjeBQOApC2B9ppGqAapAOXnxc2sms+Y8KPAaIN
	StvpJsVBpx6JJrFoDhQiW23dQ2DFSn2KOPVLJqfmsIDvV0ozazaqJLg+2Hj4TMZbp+BU1NiuN5r
	iw5Y7Si2DRgFZ0kLR9KzGxxVzQJmCmFiYj3CR9i9/2Ly5Coh6vmvuj7pCOx8YywOHnXS6gwf1C0
	6WOCKgaTN4nN90Cs3aXRzbZ/MQOPXJl6HcRErZtk=
X-Received: by 2002:a17:903:2c05:b0:2a9:327f:ac57 with SMTP id d9443c01a7336-2a9411f7cb2mr164836875ad.28.1770643428764;
        Mon, 09 Feb 2026 05:23:48 -0800 (PST)
X-Received: by 2002:a17:903:2c05:b0:2a9:327f:ac57 with SMTP id d9443c01a7336-2a9411f7cb2mr164836425ad.28.1770643428191;
        Mon, 09 Feb 2026 05:23:48 -0800 (PST)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521ba245sm107895765ad.47.2026.02.09.05.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:23:47 -0800 (PST)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Mon, 09 Feb 2026 18:53:36 +0530
Subject: [PATCH v2 1/3] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-add_pwrkey_and_resin-v2-1-f944d87b9a93@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770643418; l=1536;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=k9lauc3Hh3BMFWnRniOQyvTXx6hD1H70MySBsc54Gj0=;
 b=gVyhmJoevtPG07qKPAmEQrnKUIibA2srJ8YN/RBf+nYI21tZ0tvH1mgXPOebW5hA/eLfqpy3E
 QcsLDDM4ib/CEY7k0YQ52yj1klT0by1Kc8CGXe7YiLCfx/R3eMOYF8L
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-ORIG-GUID: Ut5UrCYFsDNUzFdstWnHNpNCSyogRO2E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDExMSBTYWx0ZWRfXwJYuGoD9mRtG
 FEeTmdlpCqKC/VpE9gYDNKQGGGBGQ0fRrB54fgFBPrWs7Nz0NG6DXxiNEhpvnYdI91cSSFtDpcA
 mqxgfIcNlNpGgw+/nk1u0KSFHNFf3dUyYZtYdQJ7qmS1x+rCG7MESkc4GvxHrk3KoE6OztAAfKn
 3yBp/DsboJHpyVlulA83XqMIIVin8eMsAt7PNljULtovyyjrflH892SrXHYb+qESZQJBPvibTsC
 8vTqv+LeNYZy6Lt8hZidL2RZo/n4yqQD+AM5xFB8ChD8oxw5LynfB0OOzrIrexy9a59TnyvfZEW
 Ja6uqTQ1JQ3g7DfGm9siTwZxM6DsmM+rZsPHs0qXyRTf4EUdxyoeM7nB5BJcEDvgbvPviYhhqQH
 8u3PeAkDAwNvxFfKMKgFZXRsEkOLilSTNYZf8J5kWhxxW8OWhWdtaVNx2cG9NUWsw7+8iGM0XML
 WGQEoOcPVC5/pBkaLpw==
X-Authority-Analysis: v=2.4 cv=WK1yn3sR c=1 sm=1 tr=0 ts=6989dfe5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=Z2k_n7hL7t1NYTrThU4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Ut5UrCYFsDNUzFdstWnHNpNCSyogRO2E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090111

Add the compatible string "qcom,pmm8654au-pon" for the PMM8654AU PMIC.
The PON peripheral on PMM8654AU is compatible with PMK8350, so it is
documented as a fallback to "qcom,pmk8350-pon".

While PMM8654AU supports additional registers compared to the baseline,
there is currently no active use case for these features. This specific
compatible string reserves the identifier for future hardware-specific
handling if required.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 .../devicetree/bindings/power/reset/qcom,pon.yaml        | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index 979a377cb4ffd577bfa51b9a3cd089acc202de0c..14b85b0d97da12c756cfe2ce33853501ba4ca46c 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -17,12 +17,16 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,pm8916-pon
-      - qcom,pm8941-pon
-      - qcom,pms405-pon
-      - qcom,pm8998-pon
-      - qcom,pmk8350-pon
+    oneOf:
+      - enum:
+          - qcom,pm8916-pon
+          - qcom,pm8941-pon
+          - qcom,pms405-pon
+          - qcom,pm8998-pon
+          - qcom,pmk8350-pon
+      - items:
+          - const: qcom,pmm8654au-pon
+          - const: qcom,pmk8350-pon
 
   reg:
     description: |

-- 
2.34.1


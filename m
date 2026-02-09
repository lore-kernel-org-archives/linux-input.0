Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74159378815
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643425; cv=none; b=bC5ZjwQU34Guorn9Un9RmeXlGD39jWlCE9ra9jljdOSBiMqDjYWCENJ1eRgZ58jPH1zmkvf9fZkWM+cUsJViW4coK/IaWW/ef3Fy4DWcOgLNgAOkLQjWFRmuqyOd6IzC/D8ig/UTAa0Pz8ETBPSFNLWgskSJ9/uZXEtEgwpRV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643425; c=relaxed/simple;
	bh=g/ZR74vhaTbG/KuTPVgsmyg7YXtgpFIDhkub2LjUZZQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G/unsR8jA0lTal+uzVeDaNDBYxKyoH9NgcN+3HMVu7CwwIU59FGI/skbC1h9kO/NRKqcUkMB+4SSsi0kqzkWTaDrSQjq8PQABAfvlk97EGnxu7bPy+IFS0OACHUK0f7L60vl1ttuF91RoJrt35PA5FzcjB0+l0RpYcIlr+Oj634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dyv2jjbg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D/zQZSDR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dyv2jjbg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D/zQZSDR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ARHxZ2381067
	for <linux-input@vger.kernel.org>; Mon, 9 Feb 2026 13:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hypUfFCv2fOn8byPy1CQII
	P7AQPAc65urxcoNegxwvg=; b=dyv2jjbgDBeqbkWwdcSRKcsaZfSy9OsORjXfQA
	H3MOogPu/BuV/e8bcQ/gChSy1rtwxGg4+rq58gVIFvW+JZyvAd3xMMXrZaQXfrcD
	vndKojM2t5JeeS9eSbF9K377w8LLArpye1U9iexs1lj6mWKr95jtrcWPV+BNBLqA
	qIVm5RAs/kKDLSmWtwNOZmJGQ1ZxV0+kVKrYm2Lr6vZ8yIeCcpIkEGICySW0Imy9
	xHLqU1YFkzyU5XN0hZ140E2gguZcXOG8pQmQ9HHE2U4Ffz4kPhvF0GF1aTPiy4dq
	jXTWMz31mxVzTWAvmtFR06HvH00WInksn0k2b62ahQ+hDopA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c78gdsrfm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 13:23:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a944e6336eso119804885ad.0
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 05:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770643424; x=1771248224; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hypUfFCv2fOn8byPy1CQIIP7AQPAc65urxcoNegxwvg=;
        b=D/zQZSDR93M+j0IkqQrI2yK9yO5hsuESYcYOs891Wiwg7lvtH/6wm+JFTHJFhHJgyY
         m3isdtnaQLKXwwy2inwNQWS2NgQ4gD7P5RadYlL4q3gC/sY16nhxuLxwGWls4SxK9bUJ
         505pWO0ckKgHLDhmKY/iRmyPWR1X7GEw+bwU8UCwIvT9tyjKrPRZvIHFARXArmF/uBu4
         A53+OTWJJb0QWKNomurF54wke6HsZCmCF1i6MCkN4zbN9RQ4T7SEY2HF8H396C72VQdm
         pD3okXK97vtfWnIOEFwRNmdXeoJzrC3QKQcA0sYFhj3unRSDsl/ZkZq+QIyKz9iCFA9i
         9CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770643424; x=1771248224;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hypUfFCv2fOn8byPy1CQIIP7AQPAc65urxcoNegxwvg=;
        b=ktklKeL/Kj4z+VCifA0gOnPt7k3iN+5zqA+p+cr4BmZ3Dmu349Rk/Efluf+CGEmjyM
         IKVV80ZqbNou4B/VMneteF9dCiwTrV3cbXlFGoHm9j4smBLKaV//5la+uQg+DauZKO62
         Bx2VdhmH/3bN+ytD5T2SAF1z8khZz35ymNh6GboevdvCJNv4wNfIvyplLw9XimWSog8Q
         RS7lnEZirj+vxUmKmpUyfHHhAF+PxQIQ/F9XLpDHsJ+afKW7TweXwdMMgTBPDbdopy6y
         I1zTD3HYycr2GigL2sFr44UBSHNZeWmj+4+VBLU7K2OnXbNxPT4EOQNB1BQKYPKBQIWC
         9f3g==
X-Forwarded-Encrypted: i=1; AJvYcCW6tIgE7OR3WNse7zbL/fqYIFrDFc4NmO3x2LhY6DTpePw4K87xH+3a+E/5rL5JUDDtycSbHVVa6zkpVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9epKMZuNSnAkKrFmNwHUWF2UYJRYbc8lcmd9MppMDs2oVn4mv
	65GDiV8Hems5YQJk8bnEr6ZyZytHjoYBM6ljNVOmJdsS+Xysp9Tc/eyoca0j9KwfBTKZm+3QkD4
	iwxtI4F0gGHbkbTdocj6b1+AfmaGyC7TVR+w/toTqcy7Y+LxKKqruRfOotRGByq22mlGr9rNv
X-Gm-Gg: AZuq6aLgvdhNhuRtJsmU2kK1fmMKTcAK26fwwcgEiSEg/viCagU/2vwUCVERvaeZSUB
	3grSmATs/ROnQZPAukcYFnV3PRodqW65g3/NT5GqSrzg5QvkEZARQbIUXjgpp4lI4sYrF4nOlI4
	AcFWe4rfvGwt/A4e4VUTFj3846No90e1/5LlGNDYhdgI3ZCLxDcQqO2sbii3q/9KprU4vaMofQ3
	DNhsk1EXA9D2NY6Y8vh46EB799U5F06DNnpghncWw8SrQvSnTQxC92j1r1fhH0t/clh3KNzc3cK
	lY6aDPHQM8saxhvBqBZPTr5Hc7v3ReR1htYTz80MuWiucZkYexz9YwaNO+inW4Syi4bCkyI+T4Q
	PbvBac/r7x8TvYe6bcgku2qnMyMDpfGSdaassRPI=
X-Received: by 2002:a17:902:da91:b0:2a0:c5a6:c8df with SMTP id d9443c01a7336-2a9516cd2fbmr122478815ad.21.1770643423979;
        Mon, 09 Feb 2026 05:23:43 -0800 (PST)
X-Received: by 2002:a17:902:da91:b0:2a0:c5a6:c8df with SMTP id d9443c01a7336-2a9516cd2fbmr122478585ad.21.1770643423509;
        Mon, 09 Feb 2026 05:23:43 -0800 (PST)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521ba245sm107895765ad.47.2026.02.09.05.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:23:43 -0800 (PST)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Subject: [PATCH v2 0/3] monaco: Add PMM8654AU PON support
Date: Mon, 09 Feb 2026 18:53:35 +0530
Message-Id: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANffiWkC/23MQQ7CIBCF4as0s5YGqKXVlfcwhhAYLNFCHbRqm
 t5d4saNm5d8i/cvkJECZthXCxDOIYcUC+SmAjuYeEYWXDFILhWXXDHjnJ6edMG3NtFpwhwis62
 zfouNb5SDcp0IfXh9s8dTsac0svtAaH4xIeX/2CyYYGbnse/apuuFOqSc69vDXG0ax7oMrOsH0
 zbGILkAAAA=
X-Change-ID: 20260206-add_pwrkey_and_resin-c5dcf4e3f36d
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770643418; l=1016;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=g/ZR74vhaTbG/KuTPVgsmyg7YXtgpFIDhkub2LjUZZQ=;
 b=N8i5t7LvRfWFPv655ifUkpJaCw+u/jpmU7uQYC+N0W91NkAY7LRwCkMcH6sa1m95/ntXI8mwm
 iSz50LwuyLIDeJbH1lWE/9FZLuKWxHHA0sWkXDu2gj+MLkXC2/t5as9
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDExMiBTYWx0ZWRfX0iIg8g6gjn5Z
 ynt1C6QrEdITCeL4xIXg/FJnG4ZNRs0yz40LJTI1jT1iJ7kC8rLfMzLFo8jOGe7b4S/AMusUloH
 Ts8sIFRHqXeOsr4Lzy7lJtEkE7LOdpCjsrlgqAJPthUhijdWLIUP5aJL/l+BWs4p/WuANYc+qwz
 uPCSbJ9fBYShW1/DEY6SWD6IRPEXM6JQhF58GpJCCBJvJaLV9FJEFqAb6lMm6sqpPOWAnEjm1t3
 JH45VNB8E3EKhTDzr+cuiwJvXwZ/1WMqPsw7Ru0alVStW2lN2z2VElOxjp9BcMAVOykhI2BDF89
 +IaVzD8pK9WkkkCr4wIRP7iR0UOGIDVbjD4pxCmwaRRGkAQSFmIypX2retEJ36RTQ91srRfznvY
 Mdvd3tMWy+rpQdfSXtCsbNiuAV53tsdaNdpIrwfvB8SL/SiTDk1XngWUJ0syIDrOcF6AYqqihh5
 GI7xP+q5UnuBLOpwq+Q==
X-Authority-Analysis: v=2.4 cv=Fv0IPmrq c=1 sm=1 tr=0 ts=6989dfe0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=x58ZVvKx_e4wcmJFeN0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: p3zFA0rT5DF4gUFkeQJweoqkZoqjOFxx
X-Proofpoint-GUID: p3zFA0rT5DF4gUFkeQJweoqkZoqjOFxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090112

This patch series updates the PON power and reset dt-bindings and
device tree to add support for PON power and reset keys on the 
Monaco platform.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v2:
- Introduces PMM8654AU compatible strings as suggested by Konrad Dybcio.

---
Rakesh Kota (3):
      dt-bindings: power: reset: qcom-pon: Add new compatible PMM8654AU
      dt-bindings: input: qcom,pm8941-pwrkey: Document PMM8654AU
      arm64: dts: qcom: monaco-pmics: Add PON power key and reset inputs

 .../bindings/input/qcom,pm8941-pwrkey.yaml           | 17 ++++++++++++-----
 .../devicetree/bindings/power/reset/qcom,pon.yaml    | 16 ++++++++++------
 arch/arm64/boot/dts/qcom/monaco-pmics.dtsi           | 20 ++++++++++++++++++++
 3 files changed, 42 insertions(+), 11 deletions(-)
---
base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
change-id: 20260206-add_pwrkey_and_resin-c5dcf4e3f36d

Best regards,
-- 
Rakesh Kota <rakesh.kota@oss.qualcomm.com>


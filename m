Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62543A7F78
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 02:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352851; cv=none; b=ErRgjk9YQidtpaMdYxhGExpdx2CfHA5ldUUaTv3xK+UqSwUtPp9xLdJb+QrMSXYPU/KMJ9ZKrSghbsHsFZjSp2fcYCdPZiqWIXeoTzsoUWYW92luz/3n8O6B3ox5akdAMokDEWncBP/+mdGTxiPeVEgd5JIYo/ko7/9hy2pEtfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352851; c=relaxed/simple;
	bh=1XRKW0vDR45JGT3UWYWuagvWFRDF/O/QLqhohEncfdo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h1tmgSp+jD3Oe9W76XTYVdWm0eVuXwXu55JkWe+Oq1bOXvgXsWl/b9yBYMgVh6J9qesObAB2pW+sYbJuYnCPrNUqktb4bCUA/8QG0UadAIOzFt+98IWI+Ozgm6RiO4OsmR6yRykMkCq1mmB1W4OlOgcb3iv0U867ALDuH3XP2gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=knKgH9hh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=emd3daBL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="knKgH9hh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="emd3daBL"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OLqmQQ452078
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 02:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iF6ibc0xqZo4e3ksGi+x6u
	qeIxacuV5DBZJu2XgrUGw=; b=knKgH9hhSkC/XfvHWKtUpM0bQmuim1l5JYQyWL
	ewXX0wPZwoZz9LJUcAE0OzKaRch2tC8rP6hUII7CsHmv/tIeY5RY31qFLFzQxm0Z
	xpjOtI/fnQHgoCKj/awLAJ6WHUcgvwAZOPc/2m4g3b8wARYl0Ow9myEIoJRcLmf7
	+EnO6HWkfid8301E2WudrSoIV/zvZSe4f+Ny/tuLTNeTaSNLWhkrC+YYStE6TdjS
	udldk8YPquDJkstbYTA0r2hfZSV/+uVl+xmayU8tKrGOASm8Ba0TxlQoit+BY1IB
	w6RYnX6V8s7hlhVk97ufHBP0M+24gHLfjVHLSC8AZNxh1CQg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05ajn1tv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 02:00:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c62861b3bso852283eec.0
        for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 19:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782352848; x=1782957648; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iF6ibc0xqZo4e3ksGi+x6uqeIxacuV5DBZJu2XgrUGw=;
        b=emd3daBLZcQ/N/xmK3g5GJTucliCKxUw6ufHwP0RFpDPZw7IPggEHdIQhG7Mixdq5Z
         zZqkEdNz1cDsOEXVweDarxdvS66h54+2HdGsstmAlQ+Ro2pgvXCuNHye1bB8fBaxqTDp
         J4ZnzYTz9CMCbOOfQjCpl16SQXalVYU6pNuvqdtvXTMNyyKhZVaOqA3y8ANiaZmt/bb0
         ry/m4Li38JZ2BDt4saabBNIyUKLRpEhfU97EYfY4CFN/AzwVkMTsoxLb5esWSHzEKlES
         0l6LEOPJRH7rVOCjEPJZKqx5oRQJUxBojpDgRpk5xq/cXwAfaqhQggw+cEw4374z3diG
         1z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782352848; x=1782957648;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iF6ibc0xqZo4e3ksGi+x6uqeIxacuV5DBZJu2XgrUGw=;
        b=onxnv0HgAN5bKXaizb/PUq9tCA+QefEI1qdqBZlo2+SqSeSxVhFy+YKc7Zof97bVf1
         WpYN++K/XxUuT8caFZZia4OKPqvwwIEctkhKGpJZJnA8NR+43SyVDaEud5MwlmiSJjGu
         XL5r2nUtBUab+nhtB53GLjJEvRkQFe+ucjeBC4aU/nmvQgWsO8L1wPOxBmVAcsXjL0iX
         uBPemTChCOiifYcFjQ3n1mWLGyTmoMj97tgRYg2gIY/8Y/QaVO8hvTob0Z0gfP82xckz
         WxHTB13y+lMKlI483GalzDe9NKmhacVZaZoyvTjyDFIYsw4vkYeby3l3UpCwQHOjv50t
         +wzA==
X-Forwarded-Encrypted: i=1; AHgh+RqQmQmDyZrcnT45O6o4q9ft8WqINJ/xbU0HSQ8GlpY1koJytkbS5styJLBZykxLhUbGeo5Ixn/H9+NqgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Y7BatgzQGG5Zvv0tfAthmyHLm6E9xtRIrT37uO92zv1hCF/s
	yayC1M0E/cf4c70vkI8MfZDHAWR3QRA+020gXfCUOeNuhSx4rXypXUTp/pc8DFXuwnt8anG0E6H
	eSHI1/eheYRk26BkFdbDD7FhHM5UGyCx9EY+EtSqH6q2dKOtnG5B2Jl0FpdGbIm0GvA==
X-Gm-Gg: AfdE7cmmRARXVXZpHO46XEHHaIVIXFNh128nAWytf6e48y5KWILyNvj1AEqJcRz1F8I
	BNxRSHcOGccoSYA9r6dLUQAohfMvLWDM3qFNBsOUIH31ize+PCIzIMzEHQgtI4HU++ALK8LNy81
	4nX/TxE8WshkTV8/KKtKmRvnqY1MKDFmom6VtBjnsP9N774oOgjwL70EtPWsy88E8E4PVo5WBDJ
	fTHB5gidl+rdO7wMyvoUi6mnU22dBK8G2a6EhcS4k+7+KdGxAPqdx6tWhr9KclMRxlRUX81BPBK
	RgnejSYRkHgV572YVShzhvLIWk5LMEM3vkp5XJHgzW/lz/yP+7StdtSVRcZp9IPeuJEG1nmWN3w
	bYuCmhl4tkgyB+x4nXt9xyAqcXpRb4zweRVq9aGInMreAOcrqMT5XJeDa5kFeFBk=
X-Received: by 2002:a05:7300:1485:b0:30c:7ab6:7ff7 with SMTP id 5a478bee46e88-30c84bc4e7amr742490eec.15.1782352845883;
        Wed, 24 Jun 2026 19:00:45 -0700 (PDT)
X-Received: by 2002:a05:7300:1485:b0:30c:7ab6:7ff7 with SMTP id 5a478bee46e88-30c84bc4e7amr742373eec.15.1782352844019;
        Wed, 24 Jun 2026 19:00:44 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8afca8sm2933939eec.17.2026.06.24.19.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 19:00:43 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Subject: [PATCH v2 0/3] input: misc: Add an initial driver for haptics
 inside Qcom PMIH010x PMIC
Date: Wed, 24 Jun 2026 19:00:35 -0700
Message-Id: <20260624-qcom-spmi-haptics-v2-0-b9118e60f3e3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMOLPGoC/32NTQ6CMBCFr0Jm7RAYSImuvIdhAWWUSYRCBxsN6
 d2tHMDNS76X97ODshdWuGQ7eA6i4uYEdMrAjt38YJQhMVBBpjClwdW6CXWZBMdu2cQqVtaeG25
 6qogh9RbPd3kfm7c28Si6Of85LkL5c/+thRILHKjmmmhg09dXp5qvr+6ZolOeBNoY4xdngIbvu
 QAAAA==
X-Change-ID: 20260616-qcom-spmi-haptics-3cc97e7b232e
To: linux-arm-msm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782352843; l=3511;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=1XRKW0vDR45JGT3UWYWuagvWFRDF/O/QLqhohEncfdo=;
 b=9gdxI7Dk+7XkZfPAg2VWu5NzwswK/jSdi94TNuaGcS8WIDVmf9HfUO0SIHgi5bTYRbJ6oPZAA
 djcbQYiyh5nCtU4WGrxhy05ja/7z9k9svfrqTvl07+XhBdHVOyejm+J
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDAxNSBTYWx0ZWRfX63dYeofF6zof
 kg/EmTwADskq5vS7RCE3teN7LyejH3XyTHLQwFX0nkgScTxT3RppRqtmFGEvp6nUxa5QSvORB9Q
 FWmCJrWdhHBOEFbpUyJjGIIZCUU29D0=
X-Proofpoint-GUID: 34DYGrS-0mcvjvY40TYerj-lB04DbRBm
X-Proofpoint-ORIG-GUID: 34DYGrS-0mcvjvY40TYerj-lB04DbRBm
X-Authority-Analysis: v=2.4 cv=DbUnbPtW c=1 sm=1 tr=0 ts=6a3c8bd0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=F7vqA0BNXnWFEAHbpNcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDAxNSBTYWx0ZWRfXyzgiQ0koBMlY
 9N5/Sn9tpZHkfnEFhnBQLaHPdoTeityhPkK3AIb6sN+h58i5k5t5AUMKgl48+s/CpwffrehzS2S
 UCq+h6GHigzXhmc4+TfCd42WL6072Oet5F4HTDimEZSg7QiSWMNHP/92Kl7RPBUu/BQLYqHUbKd
 Q4Hc1csZ+eytakU6Sf1Su/5OGv0OmzFdOkgAtDlM/rNlf6GXej2xIJr24LEKExg7hhifv19lNwz
 MVFwsd6q+0SOvQ6wLBhB98Lqn1l/UtS97ICZOGSIqpPp6XHXsuapaTyiDKxsIo/2KOt27/+b9oX
 vphVl5m3OobQskNwj90gEDY5SmVayo7mWCKKNEOcvOHsZ18PYD1NLFnVbn2LpVVvbBgX6cmbNnL
 bpa/cjH0d+jZ8AdNGAZvSJpfcX2WAEBOu3bT0q+KEND5EaYa1OIdM54fBWvF+eh9EH2QTUM7gWD
 wihGtOqVa6sLpJpkO8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250015

Qualcomm PMIH0108 PMIC has a haptics module inside and it could drive
a LRA actuator with several play modes, including: DIRECT_PLAY, FIFO,
PAT_MEM, SWR, etc. Add an initial driver to support two of the play
modes using the input force-feedback framework:

-- FF_CONSTANT effect for DIRECT_PLAY mode which drives sinusoidual
  waveforms with fixed period and amplitude, which would generate
  a constant vibration effect on the LRA actuator.

-- FF_PERIODIC effect with FF_CUSTOM for FIFO streaming mode, which
  can play an arbitrary waveform composed of a sequence of 8-bit
  samples at a configurable play rate.

Also, add the device node in the existing pmih0108 dtsi files, and enble
the haptics device for several boards by updating the vmax and
lra-period sttings according to the LRA components that mounted on each
of them.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
Changes in v2:

Dropped dtsi change and I will resend them after the driver and binding changes get accepted.

Updated haptics binding and addressed review comments from Krzysztof and Konrad:
- Extended the description to clarify the 'PAT_MEM' mode (not yet supported in the driver)
  by comparing it with the 'FIFO' mode.
- Updated the compatible string to 'qcom,spmi-haptics' to match the file name and removed
  the PMIC wildcard.
- Simplified register names to 'cfg' and 'ptn'.
- Corrected the unit naming for the 'qcom,vmax-microvolt' property.
- Added an additional clarification for the 'qcom,lra-period-us' property.

Updated the driver to address review comments from Konrad and Julian:
- In haptics_write_fifo_chunk(), separated variable declaration and assignment, and added
  comments explaining the 4-byte and 1-byte FIFO writes.
- Replaced manual 'x * n / d' calculations with mult_frac().
- Switched to disable_irq() to prevent late IRQs after device removal.
- Replaced property reads with device_property_read_u32().
- Remove the 'INPUT' dependency in Kconfig

Updated the driver to address feedback from Sashiko AI:
- Guarded pm_runtime_resume()/suspend() with 'pm_ref_held' to prevent runtime PM reference leaks.
- Replaced spinlock with a mutex to protect FIFO data during playback and avoid calling
  sleepable regmap APIs under spinlock.
- Adjusted suspend/remove() sequence to stop playback before canceling work, and freed
  FIFO buffers to prevent potential memory leaks.
- In FF_PERIODIC handling, allocated 'fifo_data' before assigning data to ensure its
  consistency with 'data_len'.
- Registered the input device after enabling runtime PM.
- Unify to use 'h->dev' pointer in probe()

- Link to v1: https://patch.msgid.link/20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com

---
Fenglin Wu (3):
      dt-bindings: input: Add Qualcomm SPMI PMIC haptics
      dt-bindings: mfd: qcom,spmi-pmic: Document haptics device
      input: misc: Add Qualcomm SPMI PMIC haptics driver

 .../bindings/input/qcom,spmi-haptics.yaml          | 132 ++++
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   4 +
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/qcom-spmi-haptics.c             | 838 +++++++++++++++++++++
 5 files changed, 986 insertions(+)
---
base-commit: 66725039f7090afe14c31bd259e2059a68f04023
change-id: 20260616-qcom-spmi-haptics-3cc97e7b232e

Best regards,
--  
Fenglin Wu <fenglin.wu@oss.qualcomm.com>


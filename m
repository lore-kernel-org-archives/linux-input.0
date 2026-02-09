Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B837106C
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642001; cv=none; b=q6CYT7s3edjLJn+Q1sCUBOk9wroXEgcSz2O7chf3wqkcvFT+hlT0LHtIyl+/bkPLlVCOZj6gReanBG8Rdb/dnuzWk/NthsxUIN/H0MWlAI79MF0v1XJnGRrJscKDSoOVdo5nHOgVcbXYMSPlPDLzom5seI+zkh1PeIvaIUlzIiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642001; c=relaxed/simple;
	bh=ccDGQKcZ6ePGyeyFfLhe3FHr6NiUQV+ntQLRKhAADt4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I3nrYO72sDM+vDfnyXHgZsEpu/tcxXcoW7kffw7UsJPuTBu6r2broCc67tqQ49U/VV6++AMwXHJQDepnMYLJuylNmegyJacb+VXMBWCnF2z78C6AmvbyPPVAy8qzAYuFnlmhnnH+SeBLbeMyxloWDkanwEqEFSqaAUIMe0pFa60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=zLAbkGpC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="zLAbkGpC"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b872f1c31f1so523721666b.0
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 05:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1770641999; x=1771246799; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jSuIAS3dA0vwtYsZinS/Tz8DT6xIcPyMvSlHpVYFP/Q=;
        b=zLAbkGpCLQP8zHspVH3vAojQy1izapXG3tbhZnepxwhxy6oFXDT9F2pYl9Nyywaeos
         Jntze/2f9+yamj/BX+tZ+v59Po+bogDWPrq+AS/Chc82j7rHAD+YmPLIFXw+D93gmJ6u
         o2dyP8C1NLD56Wd5pe99wuyXPSCFRIQZ/aN6slTqk31myT9sGqz4Xfk5NtSyXhLsy6RP
         5glWv8jolq0GCoHhPXOeIniJhXawAV7Gudrv66wvIuVi4KmN2j6T1mbmZSLvfCxM1eLd
         eV+wRdt2NgjuBOu6bpsfjHzYzdgfaSsdZAdqD9HZSBOfOgh4XC9XpzTpv8WFQVm6BgBl
         3bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770641999; x=1771246799;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSuIAS3dA0vwtYsZinS/Tz8DT6xIcPyMvSlHpVYFP/Q=;
        b=cdc6E3gzvs7XqeEUQf5aP0jxrZyktzYBW9RkWFQeh9kfIIk2VLbHfYB76QFQJieQ5e
         PsIQIl5fiuTJfOSk5k/a9ZBbjGq0EfH75e8jBDHvNqni4r7TvzfoNExjNFCujnUrlnpI
         9VdaxOsTfedQLOlUnfCsjR5lQRNSjeq0osL1466tC2km/KdwFeH/i/BNZrWX2gQ5PeCY
         TZS2CD1BWJc1GbhESRhvXC/QmPA+SSkGH3fG6UWKZcB+cSRv1Tya0lj6UZiK8lri1WPW
         Vmn7HAT10AXc7fa3E1WaUllqF86yztZC6tSyKwLh+tQI0j0S//hA3fzUdUM/8WS/Dp4s
         IkTg==
X-Gm-Message-State: AOJu0Yz3drV5afuvQIIcPOoeqo2jee4YoFQXqMptp4DEdkb0YfG73UsL
	REMzipW0jBvjb4oDfmnPEiSkHuchmO12rLXpMsLjp89k71rInQ9s7uuBuv4G1nuY1QA=
X-Gm-Gg: AZuq6aILibBzDE/ZXD+E/c1uXTKeniYSVmVL+mJTA5RI/tc2ssZqO+6tF0j2yyh5kij
	1XitFWxtYazlMqSG3cQTmVTfCinbqanjWhsRV7ZHQVQnyDZ4XQmhq6juisWG97DmnBeZxOjRwkb
	pOTen9bd51uXUpfOq7Wi6orpZKRO5vtOhEaeX0mQFHkjdIyLWvXxQt6FdO2r9YSECu8iMGFRL6n
	Z3lZqUU4HPQAGg8r6ESB5YUeimVj3d+XQS1Fr4m0PCtOxjxZmvd/fOTfQwas41nj5B0dA653I6P
	oczRYVnDccvjfQrdWGiMelXDnilozH7R6VA4l24ihO6JfNo47VI5/NF2BjOFqdDgP1Q9unLojBh
	SNgbEFgtGYBMVvoUmUwoCBKjK6Z4OCjp9fQyN3MhtfMKfD4H+//RyH8JHMueFrXuuMdJDk19wen
	kRpfbaoyBtLAR7euA+Z2mH3GvrmHrn7J26BF5C1Dm5jhQe0F5/avv88jk5vq38NmI5foPlSQ==
X-Received: by 2002:a17:907:3cc7:b0:b87:1839:2600 with SMTP id a640c23a62f3a-b8edf344224mr630775866b.33.1770641999349;
        Mon, 09 Feb 2026 04:59:59 -0800 (PST)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65983ec70fdsm2803040a12.15.2026.02.09.04.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 04:59:59 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: [PATCH v3 0/3] Add support for Awinic AW86938 haptic driver
Date: Mon, 09 Feb 2026 13:59:44 +0100
Message-Id: <20260209-aw86938-driver-v3-0-5c79cff30492@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEDaiWkC/2XPsRLCIAwG4FfpMYsHoa3o5Ht4DqkEm8G2QkW9n
 u8uWl10/JPLl2QSkQJTFJtiEoESR+67HMyiEIcWuyNJdjkLUFBprY3Eq63XxkoXOFGQTelROQN
 gEUQeGgJ5vr3B3T7nluPYh/vbT/pVnSlQ5S+VtFSSGrfStrbOG9x65DC0fUfLQ38SLy7Bl6iVB
 vtHQCaaShMpWyP66pd4zCcGOl/yq+N8p2gwksz9E4+boqPbKD8LVnni8QSKBCYYJAEAAA==
X-Change-ID: 20251113-aw86938-driver-b4fa0d3228a2
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770641998; l=1380;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=ccDGQKcZ6ePGyeyFfLhe3FHr6NiUQV+ntQLRKhAADt4=;
 b=w6jQK/AuWxQgRLy4mYkgWfxsIgi1k0f5NWQjQyV6pxjgcc0WJkYvCpxy3w+s7ok46PY/HInXO
 n1nGk4LnnvRBNE5UYaYsE9KYXL5sXZprpfvkgq0FpZ6CQCVx1nVFSEf
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add devicetree bindings and a driver for the AW86938 haptic driver chip,
and add it to the devicetree for the Fairphone 6 smartphone.

This driver is very similar to the AW86927, and shares many core
features.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
Changes in v3:
- Changed how compatibility was handled according to feedback
- Added reset gpio config for vibrator node
- Link to v2: https://lore.kernel.org/r/20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com

Changes in v2:
- Added AW86938 specific registers
- Added chip model enum to differentiate chips
- Link to v1: https://lore.kernel.org/r/20251204-aw86938-driver-v1-0-ebd71868df3a@fairphone.com

---
Griffin Kroah-Hartman (3):
      dt-bindings: input: awinic,aw86927: Add Awinic AW86938
      Input: aw86938 - add driver for Awinic AW86938
      arm64: dts: qcom: milos-fairphone-fp6: Add vibrator support

 .../devicetree/bindings/input/awinic,aw86927.yaml  |  7 ++-
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts   | 26 ++++++++++-
 drivers/input/misc/aw86927.c                       | 54 ++++++++++++++++++----
 3 files changed, 76 insertions(+), 11 deletions(-)
---
base-commit: 0364de6be161e2360cbb1f26d5aff5b343ef7bb0
change-id: 20251113-aw86938-driver-b4fa0d3228a2

Best regards,
-- 
Griffin Kroah-Hartman <griffin.kroah@fairphone.com>


Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8A30C619
	for <linux-input@vger.kernel.org>; Wed, 28 Jan 2026 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615485; cv=none; b=AHacIswomVsUy+hM0fbMAO4TXn8O7Cnidnabd25eBuarLM478RLG7ZHCfmbLfBqtJtRKRXnOL3F9OjlCdd8RB/xDTWbVDk9lpffOumjNzjdQtTAN89jrKZ7gvEf1HMSOds+FaUI58SM6Ii1nK9cBUEcSuioLkXuDnwY/UEiLLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615485; c=relaxed/simple;
	bh=s2XftgRLoQjS+g/1qoc7zKuSMJw+yLwcSC76tOy1XDY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LwR5n61iRTacTEIz6lmAg3ATyrxUZcL9/PGN52Dwjfj+RWp6KIxg5GkMsypv0nCKJOSeoG0C0yDi+iwzGOsfrGUyXeWJ6AOOl0waINPKGarsiIHBRTODjUc/+HdvllVURB1dcqiH++v/cM8hhl8RZ0TM/0Iu+Y0lrDhXMh+4hog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=aV6HDSK7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="aV6HDSK7"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so11511a12.2
        for <linux-input@vger.kernel.org>; Wed, 28 Jan 2026 07:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1769615482; x=1770220282; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqPhMZPef8IxeMTLsFDJp6gjrCUIfXLXeKcG0ugnntI=;
        b=aV6HDSK7zTGc79REnCSxq8Mt6QGmrcHKv3MpXeChDruqleXzdXHiCYi2oyVd3eF7Wj
         mbAQzATsG1InFchtHM/x0qvWIo2hM6g9q/9vW+DVYJhM0QzURPakut784EDCHpNKfdnO
         ofax65U8DtXelMyYHJZq54oCll1UEQqiHIjtdE6T7dTtHtkS4sBruVH8vml83Jo3H9FG
         V/eciT+y9VeVDhH0bux55UHP55/LmCBhv2W1BzIfca6ma79vGQ3ILL4a98lsCYM/NPku
         +s+U5qRbaFmFd2DeAvCdso4CpOn/H+kvpNxVnIdq4qquBiNvjwFLaQ/0mqePIBxi+Aw1
         QBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769615482; x=1770220282;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqPhMZPef8IxeMTLsFDJp6gjrCUIfXLXeKcG0ugnntI=;
        b=Tdi2LwEciCvj3HUI+UKPSNbTfpar+OkonZbikSYwgpmySE9Km34RIxxgoFOFAV1fvU
         3tvTWZp+LcXYYYMcn5gollBffgdyhMuUomEYZV87HFJQw+UC55N4xLB2Ayh1qzWERlI6
         4vIgTnTxU9RFCnlblRRO2XdaXt3ntABtiy7AC1NHMb8cMiAcO03DTJyBTU3mtrjdKdNh
         9DRiQmPUnA2K0W39tKIZk+uorsT1UBNVS18gMqqCAz2x3YSrikgcmjEVYKsVn5xtJiUQ
         VF+u4SJsNjmRtlkq3lAEm9U3Rf8m2rsgr0YEPifH6qBV4uUdlLrjHrCj3UsWgS/TGlRd
         n2eA==
X-Gm-Message-State: AOJu0YxQcE7Z0NUcgOmKvVJViAosUATnrAQtncHmMsGnqnCNDLjJlxMF
	BuXZKw+K6UFs5O/VpFmfwCt37dZzofh6dAyIfyhlhQHbZsxVfc9zv5to7bTw1gBp38s=
X-Gm-Gg: AZuq6aKbBTSWANA1Bnhin1ZEcLdnLhFR+SZHT46NxGQRI7qyKlBG/NDWlVWhlRQLF1i
	gJ8ojg+2kFDxb6DARFDSJ/L1yrzgh9X0DhjLY8SFaxTgzm5rnMc8vimXGRCsBiiRVOkFOJOQpHP
	/eK3nyMzldS8RRjrXM6+0pBCHJOYZVjpZ5LM4yqO53pTJnIho0dpYAjhmKnZZw/fy0ekxGXaTnD
	+QF9ak0eoTGq/tk+aQlM7Xp8OtDQsFO16tYlQ5MSK9x1tuXU3JYvBKeNAKAVr9VMT1nxbpSU7/I
	LztCNckRf8460boG8tUjmDM51FsFBRmo5HhJWbptcpn//wQsIzESDRjNidsXusSsWFx3Qy1YXzy
	R8jIkUK9/poPxUf7O9uaDcnigPdQoQ6NxLuXJpE7vOMVUkZdm0PKcDQNGbkLRw5eHAj+aZ3hAHV
	BIJ5hDsPyepi8UHNOGcxenSkbJb2f31cSzmAoliJbfTaesRA4pQW2YHKRiKxl3+iZezieYcLX3j
	Y9wHh8=
X-Received: by 2002:a05:6402:3548:b0:649:cec1:6cf1 with SMTP id 4fb4d7f45d1cf-658a5f8edcbmr3566350a12.0.1769615482091;
        Wed, 28 Jan 2026 07:51:22 -0800 (PST)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b469eb9fsm1727223a12.28.2026.01.28.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:51:21 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: [PATCH v2 0/3] Add support for Awinic AW86938 haptic driver
Date: Wed, 28 Jan 2026 16:51:12 +0100
Message-Id: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHAwemkC/12OSxKCMBBEr0Jlbax8ECIr72GxCGQisyDBBCMWx
 d2NsHP5eqpfz0oiBIRImmIlARJG9C6DOBWkH7R7AEWTmQgmLpxzSfVbVVepqAmYINCutJoZKYT
 SguTSFMDisgvvbeYB4+zDZ/cn/ksPlWDlvypxyih0puaqUsZKfbMawzR4B+fej6TdDn+A5yv/O
 R8jpNMRaL6PODeFg2WmeaBiXNS5sX0Bxjce/+EAAAA=
X-Change-ID: 20251113-aw86938-driver-b4fa0d3228a2
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769615481; l=1152;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=s2XftgRLoQjS+g/1qoc7zKuSMJw+yLwcSC76tOy1XDY=;
 b=UpFCfkbXOgKJjpAw86bajCWZpxZ2xCtZDbZ3ywSoJtcvP95aZ1oKyJXqSvx3734Dc7DE5opPd
 noxQ/gLYBMnCYkfNbKF8qg/gnEClSRd+PNBQ6hm9KSGeQJ1wVeY3eJe
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add devicetree bindings and a driver for the AW86938 haptic driver chip,
and add it to the devicetree for the Fairphone 6 smartphone.

This driver is very similar to the AW86927, and shares many core
features.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
Changes in v2:
- Added AW86938 specific registers
- Added chip model enum to differentiate chips
- Link to v1: https://lore.kernel.org/r/20251204-aw86938-driver-v1-0-ebd71868df3a@fairphone.com

---
Griffin Kroah-Hartman (3):
      dt-bindings: input: awinic,aw86927: Add Awinic AW86938
      Input: aw86938 - add driver for Awinic AW86938
      arm64: dts: qcom: milos-fairphone-fp6: Add vibrator support

 .../devicetree/bindings/input/awinic,aw86927.yaml  |  4 +-
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts   | 19 ++++++-
 drivers/input/misc/aw86927.c                       | 65 ++++++++++++++++++----
 3 files changed, 74 insertions(+), 14 deletions(-)
---
base-commit: 0364de6be161e2360cbb1f26d5aff5b343ef7bb0
change-id: 20251113-aw86938-driver-b4fa0d3228a2

Best regards,
-- 
Griffin Kroah-Hartman <griffin.kroah@fairphone.com>


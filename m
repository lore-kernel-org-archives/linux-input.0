Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C092356775
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787296350; cv=none; b=fOIY03PnFipq5zEgWQAJNbiylXUKF2TxeCOrOqdnJ57tYtBV6kXaOamH3JhU73XWt2ljYGyaFdRiLPm/2oSydeLdgPpY63oVt2ggt7/51Jq7KGjfDZJa8MciRpWCkznwIr+Dt+vt7/CXji2KF9LBw/zhW576EMLnxkZWDN8I/tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787296350; c=relaxed/simple;
	bh=wAYifBw4LrLjWPQLRl35hYzVyfpBjeQp/AkgYLUI3gY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tz7+wG7KaKjEnPm+wO2n+tY1lez6jgipiywxlwgtrVazHGSsOMCt89yiAnggV8tSSvlglHrugBsswoLwH1xYE/RuNr+pLAt9qQAie79LrKpW86hwW6TXmiyNYCwVni/teGp50MV1hK1RaQBmnMUacA7hDxN8oH0XFfI//hLFjc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=cSr8OuX4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="cSr8OuX4"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1f758014b8so70201266b.3
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 00:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1787296347; x=1787901147; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=703iFda3ZiAtYyhVCmZdIqpRPYpgiDOlfHNwV7wXBo8=;
        b=cSr8OuX4SYAKIfwZjMCNZcGmlCXn8/2Obb+O+5IYJRiYexEbIpZG2F0zo3d9TCL6fK
         cJIGJcXFxCEB4tCOnLW3ThmHmXR8PWfsnQckM5m7Plq31noysQrF1BjPNpeTri2IiLb8
         bNDXHfPaDNU/qpKbR6axlCLJpvFx23Dc9DIQ4533mFuqJDLN0nZLBp1ETqAELNl8MbTY
         uTbpwmzL1B9bgka3qy+8ppHzDhYCMuDATwu18WcfKH+rSDvYhOnfptVqoEyB/jzTSvwL
         x4PLHxlYEg9wU+n/gK9b5juhjvMMD+5mEVU2cfThS9V5TGV7ZrTQpnDAv55yu0/i8Ag/
         gchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787296347; x=1787901147;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=703iFda3ZiAtYyhVCmZdIqpRPYpgiDOlfHNwV7wXBo8=;
        b=D0OwaYCyQITZ3jzbvJO9Flw4c9GCqnBIKCHjw2wVpgsxLDDwM1YADneMNMyPw35V1S
         1C+c3qtoiB5c12xz/Jh1AwfQAlZpOcy6cQq/vj15SZJrXDEr9KWir0AWbkUPbZQXZHib
         NXF5O66342kymJ/u591nqb7D+k557VPGYp84Vo7XHmEOrGyJzNCGz14FzfGBeJm4AXvk
         t8unEsTnY6AuKSDnXfdpMZUOhNbXGZB+XKczm2YwzVjXbXubxaY6m3unY1RjcpvsLf9Q
         i3+SZmClrW1lMOhXq94UiQ7N8V8cLFzPoN3g/k2j/c2a4JwHVk2u/nYjA8JLpGW0lBIi
         qsBg==
X-Forwarded-Encrypted: i=1; AHgh+RrYdS6aqOcdkJBzMMXnRlOCpS+/wB/FTf8PcLD3MXWT/6S/dZdDbTTvr6kJO3of6wQI+H9ToB5qbowSbA==@vger.kernel.org
X-Gm-Message-State: AFuF++nHSyNCYmS/hCx4/50sYD/Dv0oxW7Gtw9Vh0/k65ObLvduF3fIO
	9w3Hgzh2RBIRYjQSm9Io9VLr23QhGriaYgqDd+swvHtn313V3mi5cH3NePN1BTRVTkA=
X-Gm-Gg: AR+sD12q7pgjho6C6+ni7p2GO9bqgd2EljxU9UBW0jciKx1DFwSdcoJGRrIgJFlm3ll
	ZNG75KJt0kDOMXs/TKAqCdVME4MvcSqnSOQuKbCTkQMYXAKK9mkCeCeJ0tORkcgrdSV/RKCAKFt
	YO3uaNUvmI7FCf8MGUOTKpCHkNs4xHwYRfNtiFmGofp18RS/EUHlMYUJA29iyXd6syOgBrLPou4
	0ABlgue3rv0F3ILX5zFaAfMS1nsD9EfbpFp0mSso6JDuE7yerTA5x0tRnnJmXrWjj5rTt4g1qr9
	vD/b2oLL4OxaaQz250VQ9z4E7J4tHWHFdeSopi9WFtG1idavWJpz038r1+6aWv8qR94cqTwJE5M
	a7zSiXLWbez5vxb7Fuw7FQ4Gd+bUOIGwiE4B1o4cSVC8wv1eLzFJ16diWpnmUd+IsRmqvgD8L9K
	PVOfcirDs2DugBRhvKUoihPZkBu2GivNzyPjQ/A4PFg3FzMjJg5UyYskiS6zyuplyKqQLxR0Ysd
	sQAMvp7ILilxkvZ5bcp7oURxw5BNpOZ/0h2n8OThRLHhHJGyQCagw==
X-Received: by 2002:a17:907:ea8b:b0:c21:2c32:e2da with SMTP id a640c23a62f3a-c246a5f4515mr470788666b.8.1787296346819;
        Fri, 21 Aug 2026 00:12:26 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589e04b5sm339431866b.5.2026.08.21.00.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 00:12:26 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/3] Add Himax HX83112A support for Fairphone 4 touchscreen
Date: Fri, 21 Aug 2026 09:12:17 +0200
Message-Id: <20260821-fp4-hx83112a-v1-0-474941bd8860@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2N2wqDMBBEfyXsc7ckUWzqrxQfknStW/DSJIog/
 nvT6tNwYObMBpECU4RabBBo4cjjkEFdBPjODi9CfmYGLXUljZbYTiV2qymU0hZdQao06m5zQJ5
 MgVpe/7pHc3Cc3Zt8+jnORqDPnH/SUQNnI6Ef+55TLZbbVUOz71/IQm0+mAAAAA==
X-Change-ID: 20260820-fp4-hx83112a-b3e14819ae14
To: Job Noorman <job@noorman.info>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787296346; l=797;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=wAYifBw4LrLjWPQLRl35hYzVyfpBjeQp/AkgYLUI3gY=;
 b=2Dj0qb8NpRFvmLKwoYP/zkmS6yTYwg+eM5kiBlrtWmCLDfScI7wglxoxFsEke4uECD4sUI0BF
 eFHZvO/aQUsDuuNZzHcfBJmTSXU84048+NdR6JfrehzNS9Ya3cqXdiL
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add bindings, driver modifications and dts additions to support the
touchscreen on the Fairphone 4.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (3):
      dt-bindings: touchscreen: trivial-touch: Add Himax HX83112A
      Input: himax_hx83112b - Add HX83112A support
      arm64: dts: qcom: sm7225-fairphone-fp4: Enable touchscreen

 .../bindings/input/touchscreen/trivial-touch.yaml  |  2 +
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  | 21 +++++++++-
 drivers/input/touchscreen/himax_hx83112b.c         | 46 ++++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)
---
base-commit: 237a1c39e8dfd3e1c6f1f023eea37a48ec04cc63
change-id: 20260820-fp4-hx83112a-b3e14819ae14

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>


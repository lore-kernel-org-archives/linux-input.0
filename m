Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2043EFD02;
	Tue, 20 Jan 2026 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945264; cv=none; b=TNzStD9aUEwCCY2dM5Dvl5En7DdBQ1OvHcy6u1EoRLMah2noY0WwiysCTWQn3x/wG/bCBzbNmENW+N6tcD1LCXPcIMk5o+HkcIg/LazG0JuPI9+s4q3zusqHSM1zmEma7J+A2vMghnCxPyPPeSKMDhs5dfoF3m4S1qMo4cvbdZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945264; c=relaxed/simple;
	bh=bLtziZlfzLupaRKZLjA5+K4TNHL5aHyGalXUz4Vybos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SfgtKWw1tB5Kpyqn7HdSSVGhKpxd5fYB/bjuVY/f4c7WKzzKHNz7S4gOrONQqCYzIgvi52eEcTzMpk43rKqw0GwtOUP7WbYzn0Pi88zAunMzTMnpnYGZTq36M1441tMW9O9uxCNesthnalPUHub2p/OV1Lo9vqKypfR9nrDdgys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTBZK0Hw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTBZK0Hw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04176C19421;
	Tue, 20 Jan 2026 21:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768945264;
	bh=bLtziZlfzLupaRKZLjA5+K4TNHL5aHyGalXUz4Vybos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DTBZK0HwZFnqjBfa3YwKwfPzkhYDTz27nfk6j4fwpb1ccSsvqNX9F2nddH7I3wQ6N
	 BFMDwgCEemYkkMugFcwna4oA69lz7bDIFRF5peAj1VtjYWW+NEsB3t5b3nJHD19v26
	 Ma04nw+7X8tnYyN4/HKwicQF+sYIE//5Rcg+w2/U839n6ZNpN79x9+YtMHP3L+0/7Y
	 I+vKMdlhLKukakMCRagRmKl6PAXOIVMniNYThlb0E4qhypuEz8WCo6sJeFRQ68u5Z2
	 gfeShfAO9BL6/iGXhN+LlvH90R9KpsGCXAU7Fmg55V/LQIFpPUewqMWioLiRsSruAq
	 6x3kWeHVHtoNg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3D0D262A8;
	Tue, 20 Jan 2026 21:41:03 +0000 (UTC)
From: Yedaya Katsman via B4 Relay <devnull+yedaya.ka.gmail.com@kernel.org>
Date: Tue, 20 Jan 2026 23:40:54 +0200
Subject: [PATCH v4 1/3] dt-bindings: input: touchscreen: edt-ft5x06: Add
 FocalTech FT3518
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-touchscreen-patches-v4-1-30145da9d6d3@gmail.com>
References: <20260120-touchscreen-patches-v4-0-30145da9d6d3@gmail.com>
In-Reply-To: <20260120-touchscreen-patches-v4-0-30145da9d6d3@gmail.com>
To: =?utf-8?q?Kamil_Go=C5=82da?= <kamil.golda@protonmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Yedaya Katsman <yedaya.ka@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768945262; l=984;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=SqsHa1FpeRSC7pDZsCiIt95zVp6duwvdtWnRvd2BIBs=;
 b=tRIihQ6uebfKCxvAmZjZiDQq3Dpi5CjZSH4851BdJ0jzG4PUxeTHUDBiQwe1l7g9ZlDRCyucH
 lgbbv/MLQ9qA/T+NAH+jZb/MdYIxQimryLBHdEijwFvp5idogzwYema
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
X-Endpoint-Received: by B4 Relay for yedaya.ka@gmail.com/20260113 with
 auth_id=601
X-Original-From: Yedaya Katsman <yedaya.ka@gmail.com>
Reply-To: yedaya.ka@gmail.com

From: Yedaya Katsman <yedaya.ka@gmail.com>

Document FocalTech FT3518 support by adding the compatible.

Co-developed-by: Kamil Gołda <kamil.golda@protonmail.com>
Signed-off-by: Kamil Gołda <kamil.golda@protonmail.com>
Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
index 7d3edb58f72d84ed19fb87fdd136c97f855aba00..6f90522de8c0afbe2d9d1e04578316350f66ec58 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
@@ -39,6 +39,7 @@ properties:
       - edt,edt-ft5406
       - edt,edt-ft5506
       - evervision,ev-ft5726
+      - focaltech,ft3518
       - focaltech,ft5426
       - focaltech,ft5452
       - focaltech,ft6236

-- 
2.52.0



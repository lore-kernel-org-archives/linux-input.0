Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE43EEAF8;
	Tue,  6 Oct 2026 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288943; cv=none; b=lpVOH7/zMtajWZ64PH5Ot4OmNj2zbnj1To+hxGKQZc1o9SFgVfJ28aZhxAYcHwlUMk3v5GqZduht0cKEQ7AH9xuxuHwTKFRH+qJ+3nQiCsXXEQLZb6pUKbMDzSpBaEL6li+R+4osZA64DWt+24EqvHoQ1Vl/1t5dqvmynx+gF/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288943; c=relaxed/simple;
	bh=0deulQ1kIGuJRh4MmwOsQAYnS8UbaVp2fh4+ZadIOc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XuICdayPqf6XDatdDz1uZ/AXCvskb7CQlSke1qIGA5wIvLanTOmeIFId7CTrSUUdFAK0wYwRlgBalYwPrYqn30HoZK9+WGdu1xA7obAnrlPxaSncLmv/0hjTj3VTxUI+lECJcAyiLmLjWJ8CzYK1szbYN/9El+qM4KflRsv5kXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSs3V3OL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSs3V3OL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34AA0C4DDE3;
	Tue,  6 Oct 2026 12:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791288941;
	bh=0deulQ1kIGuJRh4MmwOsQAYnS8UbaVp2fh4+ZadIOc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YSs3V3OL57jJ3tSVJ9MgQ6WwGe1MLVA7+kRx/zm+YAA+28ZQm1ucMjaEDyto+nERk
	 D8K1CWUXrkB3TKuM9/AwDl63uYeGrlNL/g3ML7ucMiZkKyPmz2jgWqGnhrDdGZaORo
	 Y30AI0og3bP6CRhXCrNrDc3htVMXoGRhjNt+NcIWUUnLOS8Ic9OUezQRbx4ntx5Sq5
	 JlV6Kgi/64WyfRBW0gwhoxkKxpZCAZFYDEsyPCvUVc56MNgZezxTDwJVqnKgF14S2x
	 wPJGTC3OUMmA7tmNhF+SGSrFAAd4Hm9swUibtowRUTRluSiIm+iDs9N6jOyltF0Buy
	 xHstTCTsIJpLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC49CA5FFC;
	Tue,  6 Oct 2026 12:15:41 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Tue, 06 Oct 2026 15:15:13 +0300
Subject: [PATCH v4 6/7] dt-bindings: input: touchscreen: goodix: Add
 binding for GT970
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-msm8952-initial-support-v4-6-ecdcc1ac620c@mainlining.org>
References: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
In-Reply-To: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791288938; l=1656;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=WcI6NF2jH7/1jsgO/qq/6GfopHH27DV/LBlXLYlg2yo=;
 b=qL6ny7alhXWGpoNICSK8rqcxx5rVT8AO4gqTTVM1VOiJghV3hha3+wEm2zkfLYwxGFnWrKkdB
 CiBfsku2srqBULzKViXaAPwEvtmVKLN7hPJ3f0A3H2Sq5znJgcDSkAl
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

GT970 works with GT911 driver, document it to be
used with GT911 compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 .../bindings/input/touchscreen/goodix.yaml         | 35 ++++++++++++----------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
index a26a54d63a1c..4be2c137abd7 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
@@ -14,21 +14,26 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - goodix,gt1151
-      - goodix,gt1158
-      - goodix,gt5663
-      - goodix,gt5688
-      - goodix,gt911
-      - goodix,gt9110
-      - goodix,gt912
-      - goodix,gt9147
-      - goodix,gt917s
-      - goodix,gt927
-      - goodix,gt9271
-      - goodix,gt928
-      - goodix,gt9286
-      - goodix,gt967
+    oneOf:
+      - enum:
+          - goodix,gt1151
+          - goodix,gt1158
+          - goodix,gt5663
+          - goodix,gt5688
+          - goodix,gt911
+          - goodix,gt9110
+          - goodix,gt912
+          - goodix,gt9147
+          - goodix,gt917s
+          - goodix,gt927
+          - goodix,gt9271
+          - goodix,gt928
+          - goodix,gt9286
+          - goodix,gt967
+      - items:
+          - enum:
+              - goodix,gt970
+          - const: goodix,gt911
 
   reg:
     enum: [ 0x5d, 0x14 ]

-- 
2.55.0



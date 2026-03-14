Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2365378D86;
	Sat, 14 Mar 2026 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773496272; cv=none; b=LBNJenhGcYPzKWZ6yy8tuT4E3cTIYgxkTOoZiFIFNCZYTTfwAkXHM92QwDS+0dajol3zUXEiL6rpFGNZ4fk2ZBdi7QYurWVgP8E/65s0JQMRzGCD6cmbJsN9T5BSVx9XuZKPit4tjon8p1SRlovra6USfujOUYFARkFcNEQo1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773496272; c=relaxed/simple;
	bh=pW7t2BnCj8uwVF79bm6uJuPJ7BiinCQqhERJXQguAjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ag4Mlq0mFBmrw3QjmIh3fgaF2gwRll84f+DrWIt5t8FEThhuPu1Rlsa/VDWNv2cgwR+YatdkNVtKLu98lMWnYRzkIjmEyZ7ndDKWJiwvcdGSzVP8bKXRPvQygaM6iDDnsna9QPphvoJn7r1nuQI0DreWXtuZxKtbeNLZIbDY8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machinesoul.in; spf=pass smtp.mailfrom=machinesoul.in; dkim=pass (2048-bit key) header.d=machinesoul.in header.i=@machinesoul.in header.b=DTRFNVL2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0tUTWAy+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machinesoul.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machinesoul.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machinesoul.in header.i=@machinesoul.in header.b="DTRFNVL2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0tUTWAy+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFBF814001D5;
	Sat, 14 Mar 2026 09:51:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 14 Mar 2026 09:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=machinesoul.in;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1773496268; x=
	1773582668; bh=IhkQ/5onaqgb/nqLvtpbfM0RpnExUlf8pJvYxq0f4JQ=; b=D
	TRFNVL2+r2VcPQdjmYxhCClfY0TKepVXB/aBS+wLKbTfH5LDjua7AStSY04i6yT4
	f+i4udf2U7sclhMd4Hl+StIoA0o2U2xwAw0qACydfGvL22TS89mz/13FZLe0JsK9
	XABmviX3uQHstfCJGDJ773Bl64wi5kEOFvAx7UtK2rUzxO5DFBaF/FGl5o/VpEJK
	dfu2/0gtufMJ7EynvUbIzuzlGKFBpG1dw3MwYxo1/BIQfW3ZtfwPVLFE6SUXmErK
	itKJp2hsZLdRf1tGeQ/HhOZH3PpTlINqMlvwMAIFOvh2CTHpMJPUGqXQUOtcM3SY
	jBmTCJx+6CQtaGK3wllpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773496268; x=1773582668; bh=IhkQ/5onaqgb/nqLvtpbfM0RpnEx
	Ulf8pJvYxq0f4JQ=; b=0tUTWAy+VlDaqbLR/yLc3IT1lGtCKlultOWmIqBir+5a
	YNYHiMSGejYo/9A9IXiBmDivnyOqEQIg4yLtjCZjmkc5OknLYOP5CkHN2vIvNqWS
	3N4Hfz8+96UHsekpvRCJx169JUqyRWVSyPj7LaMpROF8mJL/goV3OPd10/qZhj0H
	UZAmjnDoESTvh2pPQhmmlMbVaAbloYczL61WXHr//w4ejx0tpr3/te0IBExCoCjv
	sUlTXg3RBDSyCOgaRHbno8hHcLupNL7V0Tj1BKSB0/gMeEfNMliuZcgOwb7Pk+Vo
	TYkZOJJ3oEltSi0/Zdj232GcS3wbBXyAfh/pB/zgqQ==
X-ME-Sender: <xms:zGe1aUQ-HFM9TUYUkzE-I4xTa13355PUSaGz-HQQoVvZbXDIKPHDCA>
    <xme:zGe1adyYXwKrPO7_xnj2661-mzFe0-kUpyOwEBEFZIuELbRCEZBhrBI67HZSBxgWS
    4DOPLMYJkodvv_X945UmjR3Ws0YFKXc20SGRoAMojTQNCtFxIaogq4>
X-ME-Received: <xmr:zGe1aUAOnRv4pnTKF2fBlVtagH9KBi-2gNqAW3r3XFREoXuYjUIQXRVWgVw_QQlaa0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledvjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeeuhhhushhhrghn
    ucfuhhgrhhcuoegshhhushhhrghnrdhshhgrhhesmhgrtghhihhnvghsohhulhdrihhnqe
    enucggtffrrghtthgvrhhnpedtudffjeelfefhvdekkeeggeffhfeludevtefgkeekgfdt
    gefgtdegueduledvvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghhuhhshhgrnhdrshhh
    rghhsehmrggthhhinhgvshhouhhlrdhinhdpnhgspghrtghpthhtohepkedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhhushhhrghn
    rdhshhgrhhesmhgrtghhihhnvghsohhulhdrihhnpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdo
    ughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhho
    vhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zGe1aZFxYLKMhPS00sVfRsVFo20xY9gcWmM5nxfnRtP9u1D5eW40xg>
    <xmx:zGe1abN14o-eiTYQxzEus0m-uua-Pe_1O2SXjGeerGOpeNnYzB6R7g>
    <xmx:zGe1aa6ku4EchJeGTNE7p48cWBIEWRFbSklwsoafn0wgwtD0f8-X5w>
    <xmx:zGe1aeihwQh6JxpKaLZKTrHdfIrSfy44OOR58lAVqSRFunjo5wV1DQ>
    <xmx:zGe1abqkN4qpfLNw-E-7VVcQK4QyGBUyBTWTLhSzZAzeTVT91ZHlCVMJ>
Feedback-ID: i6b0e4831:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Mar 2026 09:51:06 -0400 (EDT)
From: Bhushan Shah <bhushan.shah@machinesoul.in>
Date: Sat, 14 Mar 2026 19:20:46 +0530
Subject: [PATCH v2] dt-bindings: input: touchscreen: edt-ft5x06: Add
 FocalTech FT3519
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-edt-ft3519-v2-1-e28c3f9c6559@machinesoul.in>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MQQ7CIBCF4as0sxZTmLSprrxH0wXCYCdRMIBE0
 3B3sWuX/0vet0GiyJTg3G0QqXDi4FuoQwdm1f5Ggm1rUL0ae5QoyGbhMg7yJK5ISiPSNBFBOzw
 jOX7v2Ly0XjnlED+7XeRv/csUKXrhaHDOjKicVZeHNit7SuF1P7KHpdb6BWuB5+ipAAAA
X-Change-ID: 20260313-edt-ft3519-b3e2a33e88ee
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bhushan Shah <bhushan.shah@machinesoul.in>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2033;
 i=bhushan.shah@machinesoul.in; h=from:subject:message-id;
 bh=pW7t2BnCj8uwVF79bm6uJuPJ7BiinCQqhERJXQguAjU=;
 b=owEBbQGS/pANAwAKARGWjESSjK78AcsmYgBptWfJUaeeT8xABTbpAjxmtsnHJwJTarC1U4Hxh
 tFZUxWPq3yJATMEAAEKAB0WIQSzyzZlUlQL4G7prZcRloxEkoyu/AUCabVnyQAKCRARloxEkoyu
 /EVXB/sFcae/tYVTjr/gvm2gl3EABy7+EwMtXqOWmR5O5Uc81Frdr47OlZDqG0CtsBUiaQhFGaG
 euG63mz1atQa3pcMYxhG/9GzLJghM8l+D9NGDqkbmtcGTWKSyMd/ZEc5KvK+3Y4VdWiA/6YK2ch
 N6UHy4LAnHVvwXZFwuW5TONnLMk9JxVYc2qzO9DZXvkFXkhLbsO/9taCZ00yu+uZ8/bfQD+nYjK
 1Dwl5aLVnAhqmSyYMwgPnGhdsy2MjRw6q0tvHNqA54QVCLjt5F+J9GOTBTd65jLhOUsXnNaaviG
 ioDjKM1msLUZ2+zYc2xELuSCPzZlkBtsS9deyB6djSkyOIHu
X-Developer-Key: i=bhushan.shah@machinesoul.in; a=openpgp;
 fpr=0AAC775BB6437A8D9AF7A3ACFE0784117FBCE11D

Document FocalTech FT3519 support by adding the compatible. It's 10
point touchscreen, which is compatible with FT3518

Signed-off-by: Bhushan Shah <bhushan.shah@machinesoul.in>
---
Document FocalTech FT3519 support by adding the compatible. It's 10
point touchscreen, which is compatible with FT3518.
---
Changes in v2:
- Remove the driver change and add only compatible in dt-bindings.
- Link to v1: https://lore.kernel.org/r/20260313-edt-ft3519-v1-0-fe5ffc632fd2@machinesoul.in
---
 .../bindings/input/touchscreen/edt-ft5x06.yaml     | 30 ++++++++++++----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
index 6f90522de8c0..cc071acc1c72 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
@@ -33,19 +33,23 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - edt,edt-ft5206
-      - edt,edt-ft5306
-      - edt,edt-ft5406
-      - edt,edt-ft5506
-      - evervision,ev-ft5726
-      - focaltech,ft3518
-      - focaltech,ft5426
-      - focaltech,ft5452
-      - focaltech,ft6236
-      - focaltech,ft8201
-      - focaltech,ft8716
-      - focaltech,ft8719
+    oneOf:
+      - enum:
+        - edt,edt-ft5206
+        - edt,edt-ft5306
+        - edt,edt-ft5406
+        - edt,edt-ft5506
+        - evervision,ev-ft5726
+        - focaltech,ft3518
+        - focaltech,ft5426
+        - focaltech,ft5452
+        - focaltech,ft6236
+        - focaltech,ft8201
+        - focaltech,ft8716
+        - focaltech,ft8719
+      - items:
+        - const: focaltech,ft3519
+        - const: focaltech,ft3518
 
   reg:
     maxItems: 1

---
base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
change-id: 20260313-edt-ft3519-b3e2a33e88ee

Best regards,
-- 
Bhushan Shah <bhushan.shah@machinesoul.in>


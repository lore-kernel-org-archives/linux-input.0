Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3F62741A0;
	Sat, 14 Mar 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773500291; cv=none; b=HLlRR5AB9lijPhTF75uc3kcH3jKIRlRF9JD4cSxD3fOvCyM+fwYrDPgLOblBclslAOXbUoe8mkOQLUYO6GC18EE5AZPG+BH8pO8pspXnzFCIbB3QupQ5oeLLmijSIpzi5arm/WDqI0otiJY4fwU5zXD7cv1Dum7x9l/PWWsBiCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773500291; c=relaxed/simple;
	bh=qzZaBR6WczjUq19/Rm9o4qZLMSf1fqqnVk12OhWwCf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Fe/IbWVYG06ax/UHXT1WIb/ae03pgV2GIbqph68QfHE93K444wyWdT6gE3BU0HgX9lR+SHWe++NdKnOVp1u0hLe4BYW/bAjHJ5MRvGEEs+ejeZPGhoiV/66v+KzbLQaWvefzCeqSPqor6TB+AL5+63uNtOrqFLJGIHV6LwJ3upU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machinesoul.in; spf=pass smtp.mailfrom=machinesoul.in; dkim=pass (2048-bit key) header.d=machinesoul.in header.i=@machinesoul.in header.b=lXjAT81/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nGAPURnL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machinesoul.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machinesoul.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machinesoul.in header.i=@machinesoul.in header.b="lXjAT81/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nGAPURnL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FC7114001C1;
	Sat, 14 Mar 2026 10:58:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 14 Mar 2026 10:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=machinesoul.in;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1773500288; x=
	1773586688; bh=rewhcCVOaBlBlXLPPExXCzwA+4le69WPGJ1AWUoSONM=; b=l
	XjAT81/qyCLfokBgEdkYIG/cgFqm6oOWiujh7B8GMytsC4W09SrP5hY3oTz3lqGc
	vSPJeIUkWQbhPFzLPvSfQF4+PUu5P+cx5eJRkPKgTYGYBH0c3pM6/o71GPNBWZeB
	OdntNDBDEkNaTRe5NeWITwq996F/oS2rris0XTH7/YMvvmQAFip9IYVLZ2PYcmnv
	2mVMFSFfBsZkC68ntbQkn8zTDdJ8GZRu0vWrYfkvLjEMUzP08qcLYVTF7vZLuGh0
	JonVPmNY6UHPzdAi3H9DEoCskrnwpyuexWm/TDafmM+mt+yLHUCBZ7dEUHrVCIwd
	IB8u4w/xxg5THoiJa1PTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773500288; x=1773586688; bh=rewhcCVOaBlBlXLPPExXCzwA+4le
	69WPGJ1AWUoSONM=; b=nGAPURnLVHeYLbMKQWeK2K9I4N5jTosvdCoXQ5I5/7Iq
	z/+ImcviSBuL6mdSLTwb2dIHPwU+9YXwnAB47btPpsmwRhRgxVmkzu3n/c6c6qAs
	IGxqJHgUFJIZTmiXBx3xuIUdAM1Ssg0iwcih9vKM1AJuPpwqZ3gICzDqLEP2FJj5
	z8R8dvOg0aPQ43T3GUY5zA0UBH40BloV9r6e3wofk717zYxk5XKIX/h4VgfbTKsu
	YBs9OQAUzPypk4fomWwINvI1V/RrXujyOiSJ7RjUBiN8BRhuO9mqAN7k6rNAJ+NA
	dBioHt46+LDRD8LwtHB7AFenGaGaLhI6oqUuUY6bVg==
X-ME-Sender: <xms:f3e1afJ5MVpOaqRCBLJhdOcpanS_luNZLjp81eEFdSCVNa_gJDBBOg>
    <xme:f3e1afJVcAJgHCP4SOip5iCKezAg1s_vq-6ZhA8h0eRxdo_OSek_KYr1cJ-rm89ZH
    dJ1AHz0HoGhCD362zDebIQjebtpLJ0dOA8NMKQzN8NMAQDvt9CZag>
X-ME-Received: <xmr:f3e1aZ5U55D-g9otIkh9XhAe7T__suS18iFqizWCWUZrZIuCyRgAAAYpQu-UUfC-SY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledvkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeeuhhhushhhrghn
    ucfuhhgrhhcuoegshhhushhhrghnrdhshhgrhhesmhgrtghhihhnvghsohhulhdrihhnqe
    enucggtffrrghtthgvrhhnpedtudffjeelfefhvdekkeeggeffhfeludevtefgkeekgfdt
    gefgtdegueduledvvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghhuhhshhgrnhdrshhh
    rghhsehmrggthhhinhgvshhouhhlrdhinhdpnhgspghrtghpthhtohepkedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegshhhushhhrghnrdhshhgrhhesmhgrtghhihhnvghsohhulhdrihhnpdhr
    tghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomhdprhgtph
    htthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodguthes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:f3e1aZfb4MCgB0X42rOCoXEzdugvYTnAgsh844_AWvRRN8hT3Fc_Bw>
    <xmx:f3e1aUH-WA2TmBv774NH4ygovlXAlIyosjRcIN1QG9pYabznls0Pyg>
    <xmx:f3e1aSRdy3L_DURlS5fe_xCfCFbxxio8UvuCGpkm7kG7cpd-Jecy_A>
    <xmx:f3e1aSYw9SyrnhFUES_1kAdL-SFvqsEl7BwnbQattVu6ueQGZBXqPw>
    <xmx:gHe1afLgMGPVPNuU4Pyo3NDw7aaVjF1Lz-G5Nx5hQrbScdkjquiEL4SM>
Feedback-ID: i6b0e4831:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Mar 2026 10:58:05 -0400 (EDT)
From: Bhushan Shah <bhushan.shah@machinesoul.in>
Date: Sat, 14 Mar 2026 20:27:58 +0530
Subject: [PATCH v3] dt-bindings: input: touchscreen: edt-ft5x06: Add
 FocalTech FT3519
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-edt-ft3519-v3-1-5ee91b408ed6@machinesoul.in>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MQQ6CMBAAv0J6dg3dtQQ8+Q/jActWNtFiWmw0h
 L9bOGn0OJPMTCpyEI5qX0wqcJIog89Am0LZvvUXBukyKyyxKkkTcDeCG8noBs7E2BJxXTOrHNw
 DO3mus+Mpcy9xHMJrfSe92L+bpKEEx8Y5WxG6Dg+31vbiOQ6P61a8Wl4JP/vdV4+ggbG25BpbG
 dP89PM8vwGhzc2A6QAAAA==
X-Change-ID: 20260313-edt-ft3519-b3e2a33e88ee
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bhushan Shah <bhushan.shah@machinesoul.in>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2477;
 i=bhushan.shah@machinesoul.in; h=from:subject:message-id;
 bh=qzZaBR6WczjUq19/Rm9o4qZLMSf1fqqnVk12OhWwCf0=;
 b=owEBbQGS/pANAwAKARGWjESSjK78AcsmYgBptXd83zIxZt4ryZZ3gLBK1YM9xRA4A5LrruTxl
 fIWtbN3e9CJATMEAAEKAB0WIQSzyzZlUlQL4G7prZcRloxEkoyu/AUCabV3fAAKCRARloxEkoyu
 /O8sB/47ZIF92dSB5JscUM1Y7lQ3GUiLIvtm3M1AJ0L/zRysJXYU6l/cT+5rAqT0MU2rae/Nnty
 JyonfdUtFdv7fPLkCXKmKn7kFiEUWAaoOttpLFkOTw20BHEZoxU4yiaXM+j586KjL7msGAWUTmV
 Saq0AmZbCkXuAfi5t3jjhqrR8FpgD/ZHzl6fzVf0CbgRo9Kh/Sjl8C/IdsiQomhC8u8hOpx60fY
 JINjGIRSFqHI0eORsLClv/qIlvP07ie0+xm88FZawkNeJSlKPpNQpi52o4FrSRBuQ4hgO1wiw0x
 NlkFkjPqlYLXKiYToeSGZNII2i+08MI3KceHCYFQM7X9yBQI
X-Developer-Key: i=bhushan.shah@machinesoul.in; a=openpgp;
 fpr=0AAC775BB6437A8D9AF7A3ACFE0784117FBCE11D

Document FocalTech FT3519 support by adding the compatible. It's 10
point touchscreen, which is compatible with FT3518

Signed-off-by: Bhushan Shah <bhushan.shah@machinesoul.in>
---
$ make dt_binding_check DT_SCHEMA_FILES=input/touchscreen/edt-ft5x06.yaml    
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   ./Documentation/devicetree/bindings
  LINT    ./Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.example.dts
  DTC [C] Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.example.dtb
---
Changes in v3:
- Fix syntax
- Link to v2: https://lore.kernel.org/r/20260314-edt-ft3519-v2-1-e28c3f9c6559@machinesoul.in

Changes in v2:
- Remove the driver change and add only compatible in dt-bindings.
- Link to v1: https://lore.kernel.org/r/20260313-edt-ft3519-v1-0-fe5ffc632fd2@machinesoul.in
---
 .../bindings/input/touchscreen/edt-ft5x06.yaml     | 30 ++++++++++++----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
index 6f90522de8c0..68b2f1601654 100644
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
+          - edt,edt-ft5206
+          - edt,edt-ft5306
+          - edt,edt-ft5406
+          - edt,edt-ft5506
+          - evervision,ev-ft5726
+          - focaltech,ft3518
+          - focaltech,ft5426
+          - focaltech,ft5452
+          - focaltech,ft6236
+          - focaltech,ft8201
+          - focaltech,ft8716
+          - focaltech,ft8719
+      - items:
+          - const: focaltech,ft3519
+          - const: focaltech,ft3518
 
   reg:
     maxItems: 1

---
base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
change-id: 20260313-edt-ft3519-b3e2a33e88ee

Best regards,
-- 
Bhushan Shah <bhushan.shah@machinesoul.in>


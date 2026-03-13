Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E5625783A;
	Fri, 13 Mar 2026 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384014; cv=none; b=fPQ7zabctSP633EEIhsnCznOY3n2WaVjLLjnYbn8FN2HYghvH5eiY9+94FiO1plQmvUG7UQ1clOCa1n5Z9lNmhn+tSM54g5BWBtCJYbVcxlFrrzRSrm4AIe2RtkcYOZpE9qgmdJh3LjyESeDKYsYC0QDXMUHsn3ODpI9TzDy0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384014; c=relaxed/simple;
	bh=qelT5TN9ESt1ux/WFFiGQGzcwRhguwVMKxQZBKqOXc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7ihPVpd+V3zqWQEy21jPYrtbGx2BhN2c+IXIoXnqmgPekCV06qDMjv29YlgkhapTKirqHWhRAHoZMjbeA53oXMnT9r7T4Hxpw7hDahtorqO9OIXxjVanZo+LqfQZk4h9/ezedjMQ1TSJhC952mb65xSKCnQh/w55MY5MnIEQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machinesoul.in; spf=pass smtp.mailfrom=machinesoul.in; dkim=pass (2048-bit key) header.d=machinesoul.in header.i=@machinesoul.in header.b=JfkQW7us; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=POk6Gpku; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machinesoul.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machinesoul.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machinesoul.in header.i=@machinesoul.in header.b="JfkQW7us";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="POk6Gpku"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 34BA7EC0BDF;
	Fri, 13 Mar 2026 02:40:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 13 Mar 2026 02:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=machinesoul.in;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1773384012; x=1773470412; bh=FRlKRY5AL40+sbmiNDvdW6t5IIEYlSBN
	EYDRoXjOVvk=; b=JfkQW7us2UTjzodOfSItGQOdySE5ccQmXpOzOLoUxhoAnssH
	EwupEeASMcsvmf2sfa7bR5Qcu3M3mIvPNPh0rvDctukc4XbKdF/0odKCVHWlgadY
	AENUwA8PB6zUISvXhXCGFFH29C/mL8/1fRAVV4S1pHus6BME26omqEIXVuOTzW0T
	kUJBTNjYUyFSw+w6ONOwRRuPCyg2EHrmX00DQdcInIhzNXQVMLjRvRe224z3OuSO
	80/aritmb7Rn6dvro/3Fci4dzHRQkA+pc9Xa/jl/woESuzzTkzmDb24EThZciSpa
	115FHZQCTFW7h5r4u37T6+JtE/vYIdbG3/dkbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773384012; x=
	1773470412; bh=FRlKRY5AL40+sbmiNDvdW6t5IIEYlSBNEYDRoXjOVvk=; b=P
	Ok6GpkuFbGUifp+S/tWUs1SOooY1Cmk7F4IsWHU7yXafuXqJxH/rdhY4f3jzeXp6
	F0iD/Tzxs39+pnRtV+f5EuaehJ6uJ9mXjD35Oh3NGteZDYTIeuFG8GEzJnO6eOzx
	6JWdGcEd+DFgfjyamGPsGiNtjHP7KTXIsu/A8a7M4RKdQulA9bfotTmkp8d1Sa4c
	fnZbl+KF/taEGAbLqzsTQPkH/d9XaSeoStQtQiwUjJfbzAfeypNSfg0w/TMeTpBe
	bkNhMndLC//ro4TwFUM9SuTqIxm+4mXfn4nbiRLrniDh3fFS8PdOs0iFS5vTYmiH
	DFpGj4CsfDQmOjjmMAb9w==
X-ME-Sender: <xms:TLGzadr51ZWmV1EVAIONnrWNJUO-LOjzRkLVPEONA7LHl16fILQgFw>
    <xme:TLGzaWaOUO6Z5HLlLGcGNC8xtIe4WHv70Anvs65v6TOxFrj3l7Oyzcatpy3I3AR2f
    zYlEk7azogK134rLDc5VkBwYgfO4D1EptT9eS-QVa9lDPPzbnP4-oc>
X-ME-Received: <xmr:TLGzab8l-MR94q7-uHmAZRU60Fimi6ipuwsyYFudEdY2pw2AAWwCZFz75Kexdb-eCto>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeeuhhhushhh
    rghnucfuhhgrhhcuoegshhhushhhrghnrdhshhgrhhesmhgrtghhihhnvghsohhulhdrih
    hnqeenucggtffrrghtthgvrhhnpedtleejffduhedvffeviedvueefhfevkeejffetffeh
    hefgheegudeitdekvdehueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegshhhushhhrghnrdhshhgrhhesmhgrtghhihhnvghsohhulhdrihhn
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    rhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtg
    homhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepsghhuhhshhgrnhdrshhhrghhsehmrggthhhinhgvshhouhhlrdhinhdprhgtphhtth
    hopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TLGzaUmBw8T1DY7M4TJdje1rV2DNG2PSjAv5dmY4qKgqhaBplQvttA>
    <xmx:TLGzaYxXPvjXGMQRXN0dXKDOLoA1eB-pZEDZzU8XFyiFZcj5Y-jjYQ>
    <xmx:TLGzaW4-w1PF3NV3RaMffLynTK8S2iN0RAw5SMSzcHSe3FUfdAv6jw>
    <xmx:TLGzaQUfQhewI-OWVKvvIUtdFnHDoH03i5VSyFRyPUoN-XuEAEannQ>
    <xmx:TLGzaSY2HCETpVDgWSwVwxF5wWxBQ0bj3i5141eVS09aAoVENT0pv0XQ>
Feedback-ID: i6b0e4831:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:40:09 -0400 (EDT)
From: Bhushan Shah <bhushan.shah@machinesoul.in>
Date: Fri, 13 Mar 2026 12:09:50 +0530
Subject: [PATCH 1/2] dt-bindings: input: touchscreen: edt-ft5x06: Add
 FocalTech FT3519
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-edt-ft3519-v1-1-fe5ffc632fd2@machinesoul.in>
References: <20260313-edt-ft3519-v1-0-fe5ffc632fd2@machinesoul.in>
In-Reply-To: <20260313-edt-ft3519-v1-0-fe5ffc632fd2@machinesoul.in>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bhushan Shah <bhushan.shah@machinesoul.in>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=876;
 i=bhushan.shah@machinesoul.in; h=from:subject:message-id;
 bh=qelT5TN9ESt1ux/WFFiGQGzcwRhguwVMKxQZBKqOXc0=;
 b=owEBbQGS/pANAwAKARGWjESSjK78AcsmYgBps7FF2mDbGfNNHdj8v7bgGVlqHo09H4j+EQpkB
 HE0c8Jzw9qJATMEAAEKAB0WIQSzyzZlUlQL4G7prZcRloxEkoyu/AUCabOxRQAKCRARloxEkoyu
 /P1DCACeZHe1OyVKFf/K31AXM8pUPfK62IDFJsugJX6E3DAWb8groLP3iDrpJJEReZTvZE4k0ej
 6LfJ9HMpVLcusLA3ARPneCrij9jr6HBG9sb0AugG3jStbRUPPIPw/Zlz4SRiiDFpW9dTPfH/sUJ
 NAbg0rRiaBWd+k9m4vFyWT1O+H6S9qqUWBd95jwCw6kZwDsq1MF+TweJC5CWqSqQSrFcD7YSJpD
 uUUq7e/1EAuZmTzkOwszXbGEl8T7NRmLaZ1kLJBhT3ajZnARm3sfFM7eCrqNioGrnprYy9oQa6Q
 u60/JbwkMFhKQPLNWti5RVV00j1MLvVBRMtIi/eNhfifyy4A
X-Developer-Key: i=bhushan.shah@machinesoul.in; a=openpgp;
 fpr=0AAC775BB6437A8D9AF7A3ACFE0784117FBCE11D

Document FocalTech FT3519 support by adding the compatible. It's 10
point touchscreen, which works with same driver.

Signed-off-by: Bhushan Shah <bhushan.shah@machinesoul.in>
---
 Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
index 6f90522de8c0..34161af90156 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
@@ -40,6 +40,7 @@ properties:
       - edt,edt-ft5506
       - evervision,ev-ft5726
       - focaltech,ft3518
+      - focaltech,ft3519
       - focaltech,ft5426
       - focaltech,ft5452
       - focaltech,ft6236

-- 
2.53.0


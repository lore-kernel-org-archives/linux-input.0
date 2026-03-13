Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D1345731;
	Fri, 13 Mar 2026 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384016; cv=none; b=mtHGC90JBFxqISQAnEHe69oyTztWxKnAKbPcjDL98S2jox1/t8NN9Udy1hxMIKHGwbIg+U5MBlL69MpnD5MZ7Ew9W1hiZU89H8k30RRET0lGr6lbal6ghQZ1gLmNxU7wfZp6WTfWCNA6vA//MRDuWAFemyLLBCwwLcB9iRw1Kx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384016; c=relaxed/simple;
	bh=NsSbfl+vzeIUhG73tPZWhBpqZDTh3sxSy+8bo9N1urw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=geRQ1wKZQbanCfGOscyzwk1MZG1dVcBvomSLWp7jMpkCvJ8xAoeu9w8UJckVG9BbyI5OnEKK28kIQYiy0GcEQqhljuxy10Q8yLW6syz3jtrEJLDs4hWN+FaNEcFXfjcA4sLcUQui7JtPd2jjZoBOPj8kQAA+MWQRadaHsTGTOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machinesoul.in; spf=pass smtp.mailfrom=machinesoul.in; dkim=pass (2048-bit key) header.d=machinesoul.in header.i=@machinesoul.in header.b=Z2+bO0XW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jxjzm4Ms; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machinesoul.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machinesoul.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machinesoul.in header.i=@machinesoul.in header.b="Z2+bO0XW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jxjzm4Ms"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4C7614001D4;
	Fri, 13 Mar 2026 02:40:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 13 Mar 2026 02:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=machinesoul.in;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1773384014; x=1773470414; bh=mNDO05cRBiZ8fOdQWDfRylFPFVhTYamy
	Ih1jwcKMpXc=; b=Z2+bO0XWS3kk2PWi7+/eCA8Jkb7I5JYcviIyiiZFoA96YWil
	w3NBNwIPtM7kXGXUvpRgKERyXCuFgu5Picx7SQwTLLkPE0pkXX339cTdtDCOByHt
	abeMuPTR532wUP6PgM0aA9Fx4gEB/2So2GBBEI/xHzyxqtA8DhNVYV2C9y14lH5T
	qipxc37IDUmduaQpBN9tBryBrmCD+XHcALzHccYGxo6QGnyak7RPep/VMJ7NnWp/
	nh6wNpalDDo6NuwhM7E2dekE6SqofVusuI3CGUNIoefhlVPz3pvX/CCvY8AkE0aU
	M2tfLoad+66uhfSUQnZsWHEWuf8q5HAQ8tHoDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773384014; x=
	1773470414; bh=mNDO05cRBiZ8fOdQWDfRylFPFVhTYamyIh1jwcKMpXc=; b=j
	xjzm4Msd4Bx7G0iA84hawpJiCJ1xi11b2eeOCfU2hm5bOUyAimfBhu3cvdOn+4hN
	johWZ8sBD9kr3jeBsR3+C+vVcl8bGc7Vs6NaT9B46a1nnAcxgrxciqv3N2sssy5z
	3LILi00yTjdrcPnle1UafzjF4m7N1qZI4i3nFe19gVwQIF6Wu0cf6SBPXujZVb4O
	iX535GmpOQBT+Y2HN9nzjdESYx5EBhcFDvqOypOasTX5cOSruIY1EZ/8r3bEegFb
	P+G7YKesseuM+iNALRc9azEY2uJFLebbnM4+6FYueBrkm0rTmx30zdllF+2fpJZD
	toIQOhuqwpfpg/MNtxrTA==
X-ME-Sender: <xms:TrGzae55bpKE8XQ_zHwSHhqA5awSz9vtTck7qCgCH8cDaLdxMlxyiQ>
    <xme:TrGzaT68tUbja1VS1Ds5sTlJUaPF4F6Gis_diCaN_R_FBlfB7CQD_Gk04xLAh-mKQ
    h2jPHaA4gfI6Tn4fopEkKP-9msWQ8nP-Zl-b8j23pvkwbwm58HETFzH>
X-ME-Received: <xmr:TrGzafoqbDJAwOwknfJTmNQasatgNpw1gHwMVBCkask8wVlaEBC7rZ1u_B7W9CWPTWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeeuhhhushhh
    rghnucfuhhgrhhcuoegshhhushhhrghnrdhshhgrhhesmhgrtghhihhnvghsohhulhdrih
    hnqeenucggtffrrghtthgvrhhnpedtleejffduhedvffeviedvueefhfevkeejffetffeh
    hefgheegudeitdekvdehueenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpegshhhushhhrghnrdhshhgrhhesmhgrtghhihhnvghsohhulhdrihhn
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    rhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtg
    homhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepsghhuhhshhgrnhdrshhhrghhsehmrggthhhinhgvshhouhhlrdhinhdprhgtphhtth
    hopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TrGzacPI1kOXepWZGzTNaSgI0csW9oR7rnukT2iFfYtu8UcC9T1Jgw>
    <xmx:TrGzaf2BtI-5YXIB3lAvVyb-LkxRcCX2ctXDFZGnUX21p0ENq23T5A>
    <xmx:TrGzaTBcbaV7L0dZm02tvZ7QviDQZyYJ-CypIYVT92BJQjY8rXJQmg>
    <xmx:TrGzaUKQI86DVsuPZu1RMcSlId4UFYM9m2UYUG-KX_HFVEE8Y0UEqg>
    <xmx:TrGzaaSiiHJ1mXZAxLqFAherz-tVYDALl3wGfehOlTSxmBHcMTD8m0m7>
Feedback-ID: i6b0e4831:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:40:12 -0400 (EDT)
From: Bhushan Shah <bhushan.shah@machinesoul.in>
Date: Fri, 13 Mar 2026 12:09:51 +0530
Subject: [PATCH 2/2] Input: edt-ft5x06 - add support for FocalTech FT3519
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-edt-ft3519-v1-2-fe5ffc632fd2@machinesoul.in>
References: <20260313-edt-ft3519-v1-0-fe5ffc632fd2@machinesoul.in>
In-Reply-To: <20260313-edt-ft3519-v1-0-fe5ffc632fd2@machinesoul.in>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bhushan Shah <bhushan.shah@machinesoul.in>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945;
 i=bhushan.shah@machinesoul.in; h=from:subject:message-id;
 bh=NsSbfl+vzeIUhG73tPZWhBpqZDTh3sxSy+8bo9N1urw=;
 b=owEBbQGS/pANAwAKARGWjESSjK78AcsmYgBps7FGrw35IflAwgroeJ63lvHcwCas6SPa2no/8
 llA8yFhMVWJATMEAAEKAB0WIQSzyzZlUlQL4G7prZcRloxEkoyu/AUCabOxRgAKCRARloxEkoyu
 /OVIB/0fzR/jolKRH/dot/TLz8/+s4he0tsNdC4U17e7HzSZHKqhwQpZhXtNm8sYMqTAASs5JE2
 HHxjDraKhbymfS1SpJaRW5ieOsh66fGH3czq5w4j+wRdy9IXVAFgkoBGgMP508QvLfpdaZv2DsM
 22p3nZpsxqgzafxtZSMKtudBv7FL5/e1qif8zBummi19ipwebj9E296oJ8sGSpskljga8qaOVdN
 QukE0IZMxfaqIl9cr5DQ57JoeSmdh8D1/dlP1AO30bYvzVrU5sgg2BfXPqCJkA4wjJ4ITg6S1J0
 1ZefoKYCnqYQxBJXHw+zp2z6sk9Wtx5+fY6+p2w3N4X/o8b0
X-Developer-Key: i=bhushan.shah@machinesoul.in; a=openpgp;
 fpr=0AAC775BB6437A8D9AF7A3ACFE0784117FBCE11D

This driver is compatible with the FocalTech FT3519 touchscreen, which
supports up to 10 concurrent touch points. Add a compatible for it.

Signed-off-by: Bhushan Shah <bhushan.shah@machinesoul.in>
---
 drivers/input/touchscreen/edt-ft5x06.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index d0ab644be006..52188e1aa9bc 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1479,6 +1479,10 @@ static const struct edt_i2c_chip_data edt_ft3518_data = {
 	.max_support_points = 10,
 };
 
+static const struct edt_i2c_chip_data edt_ft3519_data = {
+	.max_support_points = 10,
+};
+
 static const struct edt_i2c_chip_data edt_ft5452_data = {
 	.max_support_points = 5,
 };
@@ -1508,6 +1512,7 @@ static const struct i2c_device_id edt_ft5x06_ts_id[] = {
 	{ .name = "edt-ft5506", .driver_data = (long)&edt_ft5506_data },
 	{ .name = "ev-ft5726", .driver_data = (long)&edt_ft5506_data },
 	{ .name = "ft3518", .driver_data = (long)&edt_ft3518_data },
+	{ .name = "ft3519", .driver_data = (long)&edt_ft3519_data },
 	{ .name = "ft5452", .driver_data = (long)&edt_ft5452_data },
 	/* Note no edt- prefix for compatibility with the ft6236.c driver */
 	{ .name = "ft6236", .driver_data = (long)&edt_ft6236_data },
@@ -1525,6 +1530,7 @@ static const struct of_device_id edt_ft5x06_of_match[] = {
 	{ .compatible = "edt,edt-ft5506", .data = &edt_ft5506_data },
 	{ .compatible = "evervision,ev-ft5726", .data = &edt_ft5506_data },
 	{ .compatible = "focaltech,ft3518", .data = &edt_ft3518_data },
+	{ .compatible = "focaltech,ft3519", .data = &edt_ft3519_data },
 	{ .compatible = "focaltech,ft5426", .data = &edt_ft5506_data },
 	{ .compatible = "focaltech,ft5452", .data = &edt_ft5452_data },
 	/* Note focaltech vendor prefix for compatibility with ft6236.c */

-- 
2.53.0


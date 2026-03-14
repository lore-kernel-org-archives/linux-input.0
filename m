Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524C1CFBA;
	Sat, 14 Mar 2026 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773496793; cv=none; b=levHylTecGWWnR9pJfWEq9gcyQCtdiEdoRlJb9OCNajnHDu+FaM5BBCz+w1P/kO1cpyOH+sHLQsRVSxgIpFpzxJPU34aqldmtfyYwEiXgwIFbXgRPMwkyo9K8QyIuMlLBCOx2ZWtl7txlYTD8VDwRCwb5URMJbekr2mUBFePpb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773496793; c=relaxed/simple;
	bh=F5kGrLLNXzlYyDhVu5VBEO68R7JjHRzDTZx4SZq+UfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WH0765N6zfALn2ln+SaiQSbkfVIoj2D62A/gaYyXIvs19TImN4BR7uIRoaMZqEzTANI5mMQtUcaHYnGstVIMHFVyyuOybawtyYrOOv4mG8TZHRuec1yWAk5N7AWUR3QTgDkqqz7dcSB4Czcbjggd+rVNvhsfW1j4RZxcbwqAjsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machinesoul.in; spf=pass smtp.mailfrom=machinesoul.in; dkim=pass (2048-bit key) header.d=machinesoul.in header.i=@machinesoul.in header.b=hYdc15E2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GAlPrzhd; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machinesoul.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machinesoul.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machinesoul.in header.i=@machinesoul.in header.b="hYdc15E2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GAlPrzhd"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B62C14001C5;
	Sat, 14 Mar 2026 09:59:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sat, 14 Mar 2026 09:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=machinesoul.in;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1773496791; x=1773583191; bh=oPMppXcxaTRZvxx8NcFlE9UgLd6NVcpQ
	RPz6cxKOZxg=; b=hYdc15E2ewmlTkjC79GWM6lIqapDzFVNNy5H0CEDQYlGiZqq
	abo5dSQxmJ3IzjTe6Ym9Pa9GTrG7CBMPLT4KhuLxyP7TPjnf84yTvUAV2nomNSWy
	1J/NoE1tT3kT/XK1vAThRyyLKOb8+jCW5SjvMcg63B7nYwGt33MZNDuCq7UtBvDU
	2dwNCkVSgTsSzweTns5AuI1v7hddw127Q2jZ+zQRq1dGpGrwVQKwgsVEdooxFZN1
	CX5q0SPRJwIc9u6GbJSpueh7iKkq+hd/IeGaEaZ6w+PcEyaijK0w0XsdSRCjMY3x
	Kev0W8FU5ZNHrUBYIy6Ic/RSWe/vCmG4XQ4Liw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773496791; x=
	1773583191; bh=oPMppXcxaTRZvxx8NcFlE9UgLd6NVcpQRPz6cxKOZxg=; b=G
	AlPrzhd14nsVnA84SmvxG5kbk6FvHLn4dVoe4xd4lqO10GyY+TBTckRcSXkLNt0y
	p2VjchrTLWUamQj82A6uRaG1nKy+ghi8QOaySQ9wdejDRansgZY4N15JkVxzmHIC
	C2OgRXTrb2d3LWkVK4ZZbPLBYUe937Iu3XlyFknoG5S9ku1spPmyzaUVkIcA+c6h
	VlUsoUypNJPwXgv9WGnVDDKws0X5ctPllf3T5Ia28aPxrUJDzfeV3njutd05/0tB
	R1FNkAeKKmacrUf3nZMFeL5Szt77JuJBleyRMc0LOQhgWC6lLoRBnUHujxLvE+pJ
	Mwg5pzkIFgz8GtdToKTAw==
X-ME-Sender: <xms:12m1aaMscsjN8QoUV7v-J_gj0i1bE96leQuOyz6bmOVYhMt85kjJ8w>
    <xme:12m1aU9xs00vXDQCDmXHphUEA7xDAkKfEzfXpcEFXTWcASD5MSUfWTuBRVwrDl7gt
    kXmMQoHT2THSqAwEK_v4I_5f5yqjl-MkACRcKAUdL0513tOLWZQxc4>
X-ME-Received: <xmr:12m1aTeJy8YRvMW6ATD9223MVMlG9B01gz6ogYVLrJNmknyd1zLFZABCYdMf1sL94g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledvjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepuehhuhhshhgr
    nhcuufhhrghhuceosghhuhhshhgrnhdrshhhrghhsehmrggthhhinhgvshhouhhlrdhinh
    eqnecuggftrfgrthhtvghrnhepgeeftdeuheetjeevveehkeegledttdeikeejledvgfdu
    tddvteevkeehudduledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghhuhhshhgrnhdrshhhrghhsehmrggthhhinhgvshhouhhlrdhinhdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrii
    hksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegumhhithhrhidrthhorhhokhhhohhv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhn
    ohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuth
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvges
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:12m1aby2WOWlocRU3OTehq6Z1CyuqzQAcc6iyA4evynyBZtmVgUQEA>
    <xmx:12m1aQKLYF-W3Mlc3FPqrKMtOWi0-PQWsGiL03jtDIAaxIpNUtqCAw>
    <xmx:12m1aVGxY0hwr6TC13mVyhadYhD-zIUvSkNCNLLVJo50lD_bN0u1uw>
    <xmx:12m1aU917ZneeSz_5y_mewfhSppWSdFJdVuLJt1hZUHJ6vcotmVp6Q>
    <xmx:12m1abKn18-VrJY3PYeii6aFIkNUNKsgG6V2zxcBbfx6fnBcx7pe793V>
Feedback-ID: i6b0e4831:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Mar 2026 09:59:49 -0400 (EDT)
From: Bhushan Shah <bhushan.shah@machinesoul.in>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: edt-ft5x06 - add support for FocalTech FT3519
Date: Sat, 14 Mar 2026 19:29:45 +0530
Message-ID: <15572830.uLZWGnKmhe@antlia>
In-Reply-To: <20260314-successful-nano-hyrax-cc3b21@quoll>
References:
 <20260313-edt-ft3519-v1-0-fe5ffc632fd2@machinesoul.in>
 <20260313-edt-ft3519-v1-2-fe5ffc632fd2@machinesoul.in>
 <20260314-successful-nano-hyrax-cc3b21@quoll>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 14 March 2026 15:55:13 IST Krzysztof Kozlowski wrote:
> On Fri, Mar 13, 2026 at 12:09:51PM +0530, Bhushan Shah wrote:
> > This driver is compatible with the FocalTech FT3519 touchscreen, which
> > supports up to 10 concurrent touch points. Add a compatible for it.
> > 
> > Signed-off-by: Bhushan Shah <bhushan.shah@machinesoul.in>
> > ---
> > 
> >  drivers/input/touchscreen/edt-ft5x06.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/input/touchscreen/edt-ft5x06.c
> > b/drivers/input/touchscreen/edt-ft5x06.c index d0ab644be006..52188e1aa9bc
> > 100644
> > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > @@ -1479,6 +1479,10 @@ static const struct edt_i2c_chip_data
> > edt_ft3518_data = {> 
> >  	.max_support_points = 10,
> >  
> >  };
> > 
> > +static const struct edt_i2c_chip_data edt_ft3519_data = {
> > +	.max_support_points = 10,
> > +};
> 
> So same as edt_ft3518_data? Why are you duplicating it then?
> 

You are right, it does not need duplicating, I sent v2 which adjusts only dt-
bindings. Although, I must point out that this driver already contains some 
duplicates and I simply followed that.



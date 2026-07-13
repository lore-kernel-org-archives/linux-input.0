Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092363E171E
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934963; cv=none; b=cJN1UxdOiMpAZxc+nUNzU1P3BIoTdUfxRZ9uigqXclRnnZQeCx9Og6J2VgVXXDJHfdIYNjD3mHpBOEONdeioX6HPHqAZvsz1cPizGDIqAIUsCmn5YjPsRXJpMgjHxSRYb4xv9FkupUg+7F1bqQLHvOsIndmf0HCEvy1VNCCsyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934963; c=relaxed/simple;
	bh=IZYCNMPejRkhuKLcAOsd2Qmpr51bJHVcYw/mlM0i9As=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=G0hdb2sj69EvLmlyJDkM6iWTby5XDzYBXCoQE54GFfrNeqt+8q23zJPtRUpppDTnRi57DIM/m1jarlISNHUuLJgNBU0mwh5KOeMqy//GT8hjv39uqkGoMEWKsjPR4wmzeRTgTDv1zcWQRsBdXA5PoY01kqVn1T5UtcOSf5haJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=LMq68qAH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oz1f4w6R; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="LMq68qAH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oz1f4w6R"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id DFC0E1D000C0;
	Mon, 13 Jul 2026 05:29:18 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-12.internal (MEProxy); Mon, 13 Jul 2026 05:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783934958;
	 x=1784021358; bh=IZYCNMPejRkhuKLcAOsd2Qmpr51bJHVcYw/mlM0i9As=; b=
	LMq68qAH85hCdBg1kTp5wUydTjFrbbyw6dSIawp1oNplDMqphxAY3+OBewqgmKVX
	xhpR+u1WuvrnWTCjzDG29MilzN4XTB8TX3hA03x41FXHhwAH5g2i67/ulcIz3aFI
	GeC6vstqkbuANI3XZFFqZAi4oSEcOPstlQqil5LDOTJIRwLoTrZfFlPnZ2pTaWcs
	HNtPoc68Cf78Mo0P4/D+/LeC0cRQdQTTH+VPeorrS21arSKxrGTuGpmeatRbC1eE
	X4t6sYFVc+ttLuAPBzg6v2v6j6ItfhTAv0bIK1tmOmPTpC1a97JluRCFH/4zpTip
	8rmMS2tQT6wbehOTnQVUwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783934958; x=
	1784021358; bh=IZYCNMPejRkhuKLcAOsd2Qmpr51bJHVcYw/mlM0i9As=; b=O
	z1f4w6Rw3sq7rvI1di6CxVbunOcLkvlhzoU/G/iOtj6PEF6ZT+BunOwFdaLS4Frm
	6WrseK2faOHiqmYggDe5sLHsbgNOtPNvTR9utvHkIYGbjQxJxu7Iz8yj4Fj3l8FO
	GPITx3/bdDNGSHII2baUa2SX+wLOTjzKAtWz8PFNZHSJ5QYlN67a0VMpHeMc0ZAg
	K+emNFR1XlP+8iCIcLGs3FbdMwxWeONSrZMwy62aKdLqoON+KT52xXgYbyOPUMr9
	pD03i4IHmqmX58XwjXDnmUm3hkavcCTtv3wphcPj9StUjaUSe1AlPOwa9B51WE+g
	YiRssD+S+SMMTKc9z4vvA==
X-ME-Sender: <xms:7q9UakAcxtEatkY-jUAZlhMXxQsnMZbpDiXSH8lz6tdO-1Tg_OF1sA>
    <xme:7q9UahVbSrUW26r3axHMscuAr-kjyXF7EQNMnnwEQpTQi32cao3ejfJkK-eWopHkq
    3a4B3dVcOXUMqxB0O-26_fQ3aFLfzUIOhhuekhG-aKIDCrTdp6F4oA>
X-ME-Proxy-Cause: dmFkZTGhO3Q0qwwK94Vt7JMxXr0mtpG2y391gs5flwJ3MaiFwWdeyDY9ZDsTTxlLqC8MNQ
    ELKvJgXx1f4qolMlO4ph220Jc38eocSuc07CWGSl9qzt2OKVUVTLx3qqm+4SZlp0ivCwZ/
    exkN6dKBzFRvHbIfhqTMBZ4UzAXAA/O6TOy4vCdMwq0PhrzFNvHhQRo4ge9F0cCyLM+GQD
    ZW+hxdIXajXvXGprH3Q5usqs3/W0Yd9WmN8BjhAtseoyMOhIlUtzTXpQXLQQvVY6HCvG3z
    nIqBqV5eYqvvBimNkDwCu21IMZ9HDlDo/CFBMyM+0JT96dADbN7vEl5qIeZKQ8EaXObeNY
    wy8RQAO4R5xKHnASW1O7xry+tVk9n0dnyxnOwFoJLlizCpAma8CrROUsTW8CDpKdRfYR1z
    W78IqlygVt2hXxCIGLEnSMiI9glBsGhIyxsm2Dm9VKXYlSYOgvLreU6bHVnL6Uc/TYs2GG
    yPE52KsJ6IS/Eq8goZ4HSsXbVcc4S4UufysvdwD4npZ6D8FbFUVaOJ0TGPAP/O4bShmaCm
    X7bo/CnKE30p/uB0kEaaSurgzq/5jgutyuVyx/NHfRuZZqc0olGSrWX4qf15Z98inxJu4J
    yAjqbey3+g8tDM0rpdmwHUY0qz/CAWUsMdOcqGRZoS/HpRvX9O3I14pN0Dow
X-ME-Proxy: <xmx:7q9UaullHbOyfNXGv_aw83Z1fUQCnYBG7pdwvI4wMc93UPOFcQLIXg>
    <xmx:7q9UapqOlPXfH4MpZvY1dINl53H-OZ6ce-NXpBhNZ3IwJNi2e0gT5g>
    <xmx:7q9UaltzpFyhvXMdeYQMtV93p5KszNbuh8CSFdbxlv78o0ndAnngmA>
    <xmx:7q9UamE7Z-ckTJHQcrnQJutsBRr9NfvawVgm90Ar8QZ5ysIOJUqDlQ>
    <xmx:7q9Uao83IWszDLub0xlaIf57Zt9BYF0SBbkBzoY39tCv8ynSUxEOKMvy>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 305721EA006B; Mon, 13 Jul 2026 05:29:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AeQlmnlEDZAk
Date: Mon, 13 Jul 2026 11:28:56 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Rafael Passos" <rafael@rcpassos.me>,
 "Benjamin Tissoires" <bentiss@kernel.org>, "Jiri Kosina" <jikos@kernel.org>
Cc: "Shuah Khan" <skhan@linuxfoundation.org>,
 "Brigham Campbell" <me@brighamcampbell.com>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
Message-Id: <850e8696-311e-45e4-874a-8089afe35907@app.fastmail.com>
In-Reply-To: <DJV56QRLBO6S.3H33MNASQ866@rcpassos.me>
References: <20260710153456.2093889-1-rafael@rcpassos.me>
 <DJV56QRLBO6S.3H33MNASQ866@rcpassos.me>
Subject: Re: [PATCH 0/3] HID: wiimote: new LED behavior on connect, and scoped guards
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Fri, Jul 10, 2026, at 9:35 PM, Rafael Passos wrote:
> I checked sashiko reviews, and there are a few needed fixes.
> I will delay sending the v2 by a few days, in case there are any other reviews.
>
> Specially regarding these two questions:
>
> On Fri Jul 10, 2026 at 12:32 PM -03, Rafael Passos wrote:
>> [...]
>> The hid_info log message prints out the controller id.
>> I was considering adding this number to the controller name too,
>> but was unsure if this could impact applications using it.
> - device naming

What device name are you referring to exactly?

>> The wiimote_hid_probe call can also be changed in this way, but I
>> left it because it uses the wiimote_destroy in one of the err cases (w/ kfree inside).
>> But I can apply the change there too, to make this more complete.
> - wiimote_hid_probe scope cleanup

Ideally, you'd be able to call wiimote_destroy() on partially initialized devices. Not sure this is doable, but I would love to see it. I don't think using __free is worth it, if you retain the other goto labels in that function.

I mean, this is an old driver, lots of the cleanup-handlers were not around back then. But if I were to chose, I would either keep it as it is, or ensure that the destructors work with any partially initialized device just fine, and correctly checks that it only touches stuff that was initialized (or ensures the functions it calls do so).

Anyway, I like the series. I will review your v2 properly, so please go ahead!

Thanks
David

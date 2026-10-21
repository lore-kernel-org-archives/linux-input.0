Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602179;
	b=uUuIDj/cdatJJR/D/3PF6XUAmoFJgJZ0B4IJ4D8/xzLKEmZkYYS/APXoStG6rKXa7/9M
	 /Dznu7CSzf3U4jFGPjgwSspmCI4RWvtaM8HjTCFBM1ArzZqG4vc3qCIwXjiQztzL714ZI
	 2xuTchoS+khvaF1SZno+2s3XmFBaiCAqqy8zjmbPc4wTbYBREsDLPHzMI0xEOU32FD273
	 EPt/fve9MQ3xOGfjjSNphTfsetI48yYw0Wky5cX4KeuqFHxBSz6gfLDHpMkUZLo7ZReF2
	 9iWeAWHVMoI1TSqC2kSgt/SqmZrw8QohjdUUWJZoeozd4+vXCzMchvc9UPPBw2UJgCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602179;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=TEZyD5pcu62HA6lXMz0SzC2W+CY7uiKBKznI8rJlxsQ=;
	b=U/MNKK/XYbJUlw1uxQnAiegQUgwItPa59vsuLeTqbSkPQRnBs3GeuX5i9QdIU5orHbQ7
	 CSswNa2xe4O51JtfFeztrvbIHaUtZ3AZfDaZ+GCkdDYO9ZK5smRy/eKsBqKSubYpcJGWK
	 dLOkbg4spg7+gBQ43pxZKFU5Aas8q+V+R3FnAqiAUECOIVkuBEH6gUHb0IOIpOzW9OTrR
	 dQ7O0Khjz6xRQA5UiXxU6qoIodbUJNFlhZAqc+P8f5/xOLXJx+anV3aOQDGxnV2y5Qb4m
	 I9O6fBRLUFitAhq4EBpiHFta23M4Jh4qDdlbUE9ty2jCZ3h5E8EGFU6r/UuRtJcsTZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=QRY1ZjGB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kG5AVI4X;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63E606A319
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 17:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE63E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=QRY1ZjGB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kG5AVI4X
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id DFCFCEC017B
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 13:02:57 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 21 Oct 2026 13:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792602174;
	 x=1792688574; bh=TEZyD5pcu62HA6lXMz0SzC2W+CY7uiKBKznI8rJlxsQ=; b=
	QRY1ZjGBBhV/NY/+vXckqdP9UdbG7ET+EHLz9tErP6Ht/1xX/XhG+5lEdDQHyh7n
	QqO6RiwQMU76DAM999Jg1m+o4RgSBt3CuK79mu3RlJNmrs/eIIY7E9PyEc3k73zL
	UqGYL9HqdF2GK9Eqou8u9bYjXTk9EL1Sve1rxOaqJYMkJ6xWSfEO7gmtjs0ScniF
	WuyQ1gxJ+NPW+glQ9QmPT+qk1da6Rkcew+tE76lRVx2IMjvrOpwn/9wJdFODNiWE
	kfUQQho9RVGmsDYznSmTpXlrbNGxpOPCfh75U+Wt2he6QC0yWfb29CoV1x1m9YBf
	I2RI8990ppHYKvGpXywZoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792602174; x=
	1792688574; bh=TEZyD5pcu62HA6lXMz0SzC2W+CY7uiKBKznI8rJlxsQ=; b=k
	G5AVI4XTRSGyEJmWN27DMXkCV1dpAXajXKfTvVH/rEHlrO1Q12W0h+MbHFSAy5IG
	yafOOWJdzwT6zkEZKkG960TJ/dAd4mljkTAdLWOLL1N8QpDUUnde8+OFUOLGqyax
	i/uhZ+H82618bzRp4SlAg+x98sGxfTWThhDI1Cq+oPn5GY1W9UJJb4E3GN7c4uPj
	EkTFDBdnSlZzj5hvNZNOIyi3Cgv4Zdpq4xaCNnOyyPIm6xmr2rHxIYmC+Pky+akm
	BifwkpegJBFRUmTUv5IBMTGHBASHL/swC8CzGZIVKJVgwmW/lIfzjI31khPlV4VE
	/SjmTd/pkQw722LkSz6gA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792602174; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:p+bUrZSIRJAA9MXOoL/3kTbhd3KBAyJuC9OvdgyAsP3zZBu
	B8lPM4BMg0k7JSyOiPiusKIQ/iTzc5YLXE+gBk9fzArE65p0SopK6WINmnjKxZ2B
	YWnWI+JbQb/baoxYNYc89tJOPCUpUEuMPcp8lPEP+8r7U1eczfir9qVPhiqwmhgn
	5fsvZk9U24WJoLxKxvhRasortvCubW3F66Z9Ewi/wlRt0UAWT4huHOiAzM1NVmqJ
	S7ajkU+uWKMRgg8yiEmEuen2fP7q2ljuoqX0U/6mxVeObmKgSYDQYEiRK8b5RpMk
	893qI3zLvxbq11LCkC8qRUk0fRisyIb3M6ffnjQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0dEGpu+5OC750QFyrTXNnD5XTzn4dE9WmDdkwUY9cCI=:itydhWu1NgktY4WhwToR9q82X6aIYDRQkv5dsPsu+pQ=;
X-ME-Sender: <xms:PPDYahItIjuCYX_hz0h8MzYkkE9GTF7Zx7_VW9dffJXTV8Lgk9piMQ>
    <xme:PPDYan8wMuYvKpg9adBqpOcFnxbmR5GH96JjtsQlAlJMYo4xV8-0pTGbaqBswfnIO
    v6PmhWZO-WX66MOukSkrLsrDZCQX_6FWIKK50RCPtr-H-ncse35g4HP>
X-ME-Proxy-Cause: dmFkZTGKtv/0ANKjDg40Sw8CEUymGqXjjmpaqvC7zvrFp5nBZxkDBqLuiZJ/cE9cGA9KqB
    i8UHUsXp9uQyFcYOPQFrTLEygjnhao9+CkQTvm2Y4Zca7f49/BI62DJfRoiMbSE6yVxHrT
    +NPQ5hWi+AZBkWZKElVhjPau6njeHgyuZCDuYdNyRCnHwrCcY2bNaPRsMtcUGZwVLIwX9Q
    qLwZt1x/1z7gyCeKE3xaQQDFJtnEurEJJKQjw/gD9hQSQZVcX5tknzeULCduJCYwsdwcng
    kcV1DkjK/KKbIUEb1ulfbHsAhU6MX3zVmwoCsnjPDgeowJbEmQqbSND/m/m+tsKH04IvJJ
    90lgFONmIQI+ymK3FiTcvmO4lADoyI82U5SEXAyAWFcb9808iG1uA5eBMdy5vIeJjw18a6
    dofU6VCCK6cOe4P3fqC+kiLlyLvaxt0689dN8NsdXuxexi5aef0WR/oXfoBSsDYg8DZ/zY
    qwJsMmJupxIvIQT9lPgX4tVL73M6qCAFV6sKSGooyxRYR83FEpEAu+rx22iR/FJ0iw5U3l
    NDcyKy3hBBL+9uOabuCosbuaeREdr3Qv4pMIwmEDKDo20C5E/DoYO2krX/8b2vsS4S3Cq9
    mTP8hBdn5unVCSBq6nd6gWEO3+r5h84P466RTvUHQpa/QKFNcDIKMEcG+dvA
X-ME-Proxy: <xmx:PfDYan5fF5tWRe4L9yUMchFmntnD44LhSaIJAGaBVdn0Zd5SC1POlg>
    <xmx:PfDYave8mocWvqv3ManDpoBq2hiP7RkHf5rPrb9erLVLpUxf8uhWyA>
    <xmx:PfDYaiE0eq--0eykhAErvc1AnKBm9X0Or3PgQToa3p6PB3URLf10Zw>
    <xmx:PfDYaoSN1jvk-l88eAfbb8hCOtWZ99x8InTqPf-6r5hqDMIrUWWOlA>
    <xmx:PvDYarVihCqiGHca1UMiyB7ExgAeYFORzCFkzLu0DA1TKxoIEDlbehC9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9BCC232A0093; Wed, 21 Oct 2026 13:02:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AZo3noQSaVtc
Date: Wed, 21 Oct 2026 19:02:32 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Bartosz Golaszewski" <brgl@kernel.org>
Cc: "Andy Shevchenko" <andy@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 linux-input@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "Hans de Goede" <hansg@kernel.org>
Message-Id: <9496ea3b-563f-4517-86d6-e20694e2ec9b@app.fastmail.com>
In-Reply-To: <atjuDNi0_SXs4y2d@google.com>
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
 <20261021015004.1537738-3-dmitry.torokhov@gmail.com>
 <CAMRc=MfZg36BULXh3n-ce_x_4B_xOn3Jp4Jgo5BN1LsB2FqaTw@mail.gmail.com>
 <atjuDNi0_SXs4y2d@google.com>
Subject: Re: [PATCH 3/3] Input: soc_button_array - convert to software nodes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 21, 2026, at 18:56, Dmitry Torokhov wrote:
> On Wed, Oct 21, 2026 at 05:11:32AM -0500, Bartosz Golaszewski wrote:
>> >
>> > -	*gpio_ret = desc_to_gpio(desc);
>> > +	gdev = gpiod_to_gpio_device(desc);
>> > +	fwnode = dev_fwnode(gpio_device_to_device(gdev));
>> > +	if (!fwnode) {
>> > +		gpiod_put(desc);
>> > +		return -ENODEV;
>> > +	}
>> > +
>> > +	*gpio_ref = SOFTWARE_NODE_REFERENCE(fwnode, gpiod_hwgpio(desc),
>> > +					    active_low ? GPIO_ACTIVE_LOW :
>> > +							 GPIO_ACTIVE_HIGH);
>> 
>> Sigh... I hate it and it looks hacky but I also don't have a better idea. :(
>
> Thanks, that is quite common reaction to the code I write ;)

When I looked at this one in the past, the only other idea I had was to
completely separate it from the regular gpio_keys driver and just make
it a separate input driver. I think that would make this driver a bit
cleaner, but it would also require a bit of code duplication and I
can't tell if that is worth it.

      Arnd

Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422A3CC7EC
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105026; cv=none; b=RaNtDgiqlyZsIqB0oREVnQwRTkOWq5I+PGx7qt5RDR48gs5MJv1BnHRvvssfHa3FaGwdaIhFXsCQL/aDFNRc9VzvB4ezuh+3fVnL0QYYJV6MjhAHS5TiGNEUPl05n36YhKnUaCLZdbT/5ATliz/Qgzo4s71i+cC5t5gvrw26VpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105026; c=relaxed/simple;
	bh=9lMaQMmNuMEN8dVLgNG9dU9W84YYOfeLkYvobdPqucU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rcg4FtI0uOnOKfaTR1M09e0bgOVJbzGBSc5ax4p+/J20uIeEF83NC4bQ+Y0J3Fv76XyyfUuUlr6R3hZZdBbMWHfRaGRMwX5JlS4mjaZ4nnZJVhPr/M1zV0Bv90O+W3P3rS+9U/r9bx1TBUUEbkljFuiQTvGCOiOFYFz8uWFw2eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=OkMq63kL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=re5SspwY; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="OkMq63kL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="re5SspwY"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 6ACE51D000E7;
	Wed, 15 Jul 2026 04:43:41 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-12.internal (MEProxy); Wed, 15 Jul 2026 04:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784105021;
	 x=1784191421; bh=iKUothbm+a7l0maCZFc8zfDpM+rikBdHRVxisVrwd1A=; b=
	OkMq63kLTZlWKiDIMiFmurK8sBBPfx0rK1opLihNqC0kgyJ0fBkbY+CSUcMstTi2
	smLoYXZTsHg8aQ/LAWzTkydYTm8+/2wgwtOvJo2jOpyNljp+YvrJ5ZnlS0nY7xpy
	sWAg33xhcl5V9bpIp4S9JFW+0CLS+0krWsih4LxbcF3MdWIM6QeixFLzd28wkuts
	v9alPPrjWvbbpvf2atJ+tdrUEQD2Rghmn9ea9Fjchg52mA7c2XV+ZXITjh0ZB7QA
	jBfnt63cGt6OwAzyQpLEyslJ1X+YlOSA8XhU9jpR5iHb9nWf6ZhdFncl6qqtCskC
	BNzKfqcvX/gE3VbcMKZQCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784105021; x=
	1784191421; bh=iKUothbm+a7l0maCZFc8zfDpM+rikBdHRVxisVrwd1A=; b=r
	e5SspwYXwmShj8mhQFKsiexEdEBmKAZJSnP/Gdh5F/pSgs0qc4ZMrjSaPU+m2Vjd
	bSDR9nth2XU/CsolHx5+dA5ubz9EIgZJf94GjqWOz9fpoCDgZmW+2H7IY/XTSW58
	lF62NlWEDlfgs3rs9+MasCAmZeaQ9F1Ucv+JB8zWK4aeq9HsLgK/3iqz++en5+v5
	wMzCV9skMV5hkiVSr0CcQC3KxvXLmG85NhA5t2OJ+i1uaa18tFUd3MKnUshVqBFf
	NTQd+PmJlJ3jCSnv0dGzY2MpIQ5yECD408hapB79tC6HvSuAkVOUIAwrriH8e689
	l96eQNsvuEXZnlLyL8dPg==
X-ME-Sender: <xms:PEhXaj2Qnljo24N7qAwXQKsCH0xn22hye21CLhhM8Q6_Hm8JbiyIuw>
    <xme:PEhXas4L5eodUMPOTKBDh7wSPtsVYHEiAdpDtF9Q07Geqd33IPXmansXFYTEm-Ua8
    X2ytH6PTo7O60Jl_TQ0CTwhfGd5MK1SU7dpv5lRLngu0Ke-O9C_ourx>
X-ME-Proxy-Cause: dmFkZTFLCuIHkT1XitX+z0iRNs9GoJtEuY9COt3zJnsHu2TZTTY3uHTGLQZQxowf+8e/69
    JhsY0nPtIfPrD5GEy5KN5V8F8VcabIdpPbBCJ73h4XHHzzvkTzD/JhC8O0HRAoaQosy/Y+
    43ugQUSR2nX/nkuunM8jYQbzXM0CWTIWcuLDovdm67h0P8mCk6H3vp8AhV6+fnJ6RknXtq
    LZczi2ujwb6VRfTwIaEkBBK5oYq2re/dKov2/H1fe7Wtbjm/IHZMkhLkh+WxKwQvP5Veh9
    EHHDJavE8ko1uFkfQlTLG8QvWy9DlX27hACClXy+iYzXPPN3r6NcFDOHm3iYuoiq2A6HYu
    z6DZy3ijVVHuSmyQh4GFU5AGw2+M/FqvWTeAHeOY9vPliuezIpzz3yMRkrwqS24oaDDXip
    qw+HO8RJK1ivAKx3NLtgL69IaCrtWPOLxCc/3V3LTxSEi0xHGQEcQb05EmMsBxKKicAR2M
    26d46bLLGf2Kjbl/w5DgAETWXLOheXsCnvB7taOXuIyPgmwyeRuDtgmShxKb3TbhJzaMAj
    0Jt4/W1xRhnYKhI1LGDHHu1RJxhXiiWpVHrlJy3+hSo044gqVcUL9DLChJLEtYhkBvtJL8
    XWBAF+/Z6NZ/KEILtnsC5biRIj0qn+9l0uyhuB2VVFczs12CZLF2NMoBveuA
X-ME-Proxy: <xmx:PEhXagOlrGpOYuJAKWhO2G8cRxtWArhRTpIzp2zAeQfKt0K7kPyfeA>
    <xmx:PEhXanpiNs9lD_TGZIg2GoXBt3_I_zwUxBeCSYXC-qRZpFyAROIuXA>
    <xmx:PEhXaldezvI9KJ7z8aCf-dfRaY8Adf7TyPlW4Tu5ph2YA90kIGf4CQ>
    <xmx:PEhXatS0IYfc57saj6yUybVdVGjiEc-G6TabO8wK0b-gH9MvoJsjRQ>
    <xmx:PUhXajhqq53ILiVxFl1YjTJnkMDkTtDdmQOjN9QzCaQHrorNNxZnjWdd>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 74CBB1EA006B; Wed, 15 Jul 2026 04:43:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AeQlmnlEDZAk
Date: Wed, 15 Jul 2026 10:43:19 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Rafael Passos" <rafael@rcpassos.me>,
 "Benjamin Tissoires" <bentiss@kernel.org>, "Jiri Kosina" <jikos@kernel.org>
Cc: "Shuah Khan" <skhan@linuxfoundation.org>,
 "Brigham Campbell" <me@brighamcampbell.com>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
Message-Id: <48dc930b-2a70-4404-b8b5-5784c45538ae@app.fastmail.com>
In-Reply-To: <DJYKVRU31TCD.1M8E9KUMBZL1I@rcpassos.me>
References: <20260710153456.2093889-1-rafael@rcpassos.me>
 <DJV56QRLBO6S.3H33MNASQ866@rcpassos.me>
 <850e8696-311e-45e4-874a-8089afe35907@app.fastmail.com>
 <DJYKVRU31TCD.1M8E9KUMBZL1I@rcpassos.me>
Subject: Re: [PATCH 0/3] HID: wiimote: new LED behavior on connect, and scoped guards
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Tue, Jul 14, 2026, at 10:31 PM, Rafael Passos wrote:
> On Mon Jul 13, 2026 at 6:28 AM -03, David Rheinsberg wrote:
>> What device name are you referring to exactly?
> I was looking at the `wiimote_devtype_names` table,
> but I figured out its only used for logging.
>
> What I actually wanted, was a way to return a propper name to the user,
> with a controller/player ID.
> When listing bluetooth devices, I have 4 entries like the following:
>     `Device <UNIQUE MAC> Nintendo RVL-CNT-01-TR` (x4)
> I wanted to display a friendly name to the user, like the one on dmesg:
>     `Nintendo Wii Remote Plus (Gen 2) (1)` (where 1 is the player id).
>
> If you think it makes sense, and its possible, I would love to make
> this change in this or a future set :)

This name is taken from the Bluetooth and HID protocols. It is up to the application to decide what to display. I don't think you can control this in any way.

David

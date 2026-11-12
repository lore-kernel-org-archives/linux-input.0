Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468522;
	b=XkVXeCZSxlKRuNyJoRAIKbqnphGeGjbX0lDvJMz6iBJLfJ5akupQGs6Nc982vzKnQLss
	 z19z+kws6WhXVadf8qaWGNiqm0C7zR+25vsQwgxWd2gxD0Vz+i74+/zk/ULDTudNImyNF
	 lQ3Mqyfno3h0o9j2RfBhaqp9PJ7Oza7gyThl/E5SYxYBr/Phg6DksTzuwFZFTgqnRu7Oh
	 eB+8oVUr3Ug9aZqY7TBIWQnnnzfZeD98nushwelm+EZwNl06uaEBf0JhgbjkA/3Gbfp0M
	 Mwko4Yk2nzTMWOAsmb+blInutVLiuQ4w1yJmXxiSLQP/f6iPZG/f3gj6vnVzEo+eOcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468522;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=jtpWNo7TMacpo5dLQCzhDaqmAx7GU105iZnfQunsf+w=;
	b=DUGZulTogh53v2swXiWYbVS5jXXjY8QvSZAOBL/EG+S75ucAtjGg+yZ+HfyZEiLAJevO
	 FT4ZA5mn29ZGY/GntBhz8yerL8ATH4SvnO57pVDNJby2wQvNtuK6QD+mGQfiDAhMGF55f
	 sXY/8q4lkrnPwv0Jfqade6KQ1H5qDJLs1iyinlUwIEodBTwYQ3LrZS3EId8b61dhfu6kJ
	 HhBb403HqTZ2neTAgEJnbugG5DN3SClJpG7dADH5IkJYerCDtzRiVuk3Pgpdsx3Ff42GK
	 DCk3zxOHfUb6KjXj0XZf21tv27HmS6EIx8EU8Qi0E3UMHrLXkmEA8cmYp5Ygb0jGepg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=ZaECq2+H;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WT09LNp3;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C0D606A321
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 07:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37C0D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=ZaECq2+H;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WT09LNp3
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id F0F161D0023B
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 02:28:39 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 02:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794468512;
	 x=1794554912; bh=jtpWNo7TMacpo5dLQCzhDaqmAx7GU105iZnfQunsf+w=; b=
	ZaECq2+H3fZLSbZItu52liYGqOetSj4pzsfYVmCp+sFMJyF30SsjGOyB3UweUFrW
	G3K3H0C+yj6GxWQC+INukPp8kql8nLhkTumtAvdnXnVu7tAweKvytl9bgx/MOYcq
	ZXI7+Mq+mrbou63Jg+GQoTFvMy82or+7hxeDkOr8kPVR9Wx/O7/TzpLyc92BVPLJ
	fHJfF5GImdIqdXhbgGXYjx2TIOON0IEcgpXH34c6/Dw3ps/fHz7WTaI5Vb9z5aUA
	//Y16AQkhwl187DXYldkLbOb67eBvPMaqj4WoI/S5ueagvjVEuYgQmpxF+BSJ7GE
	Gaa6y/+QEd6es95GE1AMiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794468512; x=
	1794554912; bh=jtpWNo7TMacpo5dLQCzhDaqmAx7GU105iZnfQunsf+w=; b=W
	T09LNp3F+6ZU0cg7gjIeXUGQuCqupgHFyIfmNpPh66aUx8GzE/zkgrQWNZnMnx8o
	XgJ0F1/oU8sZzAZFgeGqAzD+QiWB6Kfhadoo0yq4X/W+eqAT+/6wXm+FOZxtGFj2
	74/BhZq8Te6hytXtqNimYxbi6+/nK8fSFXuS8nc7nz2/RtsfXPFm8cxjizbW8cg8
	tXDAAFkmook+dNokF2IHxHvlMlT/IBwH5RaM8voyo1K9kOTPgk2s8O0sLXAHDVTZ
	RA+wP3EV0T2HPhMd/C2del2gh8WvLwcE/Q7SefSQCiu7g61izsL6ItScQr7dun8g
	AryJ7TMpDRtXQf80DENVA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794468512; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:fGeoVUDy3/t1pTCaVPv+QrzsKgWAw1Er2YP4nKCY1seZv+k
	4EOOwxxWPTM8pTA5JwhjMDar6lan4NV90MK7wzjOSFALmK1I0XwFTnI04rnmanhh
	MUuRceArYr0d0nqgAX52f8XjV+wC5jk9xC0EBUveOGf6Ym6pfdFjuybqhItsbvXT
	FRuWdxWwDOH/C99TfYsLYM1Kgd5NdEXI2RV1xs7eYJDuxNR7a3snHqA4jBYPaJ5i
	19lJKkecJQpqLEOG3iancSkqc6APd1pWc3mk/ZBHnSCXds7oNVDEQCTT/yi0Z9b4
	9CqTRYv7FMfFoBMZvAbqYnLnT1YyhWY9tFAD+Bw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nkTOjxKk9a9RAr7YpxephbkNfsVtf2NTfupsq0l/ugw=:jtpWNo7TMacpo5dLQCzhDaqmAx7GU105iZnfQunsf+w=;
X-ME-Sender: <xms:mmr1ajgXo3Axsmou4B7KzkByWU-AjBViiPTB4XgAgf2XF5doPwnv7g>
    <xme:mmr1aq0GfE83JG6NZFgZ58z-bruQmVZxeY_ZBDuEUj6-I1pJFr17kpOGFOwybGY_Y
    5taeQtgs4Qy4WFi7M-2EES5h-jy1WTMD1KzIm0hhukvwm10erYE9bV2xg>
X-ME-Proxy-Cause: dmFkZTF9Cii5tCJ/eiFoFWruahOT1qK5ASAcalVOMwjDWcFD/dMBUFqfeKLpzlac2VvZ8W
    V9iu/o6ZR+Sv+050sngjcdznw7FD4MuBoj1sVq4A38XNzwoNh4drEfuQLnvyHU0UWAzEER
    0/4sDUx/ru4772Ka7asMoVI39ZZKd+VMgg1hWK6dIhZQusAVxfVVXcRBOYa2HO+ODWkJJk
    yHhAg0/yNzYdXHGAfMBwRNrzlT71WYs3yYVuMgiUtP2W3xChnosbmHTg8oFgQ2A1Wly06T
    4FJ4LnlTHRsMOa7D+xSMU1HYoEgWvMmfr2TX4b/cJomuLFseYhxG8OoKH52UP023qwOdju
    OXU/rstS7rhtjzYoEJXl0iV73emRZjJYCx4fU+8YffGbrnO3MpCKZE18sAT5Y8FQUcxkVi
    gOd9Ye6RcDoNFMyPc9eKbSz0Ntwd9lt3pCFSxcmEyrm1xUkbI7kQIU13hAiY7QRVsDGZ3w
    MLjUJuiXF7lrFYYtA+Uk2lkbCo3JpWb0eeMr21UcrDPfQ3q1OuO13/0xapduxh0EOx5ZKz
    AzNi1C/daJAUAlTkwWvNE2oarkNe5WErEMnJtCrw5mQhgyKcA2troNXK9HqN8JU7ZNphoa
    rQnxuSiEIxK4WY/zpd7LmSHG6MRvS2ebD33d/lkgLortuG/jXaQDedowMbkQ
X-ME-Proxy: <xmx:nGr1ahnGhNSr4FzptxJsS4_djP_SITwZbwIIgTdu6g6H5GCl3lZdQA>
    <xmx:nGr1aiYuQsfIJ9UNvMD4tHZlUHhp92ePdBhAJ0tsvBhd-LVYM3In7A>
    <xmx:nGr1ahNS_d9-LNiv0DwFTrBW7SIySjRPKl8etJxhbQGqBdOgdZIMxA>
    <xmx:nGr1aidCo_l8iDMifNF071yQQ5TkBpvrB3t41x3zD12lr0Mj7Mzv9g>
    <xmx:oGr1atPBQrgBZMfEnO70sZpJxtfjXWX6JfXMabrdIR7Zf8qDG6wV5BbS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1E5CE32A0099; Thu, 12 Nov 2026 02:28:26 -0500 (EST)
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
X-ThreadId: ARWrktkilFtV
Date: Thu, 12 Nov 2026 08:28:05 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Linus Walleij" <linusw@kernel.org>, "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Daniel Mack" <daniel@zonque.org>,
 "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>
Cc: "Mark Brown" <broonie@kernel.org>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 "Kris Bahnsen" <kris@embeddedts.com>,
 "Mark Featherston" <mark@embeddedts.com>,
 "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>,
 linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <1ce5b6c0-5926-4330-bc45-593a119c65ef@app.fastmail.com>
In-Reply-To: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/5] Input: ads7846 - drop platform data support and cleanups
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 12, 2026, at 07:49, Dmitry Torokhov wrote:
> Now that all in-tree boards using ads7846 have been converted to Device
> Tree or software nodes, this series drops legacy platform data support
> and its header file, simplifies sample filtering by calling
> ads7846_debounce_filter() directly instead of through function pointers,
> removes redundant memory barriers, deletes dead code, and cleans up
> minor coding style issues.

Nice cleanup!

I took a look at the patches and everything seems fine to me. The
spitz.c change will of course conflict with the board removal but
I see no problem with that.

I did not have a patch for this driver in my cleanup series because
it was still using platform data when I created my list.

Acked-by: Arnd Bergmann <arnd@arndb.de>

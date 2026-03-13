Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6719ADA4;
	Fri, 13 Mar 2026 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384012; cv=none; b=D94yhfE4F+Wam+/J3OXUAKijW2mE4yAmDmGWjc4mzCXblTPEFrxUpQHrFcMr/yJgE1SqeYFw0EXFt359zb8EP6BiQ74RsbacK4RkPJg5LuEdo3D0TfKx1W3XDXwZNGU4lHfqOBxxMCRy/pVBnOjKCyC/ZSYSEvLEJpDIag57Cuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384012; c=relaxed/simple;
	bh=jEpKkk/9+gcIUv8aKkbKMHfqd8ZhETPXpcd6jbjm/NU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MJWUbF1BG3xR/X4oXZ9UaK254g+0Vgnb1MLJFfEXfmYcRhUEaZHLCtiICcJpZm9WUpCrHTgxT8cpJjOXD6yL7grlxK92PIX7OTd5Z1r2C+SqvqSegmekOJS7NqrLSQTI41LmUZpPmc9hHll7ceXxJdeB+g5iQNdELl/V1fFnKSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machinesoul.in; spf=pass smtp.mailfrom=machinesoul.in; dkim=pass (2048-bit key) header.d=machinesoul.in header.i=@machinesoul.in header.b=jllJhWdS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2ZRFzYCS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machinesoul.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machinesoul.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machinesoul.in header.i=@machinesoul.in header.b="jllJhWdS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2ZRFzYCS"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CFA9140005D;
	Fri, 13 Mar 2026 02:40:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 13 Mar 2026 02:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=machinesoul.in;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1773384009; x=
	1773470409; bh=RNaaZbOtlVCXNivNe4DWX8GVfLx2sYQ9sqkRtm1lnEU=; b=j
	llJhWdSMeHQfEpPokEVWWbpFLRvcciQwUrnhRe9dKqJhfBmVHbMG6qvI8Tfqew4B
	QQhYIpfG0q9OxQh+Tc3I7NzT89j+dwkUNMEOzEZNLPlh+blw79yHUEedTQAUHm2i
	e9ta1IaM/oEr8Rl0+FGNy4+nirFTcMVQG6AEo9j3JHKiKl+cdkA6euUEeT+VNhU7
	lyjAdxS/q1oQkJ/apyEXBxMdOTzIwlQxI45A0gD/JP1JaNnn0PJq4sbuWMpuY8E/
	gSCVxoNwRAAC06tDHPQ8EOXMKFhBtEXBkXcyznSWTqo96kbtjtX8u3qAYVN3S0BO
	J1pugUxi4J4BxfpNAt10A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773384009; x=1773470409; bh=RNaaZbOtlVCXNivNe4DWX8GVfLx2
	sYQ9sqkRtm1lnEU=; b=2ZRFzYCSU80wHE/IQ78DAg5FL/ro6cxYNdSmwjwu852D
	ERw71fyEmvwBH5YjFxsYeB73ZQqdoKSPWUTBb1h/7yv+bpgy0JjR8cQdc+3o56xx
	jzeJZ1ZOSf6ktuhj3EVsx1yuLlSUKJVf6F91t4nokvRtVvn+v0YaCCQuxKZWBoGc
	ADM//Uvf1hNPtcxZyCcVFj+W/Vtea2akJK33/MjxefqB46YSspfftelWeuKYo8RE
	sZaQ9ONCIWMqqKp6ThRyi36zH4FZrTdhEiTxGqhF8bokOy1RrGkiRD9usLRfxC9I
	sO3iUZ87EGWsDt+pimtCADqDVdXGxxP1spw6o8/n3w==
X-ME-Sender: <xms:SbGzabIY8rDgYz6FXQEuFIS4CS02fXwDjjeQWK2NyiZOHeMIOjCyPw>
    <xme:SbGzabJtFNqMwwGiNAxI7rcnlc4M5ctJ3VJGHU1QiMJuHAwaZgxDPevKtPDOPedLr
    RqfW-A3JKbzTaLnmOk3l4C64LskccjiuuLfjDeTVltRl6IymzClFFTP>
X-ME-Received: <xmr:SbGzaV7xGzS1HHGrU_Ndo4bsnJmA9g1SjWdvZP9ACyh06t4I6zcWC2TXvLDHbVEM6WM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeeuhhhushhhrghn
    ucfuhhgrhhcuoegshhhushhhrghnrdhshhgrhhesmhgrtghhihhnvghsohhulhdrihhnqe
    enucggtffrrghtthgvrhhnpeeuleduudfgteevhfelteeiudetuddutedutdduveeuvdfh
    heffteeihfdvudeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegshhhushhhrghnrdhshhgrhhesmhgrtghhihhnvghsohhulhdrihhnpdhn
    sggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhii
    khdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomh
    dprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sghhuhhshhgrnhdrshhhrghhsehmrggthhhinhgvshhouhhlrdhinhdprhgtphhtthhope
    hlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SbGzaVcZHISKF3EnTGcb_0fPwkkLT69SFQeFWuwJDOyucygtKtaw7g>
    <xmx:SbGzaQHJDNQp5Pp7gkuo7sBqz2aX5Ar8OMuSQSGMGLBqr5PYrvPd8A>
    <xmx:SbGzaeQwgf5z-t-0gEF6vIa5mUKm1n8MOe5P0efvCbfWfSRa8woCGg>
    <xmx:SbGzaebYnrrt5CCu5EW_rJ_abzwfmfTvO2y1i7cX_0w_5xTwc3SVKQ>
    <xmx:SbGzaeirv238QMe3EtkBtSg_y_vy2liET7a6-sgm3886kZXw5lqMQRPL>
Feedback-ID: i6b0e4831:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:40:06 -0400 (EDT)
From: Bhushan Shah <bhushan.shah@machinesoul.in>
Subject: [PATCH 0/2] Input: ft5x06: Add support for FocalTech FT3519
Date: Fri, 13 Mar 2026 12:09:49 +0530
Message-Id: <20260313-edt-ft3519-v1-0-fe5ffc632fd2@machinesoul.in>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Nj3dSUEt20EmNTQ0vdJONUo0Rj41QLi9RUJaCGgqLUtMwKsGHRsbW
 1AHl1dUtcAAAA
X-Change-ID: 20260313-edt-ft3519-b3e2a33e88ee
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bhushan Shah <bhushan.shah@machinesoul.in>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=690;
 i=bhushan.shah@machinesoul.in; h=from:subject:message-id;
 bh=jEpKkk/9+gcIUv8aKkbKMHfqd8ZhETPXpcd6jbjm/NU=;
 b=owEBbQGS/pANAwAKARGWjESSjK78AcsmYgBps7FE2PB5gXZDuzK0LsQj8x6Q8SMH+kLBY9EuI
 t+8ZvrGGiSJATMEAAEKAB0WIQSzyzZlUlQL4G7prZcRloxEkoyu/AUCabOxRAAKCRARloxEkoyu
 /GI+CAC3NRx1x9loyuZyJZOySbn6ya8vAoCSgJ/FqDRNhC9QdY2wlLuzJEozjb1gzlnh8XiWQ94
 qSozaEEa7Rd79VvKgM91BndENXRMA+fvCDupIr+xdFrl68v/8tSSTSGNE2Ep78f4rlpTT9chOl0
 zphaK257ZtNETGC6XAunQbZ/jKo0yPGGZcDAQTPafcXx8HxFb4Jjzdv6xosERHZO9DrBnTaortg
 uflLZb/rCkI2JvwLJ+iw0ZyrfGsMEcrYwCetG2fZqq9tKHfZ3BTkRtjjQX7FeFCBTxktjrUTiw3
 nqmrwRmw3ZMDUNY66MhoBbokTB3v7x3GWNVJe5gj1JIbM32Q
X-Developer-Key: i=bhushan.shah@machinesoul.in; a=openpgp;
 fpr=0AAC775BB6437A8D9AF7A3ACFE0784117FBCE11D

This touchscreen supports upto 10 touch points, add devicetree bindings
and compatible in driver for it.

Signed-off-by: Bhushan Shah <bhushan.shah@machinesoul.in>
---
Bhushan Shah (2):
      dt-bindings: input: touchscreen: edt-ft5x06: Add FocalTech FT3519
      Input: edt-ft5x06 - add support for FocalTech FT3519

 Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml | 1 +
 drivers/input/touchscreen/edt-ft5x06.c                              | 6 ++++++
 2 files changed, 7 insertions(+)
---
base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
change-id: 20260313-edt-ft3519-b3e2a33e88ee

Best regards,
-- 
Bhushan Shah <bhushan.shah@machinesoul.in>


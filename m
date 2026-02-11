Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8812E8E09;
	Wed, 11 Feb 2026 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770848082; cv=none; b=elIBec40Mqyt0t7sMx2+gcPw+cosAqCQjd84JbTNBOhBqKg3OceeNYaf9y6128+WnuehFM05C5Zex4kAie6QNGT28ceZtDaiy1g9Za8/36B2ud0mJZmtERp2pqC3/1x4ytegYZMwKJTUkiJSWe3jwdOMBnDf5S1IEJ/DczApqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770848082; c=relaxed/simple;
	bh=eRJfzvCkRi7fxO9sNWFGwt0WmfaOMjVhsfO21ejuzwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0OCyMVp+iZYBTTo5sIYFLMeq3QjnCfoQsBwXiIVw/ky/HO8JiwWdZABKZUfVEbnP9BMBVM/8qwuNz9gJwV/sH5lJ4baiEzlo/y+dilDkWxzGTeYfI8lPdVk2ZXcWLCe0yeH/rxk+1B31jaOp6Lya4QgxvwN95ZL9DI3/a0PbrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gUb4S3Oj; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gUb4S3Oj"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fBCQc0L2pz9srf;
	Wed, 11 Feb 2026 23:14:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1770848072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRJfzvCkRi7fxO9sNWFGwt0WmfaOMjVhsfO21ejuzwg=;
	b=gUb4S3OjiL5a5pV0zlrxIRnjxSc7rF48b0TjJOwZHBQUVGYNOqiZrXogwwFQ2XqsbIRyjI
	PHc1Oc4z3OoHi9QK+14xjkN77KyqEKBuwUdcYX3Y+um8M8d67MwDZlPM2Zjvi9xElb3r2u
	1dNgK3IwNgqCeYkp4jAS85Y4TBBaJX7tBA7+QLIbTvmcqOCFP4JaLfvJyswqP8+6iZK07h
	IFgM+j0N+HPYEyYDMg0kl8TmowA5LVE4yzYJSub+0TKcyJ6shxlIlwrHKAD12p/Yzqol+B
	7CZaPfkgU7ZDH+FsACSWpxry8ioVr43QH0opkBV9dCEgwRRqK7cM2SiMwatRIQ==
Message-ID: <bf7d38f4-9411-475c-80f0-1afcb99014f3@mailbox.org>
Date: Wed, 11 Feb 2026 23:14:28 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] dt-bindings: input: ti,ads7843: allow spi-cpol
 property
To: Frank Li <Frank.Li@nxp.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Marek Vasut <marex@denx.de>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20260211214409.3696442-1-Frank.Li@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260211214409.3696442-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f13f7c9e9bf4074e251
X-MBO-RS-META: mhaq1ndkjb846xfbx9copkpbwkp8f4mn

On 2/11/26 10:44 PM, Frank Li wrote:
> Allow spi-cpol property for ti,ads7843.
... because ... why is this change valid ?

This information should be explained in the commit message.

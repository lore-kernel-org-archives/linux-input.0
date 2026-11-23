Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.247.164.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463434;
	b=xO64wjsRJ+OZQyO8fZUCFFWo5SpXyHlH6Qrqs94MG8jOiIvmEjvLYQb0Joi3x3wyAszA
	 /e1ExFlubD+Cc1RVFaliES4ox7aola5rugNa+wYxrUAZnO4YmWAS/vecyfDSvAdhI0UiM
	 8bIM9+tp5/dO/DkFYq+K9/JiLO1t/0/a8gxjJa1t0Q9ylNSZwA/dT1XnUTlaojYXMAt56
	 RIbL13GUWTohZe6oXb3JAum6N8KNwPnBRcZ6d0EwwtxnTAlBGDzNINgIBkEQu5QC/jej8
	 dI+3XP1dC7F0/d4JziZPDqJEicN0iBUZN8VUCc/9kAg9Ki4NvIPxR3weD2bZRJDUjwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463434;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Last-TLS-Session-Version;
	bh=comPKp6BAVZLBWCy+PQv3XeIRpcVvcg/5X7fNTty6Qo=;
	b=glRHXp4QdathQk99nOu+aaX35lJqXeEOjkUYTJ3cr/tzh0CqB3BiWVa2mBjjJoGtx1xn
	 sbO68PUo72rrAYS/LIG8PFcoR9MdsN3YOgLaFy45aVPd7mtrT2YmbtikFd8gKeauYWVaO
	 HQN4rShVTw5WdygadKrRBGSH9r3cgfE/szgfhpk5elXpuPKP4yPquZiHKNlNGPFeaDpt/
	 tSEI2PGnehPwR2Zt7l7i8TD2lN5r96E1u8+4VhrnxhK4xr35DV8zsV1/a+7SLCvv6sTt9
	 EC2W+wiIgvUH2D3yKOp8yUIRDvr7c4JUw4YcZcn1fOcHlCkrJqROvvzJu1Kqt9L3jBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=koesling.info;
	spf=none smtp.mailfrom=koesling.info;
	dkim=pass header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=cnW1Yav0;
	arc=none smtp.remote-ip=84.247.164.36
Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E112606A31E
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 19:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E112606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=cnW1Yav0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C2181320FA0;
	Mon, 23 Nov 2026 20:50:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1795463431; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=comPKp6BAVZLBWCy+PQv3XeIRpcVvcg/5X7fNTty6Qo=;
	b=cnW1Yav0g1W7JnKdKR5md5ZZJWsRpkPJv/ubQZ2Z3JkWjesJeekgBvNUmRf5JRiZ1Qo6+/
	ZVylLcpKruSbmFEoghvirBYeiAOqV/HTplWudxpoYesgoAlhRczZmTibEHTQAgwfh4LMQG
	NJqjTEfwirelShOULTVjnvBIz54vWU1EatYA8l5xy8CnzehR+xlSpyClLmYtjKkBOQHtts
	CMuwmksWzZ5AXQWPaRt2OfQ8xnrHfgyb0P0tIDjE7bcsfWIS2K+trxilrINy9xGXBwaEww
	agJEdfSigMjtMQsFJzkB+6XoIGNmaCE79P4jV2DZuk+BdEmfEqRLw8C3+W3tPQ==
From: Nikolas Koesling <nikolas@koesling.info>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, Aaron Ma <mapengyu@gmail.com>
Subject: Re: [PATCH 2/3] HID: pulsar: resume device for raw command execution
Date: Mon, 23 Nov 2026 20:50:30 +0100
Message-ID: <3ssTmVAPSp6OcQzpLtff0Q@koesling.info>
In-Reply-To: <20261123141542.8128-2-mapengyu@gmail.com>
References:
 <20261123141542.8128-1-mapengyu@gmail.com>
 <20261123141542.8128-2-mapengyu@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi Aaron,

> usbhid drops its runtime PM reference after open, allowing the USB
> device to autosuspend while idle. When suspended, hid_hw_raw_request()
> fails with -EHOSTUNREACH (-113), causing battery status reads to fail.

thanks, good catch. I could reproduce it with power/control=auto on the
receiver: once it autosuspends, battery reads fail with -EHOSTUNREACH.
With this patch applied they succeed.

> +	ret = hid_hw_power(hdev, PM_HINT_FULLON);
> +	if (ret < 0)
> +		goto out_unlock;

> +out_power:
> +	hid_hw_power(hdev, PM_HINT_NORMAL);

A failed hid_hw_power() is returned silently, while a failed send is
logged. Please add a hid_err() there in v2.

With that change:

Tested-by: Nikolas Koesling <nikolas@koesling.info>
Reviewed-by: Nikolas Koesling <nikolas@koesling.info>

Thanks,
Nikolas





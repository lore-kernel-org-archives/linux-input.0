Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.247.164.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463636;
	b=4FSb0tzzu6H/e1shcDSjxSA9Jlqu9US8b7ZJj6KXFvkHH4H0ZRO9/wTcVDg7dsDRLlK2
	 UQgEHpGqL9MC3O1oTWFhkGNX8mjLaX5ucfpX5ICMaR3VOSCCQMZjZigoNGAu1Xq5AJZHp
	 3WB+BPaUBpe+MGIdVU67Oh8f1GBJH2NdaDZglMHjwbHRB9twtWE75LP5vQw0dZbS9zgia
	 Zj8xkp7/bWVuC+J/LgVou1pz7WSxho+M9ROPkYvAcEOPMPECHDfAJ49I6H57ZP0jR3eMf
	 4lQ3otD67bc2Dj2pVv3QyGfk08S6h0cn/AxeGIxxCWSNtSOb1o33qEHFHc6snIY1mbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463636;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Last-TLS-Session-Version;
	bh=JIbrix0xDE8CHakN9DKoB/kZdEdiye5fpf/KmnjDBis=;
	b=GvqbBDoCbvDEecSeeInhL1actsQjFIGBpmm1n6A+8CG2922NLJ0lwTWgegq+SD3/OcXX
	 tpchnxJODLQBY3PvT7Xuuezr4zEagIxLc3AjIxqZSbW0uZZoY7wohRVZdhhws82plseEj
	 8N8rCtUFgsHgRe+2ecG7SIeyJXS4Jh7Jo+5Kt70aYW42UmdgFT5w8IyLw4PZIQ71xKOZw
	 2QAYVoeu05/p6Ev3yj3CySY+d+xNJgZgRF51wSUeJiu0hsxy1rUAu5kNGjmhyLdsf2igw
	 ohHTziKxEcehWJaRFc5RTh6ARf9qNC4EFNZMglmHQJE5PO52xCJpE0BWDeb94/2Kulw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=koesling.info;
	spf=none smtp.mailfrom=koesling.info;
	dkim=pass header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b="jsEZvy/N";
	arc=none smtp.remote-ip=84.247.164.36
Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF005606A334
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 19:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF005606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=jsEZvy/N
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8932F1320FA0;
	Mon, 23 Nov 2026 20:53:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1795463633; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JIbrix0xDE8CHakN9DKoB/kZdEdiye5fpf/KmnjDBis=;
	b=jsEZvy/NX9scb8dx1zB9OCwMSbF2kJhkubNpRso6SgGqBib32HdyhHCk0+8HsRdlwU8kCy
	tnFB51hi0NllnoCxQVArFoURP0zcx+zuAp6VRitClwVsE/3M5IQ9obNLQqdFfnWe/0eXia
	UEoIAgdmdAHvBA+k/2++ztJAbYIbMEEHk0U5K4Ahazm0pFOV5GCEabsz9Mfzk2LuEkQmMQ
	j+K1AHXi6HXX6ad/bdgrV+PbYOmAPYF4k1J4mYQwYfC+w9qT0wKZRxaCqHiQkx2ldzfvAr
	O9aQPiveqQOcmhQ8Lh8Btr321JtueNZcmj/Czhh7qPIOM7T/P8ffdUs+8WJhvQ==
From: Nikolas Koesling <nikolas@koesling.info>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, Aaron Ma <mapengyu@gmail.com>
Subject: Re: [PATCH 3/3] HID: pulsar: add support for Akko Gaming Mouse
Date: Mon, 23 Nov 2026 20:53:52 +0100
Message-ID: <fEKBTBrZSg2lsEJtHNGWdw@koesling.info>
In-Reply-To: <20261123141542.8128-3-mapengyu@gmail.com>
References:
 <20261123141542.8128-1-mapengyu@gmail.com>
 <20261123141542.8128-3-mapengyu@gmail.com>
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

thanks for adding the Akko mouse. A few small things for v2:

> + *	- Akko
> + *		- Gaming Mouse
> + *		- 8K Receiver

Please drop the "8K Receiver" line from the header comment. The list
names mice, not connection modes; the Pulsar dongles aren't listed either.

Please add the Akko mouse to the HID_PULSAR help text in
drivers/hid/Kconfig.

Did you test both the wired mode and the 8K receiver? It would be
good to know whether the battery gets registered in both modes and
whether battery readings and power events work.

Thanks,
Nikolas




Received: from mail.koesling.network (vmd143767.contaboserver.net [45.67.216.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9193DCD94;
	Mon, 23 Mar 2026 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.67.216.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295461; cv=none; b=tJgJrN8BHEuGYNOW7wAPi8Zf7kSnvHekCaa6Pj6tlCoY788zN/nknzSSUhmGWsXQp8UIQlcVUWENBBZQMgUeNoPSfsSarmKyfnekTz9zSaJ91C0aHL7xHXQw7MPU/NJqDmMk7LcMSnYHlTF0kv/wfkCSG02vnsGu7cp29iAwRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295461; c=relaxed/simple;
	bh=kPP9a2DAAiOSn27UkwhhX7+GP+U0RbRC7GhDubwQsPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=boonC6dLS3FRTKv+IJtnvBqHkUBNb//UkFM2xD68v0AbzdtCC5g/GwWvwEVlCvxyGTlZTwkQgzK3CWTf4kV2oAYfDHxmBxHM54BcGGWCsPjmaLTL1IBsYHeqWjv8hZVy2WBefcs0+YRWf04gjimrVgzYJG6tsXQPSv8iN7szF1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info; spf=none smtp.mailfrom=koesling.info; dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b=AbaG0imW; arc=none smtp.client-ip=45.67.216.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b="AbaG0imW"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87DA51321681;
	Mon, 23 Mar 2026 20:50:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1774295450;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kPP9a2DAAiOSn27UkwhhX7+GP+U0RbRC7GhDubwQsPU=;
	b=AbaG0imWERFfQfM+ePweGQO7erompoz+HkDGb7aNsMwA3R2RZH9mNICqWK/J7q4vdrB6bZ
	dw5oUIpB2rKM28+Tw4Z5HeaBMgA6Pm1Ba9yP44jIReMVd5xaXV0eHC9aSdhBaCc3rMZ+g4
	8qsAWkeZxbKF+6/d9A80J00zOWH0L5Zo5IL89cZsWg0VSG0DZdEG9xbQpkRyUhooLKo3kh
	JJOYEkQjfRFn6HdzJMoFTJ/SmBv1yA5znPZ3/zqr9m4RsU8Q+hzLbfA9hngMryeo8P0YNK
	mK6YPH7RmOrJbEXx/uKFqZEC9K0jhWm7DVploB9xOkuvUrdAOzQKPlKCrz5A/A==
From: Nikolas Koesling <nikolas@koesling.info>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Leo <leo@managarm.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: pulsar: add driver for Pulsar gaming mice
Date: Mon, 23 Mar 2026 20:50:44 +0100
Message-ID: <5087363.31r3eYUQgx@nk-eos>
In-Reply-To: <bfb2bcd2-d484-40b3-a548-ccdb6c88a75d@managarm.org>
References:
 <20260318205503.64420-1-nikolas@koesling.info> <2344095.iZASKD2KPV@nk-eos>
 <bfb2bcd2-d484-40b3-a548-ccdb6c88a75d@managarm.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi Leo,

thanks for testing and for the detailed feedback.

> I did some digging into the protocol, and from what I can tell it is
> not necessarily associated with the specific sensor, as multiple mice
> with differing sensors speak the same protocol (PAW3950 to name one).
> The nrf52840 also does not seem to be limited to this protocol. I can't
> find a public name for the protocol. Given that and that I'm not sure
> what the subsystem's policy on module naming is, but I would assume
> that changing them after the fact is not ideal. Probably (?) the
> optimal solution would be to integrate your patch (thank you!) with the
> existing hid-kysona driver; maybe a maintainer should weigh in on that.

Same here, I could not find a public name for the protocol either.
I will either fold it into hid-kysona or keep hid-pulsar, depending
on what a maintainer suggests.

> I added my mouse's ID (3554:F58F) to the list and tested the patch.
> Everything behaved as expected, UPower output looks reasonable. If you
> like, you can amend the device ID to your patch.

Will include it in v2.

Kind regards,
Nikolas





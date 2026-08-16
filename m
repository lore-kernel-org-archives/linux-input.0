Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CBD4B04A3
	for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786891727; cv=none; b=Mg0RLgMaljGrOX26M+gTcHFOv9FpmHx+2fYqyIL/evtJgJineecmXpg2iHjYxNr6GIYMSphwDO8A2/Ay1IDNuuAJ2y8lNhhKCne9s2wqkSl4nBB7G1O50JnYisBTcpdC4AKZi9y9zWKnRVcgPR+zhRVQ9/0AfvR8+V73Cshw/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786891727; c=relaxed/simple;
	bh=/AKONZWJt2brnxTxy/Asi4kQa/F4ZoDZBeFkKaiiP+c=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=AHxE8n7j/DHxtE29CdVHUltLFgXAfZtBb1uF6QuorMQ5BszLG+MntvQuUKYcfm9vE6iyBPncBqNL6oYLow/oSTO4Rc/IcwrSEoEtuoGYnin913h5MXKAcZxtSi8pK5jYLxyO+PRh6ksZqQiVkd78BqO3ZaAUxNmqdaU7Qc9R84Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=U8hvdK5+; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="U8hvdK5+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786891715;
	bh=sMCfMZxpPFQ0FldILPA/nOm7SH4Mjl9LQsVsaBs1zuY=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=U8hvdK5+cmidZoNav7EQ1n7TVMsaQt5YN7zin8mNVB+3KTVQnM+gmo/gX4wvvLBo+
	 twW4GXXsYxA7f2F3n2Yd1Pf18CXWoxMQDo2C2zlBWW+GB3eRN8c+pAPameHA+6G1qN
	 dJ/4qWF6ZIlJqQyBK/gBIVfBXNsvDx5qmMf+e5t4=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4hNJkC2sM1zGpDT;
	Sun, 16 Aug 2026 14:48:35 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hNJkB6fNgzGpDJ;
	Sun, 16 Aug 2026 14:48:34 +0000 (UTC)
Date: Sun, 16 Aug 2026 15:48:35 +0100
From: Bradley Morgan <include@grrlz.net>
To: u.kleine-koenig@baylibre.com
CC: farbere@amazon.com, linux-input@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v5 01/13] notifier: add device-managed registration APIs
In-Reply-To: <aoFd149hoxHDcPU0@monoceros>
Message-ID: <76AA8FCA-0F62-4790-A265-B534463CAD5C@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

>🤷, I don't care much.

I'm surprised how emojis can be used in the lkml...

btw I can't review this series (much) because this seems to be like for
something
else

But the least I can do:

Tested-by: Bradley Morgan <include@grrlz.net>

Acked-by: Bradley Morgan <include@grrlz.net> # kernel/


A-B instead of R-B because I haven't done vigorous review. 

Also, I added akpm because he (sorta) maintains reboot.c for instance...

We should really add a formal maintainer/reviewer slot for these files. I
don't mind taking it up, but reboot.c ATM is quite nuts.....

Btw, thanks for your patch Eliav
Thanks!

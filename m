Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C22C3768;
	Mon, 29 Jun 2026 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726440; cv=none; b=CzUxIl7ciFVepBdCbUZBOnqAnleCCngAMZ1ONlRw5HHK2rldhffb+YydcreuViDHZyI5Y2rIuwpw33WcIWZAwqLuuJMrFz9NTPrKsD8XdnlmR12wmik15v4t6K4oJFTKBEZVugTNHZpr2siMP7L0bTdeZ/+2xNLT+c3x1zMXQms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726440; c=relaxed/simple;
	bh=s5cJtQQoMF/pMBqGC6BQ7RMQTihVDcpuw5v1drK2sAU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=acAARufNY3AVkGDFXEZL+lQNCCrvQQHcLAUMc2sg0cWQ868h1ZhFDOjYeqFke3KrZkMfjfnrE9d5yoipchA8E/Rm4Duuc1qBLMoa6V0Cr+3c7zA3odSQb/Vy8D7R89H6HwFAI8QC/44Bjm+0UHrwH2CVFpLzT2G/0HpWjdvUDPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFP6meRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFP6meRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945011F000E9;
	Mon, 29 Jun 2026 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782726439;
	bh=ngxzncl27+1B2TuUccU3eQ7AquEfKMSMmWIfZJvh8TM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=GFP6meRWVvKlk107TZqHRBaI0mZ9JLvJ/WfhM9QSeHssuI/dSreDKUe51uwqIIwAV
	 BBoo54UOWMagnVTHQT9W5pF5knTCiURf1d+cDz87eGNtJG9FdLH0LsHAiXoETDRfWQ
	 JPVmdRTothJ3rxwW+Hk77FYisBOGpacZXFUqFlZFmbRyqUxt1up0Cc8h2JA0DPNW1M
	 cfxTBlEmxD473LSvQUedDvL41xFJtRtFXHm89xyj1lD0DV18V6Y9uyenyoQn4n5hMn
	 2b2Ki/kBM3HTaR91ihaUkSguOquexdX2mDG+4hJQcmj746A3ghso34cI0g1LS4cjPy
	 5lxJUlZpihjEA==
Date: Mon, 29 Jun 2026 11:47:16 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Sriman Achanta <srimanachanta@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Simon Wood <simon@mungewell.org>, 
    Christian Mayer <git@mayer-bgk.de>, Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v4 00/10] HID: steelseries: Refactor Arctis driver and
 add Arctis Nova 7 Gen2 support
In-Reply-To: <20260623172310.272708-1-srimanachanta@gmail.com>
Message-ID: <7r968644-p7oo-7q91-p75q-7os140254155@xreary.bet>
References: <20260623172310.272708-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Sriman,

thanks a lot for the effort. The patchset looks good to me, but Sashiko 
found a couple issues.

I specifically believe the ones for 4/10 are valid. Have you looked into 
those?

Thanks,

-- 
Jiri Kosina
SUSE Labs


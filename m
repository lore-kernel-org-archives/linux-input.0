Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1A4266B2;
	Mon,  3 Aug 2026 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778846; cv=none; b=RDAZ1R/7CaGi6qHPB4zVlJaOJNWdvK3nBuA4DT7RvWYlVb0/ME+sxKsR9kmG6UWERlvRktvVUe5qSFPhkH4wPyLwnKYdsVP4wmWElnYQWYXAnZZ52yiNCvNDNkV0F8TdkAIxXx6D4fLXT7POhmZyH78NUQQQoTbOyMJYPKMlyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778846; c=relaxed/simple;
	bh=a8gQZTgbKf58u6yI4+DSZ1aRUpGQaIMjV5o2lD/GIzE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nOpQJAqztVoWQEwVDOx7T0myveXLtoB4cexnt0oaFSWmsSoLkLehTT1fDEN7Il8+iXbFAI9Vity5v2G6SAJsJzt1OuH+82InIe/4/EnU+dSgyPb/QHJu3pLyFjMlmKijdMOs1b+J83j2weYp3Jrvt5KqGkFQFS6GswTJRNzg8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkRPIUN3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkRPIUN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D181F000E9;
	Mon,  3 Aug 2026 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778844;
	bh=N45o7ZFUtM8Q3A1drJz7OfwEp9Uosz//COLBdbst4eI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=HkRPIUN3Saw81hdv5qkwKa5nyhvOKXVPwPEu5vCkUZSFx5nknb9Nk6BkdUtE6NVv4
	 cSof/stxFvv3fqO0CA5mlwHUk0Dj9k9w/TafPyv7S39qhmBWSNmfzA5nhaXOQuRbxp
	 PvKJRGNTR9q/m9IFcSEWtzHMZJfTI23iCqm4snYT6QMDcZap0YRFyh/E/g3vvCpWjc
	 j3OPcOjnisGgycftxuUSmlyTaLnC1UPXW/oZge0icwhMnNmb896KI04IX5UrIwirBQ
	 PvB/nCwUWwJEB0BYs/zSzRkngkc0Gtc6X7tqLIVIrh25+KJPE1oWdjqhwJh9mZkDNf
	 bzjrkONj1zlKg==
Date: Mon, 3 Aug 2026 19:40:42 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Sofia Schneider <sofia@schn.dev>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: hyperx-headset: Add support for HyperX headset
 devices
In-Reply-To: <20260627210206.1061062-1-sofia@schn.dev>
Message-ID: <82032so5-s251-1ns0-1090-56sq481328r1@xreary.bet>
References: <20260627210206.1061062-1-sofia@schn.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 27 Jun 2026, Sofia Schneider wrote:

> Introduce a HID driver for HyperX Cloud III Wireless headsets,
> supporting battery reporting and connection status.
> 
> Tested with a HyperX Cloud III Wireless only, for lack of
> other testable devices.
> 
> Signed-off-by: Sofia Schneider <sofia@schn.dev>

Sofia,

thanks for the patch. We've traditionally been naming HID driver by the 
vendor (and not per device ... and yes, I am aware of all the exceptions 
that violate this :) ), i.e. in this case that would probably be just 
hid-hp, as far as I understand? Could you please adjust that and resubmit?

Thanks,

-- 
Jiri Kosina
SUSE Labs


Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F93264D4;
	Wed, 15 Apr 2026 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244630; cv=none; b=iB90cmKkiMQxGTqdklIpUotylkdhXgf2ATAoBd/DYwfBaYTLE3oDRefc+ySduQkcJB3vJ8yUG/0byZgHrW6kDnY2CwWgn3cQSk1O7xyaX2l4aK0PRyfawR5evJ4Mxvwz6KNFeFxMxeowFvO6r9QCt0Yrhmi1kH6mD2Z1/X+i+3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244630; c=relaxed/simple;
	bh=IwsBV3cK6S9hnl6YZYnd3vNZCkuvsU86N6xLae159yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVNUFVZBgtKn3x547Ziz3E2wZENTBe+jfc1wBQG0OMBeRFLNJlE06e0VFO7Uxl33znKPoT7td9Tiic0enhkTWwjmc/ifXQHydvt8thLzcYCEKir5yqXutOTwKxmA6kT5l+9djX6pyZTZzHQsfrsPJEfMCOH2oGehGVaGAF8SDkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ZcbSjh5/; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ZcbSjh5/"
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4fwb2T3fQHz47c3;
	Wed, 15 Apr 2026 11:10:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1776244209;
	bh=IwsBV3cK6S9hnl6YZYnd3vNZCkuvsU86N6xLae159yY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZcbSjh5/4fQPrOBHKzfd6r9KRqnPImnh8CTuuhtjyCwdtr1NHkB6vqfPXh3sYLpHz
	 Wqe8D3hmv0ohUgzTJhYUuGN7Jbi4tShZYQV5Rx7iY9Cy0+b6co+47LuES08OJYayQ1
	 2zAd5232CsL98dYV9C9q1zwW1Riuf83f/8aJr0O3vqL1btHcG1rc+V8igG6cj6pIgC
	 eO0ZCH5gv2xQMLtqFw1HXZNwDvqSo8M+SSr4xQee24qHeFzSKdp/IsKcY7JEzhRCYN
	 9W1wYXmG0YOWcnOVyrcM/d1PfWCzcRtAHRbBn2XrRl/j5vs2KY61oJnnh7W63NeuVr
	 T3f8ycSiZdO4A==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4fwb2T2ws7z47Ww;
	Wed, 15 Apr 2026 11:10:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4fwb2S0YZDz8tdB;
	Wed, 15 Apr 2026 11:10:08 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 42EAC633C0;
	Wed, 15 Apr 2026 11:10:07 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <43bf6733-cd16-4455-9a69-5b03a6159810@leemhuis.info>
Date: Wed, 15 Apr 2026 11:10:05 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: core: add short report quirk and use it for GPD Win
 (2f24:0137)
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, denis.benato@linux.dev,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 honjow <honjow311@gmail.com>, Anj D <aduvnjak@hotmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260407173212.86942-1-honjow311@gmail.com>
 <adZ2PTzQ05iObcGt@beelink>
 <652713b8-aa98-4ca7-8cd4-8f7ad6cff77f@leemhuis.info>
 <ad9IhFBm85HmoxB2@beelink>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <ad9IhFBm85HmoxB2@beelink>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177624420763.2228407.6812998034623786511@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 42EAC633C0
X-NC-CID: Rhz0ySDaoI1Yepp8sqywB97cgdA2gvB6ipVnPRrr2KLZFKCq5TI=

On 4/15/26 10:23, Benjamin Tissoires wrote:
> On Apr 14 2026, Thorsten Leemhuis wrote:
>> On 4/8/26 17:41, Benjamin Tissoires wrote:

Thx for the reply.

> [...]
>>> We can tell people to upgrade to the latest firmware
>> Well, that should not be required by users when it comes to regressions
>> -- unless maybe no other way to fix a severe issue can be found. Is that
>> the case here?
> Sigh. The fix that was introduced in the previous release cycle was a
> "security" one. [...]

Yeah, I figured and should have made this more obvious in my reply
(sorry), but it's hard to distinguish "this is a fix for something that
is unlikely to happen" and is fine to be reverted again temporarily in
case of regressions from those where that's not a good idea. And I
wanted to know which of it it was, but clearly did so poorly. Sorry!
>> How far is a proper fix away? And will that be GPD Win specific, or fix
> Should be out today or tomorrow, [...]

Great, thx!

Ciao, Thorsten

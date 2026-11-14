Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794643319;
	b=Th7/mVATuOyiDGBJfQnGuEYEi7SdWox93LLkNbgwrqGj57R8+dzkwPZCvhcnDqETzz4F
	 FHbOdljiPmtjh8j2tGmx/CULLgHiXbAjLZvV10NmUq3w93L8LFAzHqYpguiyZwllF4yFU
	 bt8M91QSXw/O4l1cEDVyYqb2QN6Bx1aBsGQJRhRE8YEItMEIueWy+kVHqp5Ha6blPICVT
	 Qox31BtdOVua0s9BvpnyO9frVE/AvIfGOpZ07VbWjL8TRWt9lYffyqzc/niazhhdMGuP2
	 S2XNPMMMtlciVgb/9upMcJ4lzJ0QwOZRH+R86M1BplImKLT5obK5PdwcLMJ3bHxUv0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794643319;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-NC-CID;
	bh=+e4Qv5dpgApZcFQLKkFUQgFtfial+GgeYfnYt/zvYOs=;
	b=EJuwVgdqNZee87WuEYtcklREzzpsAYc6H188HpBJo/fF/DAtQHoeff1jC/k8vdYmlXO4
	 Td7jL1lDNoRV3b6F5wjaGBtDDHWAsjcEz65IiTj1zRc/JWlIWRBHIVlN+zyE/1V1Epzuc
	 hGFL2U47VL53ZI+X9JwMYHeynBlxd8UB7BLezSWAY3iIH6HIhVdjda/O4Ne+Jwz59hvJ7
	 Hut5CRWTnErAsEsnqs3q2ILU+Lm7oRfdpScoBKAiU1beTXqTMz/nch0kTRlQfpx9EL1kQ
	 l6Yy8B6krBaCfBzR1q2iok5hjCQFfZiImCVG+mCXjAOFUu32Y1E4zhe9EnttHqBQixQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=AXkK6eAe;
	arc=none smtp.remote-ip=188.68.63.102
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8D606A333
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 08:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFD8D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=AXkK6eAe
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4jRRRL0pC1z6V0c;
	Sat, 14 Nov 2026 09:01:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1794643310;
	bh=UPXqxqpm2KnGStbmzeRzcOGE/OJEzVC481Zzvzp8we0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AXkK6eAe8qp9yP73+ixsL3o9vgNlOYSg1erRWK204nbTt/DlG8Y/pFNrYZdRRAeiJ
	 bZ5ooKn3kDyHD2BWfS4/jcCdZmqP2ud5UivZ2yrfbvEEAZNjxvIIic5eIlU511oBTN
	 FUmXgoN8qge6XFyN80z9llSIgN/+Zvk5ytqrlAwm79TjS/0CNyJ610JHv0t9mQr5Tx
	 cnfSldr3Hs4ee0afMkN0gbgWXp3DqvbMHuHvYozirNz1WgyDZ/p3SxoQ/ptW9dx87Q
	 0b85DTno/WculuaFkKgLmukqRSMTiYZ5SnOIpG0YxxvQDKaUFTOzJFwU9t3RsyiZko
	 iJ1DNwnlbSyAg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4jRRRL00y1z4xNp;
	Sat, 14 Nov 2026 09:01:50 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jRRRK3bs6z8sZd;
	Sat, 14 Nov 2026 09:01:49 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id D1F7C5F98B;
	Sat, 14 Nov 2026 09:01:40 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <36fc271e-eeae-48ec-ae9e-4fa284605112@leemhuis.info>
Date: Sat, 14 Nov 2026 09:01:39 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] HID: Corsair K70 RAPIDFIRE interface 1 times out on
 Linux 7.3.4
To: Ali Lin <alexlin901107@gmail.com>, linux-input@vger.kernel.org
Cc: regressions@lists.linux.dev, jikos@kernel.org, bentiss@kernel.org
References: 
 <CAMX8SmaXHh-dzH2n6pRhQr8q=iN=Ui7T3TC42e35LBUjvMaH1Q@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAMX8SmaXHh-dzH2n6pRhQr8q=iN=Ui7T3TC42e35LBUjvMaH1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179464330112.547980.6125337135683635613@mxe9fb.netcup.net>
X-NC-CID: J5KgsYkr5XNtbCq7WW1k0cwXP0CHfvStSuzHfxS6/HjIvbPdbuk=

On 11/14/26 07:56, Ali Lin wrote:
> 
> I would like to report a possible Linux HID regression affecting the
> Corsair Gaming K70 RAPIDFIRE keyboard (USB ID 1b1c:1b3a).
> 
> On Linux 7.3.4-arch1-1, the keyboard works for normal typing, but the
> Num Lock, Caps Lock, and Scroll Lock indicator LEDs do not function
> correctly after boot.
> 
> Unplugging and reconnecting the keyboard restores normal operation.
> [...]
> Relevant kernel messages on Linux 7.3.4:
> 
> [   36.929377] usbhid 1-4:1.1: can't add hid device: -110
> [   36.930405] usbhid 1-4:1.1: probe with driver usbhid failed with error -110
> 
> The USB topology on the affected kernel shows:

Not my area of expertise, so take this with a grain of salt, as I might
send you in the wrong direction. But it sounds somewhat like the problem
this patch tries to solve:

xhci: give back TDs and clean up ep0 after disconnect
https://lore.kernel.org/all/20261029204324.658845-2-mathias.nyman@linux.intel.com/

You might want to compare your error msg with earlier reports that led
to that patch:
https://lore.kernel.org/lkml/20261010064407.11030-1-yiyu@yiyuzhou.io/
https://lore.kernel.org/lkml/20261010071811.20483-1-yiyu@yiyuzhou.io/
https://lore.kernel.org/linux-usb/20261023132616.339833-1-diogochaves@me.com/




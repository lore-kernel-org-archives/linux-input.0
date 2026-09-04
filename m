Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157A364052
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541425; cv=none; b=PEo8qz5NWHz35C37sp2YtHQW7sT8lJRT4TRq0azxuhKCa0JbcyEygwuzf2CW3RG1b0SKvDhF5KlY3QCAdiBwSZDjFKeBoJIXjKkRLEzilBEaO2tRSgt26E71sSJdAZCsa6gx1htyh3qzYvRIUd0/57FzKoIkeimX1/y+VCo+Nn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541425; c=relaxed/simple;
	bh=9GNevXAtGS/2lU26WLQzSmaXODEHwft7UHmQzEQh/sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs+WwZz5UyE4TQzT+UIQYdg637L39T4dTHv8RvcJAOKJU0F3gPC3kwDSW5HMYBS/VhOug9urrdaoS6fjtlkPdi+vAXWQDP/rZkdKFKJhfvNPDxXoj880zIMRpdGHki368TbEorupzv+eaOIoc64oq/E06UcguBoWbp2RELL5z5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5DKp93E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5DKp93E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AD31F00A3D;
	Fri,  4 Sep 2026 17:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541424;
	bh=9GNevXAtGS/2lU26WLQzSmaXODEHwft7UHmQzEQh/sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D5DKp93EkGMC0+AimTl9uAB+gfKcX6bhRxNxTzARHzgb9nnUf5ZbqkNaDTKAM1NE1
	 jwRZopFkWtsX2PK4IpFywCXQs3bIUU23YR8v5GCJgI0K4rbsGuB5/XBx0fN8qxwo5x
	 aLXLExkRYuKJTWKCn0jWI0shAHuxRrKI49CWmTLZztK51kJA/p3QQ7hc9QTbEWEtua
	 cDeqStMWIr3A2wJppvhdE3zBo+mGJktUZGuOcskOcQl+s/l/GWQsDmx95+R6FYMu3L
	 tBoHJSBm2WL5tYoPNpoHqs45UhkOJsP0buvWJ/DHBXWlsrBh7W/uegv9CodWkk4ckY
	 VnkRHzOB4Ip0w==
Date: Fri, 4 Sep 2026 19:03:39 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Erik =?utf-8?Q?H=C3=A5kansson?= <erikhakan@gmail.com>
Cc: Alexey Zagorodnikov <xglooom@gmail.com>, 
	Rafael Passos <rafael@rcpassos.me>, lains@riseup.net, hadess@hadess.net, jikos@kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Brigham Campbell <me@brighamcampbell.com>, 
	Jori Koolstra <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: fix hi-res scroll for
 Bolt-connected MX Master
Message-ID: <apr493wpBH50vXNi@beelink>
References: <20260904034843.1340846-1-rafael@rcpassos.me>
 <96cd3161-3a6c-455e-a63c-f3226b27f74f@gmail.com>
 <119cd005-ece9-4e2a-aded-0d6d66c5bcfc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <119cd005-ece9-4e2a-aded-0d6d66c5bcfc@gmail.com>

On Sep 04 2026, Erik Håkansson wrote:
> Hi!
> Is this the same issue as in
> https://lore.kernel.org/linux-input/20260901-bolt-scroll-fix-v1-1-58bca7ae487f@protonmail.com/
> The symptoms seem similar at least, and if so the approach to fixing
> it in that case is to simply treat Bolt devices like previous DJ
> devices, rather than having special treatment for Bolt.
> Can you who have Bolt mice maybe test that patch too to see if it
> solves the same issue?

FWIW, my initial decision a few years back when Bolt was introduced was
to not include it in the kernel, because there are too many things it's
missing, the most problematic one being that we don't know which device
sends which event.

So basically, there is a chance that the driver sets high-resolution
scrolling on a bolt device, when 2 mice are connected, and one is
capable of it and the other is not. This is unlikely to happen, but is
hard to solve in the kernel.

So I'm happy to wait for testing and patches, but I would also like a
conclusion where bolt doesn't belong to the kernel, and we just revert
the inclusion of the receiver in the dj driver.

Cheers,
Benjamin

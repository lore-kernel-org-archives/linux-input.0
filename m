Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A43A450C;
	Mon, 24 Aug 2026 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567158; cv=none; b=sEXxF2aasUVnbPlb9mcUbFMcHZRRAts6l+V/kKi0ybaFKePQ8ffUijKSuf9Pk72bbr/8bPVzg7kV4gq/QPvnkIVqQmFpCOGcBq0sxJxL6jMtiQMRoufqwWCU9qEWAWblEuY0Y5ba692Hh/YqOxHa40ccptIvy5WQe5nFcJ3w8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567158; c=relaxed/simple;
	bh=BB9/P9MTQgvNJMcMyLNnB8Cj/IcuhidEHT1N1Ki1lXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNhrWWC6jI/IhbekkNtjZPQw6l7V6x2onvx5tu2OEsOUycU2deClzmRCyNFG98iIkZrw26nViMo1efDV2spQpHDbov2ZJSVyaoWvQHEtgv3QDEzGBDNZf3/O9+LPpraRhuoSSFoVKMzK4y9SxEns08TJOltY2ViInlaYI6JKe58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY998uiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY998uiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A9A1F000E9;
	Mon, 24 Aug 2026 10:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787567156;
	bh=lBPGU7NHdeVPM/325IfxrTmib3GcqLC8H9NbUxGPU/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jY998uiKk+vkjCrUoSENIjEm0UNkoRieDv3GlKSi1dJ5p8sXGm+8b2QQtmKJs9zUP
	 54lBuk25ssJk8FYOBRbhLvahBI25G1uAwLDb+AiXQ8IATlbPDzWPN7MDfh3vmnYfyL
	 9vgvH8+lRAwQFD4MuH/DwFxgUniEx0+GE2XaApE1JJYEBDx6hegZZnFSm6Ab3qiRtI
	 mI5jeBymL98D6d0yy8/pSg1SeNEG2muuI5vrBCcAgAlT6AqfHNNw/yHkPL+HJHQSvD
	 ESLwJdegAn2pQa/viMulMTlRaC+29QMWgwdOjlY2PcIF/vReyk7dDUx0P0Z2jQRMwT
	 LW5DmIgP6VS5g==
Date: Mon, 24 Aug 2026 11:25:52 +0100
From: Lee Jones <lee@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Matteo Croce <technoboy85@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH v2] HID: core: demote warning to debug level
Message-ID: <20260824102552.GA813380@google.com>
References: <20260523105545.68079-1-technoboy85@gmail.com>
 <9no2pr1r-5277-5765-9q79-on37sn09qn4n@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9no2pr1r-5277-5765-9q79-on37sn09qn4n@xreary.bet>

On Wed, 10 Jun 2026, Jiri Kosina wrote:

> On Sat, 23 May 2026, Matteo Croce wrote:
> 
> > From: Matteo Croce <teknoraver@meta.com>
> > 
> > The log level for short  messages was changed from debug to warning,
> > flooding syslog on systems with devices that regularly send
> > short reports, in my case an UPS:
> > 
> >     $ dmesg |grep -c 'Event data for report .* was too short'
> >     35
> > 
> > Demote it back to debug level.
> > 
> > Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
> > Signed-off-by: Matteo Croce <teknoraver@meta.com>
> 
> Applied, thanks.

FWIW, I'd like to contest this patch.

The warning is real.  It means that the HID report was rejected and as
such something on the system will be now be non-functional.  Silencing
the warning is not helpful.  It does not fix the issue, and now the user
/ admin has no idea that its even happening.

This warning has caught a bunch of genuine issues related to testing
infrastructure and incorrectly coded firmware that have subsequently
been rectified.

Please don't hide this issue.  Fix the root cause instead.

-- 
Lee Jones

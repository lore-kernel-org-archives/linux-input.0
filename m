From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] TWL4030 keypad: keypad lock / unlock
Date: Wed, 25 Nov 2009 14:46:02 +0000
Message-ID: <20091125144601.GB636@rakim.wolfsonmicro.main>
References: <1257841448-12757-1-git-send-email-samu.p.onkalo@nokia.com>
 <1257841448-12757-2-git-send-email-samu.p.onkalo@nokia.com>
 <20091110134329.GB30911@sirena.org.uk>
 <20091110172637.GB15263@core.coreip.homeip.net>
 <1257933456.3507.42.camel@4fid08082>
 <20091111100837.GA6263@rakim.wolfsonmicro.main>
 <1258977955.5272.37.camel@4fid08082>
 <20091123135435.GG24326@rakim.wolfsonmicro.main>
 <1259158937.9055.6.camel@4fid08082>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35559 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750904AbZKYOp4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2009 09:45:56 -0500
Content-Disposition: inline
In-Reply-To: <1259158937.9055.6.camel@4fid08082>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Onkalo Samu <samu.p.onkalo@nokia.com>
Cc: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Nov 25, 2009 at 04:22:17PM +0200, Onkalo Samu wrote:

> Something like that:

The userspace interface looks reasonable to me but...

> +		return count;
> +	}
> +	input_dev->disabled = i;

> should this be a counter or boolean? Or should this be in driver itself
> and not in input system.

I'd expect a boolean - userspace can refcount itself if it needs to, but
it'd be strange if configuration written into sysfs didn't always take
effect.

> +	if (i)
> +		input_dev->disable(input_dev);
> +	else
> +		input_dev->enable(input_dev);

...it'd seem more natural to have the sense of the sysfs file be the
other way around, but that is a matter of taste.  It just feels better
to me for "true" to mean "on".

I don't know what the best way to sync with the device being open and
in use is, though.

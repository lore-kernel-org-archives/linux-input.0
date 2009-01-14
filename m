From: Daniel Silverstone <dsilvers@simtec.co.uk>
Subject: Re: usbtouchscreen: Add support for Zytronic capacitive touchscreen
Date: Wed, 14 Jan 2009 17:36:53 +0000
Message-ID: <1231954613.9219.8.camel@ataraxia>
References: <20090109121026.052643915@fluff.org.uk>
	 <20090111234903.ZZRA012@mailhub.coreip.homeip.net>
	 <1231751234.23618.6.camel@petitemort>
	 <20090112212907.ZZRA012@mailhub.coreip.homeip.net>
	 <1231838958.30531.3.camel@petitemort>
	 <20090114053515.GC4375@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from batfish.pepperfish.net ([87.237.62.180]:44743 "EHLO
	flounder.pepperfish.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757497AbZANRgV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2009 12:36:21 -0500
In-Reply-To: <20090114053515.GC4375@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, vince@simtec.co.uk

On Tue, 2009-01-13 at 21:35 -0800, Dmitry Torokhov wrote:
> > As I understand it; yes. (Some bits of hardware really are hideous
> > things) Indeed if the driver fails to load quickly enough, the device
> > might disconnect/reconnect before the driver can get hold of it.
> Geez... you sure it wasn't just broken device/batch?

Nope, the datasheet proudly proclaims this watchdog functionality.

> > Unfortunately it's often harder to get people to change their userland
> > than their kernel. It seems a pity to make the driver less useful during
> > any longer-term effort to fix TSLIB. If acceptance of this patch is
> > predicated on removing that then I guess we'll have to discuss it
> > amongst ourselves and try and work out what we'd rather do. Is removing
> > the fake pressure report a requirement or a would-like?
> I just checked TSLIB and the change to recognize devices that do not
> report pressure was applied 2 months ago so everything should work fine
> now. I do not think that we need to implement workarounds in newly
> added drivers just because users are not willing to upgrade their
> TSLIB installation.

I see. I shall look into sorting out a fresh patch without fake
pressure.

Regards,

Daniel.

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
PGP mail accepted and encouraged.            Key Id: 2BC8 4016 2068 7895




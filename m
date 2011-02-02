From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Elo TouchSystems touchscreen support? (04e7:0022)
Date: Wed, 02 Feb 2011 12:42:47 +0000
Message-ID: <1296650569.2123.2.camel@novo.hadess.net>
References: <1296485689.7756.9.camel@novo.hadess.net>
	 <20110131212842.GB1603@polaris.bitmath.org>
	 <AANLkTi=8O=p6-zTdMete7uhrT5OKODZXROKyoGPURJ3h@mail.gmail.com>
	 <1296561717.15349.5.camel@novo.hadess.net>
	 <AANLkTim=RV1Cd0k08gv-DDho-Mim64bR7RRJ+c7D1RZf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60265 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab1BBMmw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Feb 2011 07:42:52 -0500
In-Reply-To: <AANLkTim=RV1Cd0k08gv-DDho-Mim64bR7RRJ+c7D1RZf@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Tue, 2011-02-01 at 14:25 +0100, Benjamin Tissoires wrote:
<snip>
> First pass:
> - please get the branch multitouch of jiri's tree (at
> http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git;a=shortlog;h=refs/heads/multitouch)
> - then apply the attached patch (git am
> 0001-hid-multitouch-Introduce-Elo-TouchSystems-2515-Intel.patch)
> - get your config from your current kernel (check that hid-multitouch
> is enabled as a module)
> - compile, install, reboot

That's where I hit a problem. It seems that the kernel on which that
branch is based has broken cgroups support (it panics on startup).

Would your patch, or a patchset be available to apply to the close to
Linus tree Fedora rawhide kernel?

> - Now your device should still work and must be handled by hid-multitouch
> if it's the case:

As soon as I manage to get it to boot, I'll be doing that :)

Cheers


From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Elo TouchSystems touchscreen support? (04e7:0022)
Date: Wed, 2 Feb 2011 14:18:36 +0100
Message-ID: <AANLkTinOK+=J64NRWZjit3S7hAdGVXxRE9HYkxTxrxON@mail.gmail.com>
References: <1296485689.7756.9.camel@novo.hadess.net>
	<20110131212842.GB1603@polaris.bitmath.org>
	<AANLkTi=8O=p6-zTdMete7uhrT5OKODZXROKyoGPURJ3h@mail.gmail.com>
	<1296561717.15349.5.camel@novo.hadess.net>
	<AANLkTim=RV1Cd0k08gv-DDho-Mim64bR7RRJ+c7D1RZf@mail.gmail.com>
	<1296650569.2123.2.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57284 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010Ab1BBNSi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Feb 2011 08:18:38 -0500
Received: by wyb28 with SMTP id 28so7841794wyb.19
        for <linux-input@vger.kernel.org>; Wed, 02 Feb 2011 05:18:37 -0800 (PST)
In-Reply-To: <1296650569.2123.2.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Wed, Feb 2, 2011 at 13:42, Bastien Nocera <hadess@hadess.net> wrote:
> On Tue, 2011-02-01 at 14:25 +0100, Benjamin Tissoires wrote:
> <snip>
>> First pass:
>> - please get the branch multitouch of jiri's tree (at
>> http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git;a=shortlog;h=refs/heads/multitouch)
>> - then apply the attached patch (git am
>> 0001-hid-multitouch-Introduce-Elo-TouchSystems-2515-Intel.patch)
>> - get your config from your current kernel (check that hid-multitouch
>> is enabled as a module)
>> - compile, install, reboot
>
> That's where I hit a problem. It seems that the kernel on which that
> branch is based has broken cgroups support (it panics on startup).
>
> Would your patch, or a patchset be available to apply to the close to
> Linus tree Fedora rawhide kernel?

Hi Bastien,

Sorry for that. Attached a new version that bumps a Linus' 2.6.38-rc2
or 2.6.38-rc3 to Jiri's tree and applies the patch above.

If it's still not working, I'll send you the files directly ;)

>
>> - Now your device should still work and must be handled by hid-multitouch
>> if it's the case:
>
> As soon as I manage to get it to boot, I'll be doing that :)

Cool ;)

Cheers,
Benjamin

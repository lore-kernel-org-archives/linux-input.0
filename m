From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [PATCH] Core driver for WM97xx touchscreens
Date: Sat, 19 Jan 2008 22:48:32 +0300
Message-ID: <bc64b4640801191148m39ae5cd6ra190ac8e9c40fba7@mail.gmail.com>
References: <20080118162627.GA28974@rakim.wolfsonmicro.main>
	 <1200673631-366-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	 <20080118120148.ZZRA012@mailhub.coreip.homeip.net>
	 <fmqq50$te0$1@ger.gmane.org> <20080119170030.GA469@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:30554 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYASTsg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Jan 2008 14:48:36 -0500
Received: by py-out-1112.google.com with SMTP id u52so2126962pyb.10
        for <linux-input@vger.kernel.org>; Sat, 19 Jan 2008 11:48:35 -0800 (PST)
In-Reply-To: <20080119170030.GA469@sirena.org.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, liam.girdwood@wolfsonmicro.com

Hi,

2008/1/19, Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Jan 18, 2008 at 06:11:45PM +0000, Dmitry Baryshkov wrote:
> > Dmitry Torokhov wrote:
>
> > > I will need some more time to review and understand the need for the new
> > > bus in the driver.
>
> > Most likely this can be converted to platform_bus. Maybe this can also get
>
> Could you expand on how you see that being implemented, please?  It
> doesn't feel entirely comfortable to me - providing a bus for the chip
> seems more direct and the platform bus not what I'd think of using for
> something hanging off another bus - but I think I'm just not visualising
> what you're thinking of properly.

Well... It's a common suggestion not to duplicate code. The wm97xx bus
looks mostly like platform. The only difference is the name. To help
visualisation, devices can have parents. Just set (in pseudocode)
wm97xx-touchscreen->parent to wm97xx, do the same for wm97xx-battery
and so on. Thus all devices would be on the platform device but with
proper parent <-> child notation.

> > help from soon-to-be posted MFD (multi function devices) helpers.
>
> The multi-function device support does feel like it could be a good fit.
> I'd seen it discussed sometime last year but don't recall seeing
> anything for quite a while.  Like Ben said, any pointers to current work
> would be appreciated.

You can find the current work at
git://git.mnementh.co.uk/linux-2.6-im.git#tmio_dev_try3. Look for
"Core MFD support" changeset.

>
> It's probably worth mentioning that in addition to what is in the
> current patch series these chips all also provide an audio codec which
> requires a reasonably substantial driver for full support.
>

This would only touch child devices organisation.

-- 
With best wishes
Dmitry

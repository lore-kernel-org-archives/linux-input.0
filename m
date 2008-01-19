From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Core driver for WM97xx touchscreens
Date: Sat, 19 Jan 2008 21:55:07 +0000
Message-ID: <20080119215506.GA7400@sirena.org.uk>
References: <20080118162627.GA28974@rakim.wolfsonmicro.main> <1200673631-366-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20080118120148.ZZRA012@mailhub.coreip.homeip.net> <fmqq50$te0$1@ger.gmane.org> <20080119170030.GA469@sirena.org.uk> <bc64b4640801191148m39ae5cd6ra190ac8e9c40fba7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1900 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbYASVzJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Jan 2008 16:55:09 -0500
Content-Disposition: inline
In-Reply-To: <bc64b4640801191148m39ae5cd6ra190ac8e9c40fba7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry <dbaryshkov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, liam.girdwood@wolfsonmicro.com

On Sat, Jan 19, 2008 at 10:48:32PM +0300, Dmitry wrote:

> Well... It's a common suggestion not to duplicate code. The wm97xx bus
> looks mostly like platform. The only difference is the name. To help
> visualisation, devices can have parents. Just set (in pseudocode)
> wm97xx-touchscreen->parent to wm97xx, do the same for wm97xx-battery
> and so on. Thus all devices would be on the platform device but with
> proper parent <-> child notation.

That's exactly what I had understood you to mean.  I guess it's just
that using the platform bus for this purpose feels like an abstraction
violation to me due to having platform devices parented off a device on
another bus.  Obviously it's just my model of a platform device that's
wrong here.  I will change the driver to use the platform bus for my
next submission.

> git://git.mnementh.co.uk/linux-2.6-im.git#tmio_dev_try3. Look for

Thanks, I'll take a look.

> 2008/1/19, Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > current patch series these chips all also provide an audio codec which
> > requires a reasonably substantial driver for full support.

> This would only touch child devices organisation.

Indeed - I mention it mostly for additional motivation.

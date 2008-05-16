From: Tino Keitel <tino.keitel@gmx.de>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Fri, 16 May 2008 15:32:34 +0200
Message-ID: <20080516133234.GA10193@thinkpad.home.local>
References: <20080514221519.GA6575@kroah.com> <20080515132108.GA9327@dose.home.local> <20080515094212.ZZRA012@mailhub.coreip.homeip.net> <20080515174939.GA10881@dose.home.local> <20080515142845.ZZRA012@mailhub.coreip.homeip.net> <20080515205950.GA11794@dose.home.local> <20080516090351.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eazy.amigager.de ([213.239.192.238]:60531 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957AbYEPNfQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 May 2008 09:35:16 -0400
Content-Disposition: inline
In-Reply-To: <20080516090351.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg KH <greg@kroah.com>, jkosina@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 16, 2008 at 09:13:41 -0400, Dmitry Torokhov wrote:

[...]

> Does the learning remote have the same VID/PID as AppleIr? If not I am
> not sure why you are btringing it here.

It has no VID/PID at all, as it is not connected to the computer. It
just sends IR codes to the IR sensor in the Mac mini (the builtin USB
device that the appleir driver is for). And as the learning remote has
more than 6 keys, it can send more than 6 different codes. The Apple
remote has only 6 keys, and only these keys are handled by the driver.

Regards,
Tino

From: Ron <ron@debian.org>
Subject: Re: [Linuxwacom-devel] [PATCH] Use hid blacklist in usbmouse/usbkbd
Date: Mon, 26 Nov 2007 21:43:28 +1030
Message-ID: <20071126111328.GA9235@homer.shelbyville.oz>
References: <1196074688.12642.10.camel@plop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppp121-45-25-139.lns10.adl2.internode.on.net ([121.45.25.139]:54613
	"EHLO homer.shelbyville.oz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754168AbXKZMGz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2007 07:06:55 -0500
Content-Disposition: inline
In-Reply-To: <1196074688.12642.10.camel@plop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pascal Terjan <pterjan@mandriva.com>
Cc: linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net


Hi Pascal,

There is a less intrusive way to handle this for any reasonably modern
2.6 kernel...  see the check_driver script in the Debian package.

It's called from udev when the device is plugged and if it is a wacom
tablet, it will repossess it from any other driver and bind it to the
wacom one.

We had a more brutal hack that did this for 2.4 too, but this method
is I believe the recommended one now (or at least supported without
further kernel patching since about 2.6.13-ish).

hth!
Ron


On Mon, Nov 26, 2007 at 11:58:08AM +0100, Pascal Terjan wrote:
> Hi,
> Some devices are blacklisted in hid-quirks, but still get handled by
> usbmouse/usbkbd.
> 
> That means that if usbmouse is already loaded when a wacom tablet gets
> plugged it, it will take it.
> 
> This patch fixes this behaviour by using hid's blacklist in usbmouse
> and usbkbd, but I don't know much about interactions between hid and
> usbmouse/usbkbd so I'm not sure this is the correct way to do it.
> 
> So, please voice you opinion :)



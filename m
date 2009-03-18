From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Wacom Graphire Bluetooth driver (updated with a few
 fixes)
Date: Wed, 18 Mar 2009 22:47:28 +0000
Message-ID: <1237416448.15346.1483.camel@cookie.hadess.net>
References: <1236988799.32264.6310.camel@cookie.hadess.net>
	 <1237247755.32264.10664.camel@cookie.hadess.net>
	 <1237335112.15346.118.camel@cookie.hadess.net>
	 <20090319002838.5b0132b4@zap.home.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:52482 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759715AbZCRWri (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Mar 2009 18:47:38 -0400
In-Reply-To: <20090319002838.5b0132b4@zap.home.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Zabolotny <zap@homelink.ru>
Cc: linux-input <linux-input@vger.kernel.org>, mjg <mjg@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, BlueZ development <linux-bluetooth@vger.kernel.org>

On Thu, 2009-03-19 at 00:28 +0300, Andrew Zabolotny wrote:
> From Wed, 18 Mar 2009 00:11:52 +0000
> Bastien Nocera <hadess@hadess.net> wrote:
> 
> > Based on the work by Andrew Zabolotny, an HID driver for the Bluetooth
> > Wacom tablet.
> Great to see my old work was finally useful :) I tried in the past to
> contact the bluetooth stack author to submit my patch, but got no answer
> and gave up.

I think that the main problem was because, at that time, there was no
such thing as the HID sub-system to avoid having to reimplement things
twice for Bluetooth and USB devices.

And adding support for a specific device in the hidp driver isn't the
best way to do this. Nowadays the driver for joysticks and keyboards are
the same whether Bluetooth or USB.

> Also I like the fact that you have dropped my wicked out-of-active-area
> pseudo-buttons support. Such kind of things should be implemented, if
> needed, in the x11 driver (but the driver would need a way to report
> out-of-active area stylus presses).

I removed it because the other drivers didn't implement it. If it were
to be implemented, the USB drivers would need to support it as well, so
that the interface is agreed upon.

Better start with something small, and get it merged, then discuss
extensions.

> What's that "mode 2 patch" you're talking about? Should it be applied
> to hidd, and is it available somewhere?

It's at:
http://cvs.fedoraproject.org/viewvc/rpms/bluez/devel/bluez-activate-wacom-mode2.patch?view=markup

And it's a patch to input plugin for bluetoothd, not hidd. hidd is the
BlueZ 3.x daemon, we've been at BlueZ 4.x for a while.

The bluetoothd patch is already in Fedora rawhide, and the kernel patch
will get there once we've released Fedora 11 Beta.

Cheers


From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: Lenovo G360: ALPS Touchpad Recognized as "PS/2 Generic Mouse"
Date: Thu, 5 Jul 2012 08:30:36 -0500
Message-ID: <20120705133036.GA28604@thinkpad-t410>
References: <CAAT31jY5_P13xjybsYFm3oix0pjbbzRihCrjecQ+cXkrHhnrCQ@mail.gmail.com>
 <20120705032009.GA8748@burratino>
 <20120705154545.8d7492cc.dashing.meng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60425 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438Ab2GENaj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jul 2012 09:30:39 -0400
Content-Disposition: inline
In-Reply-To: <20120705154545.8d7492cc.dashing.meng@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: littlebat <dashing.meng@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-input@vger.kernel.org, 679750@bugs.debian.org

On Thu, Jul 05, 2012 at 03:45:45PM +0800, littlebat wrote:
> > Is the following summary correct?
> > 
> >  - 2.6.32.y (Debian squeeze) works well, using xinput or synclient to
> >    configure
> >  - 3.2.y (Ubuntu 12.04 LTS) sees a generic mouse, unconfigurable
> >  - 3.2.y (Debian squeeze-backports) is likewise unconfigurable
> >  - 3.4.4 (Debian experimental) is also unconfigurable
> 
> No, none of these four kernels can configure a full functional ALPS
> touchpad. Under all of these four kernels:
> 1, "synclient -l" shows "Couldn't find synaptics properties. No
> synaptics driver loaded? "
> 2, "xinput --list" shows it is a "PS/2 Generic Mouse"
> 3, "cat /proc/bus/input/devices" shows it is "N: Name="PS/2 Generic
> Mouse""
> 4, Can't find any string like "touchpad", "synaptics" in
> "/var/log/Xorg.0.log" 
> 5, There isn't touchpad tab in gnome mouse setting dialog, so I
> can't setup edge scrolling and disable touchpad on typing.

ALPS refuses to provide information about their touchpad protocols, so
any support we have for ALPS touchpads is based on reverse engineering
the protocol. It's likely that yours uses some version of the protocol
that isn't supported, in which case someone with access to the hardware
will need to do the reverse engineering work.

There's a slight chance that it uses a known protocol but just has an
unknown model signature. In that case the fix is easy, but it will
require some trial and error to see if that's the case.

> > Could you provide full "dmesg" output from booting a working and
> > non-working kernel?
> 
> The laptop isn't here, I will post full "dmesg" output under "3.4.4
> (Debian experimental)" kernel later.

When you send dmesg it would help if you could use a build with the
following line added to the top of drivers/input/mouse/alps.c, before
the includes.

 #define DEBUG

This will cause the model signature for your touchpad to be included in
the log.

Thanks,
Seth


From: littlebat <dashing.meng@gmail.com>
Subject: Re: Lenovo G360: ALPS Touchpad Recognized as "PS/2 Generic Mouse"
Date: Thu, 5 Jul 2012 15:45:45 +0800
Message-ID: <20120705154545.8d7492cc.dashing.meng@gmail.com>
References: <CAAT31jY5_P13xjybsYFm3oix0pjbbzRihCrjecQ+cXkrHhnrCQ@mail.gmail.com>
	<20120705032009.GA8748@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45688 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab2GEH1p (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jul 2012 03:27:45 -0400
Received: by pbbrp8 with SMTP id rp8so12358815pbb.19
        for <linux-input@vger.kernel.org>; Thu, 05 Jul 2012 00:27:45 -0700 (PDT)
In-Reply-To: <20120705032009.GA8748@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: linux-input@vger.kernel.org, seth.forshee@canonical.com, 679750@bugs.debian.org

On Wed, 4 Jul 2012 22:20:09 -0500
Jonathan Nieder <jrnieder@gmail.com> wrote:

> (dropping Debian bug from cc list)
> Hi,
> 
> littlebat wrote:
> 
> >                                                               I
> > report a kernel bug about ALPS touchpad to you.
> >
> > My lenovo G360 has an ALPS touchpad, show in Windows 7 Home
> > Editition OEM in this laptop. Under Debian Squeeze or Ubuntu 12.04
> > LTS LiveCD in same laptop, the left and
> > right key, single and double tap, tracking  of touchpad works well.
> > But, there isn't touchpad tab in gnome mouse setting dialog, so I
> > can't setup edge scrolling and disable touchpad on typing. xinput
> > shows it is a "PS/2 Generic Mouse".
> [...]
> > Tell me If need more detail information.
> 
> Thanks.  Forgive me for being dense: can you spell this out a little
> more for me?
> 
> Is the following summary correct?
> 
>  - 2.6.32.y (Debian squeeze) works well, using xinput or synclient to
>    configure
>  - 3.2.y (Ubuntu 12.04 LTS) sees a generic mouse, unconfigurable
>  - 3.2.y (Debian squeeze-backports) is likewise unconfigurable
>  - 3.4.4 (Debian experimental) is also unconfigurable

No, none of these four kernels can configure a full functional ALPS
touchpad. Under all of these four kernels:
1, "synclient -l" shows "Couldn't find synaptics properties. No
synaptics driver loaded? "
2, "xinput --list" shows it is a "PS/2 Generic Mouse"
3, "cat /proc/bus/input/devices" shows it is "N: Name="PS/2 Generic
Mouse""
4, Can't find any string like "touchpad", "synaptics" in
"/var/log/Xorg.0.log" 
5, There isn't touchpad tab in gnome mouse setting dialog, so I
can't setup edge scrolling and disable touchpad on typing.

> Could you provide full "dmesg" output from booting a working and
> non-working kernel?

The laptop isn't here, I will post full "dmesg" output under "3.4.4
(Debian experimental)" kernel later.

Thanks. 

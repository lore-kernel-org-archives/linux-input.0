From: Joe Sweeney <joesweeney413@gmail.com>
Subject: Fn Keys bug
Date: Mon, 12 Nov 2012 13:15:51 -0500
Message-ID: <CA+X-he1=3ykJsGaUQ+4sSEY2Y5WV1QTdyzdrT15jg8cyKKAA=g@mail.gmail.com>
References: <CA+X-he1ZLfvWWEJ92CSnUUxr4QN5mT_zqgBR2=fj3Z3dCxGK6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:36992 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab2KLSPv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Nov 2012 13:15:51 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so22802iay.19
        for <linux-input@vger.kernel.org>; Mon, 12 Nov 2012 10:15:51 -0800 (PST)
In-Reply-To: <CA+X-he1ZLfvWWEJ92CSnUUxr4QN5mT_zqgBR2=fj3Z3dCxGK6w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1074169


thinkpad edge 15 0319 model. ubuntu 12.10. tried on various kernels,
only the play pause forward reverse(media keys) work, however
brightness, sound, mute, wifi, etc keys do not work.

xev | sed -n 's/^.*state \([0-9].*\), keycode *\([0-9]\+\) *\(.*\),
.*$/keycode \2 = \3, state = \1/p' does not give an output when i
press the above keys. the bios is set to allow the FN keys to work
without pressing Fn, i have tried the legacy option as well, in that
case xev sees the actual 'Fn' key was XFWakeUp.
---
ApportVersion: 2.6.1-0ubuntu6
Architecture: amd64
DistroRelease: Ubuntu 12.10
InstallationDate: Installed on 2012-10-18 (14 days ago)
InstallationMedia: Ubuntu 12.10 "Quantal Quetzal" - Release amd64 (20121017.5)
MarkForUpload: True
Package: linux (not installed)
ProcEnviron:
 TERM=xterm
 PATH=(custom, no user)
 XDG_RUNTIME_DIR=<set>
 LANG=en_US.UTF-8
 SHELL=/bin/bash
Tags: quantal running-unity
Uname: Linux 3.7.0-030700rc3-generic x86_64
UnreportableReason: The running kernel is not an Ubuntu kernel
UpgradeStatus: No upgrade log present (probably fresh install)
UserGroups: adm cdrom dip lpadmin plugdev sambashare sudo
---
ApportVersion: 2.6.1-0ubuntu6
Architecture: amd64
DistroRelease: Ubuntu 12.10
InstallationDate: Installed on 2012-10-18 (14 days ago)
InstallationMedia: Ubuntu 12.10 "Quantal Quetzal" - Release amd64 (20121017.5)
MarkForUpload: True
Package: linux (not installed)
ProcEnviron:
 TERM=xterm
 PATH=(custom, no user)
 XDG_RUNTIME_DIR=<set>
 LANG=en_US.UTF-8
 SHELL=/bin/bash
Tags: quantal running-unity
Uname: Linux 3.7.0-030700rc3-generic x86_64
UnreportableReason: The running kernel is not an Ubuntu kernel
UpgradeStatus: No upgrade log present (probably fresh install)
UserGroups: adm cdrom dip lpadmin plugdev sambashare sudo


--
Joe Sweeney
A+ Network+ Certified Technician
joesweeney413@gmail.com

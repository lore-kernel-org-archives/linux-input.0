From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [bug?] [powerpc] hid_logitech_dj: Wireless mouse does not work
 in xorg or gpm
Date: Fri, 4 May 2012 05:49:02 -0500
Message-ID: <20120504104902.GA7766@burratino>
References: <20120503055051.GA15960@burratino>
 <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
 <20120503130821.GB16978@burratino>
 <20120503131356.GC16978@burratino>
 <20120504024054.GA19355@hugoo.com.ar>
 <20120504074137.GB6451@burratino>
 <20120504081031.GA30509@hugoo.com.ar>
 <4FA38FFD.6080805@osvaldobarrera.com.ar>
 <20120504083605.GI6451@burratino>
 <CAE7qMrpWMJ=U3H3BBkxXGskNnNG7ZURS44Euh0_LZhq6ucBmpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:33678 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754952Ab2EDKtM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 4 May 2012 06:49:12 -0400
Received: by ghrr11 with SMTP id r11so2623053ghr.19
        for <linux-input@vger.kernel.org>; Fri, 04 May 2012 03:49:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAE7qMrpWMJ=U3H3BBkxXGskNnNG7ZURS44Euh0_LZhq6ucBmpA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org

Nestor Lopez Casado wrote:

> Would you be able to test the following patch on both systems and let
> us know about the result?

Instructions for Hugo:

	# prerequisites
	apt-get install git build-essential

	# get the kernel history, if you don't already have it
	git clone \
	  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

	# latest mainline kernel
	cd linux
	git fetch origin
	git checkout origin/master

	# configure
	cp /boot/config-$(uname -r) .config; # current configuration
	scripts/config --disable DEBUG_INFO; # smaller build
	make localmodconfig; # minimize configuration

	# apply patch
	git apply --index /path/to/patch

	# build
	make deb-pkg; # optionally with -j<num> for parallel build

	# test
	dpkg -i ../<name of package>; # as root
	reboot

	# to unapply patch:
	cd linux
	git reset --hard origin/master

	# when you want to build again:
	make deb-pkg; # maybe with -j4
	dpkg -i ../<name of package>; # as root
	reboot

I would also be interested in a capture of the pairing event, if possible:

	(remove mouse battery or bring mouse out of range)
	mount -t debugfs debugfs /sys/kernel/debug
	ls /sys/kernel/debug/hid/
	modprobe -r hid_logitech_dj
	modprobe hid_logitech_dj
	cat /sys/kernel/debug/hid/<device name>/events >events.captured
	(insert mouse battery or bring mouse within range)
	^C

Jonathan

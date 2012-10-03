From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Mouse and keyboard freeze on Ivy Bridge platform
Date: Wed, 3 Oct 2012 12:44:02 -0700
Message-ID: <20121003194402.GB23195@elie.Belkin>
References: <181608016.271891744.1349250048886.JavaMail.root@zimbra59-e10.priv.proxad.net>
 <Pine.LNX.4.44L0.1210031028130.1441-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50925 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab2JCToI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Oct 2012 15:44:08 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1210031028130.1441-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sebastien.dinot@free.fr
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Alan Stern wrote:
> On Wed, 3 Oct 2012 sebastien.dinot@free.fr wrote:

>> I am encountering random keyboard and mouse freezes which can only be
>> resolved by a hard reset (by pushing the power switch of the computer
>> case).
[...]
> Please build a kernel with CONFIG_USB_DEBUG enabled.  When a hang
> occurs, get a list of hang tasks (Alt-SysRq-w probably won't work, but
> "echo w >/proc/sysrq-trigger" from a network login should).  Then send
> the dmesg output

Sebastien: for reference, here's a way to build a kernel with
CONFIG_USB_DEBUG enabled.

	# prerequisites
	apt-get install git build-essential

	# get the kernel history, if you don't already ahve it
	git clone \
	  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

	# configure
	cd linux
	cp /boot/config-$(uname -r) .config; # current configuration
	scripts/config --disable DEBUG_INFO
	make localmodconfig; # optional: minimize configuration
	scripts/config --enable USB_DEBUG

	# build, test
	make deb-pkg; # can use -j<num> for parallel build
	dpkg -i ../<name of package>; # as root
	reboot

Thanks,
Jonathan

From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [input:synaptics-rmi4 4/11] make[4]: *** No rule to make target
 `drivers/input/rmi4/rmi_f01.o', needed by `drivers/input/rmi4/built-in.o'.
Date: Wed, 28 Nov 2012 17:37:54 +0800
Message-ID: <20121128093754.GB23422@localhost>
References: <50b5ac1d.3WARZ5TfIUdF7U71%fengguang.wu@intel.com>
 <20121128063334.GB23378@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58119 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720Ab2K1Jh6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Nov 2012 04:37:58 -0500
Content-Disposition: inline
In-Reply-To: <20121128063334.GB23378@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org

On Tue, Nov 27, 2012 at 10:33:34PM -0800, Dmitry Torokhov wrote:
> Hi,
> 
> On Wed, Nov 28, 2012 at 02:15:57PM +0800, kbuild test robot wrote:
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git synaptics-rmi4
> > head:   0af25383d395fb5ece54b79d12d06138bf8b9836
> > commit: 49c28c0062548243aa0e15f181098af34bab9712 [4/11] Input: input/rmi4 - Config files and makefiles
> > config: make ARCH=x86_64 allmodconfig
> > 
> > Note: the input/synaptics-rmi4 HEAD 0af2538 builds fine.
> >       It only hurts bisectibility.
> 
> This branch is gonna have a few errors for a while, I am not sure if we
> want to exclude it or just ignore the errors for now....

Dmitry, reported errors will be remembered by the build system and not
reported again.

However if you want to avoid possible new errors being reported, you
may put this line to any commit of the branch

Dont-Auto-Build

The build script will then skip the whole branch.

And remember to remove that line by the time you think it suitable for
testing again. ;)

Thanks,
Fengguang

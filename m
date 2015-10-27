From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [input:master 1384/1384] drivers/input/evdev.c:719:7: warning:
 passing argument 1 of 'copy_from_user' discards 'const' qualifier from
 pointer target type
Date: Mon, 26 Oct 2015 19:08:58 -0700
Message-ID: <20151027020858.GA15536@localhost>
References: <201510270918.x4rKus8w%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33702 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbbJ0CJI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Oct 2015 22:09:08 -0400
Received: by pabla5 with SMTP id la5so12621337pab.0
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2015 19:09:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201510270918.x4rKus8w%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, kbuild-all@01.org, linux-input@vger.kernel.org

On Tue, Oct 27, 2015 at 09:52:20AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git master
> head:   86f77bf98fdd07cd7e9b65014c5f8d8d233b3449
> commit: 86f77bf98fdd07cd7e9b65014c5f8d8d233b3449 [1384/1384] Input: evdev - add event-mask API
> config: sparc64-allyesconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 86f77bf98fdd07cd7e9b65014c5f8d8d233b3449
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/input/evdev.c: In function 'bits_from_user':
> >> drivers/input/evdev.c:719:7: warning: passing argument 1 of 'copy_from_user' discards 'const' qualifier from pointer target type
>       if (copy_from_user(p, bits, len))
>           ^
>    In file included from arch/sparc/include/asm/uaccess.h:4:0,
>                     from include/linux/poll.h:11,
>                     from drivers/input/evdev.c:18:
>    arch/sparc/include/asm/uaccess_64.h:251:1: note: expected 'void *' but argument is of type 'const void *'
>     copy_from_user(void *to, const void __user *from, unsigned long size)
>     ^

Should be fixed now.

Thanks.

-- 
Dmitry

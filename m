From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [input:synaptics-rmi4 4/11] make[4]: *** No rule to make target
 `drivers/input/rmi4/rmi_f01.o', needed by `drivers/input/rmi4/built-in.o'.
Date: Tue, 27 Nov 2012 22:33:34 -0800
Message-ID: <20121128063334.GB23378@core.coreip.homeip.net>
References: <50b5ac1d.3WARZ5TfIUdF7U71%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53088 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab2K1Gdi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Nov 2012 01:33:38 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so6545228pad.19
        for <linux-input@vger.kernel.org>; Tue, 27 Nov 2012 22:33:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50b5ac1d.3WARZ5TfIUdF7U71%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org

Hi,

On Wed, Nov 28, 2012 at 02:15:57PM +0800, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git synaptics-rmi4
> head:   0af25383d395fb5ece54b79d12d06138bf8b9836
> commit: 49c28c0062548243aa0e15f181098af34bab9712 [4/11] Input: input/rmi4 - Config files and makefiles
> config: make ARCH=x86_64 allmodconfig
> 
> Note: the input/synaptics-rmi4 HEAD 0af2538 builds fine.
>       It only hurts bisectibility.

This branch is gonna have a few errors for a while, I am not sure if we
want to exclude it or just ignore the errors for now....

-- 
Dmitry

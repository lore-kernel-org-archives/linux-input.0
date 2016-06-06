From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: rmi: Make hid-rmi a transport driver for
 synaptics-rmi4
Date: Mon, 6 Jun 2016 11:25:44 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606061124500.11844@cbobk.fhfr.pm>
References: <201606040447.LMmbn7qw%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201606040447.LMmbn7qw%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, kbuild-all@01.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

On Sat, 4 Jun 2016, kbuild test robot wrote:

> Hi,
> 
> [auto build test ERROR on hid/for-next]
> [also build test ERROR on v4.7-rc1 next-20160603]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Andrew-Duggan/HID-rmi-Make-hid-rmi-a-transport-driver-for-synaptics-rmi4/20160604-024428
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-next
> config: x86_64-randconfig-s4-06040320 (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/hid/hid-rmi.c:572:2: error: unknown field 'dribble' specified in initializer
>      .dribble = RMI_REG_STATE_OFF,
>      ^
> >> drivers/hid/hid-rmi.c:572:13: error: 'RMI_REG_STATE_OFF' undeclared here (not in a function)
>      .dribble = RMI_REG_STATE_OFF,
>                 ^~~~~~~~~~~~~~~~~
> >> drivers/hid/hid-rmi.c:573:2: error: unknown field 'palm_detect' specified in initializer
>      .palm_detect = RMI_REG_STATE_OFF,
>      ^

This patch depends on this series:

	http://lkml.kernel.org/r/1464979127-2327-1-git-send-email-aduggan@synaptics.com

but there is unfortunately no way for your robot to recognize this 
dependency.

-- 
Jiri Kosina
SUSE Labs

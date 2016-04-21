From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH] HID: uhid: Fixes a bug with userspace bluetooth stacks,
 which causes hangs during certain operations
Date: Thu, 21 Apr 2016 14:27:47 -0700
Message-ID: <CANndSK=tc_aywb6_uQ9FK4Br1gtGUhm_EYCSM0MZsrnEi_x=hg@mail.gmail.com>
References: <1461272067-17624-1-git-send-email-roderick@gaikai.com>
	<201604220504.EolKOFSW%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34324 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbcDUV1s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Apr 2016 17:27:48 -0400
Received: by mail-oi0-f51.google.com with SMTP id k142so100226618oib.1
        for <linux-input@vger.kernel.org>; Thu, 21 Apr 2016 14:27:48 -0700 (PDT)
In-Reply-To: <201604220504.EolKOFSW%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>, Tim Bird <tim.bird@sonymobile.com>, linux-kernel@vger.kernel.org, Roderick Colenbrander <roderick.colenbrander@sony.com>, stable@vger.kernel.org

Please ignore this revision of the patch, there was a small merge
conflict on my end.

On Thu, Apr 21, 2016 at 2:15 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi,
>
> [auto build test WARNING on hid/for-next]
> [also build test WARNING on v4.6-rc4 next-20160421]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/roderick-gaikai-com/HID-uhid-Fixes-a-bug-with-userspace-bluetooth-stacks-which-causes-hangs-during-certain-operations/20160422-050505
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-next
> config: x86_64-randconfig-x003-201616 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All warnings (new ones prefixed by >>):
>
>    In file included from arch/x86/include/asm/atomic.h:4:0,
>                     from include/linux/atomic.h:4,
>                     from drivers/hid/uhid.c:13:
>    drivers/hid/uhid.c: In function 'uhid_event_from_user':
>    drivers/hid/uhid.c:403:6: error: implicit declaration of function 'is_compat_task' [-Werror=implicit-function-declaration]
>      if (is_compat_task()) {
>          ^
>    include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>                                  ^
>>> drivers/hid/uhid.c:403:2: note: in expansion of macro 'if'
>      if (is_compat_task()) {
>      ^
>    cc1: some warnings being treated as errors
>
> vim +/if +403 drivers/hid/uhid.c
>
>    387          __u8 phys[64];
>    388          __u8 uniq[64];
>    389
>    390          compat_uptr_t rd_data;
>    391          __u16 rd_size;
>    392
>    393          __u16 bus;
>    394          __u32 vendor;
>    395          __u32 product;
>    396          __u32 version;
>    397          __u32 country;
>    398  } __attribute__((__packed__));
>    399
>    400  static int uhid_event_from_user(const char __user *buffer, size_t len,
>    401                                  struct uhid_event *event)
>    402  {
>  > 403          if (is_compat_task()) {
>    404                  u32 type;
>    405
>    406                  if (get_user(type, buffer))
>    407                          return -EFAULT;
>    408
>    409                  if (type == UHID_CREATE) {
>    410                          /*
>    411                           * This is our messed up request with compat pointer.
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Roderick Colenbrander
Manager of Software Engineering
Gaikai, a Sony Computer Entertainment Company
roderick@gaikai.com

From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [hid:for-4.10/i2c-hid 6/7] drivers/hid/i2c-hid/i2c-hid.c:1048:23:
 error: implicit declaration of function 'devm_regulator_get'
Date: Fri, 9 Dec 2016 13:40:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1612091339220.16984@cbobk.fhfr.pm>
References: <201612092048.bvPAKPI7%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932299AbcLIMkH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Dec 2016 07:40:07 -0500
In-Reply-To: <201612092048.bvPAKPI7%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Brian Norris <briannorris@chromium.org>, kbuild-all@01.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Caesar Wang <wxt@rock-chips.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Fri, 9 Dec 2016, kbuild test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-4.10/i2c-hid
> head:   de3c99488609284e454cf2b4420a789038a4cfa8
> commit: ead0687fe304a66a24e3d809d1070684f3abee71 [6/7] HID: i2c-hid: support regulator power on/off
> config: x86_64-randconfig-x015-201649 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout ead0687fe304a66a24e3d809d1070684f3abee71
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/hid/i2c-hid/i2c-hid.c: In function 'i2c_hid_probe':
> >> drivers/hid/i2c-hid/i2c-hid.c:1048:23: error: implicit declaration of function 'devm_regulator_get' [-Werror=implicit-function-declaration]
>      ihid->pdata.supply = devm_regulator_get(&client->dev, "vdd");
>                           ^~~~~~~~~~~~~~~~~~
> >> drivers/hid/i2c-hid/i2c-hid.c:1048:21: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>      ihid->pdata.supply = devm_regulator_get(&client->dev, "vdd");
>                         ^
> >> drivers/hid/i2c-hid/i2c-hid.c:1057:8: error: implicit declaration of function 'regulator_enable' [-Werror=implicit-function-declaration]
>      ret = regulator_enable(ihid->pdata.supply);
>            ^~~~~~~~~~~~~~~~
> >> drivers/hid/i2c-hid/i2c-hid.c:1139:2: error: implicit declaration of function 'regulator_disable' [-Werror=implicit-function-declaration]
>      regulator_disable(ihid->pdata.supply);
>      ^~~~~~~~~~~~~~~~~

Mea culpa, I've omitted this hunk while I was resolving a patch 
application conflict into for-4.10/i2c-hid branch. Fix now pushed out as 
d4c9be331.

Thanks,

-- 
Jiri Kosina
SUSE Labs


From: Julia Lawall <julia.lawall@lip6.fr>
Subject: [input:next 1901/1903] drivers/input/misc/axp20x-pek.c:385:1-2:
 axp_pek_id_match is not NULL terminated at line 385 (fwd)
Date: Thu, 17 Aug 2017 11:20:27 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1708171119580.3748@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:63757
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752483AbdHQJUs (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 05:20:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, kbuild-all@01.org



---------- Forwarded message ----------
Date: Thu, 17 Aug 2017 10:09:14 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [input:next 1901/1903] drivers/input/misc/axp20x-pek.c:385:1-2:
    axp_pek_id_match is not NULL terminated at line 385

CC: kbuild-all@01.org
CC: linux-input@vger.kernel.org
TO: Quentin Schulz <quentin.schulz@free-electrons.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
head:   448f587d525d4fb5bda4b521e35ad6f15050cebd
commit: 2ebdfecef50840a9c6fd6a2236a1bdf2942dc1a7 [1901/1903] Input: axp20x-pek - use driver_data of platform_device_id instead of extended attributes
:::::: branch date: 83 minutes ago
:::::: commit date: 83 minutes ago

>> drivers/input/misc/axp20x-pek.c:385:1-2: axp_pek_id_match is not NULL terminated at line 385

# https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?id=2ebdfecef50840a9c6fd6a2236a1bdf2942dc1a7
git remote add input https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
git remote update input
git checkout 2ebdfecef50840a9c6fd6a2236a1bdf2942dc1a7
vim +385 drivers/input/misc/axp20x-pek.c

58be7689 Hans de Goede  2017-06-02  380
2ebdfece Quentin Schulz 2017-08-14  381  static const struct platform_device_id axp_pek_id_match[] = {
2ebdfece Quentin Schulz 2017-08-14  382  	{
2ebdfece Quentin Schulz 2017-08-14  383  		.name = "axp20x-pek",
2ebdfece Quentin Schulz 2017-08-14  384  		.driver_data = (kernel_ulong_t)&axp20x_info,
2ebdfece Quentin Schulz 2017-08-14 @385  	},
2ebdfece Quentin Schulz 2017-08-14  386  };
2ebdfece Quentin Schulz 2017-08-14  387

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

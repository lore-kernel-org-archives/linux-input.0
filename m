From: kbuild test robot <fengguang.wu@intel.com>
Subject: [input:synaptics-rmi4 4/11] make[4]: *** No rule to make target
 `drivers/input/rmi4/rmi_f01.o', needed by `drivers/input/rmi4/built-in.o'.
Date: Wed, 28 Nov 2012 14:15:57 +0800
Message-ID: <50b5ac1d.3WARZ5TfIUdF7U71%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15331 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281Ab2K1GRM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Nov 2012 01:17:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git synaptics-rmi4
head:   0af25383d395fb5ece54b79d12d06138bf8b9836
commit: 49c28c0062548243aa0e15f181098af34bab9712 [4/11] Input: input/rmi4 - Config files and makefiles
config: make ARCH=x86_64 allmodconfig

Note: the input/synaptics-rmi4 HEAD 0af2538 builds fine.
      It only hurts bisectibility.

All error/warnings:

make[4]: *** No rule to make target `drivers/input/rmi4/rmi_f01.o', needed by `drivers/input/rmi4/built-in.o'.
make[4]: *** No rule to make target `drivers/input/rmi4/rmi_f11.c', needed by `drivers/input/rmi4/rmi_f11.o'.
make[4]: *** [drivers/input/rmi4/rmi_driver.o] Error 1
make[4]: Target `__build' not remade because of errors.
--
drivers/input/rmi4/rmi_driver.c:45:21: fatal error: rmi_f01.h: No such file or directory
compilation terminated.

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation

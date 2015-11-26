From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 10/10] HID: rmi: Make hid-rmi a transport driver for
 synaptics-rmi4
Date: Thu, 26 Nov 2015 09:43:32 +0800
Message-ID: <201511260901.oU2KNPdc%fengguang.wu@intel.com>
References: <1448496641-25457-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:22946 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133AbbKZBoW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2015 20:44:22 -0500
Content-Disposition: inline
In-Reply-To: <1448496641-25457-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: kbuild-all@01.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@syanptics.com>

Hi Andrew,

[auto build test WARNING on input/next]
[cannot apply to v4.4-rc2 next-20151124]

url:    https://github.com/0day-ci/linux/commits/Andrew-Duggan/Input-synaptics-rmi4-Synaptics-RMI4-Driver-rebased-on-4-3/20151126-081351
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/hid/hid-rmi.c:500:36: sparse: symbol 'rmi_hid_2d_sensor_data' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v4 01/10] Input: synaptics-rmi4: Add support for
 Synaptics RMI4 devices
Date: Wed, 10 Feb 2016 10:27:44 +0800
Message-ID: <201602101040.KxxuxnZe%fengguang.wu@intel.com>
References: <1455068422-11916-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:45089 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034AbcBJCaH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Feb 2016 21:30:07 -0500
Content-Disposition: inline
In-Reply-To: <1455068422-11916-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: kbuild-all@01.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>

Hi Andrew,

[auto build test WARNING on input/next]
[also build test WARNING on v4.5-rc3 next-20160209]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Andrew-Duggan/Input-synaptics-rmi4-Synaptics-RMI4-Driver/20160210-094628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/input/rmi4/rmi_bus.c:295:20-21: WARNING: Use ARRAY_SIZE

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

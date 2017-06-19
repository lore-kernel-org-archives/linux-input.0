From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2] Input: Add driver for GOODiX GTx5 series touchsereen
Date: Mon, 19 Jun 2017 21:24:27 +0800
Message-ID: <201706192107.ru8ophjW%fengguang.wu@intel.com>
References: <33339a02-dac7-9097-9ea4-3c12c7b84a59@goodix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:59105 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750905AbdFSNZa (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 09:25:30 -0400
Content-Disposition: inline
In-Reply-To: <33339a02-dac7-9097-9ea4-3c12c7b84a59@goodix.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wang Yafei <wangyafei@goodix.com>
Cc: kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, andrew@goodix.com, mouse@goodix.com, linux-kernel@vger.kernel.org

Hi Wang,

[auto build test WARNING on input/next]
[also build test WARNING on v4.12-rc5 next-20170619]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wang-Yafei/Input-Add-driver-for-GOODiX-GTx5-series-touchsereen/20170619-200451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/input/touchscreen/goodix-ts-sunrise/goodix_gtx5_i2c.c:872:3-8: No need to set .owner here. The core will do it.
--
>> drivers/input/touchscreen/goodix-ts-sunrise/goodix_ts_core.c:1335:3-8: No need to set .owner here. The core will do it.
--
>> drivers/input/touchscreen/goodix-ts-sunrise/goodix_gtx5_update.c:752:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

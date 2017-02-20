From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] add driver for cypress cy8cmbr3102
Date: Mon, 20 Feb 2017 20:05:29 +0800
Message-ID: <201702202015.pVoAzgsD%fengguang.wu@intel.com>
References: <1487586813-4122-2-git-send-email-Patrick.Vogelaar@gigatronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487586813-4122-2-git-send-email-Patrick.Vogelaar@gigatronik.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, Patrick Vogelaar <Patrick.Vogelaar@gigatronik.com>
List-Id: linux-input@vger.kernel.org

Hi Patrick,

[auto build test WARNING on input/next]
[also build test WARNING on v4.10 next-20170220]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Patrick-Vogelaar/add-driver-for-cypress-cy8cmbr3102/20170220-185014
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/input/misc/cy8cmbr3102.c:210:4-9: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

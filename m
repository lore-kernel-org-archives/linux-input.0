From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH V1 3/3] Input: new da7280 haptic driver
Date: Thu, 16 Aug 2018 14:46:01 +0800
Message-ID: <201808161448.n4U6oBQU%fengguang.wu@intel.com>
References: <662cd241e04a1e033c87d1a94c594740b594b0b6.1534384964.git.Roy.Im@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <662cd241e04a1e033c87d1a94c594740b594b0b6.1534384964.git.Roy.Im@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>
Cc: kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Support Opensource <support.opensource@diasemi.com>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Roy,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on input/next]
[also build test WARNING on v4.18 next-20180815]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Roy-Im/da7280-haptic-driver-submission/20180816-133626
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/input/misc/da7280.c:116:9-10: WARNING: return of 0/1 in function 'da7280_volatile_register' with return type bool
--
>> drivers/input/misc/da7280.c:1335:7-32: ERROR: Threaded IRQ with no primary handler requested without IRQF_ONESHOT

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

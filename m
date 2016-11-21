From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 2/4] HID: lg: make transfer buffers DMA capable
Date: Mon, 21 Nov 2016 20:05:31 +0800
Message-ID: <201611211942.OoqNaSxL%fengguang.wu@intel.com>
References: <1479725322-30863-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479725322-30863-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: kbuild-all@01.org, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

[auto build test WARNING on hid/for-next]
[also build test WARNING on v4.9-rc6 next-20161117]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Benjamin-Tissoires/HID-fix-few-non-DMA-capable-HID-transfers/20161121-185330
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/hid/hid-lg.c:780:47-53: ERROR: application of sizeof to pointer

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

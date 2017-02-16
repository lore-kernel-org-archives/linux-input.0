From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/3] Input: synaptics - allocate a Synaptics
 Intertouch device
Date: Fri, 17 Feb 2017 05:44:41 +0800
Message-ID: <201702170545.UnYJQAQK%fengguang.wu@intel.com>
References: <20170216175100.1668-3-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29638 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933087AbdBPVpL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Feb 2017 16:45:11 -0500
Content-Disposition: inline
In-Reply-To: <20170216175100.1668-3-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Benjamin,

[auto build test WARNING on input/next]
[also build test WARNING on v4.10-rc8 next-20170216]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Benjamin-Tissoires/Bind-RMI4-over-SMBus-from-PS-2/20170217-043234
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/input/mouse/synaptics.c:279:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

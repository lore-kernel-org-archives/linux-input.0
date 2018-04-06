From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 4/8] Input: elantech - split device info into a separate
 structure
Date: Fri, 6 Apr 2018 15:33:28 +0800
Message-ID: <201804061445.qVN8iyNr%fengguang.wu@intel.com>
References: <20180405132537.3218-5-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180405132537.3218-5-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>, Benjamin Berg <bberg@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20180405]
[cannot apply to input/next v4.16 v4.16-rc7 v4.16-rc6 v4.16]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Benjamin-Tissoires/Input-support-for-latest-Lenovo-thinkpads-series-80/20180406-110729
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/input/mouse/elantech.c:1665:5: sparse: symbol 'elantech_query_info' was not declared. Should it be static?
   drivers/input/mouse/elantech.c: In function 'elantech_init':
   drivers/input/mouse/elantech.c:1839:9: warning: 'error' may be used uninitialized in this function [-Wmaybe-uninitialized]
     return error;
            ^~~~~

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

From: kbuild test robot <fengguang.wu@intel.com>
Subject: [next:master 9498/10844] drivers/input/mouse/alps.c:1096:15: sparse:
 symbol 'alps_get_pkt_id_ss4_v2' was not declared. Should it be static?
Date: Sat, 11 Apr 2015 09:21:11 +0800
Message-ID: <201504110955.4uEmNJDX%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   ab738b3efaea11cf9f130c7fe9ebb7568e998fe6
commit: 3db5b9f782b50a309fe0fb89fb890f6b4f66d9ae [9498/10844] Input: ALPS - add support for SS4 touchpad devices
reproduce:
  # apt-get install sparse
  git checkout 3db5b9f782b50a309fe0fb89fb890f6b4f66d9ae
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/input/mouse/alps.c:1096:15: sparse: symbol 'alps_get_pkt_id_ss4_v2' was not declared. Should it be static?
>> drivers/input/mouse/alps.c:2343:5: sparse: symbol 'alps_update_device_area_ss4_v2' was not declared. Should it be static?
>> drivers/input/mouse/alps.c:2368:5: sparse: symbol 'alps_update_btn_info_ss4_v2' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation

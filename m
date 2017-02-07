From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 00/18] HID: Fine-tuning for several function implementations
Date: Tue, 7 Feb 2017 20:36:52 +0100
Message-ID: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:63505 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932081AbdBGTha (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Feb 2017 14:37:30 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 7 Feb 2017 20:26:54 +0100

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (18):
  Use kmalloc_array() in hid_input_field()
  Delete an error message for a failed memory allocation in open_collection()
  Use kmalloc_array() in open_collection()
  Improve another size determination in open_collection()
  Improve two size determinations in hid_open_report()
  Improve another size determination in hid_scan_report()
  Improve another size determination in hid_register_report()
  Adjust five checks for null pointers
  Return an error code only as a constant in hid_allocate_device()
  debug: Replace five seq_printf() calls by seq_putc()
  debug: Delete an unnecessary seq_printf() call in hid_dump_device()
  debug: Replace 12 seq_printf() calls by seq_puts()
  debug: Combine 11 seq_printf() calls into one call in hid_dump_field()
  debug: Adjust two function calls together with a variable assignment
  debug: Return an error code only as a constant in hid_debug_events_open()
  debug: Add some spaces for better code readability
  debug: Delete an unnecessary variable initialisation in hid_resolv_usage()
  Use seq_puts() in picolcd_debug_reset_show()

 drivers/hid/hid-core.c            |  39 ++++++-------
 drivers/hid/hid-debug.c           | 115 +++++++++++++++++++-------------------
 drivers/hid/hid-picolcd_debugfs.c |   6 +-
 3 files changed, 78 insertions(+), 82 deletions(-)

-- 
2.11.1


From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/5] HID: intel_ish-hid: various cleanups
Date: Tue, 16 May 2017 13:09:02 +0200
Message-ID: <20170516110907.3545799-1-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:52817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbdEPLJS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 May 2017 07:09:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

Hi,

I ran into a warning message during randconfig testing and spent way
too much time figuring out how to best address it. One thing led to
another and I ended up with a 5 patch series.

Please have a look at the first patch separately, it might fix an
important bug and need backporting to stable kernels, or it might
only address a harmless warning.

For the rest of the patches, please merge for 4.13 unless you
see something wrong.

      Arnd

 [PATCH 1/5] HID: intel_ish-hid: fix potential uninitialized data
 [PATCH 2/5] HID: intel_ish-hid: clarify locking in client code
 [PATCH 3/5] HID: intel_ish-hid: convert timespec to ktime_t
 [PATCH 4/5] HID: intel_ish-hid: fix format string for size_t
 [PATCH 5/5] HID: intel_ish-hid: enable compile testing

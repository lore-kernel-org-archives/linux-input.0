From: Arnd Bergmann <arnd@arndb.de>
Subject: HID: intel_ish-hid: various cleanups
Date: Thu, 18 May 2017 22:21:39 +0200
Message-ID: <20170518202144.3482304-1-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:49613 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbdERUWh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 18 May 2017 16:22:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

I ran into a warning message during randconfig testing and spent way
too much time figuring out how to best address it. One thing led to
another and I ended up with a 5 patch series.

Unforunately I screwed up the first version of the series and
had to replace the first patch, but the second version should
be much better.

Please have a look at the first patch separately, it might fix an
important bug and need backporting to stable kernels, or it might
only address a harmless warning.

For the rest of the patches, please merge for 4.13 unless you
see something wrong.


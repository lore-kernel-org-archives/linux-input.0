From: Richard Nauber <richard.nauber@googlemail.com>
Subject: [RFC] Port of hid-egalax to the unified hid-multitouch driver
Date: Sun, 06 Mar 2011 14:24:42 +0100
Message-ID: <1299417883.9645.494.camel@itzy>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60661 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab1CFNY4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Mar 2011 08:24:56 -0500
Received: by fxm17 with SMTP id 17so3384266fxm.19
        for <linux-input@vger.kernel.org>; Sun, 06 Mar 2011 05:24:55 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>

Hi everyone,
I wrote this little patch that merges hid-egalax into hid-multitouch.
(It applies to 2.6.38-rc7, but I can rebase it as you please...) The
latter driver has to gain a new quirk type (MT_QUIRK_EGALAX) for fixing
the reported ranges (X,Y and Z) and work around the corrupt packet
length (td->last_field_index).
With these changes it works like a charm for my Samsung MB30
touchscreen and by the way fixes the broken suspend/resume behavior.

So I'd like you to test it for other egalax devices and give me your
feedback on this patch.

Thanks and Greetings,
Richard

  [input-hid] Add hid-egalax driver to the unified hid-multitouch
    framework.

 drivers/hid/Kconfig          |    9 +-
 drivers/hid/Makefile         |    1 -
 drivers/hid/hid-egalax.c     |  279
------------------------------------------
 drivers/hid/hid-multitouch.c |   48 +++++++-
 4 files changed, 47 insertions(+), 290 deletions(-)
 delete mode 100644 drivers/hid/hid-egalax.c




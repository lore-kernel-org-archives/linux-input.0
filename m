From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/5] HID: asus: T100 keyboard dock support improvements
Date: Sun,  2 Jul 2017 16:34:11 +0200
Message-ID: <20170702143416.23643-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbdGBOeU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 2 Jul 2017 10:34:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Hi Jiri, Benjamin,

Here is a patch series with some further improvements for
the keyboard docks of Asus Transformer T100* 2-in-1s.

You may want to wait with merging the last patch of this series
because switching from mouse to touchpad (absolute) mode makes
the cursor movement somewhat jerky. I've a matching libinput
patch series fixing this:

https://cgit.freedesktop.org/~jwrdegoede/libinput/log/

I think it might be best to delay merging the last patch of
this kernel series until the matching libinput changes have been
accepted by libinput upstream (libinput does stable releases often,
so I expect this to become available quickly once merged).

Benjamin, the libinput series may also help with the Bluetooth
Logitech wireless touchpad which I believe some people were
complaining about when you put it in native mode. Although I'm
not sure if that was the same problem or something else.

Regards,

Hans

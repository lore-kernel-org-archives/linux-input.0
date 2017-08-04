From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend 0/1] HID: asus: Add T100CHI bluetooth keyboard dock touchpad support
Date: Fri,  4 Aug 2017 15:31:03 +0200
Message-ID: <20170804133104.19685-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752138AbdHDNbL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 4 Aug 2017 09:31:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Hi Jiri,

The libinput touchpad-code changes for dealing with bluetooth event timestamps
being unreliable have been merged in upstream libinput, so this patch which
switches the touchpad from mouse-emulation to touchpad-mt mode can be merged
now.

Thanks & Regards,

Hans

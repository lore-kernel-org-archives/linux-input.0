From: Bernard GODARD <bernard.godard@gmail.com>
Subject: HID: broken force feedback support for ACRUX gamepad
Date: Wed, 3 Aug 2011 16:06:15 +0000
Message-ID: <CAFxvmmd3NB5jtEb4TPtLuHxWC_PDUReVe1cB=nS93GfJqJmxqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63075 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549Ab1HCQGR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2011 12:06:17 -0400
Received: by eyx24 with SMTP id 24so832190eyx.33
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2011 09:06:15 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

The force feedback support for the ACRUX gamepad is broken since
2.6.38.8 and more recent kernels due to this
commit:	0ae43810976bc969ee158510c4acbe70ed136e61
The problem is simply with drivers/hid/Kconfig:
HID_ACRUX_FF should be a bool not a tristate. Otherwise the support
for the force feedback is not compiled into the module hid-axff.

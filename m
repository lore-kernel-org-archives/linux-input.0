From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: ELAN1000 not working on Asus Zenbook UX305CA-EHM1
Date: Fri, 20 Nov 2015 09:52:14 +0100
Message-ID: <CAN+gG=EHEtTyWUQsYJ6HDMr-O_D6XVYWoWkMTS9wqeL2TDZLnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37084 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161067AbbKTIwP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2015 03:52:15 -0500
Received: by wmww144 with SMTP id w144so11833334wmw.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2015 00:52:14 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Duson Lin <dusonlin@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

Hi Duson,

A user reported a non working touchpad on his Asus Zenbook UX305CA.
The touchpad is the ELAN1000 which has been added to v4.3:

https://bugzilla.redhat.com/show_bug.cgi?id=1281990

In the logs, I see:

[   16.636101] i2c_designware i2c_designware.0:
i2c_dw_handle_tx_abort: lost arbitration
[   16.636110] elan_i2c i2c-ELAN1000:00: writing cmd (0x0005) failed: -11
[   16.636113] elan_i2c i2c-ELAN1000:00: device reset failed: -11
[   16.636115] elan_i2c i2c-ELAN1000:00: device initialize failed: -11

I wonder if you could have a look at this and tell us whether the
touchpad is failing (I mean the driver) or if the i2c bus driver is at
fault.

Cheers,
Benjamin

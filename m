From: Daniel Nicoletti <dantti12@gmail.com>
Subject: Apple Magic TrackPad battery level
Date: Thu, 24 Nov 2011 08:49:32 -0200
Message-ID: <CACo8zOcBgqD_iGpH=dQuEbM2DuMXD-hZCO2R0gfStMjgpZBxQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46701 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab1KXKtd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Nov 2011 05:49:33 -0500
Received: by iage36 with SMTP id e36so2818539iag.19
        for <linux-input@vger.kernel.org>; Thu, 24 Nov 2011 02:49:32 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,
I've been following some of the discussions about
battery level stuff on bluetooth devices. As
recently I bought a bt device with this capability
and I also have an apple keyboard that can
do this too.

Most people I talked believed the device itself
send events with the battery status, and after
some investigation I found how to probe the
device. But I have a problem (of cours), running
hcidump it shows that my request is the same
as Mac OSX does it sends a GetFeature(report_id)
* I runned PacketLogger.app to be sure it worked the way HID spec says so.
which turns in 0x43 0x47 (0x47 being the report id),
but the call does not return the value, so I wonder
that maybe some code in hid-core or usbhid-core
is filtering the data somehow, or maybe I even found
a bug on the hidraw stuff.

My code added to hid-magicmouse.c into the probe function:
    __u8 *buf;
    unsigned char report_number = 0x47;

    buf = kmalloc(3 * sizeof(__u8), GFP_KERNEL);
    if (!buf) {
        ret = -ENOMEM;
        goto err_stop_hw;
    }

    memset(buf, 0, sizeof(buf));

    ret = hdev->hid_get_raw_report(hdev, report_number, buf,
sizeof(buf), HID_FEATURE_REPORT);
    if (ret != -EIO && ret != sizeof(report_number)) {
        hid_err(hdev, "unable to request BATTERY feature data (%d)\n", ret);
        goto err_stop_hw;
    }
    dbg_hid("PROBING BATTERY (%d), (%s), (%d)\n", buf[0], buf, buf[1]);


----- It produces the following on the hcidump which is what I need, but the buf
only contains the 0x43 value (which is espected as the report number
is stored there);

< ACL data: handle 11 flags 0x02 dlen 6
    L2CAP(d): cid 0x0042 len 2 [psm 17]
      HIDP: Get report: Feature report
      47
> ACL data: handle 11 flags 0x02 dlen 7
    L2CAP(d): cid 0x0040 len 3 [psm 17]
      HIDP: Data: Feature report
      47 44

As you can see my battery at the report 47 is 44 (68%), also the
hcidump show some random stuff
before the get and response but I guess it might be part of the protocol.

Any hints on how do I get the data that the device is actually sending now?

Thanks.

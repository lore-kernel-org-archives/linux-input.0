From: Andrew Kanner <kanner@mail.ru>
Subject: Elektex bluetooth keyboard incorrect device class
Date: Mon, 6 Mar 2017 11:17:39 +0300
Message-ID: <20170306081738.GA5857@gentooxa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.181.128]:37215 "EHLO
        fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752580AbdCFIV2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Mar 2017 03:21:28 -0500
Received: from smtp2.mail.ru (smtp2.mail.ru [94.100.179.91])
        by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 850AD18219B8C
        for <linux-input@vger.kernel.org>; Mon,  6 Mar 2017 11:05:42 +0300 (MSK)
Received: from [95.131.89.227] (port=59056 helo=gentooxa)
        by smtp2.mail.ru with esmtpa (envelope-from <kanner@mail.ru>)
        id 1ckneF-0008As-Nn
        for linux-input@vger.kernel.org; Mon, 06 Mar 2017 11:05:40 +0300
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I'm writing the duplicate message here, because got no answer in the
following mailing list: linux-bluetooth@vger.kernel.org
(https://www.spinics.net/lists/linux-bluetooth/msg69655.html)

I'm trying to get Elektex (G-Tech) Bluetooth Smart Fabric keyboard
work on Linux (latest kernel).

This keyboard have been supported by Android devices via some
unofficial apk (I only found footprints of using some Bluez functions
and native Android keyboard + device key mapping in sources). But when
I tried to connect it to Linux, I saw that it's device class is
0x500204 (like a cell phone) in btmon output and it's naturally not
determined as a HID device.

Could someone direct me how to get this keyboard work like HID device?
Where should I start from?

Here is some minimal info about the device:

# hcitool scan
Scanning ...
        00:16:C1:00:6A:C8       keyboard
# sudo hcitool info 00:16:C1:00:6A:C8
Requesting information ...
        BD Address:  00:16:C1:00:6A:C8
        OUI Company: Eleksen Ltd (00-16-C1)
        Device Name: keyboard
        LMP Version: 1.1 (0x1) LMP Subversion: 0x5e1
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x00 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log>
# sudo hcitool cc --role=m 00:16:C1:00:6A:C8
Connections:
        < ACL 00:16:C1:00:6A:C8 handle 21 state 1 lm MASTER
# sudo hcitool con

(latest command return active connections, but after several seconds
the device is disconnected by host)


--
With best regards,
Andrew Kanner

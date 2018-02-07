From: Peter Suetterlin <pit@astro.su.se>
Subject: Lenovo T460p touchpad and kernel 4.15.0
Date: Wed, 7 Feb 2018 12:31:30 +0000
Message-ID: <20180207123130.GA24827@dubshen.astro.su.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-prod-route02.it.su.se ([77.238.35.140]:54540 "EHLO
        mail-prod-route02.it.su.se" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753731AbeBGMlL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 7 Feb 2018 07:41:11 -0500
Received: from e-mailfilter02.sunet.se (e-mailfilter02.sunet.se [IPv6:2001:6b0:8:2::202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail-prod-route02.it.su.se (Postfix) with ESMTPS id 3zc10M72lXzyt9
        for <linux-input@vger.kernel.org>; Wed,  7 Feb 2018 13:31:31 +0100 (CET)
Received: from smtp.su.se (mail-prod-smtp03.it.su.se [130.237.181.83])
        by e-mailfilter02.sunet.se (8.14.4/8.14.4/Debian-8+deb8u2) with ESMTP id w17CVUC8167264
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-input@vger.kernel.org>; Wed, 7 Feb 2018 13:31:31 +0100
Received: from dubshen.astro.su.se (dubshen.astro.su.se [130.237.166.72])
        by smtp.su.se (Postfix) with ESMTPS id 3zc10L5lZ0zyty
        for <linux-input@vger.kernel.org>; Wed,  7 Feb 2018 13:31:30 +0100 (CET)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


  Hi,

After switching to kernel 4.15.0 (openSUSE Tumbleweed 20180203) the touchpad of
my Lenovo T460p stops working after a resume/suspend cycle.

Comparing to old logfiles I found a notice

  "Your touchpad (PNP: LEN2018 PNP0f13) says it can support a different bus. If
  i2c-hid and hid-rmi are not used, you might want to try setting
  psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org."

That's why I'm writing here now.

The old logfile (from kernel 4.14.15) had this notice from psmouse:

 kernel: psmouse serio1: synaptics: queried max coordinates: x [..5676], y [..4758]
 kernel: psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1096..]
 kernel: psmouse serio1: synaptics: Your touchpad (PNP:
     LEN2018 PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are
     not used, you might want to try setting psmouse.synaptics_intertouch to 1 and
     report this to linux-input@vger.kernel.org.
 kernel: psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf006a3/0x943300/0x12e800/0x10000, board id: 3053,fw id: 2010421
 kernel: psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0

rmi was not used in this version

Booting 4.15.0 shows the same, just without the notice, but further down also

 kernel: input: Synaptics TM3053-006 as /devices/rmi4-00/input/input23

During resume I then get the following:

 kernel: rmi4_smbus 8-002c: failed to get SMBus version number!
 kernel: rmi4_physical rmi4-00: rmi_driver_reset_handler: Failed to read current IRQ mask.
 kernel: rmi4_f01 rmi4-00.fn01: Failed to restore normal operation: -16.
 kernel: rmi4_f01 rmi4-00.fn01: Resume failed with code -16.
 kernel: rmi4_physical rmi4-00: Failed to suspend functions: -16
 kernel: rmi4_smbus 8-002c: Failed to resume device: -16
 kernel: rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03 TX register (-16).

which likely(?) is the reason for the non-working touchpad.
(The trackpoint is affected, too, BTW, but I don't use it)

If you need more info let me know (please via direct mail, I'm not on the list)

Regards,

  Pit
  
-- 
Dr. Peter "Pit" Suetterlin                 http://www.astro.su.se/~pit
Institute for Solar Physics
Tel.: +34 922 405 590  (Spain)             P.Suetterlin@royac.iac.es
      +46 8 5537 8558  (Sweden)            Peter.Suetterlin@astro.su.se

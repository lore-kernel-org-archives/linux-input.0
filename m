From: Kamil Iskra <kamil.54002@iskra.name>
Subject: Synaptics RMI4 on HP EliteBook 820 G4
Date: Sat, 8 Jul 2017 12:57:17 -0500
Message-ID: <20170708175717.GA7613@scooby.iskra.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.iskra.name ([168.235.69.87]:36006 "EHLO mail.iskra.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753043AbdGHSTu (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 8 Jul 2017 14:19:50 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

After upgrading the kernel to 4.12 the synaptics driver on my HP EliteBook
820 G4 laptop informed me that:

psmouse serio3: synaptics: The touchpad can support a better bus than the too old PS/2 protocol. Make sure MOUSE_PS2_SYNAPTICS_SMBUS and RMI4_SMB are enabled to get a better touchpad experience.

I enabled RMI4_SMB and the message changed to:

psmouse serio3: synaptics: Your touchpad (PNP: SYN3054 SYN0100 SYN0002 PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.

I rebooted with psmouse.synaptics_intertouch=1 and I'm now getting:

psmouse serio3: synaptics: Trying to set up SMBus access
rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3146-001, fw id: 2004303

For the sake of completeness, before making these changes the driver would
identify it as:

psmouse serio3: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf00123/0x840300/0x2e800/0x0, board id: 3146, fw id: 2004303

I'm emailing you this info as instructed by the kernel message.  The
touchpad seems to be working fine over RMI4 (then again, so it did before
over PS2).  Let me know if you need any additional info.

Regards,

Kamil

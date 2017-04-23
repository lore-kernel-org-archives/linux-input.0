From: Julian Exner <jexner@techfak.uni-bielefeld.de>
Subject: Input: mouse: Trackpoint middle button not recognized on Thinkpad
 E470
Date: Sun, 23 Apr 2017 13:36:25 +0200
Message-ID: <13710506-2225-9f81-40e3-7463ac829860@techfak.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smarthost.TechFak.Uni-Bielefeld.DE ([129.70.137.17]:58498 "EHLO
        smarthost.TechFak.Uni-Bielefeld.DE" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1045131AbdDWLov (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 23 Apr 2017 07:44:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: aduggan@synaptics.com

The middle trackpoint button on the Thinkpad E470 (20H2) is not 
recognized. The psmouse module warns about "failed to get extended 
button data".

I tried to dive a bit deeper into trackpoint.c and track down the issue:

- trackpoint_read for TP_EXT_BTN fails.
- This read consists of two ps2_commands, first TP_COMMAND and then the 
actual TP_EXT_BTN command
- The second ps2_command fails.
- In __ps2_command, it's the first ps2_sendbyte that fails.
- In ps2_sendbyte, serio_write returns 0. Waiting for the 
acknowledgement does not timeout. But ps2dev->nak is 0xfe.
- Therefore ps2_sendbyte fails.

 From there the whole stack unwinds, "failed to get extended button 
data" is produced and button_info is set to 0. And finally

__set_bit(BTN_MIDDLE, psmouse->dev->keybit);

is not called. Manually calling it, or setting button_info to 0x33, 
makes the middle button functional. Of course that's not a general solution.

Additionally, when loading the psmouse module with proto=imps the middle 
mouse button is detected as discussed here: 
https://bugs.freedesktop.org/show_bug.cgi?id=100694

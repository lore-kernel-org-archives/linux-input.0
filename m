From: Anthony Agresta <me@anthonyagresta.com>
Subject: Bug: hid-xinmo: Both joysticks register as player 1
Date: Fri, 4 Sep 2015 10:43:56 -0700
Message-ID: <CAGJwqMLDHcXa3UDbeTfEj-b9++xxmFduJaCUsZX0bZcBYSS_jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tmde01oc.mail2world.com ([209.67.128.182]:3744 "EHLO
	tmde01oc.mail2world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbbIDSBj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Sep 2015 14:01:39 -0400
Received: by vkbc123 with SMTP id c123so15496705vkb.3
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2015 10:44:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi folks.

I recently upgraded from 3.17.6-1 -> 4.1.6-1, and my joystick stopped
working correctly.
I'm using some admittedly poorly-behaved hardware, with the hid-xinmo driver.

The hardware is a dual-joystick + 22-button USB controller, for use in
a MAME cabinet:
http://www.hollandcomputers.com/store/pc/Arcade-Game-Controller-USB-Interface-PCB-Kit-for-PC-MAME-PS3-to-Mame-2517p6687.htm

On the current hid-input driver, both joysticks control player 1's X
and Y axes, which is no good.

I commented out these lines in /drivers/hid/hid-input.c (around line
619) and it solved my problem:

    case HID_GD_RX: case HID_GD_RY: case HID_GD_RZ:
        /* if (field->flags & HID_MAIN_ITEM_RELATIVE)
            map_rel(usage->hid & 0xf);
        else
            map_abs_clear(usage->hid & 0xf);
        break; */

These were added in commit # 79346d620e9de87912de73337f6df8b7f9a46888 ,
to fix a quirk of an Atmel 840B digitizer by forcing the axes to the
first X and Y.
Unfortunately it looks like it has broken my device.

I'm content to run with a patched kernel for my own personal use,
but it might be good to figure out another way to work around the
Atmel 840B's quirk
without breaking the Xin-Mo dual joystick adapter.

I'm not super familiar with the driver, so I don't have a patch
prepared at the moment.
Please let me know if any further information would be useful.

Thanks,

Anthony Agresta

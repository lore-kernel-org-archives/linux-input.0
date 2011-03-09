From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: FW: [Bug 30792] New: MosArt touchscreen relative motion since kernel
 upgrade
Date: Wed, 9 Mar 2011 11:53:51 -0800
Message-ID: <20110309195350.GA9604@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57705 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab1CITx6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2011 14:53:58 -0500
Received: by qwd7 with SMTP id 7so675195qwd.19
        for <linux-input@vger.kernel.org>; Wed, 09 Mar 2011 11:53:58 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: james.sharam@gmail.com, Linux Input <linux-input@vger.kernel.org>

Forwarding since Benjamin does not seem to have bugzilla account...

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Wed, 9 Mar 2011 10:25:31 GMT
From: bugzilla-daemon@bugzilla.kernel.org
To: dmitry.torokhov@gmail.com
Subject: [Bug 30792] New: MosArt touchscreen relative motion since kernel upgrade

https://bugzilla.kernel.org/show_bug.cgi?id=30792

           Summary: MosArt touchscreen relative motion since kernel
                    upgrade
           Product: Drivers
           Version: 2.5
    Kernel Version: 2.6.37.2 and 2.6.37.3
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Input Devices
        AssignedTo: drivers_input-devices@kernel-bugs.osdl.org
        ReportedBy: james.sharam@gmail.com
        Regression: No


I have a laptop with a MosArt touchscreen and since upgrading to 2.6.37.2 it
hasn't been behaving correctly.

Motion since the update is relative rather than absolute. For example, when I
touch part of the screen, nothing happens, the cursor doesn't jump to where my
finger presses. However, when I touch the screen and drag my finger the mouse
moves around in the same direction as my finger moves, but doesn't move to
where my finger is.

It seems to be behaving like a touchpad rather than like a touchscreen.

I think this is related to commit c64f6f934c7490faff76faf96217066a1b3570a0
which changes over the driver for the touchscreen to use hid-mosart.

Is this likely to be a configuration issue with the new driver or a bug in the
driver?

Thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.

----- End forwarded message -----

-- 
Dmitry

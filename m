From: Giedrius Statkevicius <giedrius.statkevicius@gmail.com>
Subject: Hp 3d driveguard seems to be sending events through the keyboard
 bus - should atkbd be modified to ignore that?
Date: Thu, 16 Oct 2014 19:05:01 +0300
Message-ID: <543FECAD.5030104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:54385 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbaJPQF1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Oct 2014 12:05:27 -0400
Received: by mail-la0-f49.google.com with SMTP id q1so3125679lam.22
        for <linux-input@vger.kernel.org>; Thu, 16 Oct 2014 09:05:26 -0700 (PDT)
Received: from [192.168.1.89] (78-57-189-147.static.zebra.lt. [78.57.189.147])
        by mx.google.com with ESMTPSA id n7sm2453348lae.11.2014.10.16.09.05.24
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Oct 2014 09:05:24 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,
In some hp laptops there is a functionality called hp 3d driverguard
which is basically a accelerometer that detects free fall. It seems
that on some laptops a keyboard button press event is generated when
accelerometer's values change and ofc the scan code is not recognized
by atkbd (and it shouldn't be as it's not a real key). The result of
this is that the system log gets filled with these messages:

[ 9163.578181] atkbd serio0: Unknown key pressed (translated set 2, code 0xa8 on isa0060/serio0).
[ 9163.578189] atkbd serio0: Use 'setkeycodes e028 <keycode>' to make it known.

The range of scan codes seem to be from 0xa5 to 0xa8. In my opinion,
these scan codes on hp laptops with this future should definitely be
ignored because they are handled by the 'hp_accel' driver. For some
reason, the accelerometer sends the events through the keyboard bus too.

I've filled a bug report here:
https://bugzilla.kernel.org/show_bug.cgi?id=84941

What does everyone else think about ignoring these scan codes for
laptops with this particular feature?

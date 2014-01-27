From: Lauri Peltonen <lauri.peltonen@gmail.com>
Subject: HID_REQ_GET_REPORT and report not filled during hid_pidff_init
Date: Mon, 27 Jan 2014 21:31:53 +0200
Message-ID: <CAMvWtwT_J7rL1yFXZ3PyK1EEmmd=z3CgRUtQcgG+Yeh1tcWNrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:33767 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbaA0Tby (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jan 2014 14:31:54 -0500
Received: by mail-ve0-f175.google.com with SMTP id c14so3719206vea.20
        for <linux-input@vger.kernel.org>; Mon, 27 Jan 2014 11:31:54 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz

Hi.

I'm making some enhancements to hid/usbhid/hid-pidff.c to support more
force feedback devices, but I've encountered some weird behaviour. I'm
not sure whether it's a bug or something else.

My changes depend on knowing some device information (like memory) in
the initialization phase, and luckily hid-pidff reads the info from
PID_POOL report in hid_pidff_init -> pidff_reset. [1] and [2]

However, I noticed that the report struct never gets filled (all
zeros), even though with usbmon I can see the ctrl message out and the
report coming in with correct data (300 bytes of memory etc). I
managed to locate the line which causes the report to be dropped in
hid/hid-core.c , in hid_input_repor(..)t checking for
driver_input_lock. [3] Commenting out the following lines "fixes" the
issue, and the struct gets filled correctly. Anyways, I think that is
not a real solution.

if (down_trylock(&hid->driver_input_lock))
 return -EBUSY;

Now, I wonder if there is a reason why the locking fails? Is the
driver locked during the initialization and hid_hw_request(...
HID_REQ_GET_REPORT) cannot be used? If that is so, what is the correct
way to read device reports during the init? And does the hid-pidff
driver ever read the pool report correctly, or is this just with my
Saitek device?

I'm using kernel 3.13.

Best regards, Lauri Peltonen

[1] http://lxr.free-electrons.com/source/drivers/hid/usbhid/hid-pidff.c#L1268
[2] http://lxr.free-electrons.com/source/drivers/hid/usbhid/hid-pidff.c#L1172
[3] http://lxr.free-electrons.com/source/drivers/hid/hid-core.c#L1392

-- 
Lauri Peltonen
lauri.peltonen@gmail.com

From: Daniel Martin <consume.noise@gmail.com>
Subject: Why do we ignore constant fields?
Date: Wed, 23 Sep 2015 15:42:13 +0200
Message-ID: <CADscph08sZjC0K=2aJ3StR6OTmwzF4H=cjJDe3S8+uMba-Suqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33462 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbbIWNmO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2015 09:42:14 -0400
Received: by ykft14 with SMTP id t14so41474140ykf.0
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2015 06:42:13 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi,

why do we skip constant fields (HID_MAIN_ITEM_CONSTANT) in hid-input
and hid-core?

In the "Device Class Definition for Human Interface Devices" (v1.11)
one can read:
    "Constant indicates the item is a static read-only field in a
report and cannot be modified (written) by the host."

(As an HID noob) I'm interpreting this as:
- The values we see in this field are not constant per se as the
device (firmware) may change it, but we can't with a command.

To give a more practical hint - why I'm asking. I've had a look at the
Type Cover of a MS Surface 2. Here the touchpad doesn't do multitouch.
Within the report descriptor is Input(4), Application
(Digitizers.TouchPad), having the ContactID field as constant tagged.
Now, I just removed the constant checks from hid-{core,input} plus a
few other tweaks and hid-multitouch handles it fine with up to 3
contacts.

Can't we remove those checks?


Cheers,
    Daniel

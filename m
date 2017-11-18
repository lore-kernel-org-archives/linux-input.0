From: Tomasz Kramkowski <tk@the-tk.com>
Subject: Re: [PATCH] HID: elecom: fix the descriptor of the EX-G trackball
Date: Sat, 18 Nov 2017 22:27:26 +0000
Message-ID: <20171118222726.GA14579@gaia.local>
References: <CAGqt0zzPC56sU5=GDS=FkwpTcnjoHotwhOZQ8bEf01=ePObk_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from erebus.the-tk.com ([109.74.205.187]:45576 "EHLO
        erebus.the-tk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763756AbdKRWeJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 17:34:09 -0500
Content-Disposition: inline
In-Reply-To: <CAGqt0zzPC56sU5=GDS=FkwpTcnjoHotwhOZQ8bEf01=ePObk_A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yuxuan Shui <yshuiv7@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Since the device only has 6 physical buttons, I don't think unmasking
all 8 bits in the HID report descriptor is appropriate. If you do that
then userspace sees a mouse with 8 buttons and you never know when
software might actually behave differently depending on that number. (I
can imagine fancy mouse configuration program which might allow mouse
button remapping which would enable more button options depending on the
number of mouse buttons.)

I think some work could be done to modify the HID report descriptor
based on which model of trackball the code is working on. (It looks like
ELECOM used very similar descriptors across the board.)

I was going to do this just now actually but then I noticed that someone
had beat me to the punch with the EX-G (I was already surprised when I
found someone had patched the HUGE and DEFT).

On that note, here's some code I wrote a few months ago to address this
specific problem on this specific mouse and adapted just yesterday in
order to begin further work on the driver:

Feel free to re-use bits of it:

diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index 54aeea57d209..5af0de38db2c 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -31,6 +37,17 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
                        rdesc[47] = 0x00;
                }
                break;
+       case USB_DEVICE_ID_ELECOM_M_XT3URBK:
+               if (*rsize >= 32 && rdesc[12] == 0x95 && rdesc[13] == 0x05 &&
+                   rdesc[14] == 0x75 && rdesc[15] == 0x01 &&
+                   rdesc[20] == 0x29 && rdesc[21] == 0x05 &&
+                   rdesc[30] == 0x75 && rdesc[31] == 0x03) {
+                       hid_info(hdev, "Fixing up Elecom M-XT3URBK report descriptor\n");
+                       rdesc[13] = 0x06;
+                       rdesc[21] = 0x06;
+                       rdesc[31] = 0x02;
+               }
+               break;

(Note: I just pulled this out of a diff with a bunch of other changes so
it might not apply cleanly.)

Aside from the naming of the PID macro, this should work just fine (in
fact, I tested it).

If you're wondering why I didn't publish this patch many months (a
year?) ago when I first wrote it, the reason is that I noticed that the
mouse has a FEATURE report.

I had thought that this rather bizarre FEATURE report could be used to
do something with the 4 other weird INPUT reports that the device has.

Upon further inspection of the FEATURE report I can't get it to actually
do anything AT ALL. I also noticed that the OSX mouse software Elecom
provides for this mouse doesn't actually touch that FEATURE report (or
well, I poked around in it using radare2, it would be helpful if someone
who has a windows/OSX machine and this mouse could confirm this but
after asking around, I couldn't find any volunteers). This FEATURE
report seems to have been a dead end in the end.

Shows you what happens when you're lazy and put things off until the
next day (or year)...

P.S. Apologies if I missed anything out or added anything extra to CC,
I've had to reply to this email without the original message by piecing
the information together out of the MHonArc header in the spinics.net
archive. This seems to be the only downside of mailing lists.

-- 
Tomasz Kramkowski | GPG: 40B037BA0A5B8680 | Web: https://the-tk.com/

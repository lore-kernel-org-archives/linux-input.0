From: Tomasz Kramkowski <tk@the-tk.com>
Subject: [PATCH v2 0/2] patches for Innomedia INNEX GENESIS/ATARI adapter
Date: Tue, 14 Feb 2017 23:14:31 +0000
Message-ID: <20170214231433.27060-1-tk@the-tk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from erebus.the-tk.com ([109.74.205.187]:58272 "EHLO
        erebus.the-tk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdBNXVZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Feb 2017 18:21:25 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Kramkowski <tk@the-tk.com>

I apologise sincerely for sitting on these patches for so long, aside from
other tasks I was busy with, I have found it very difficult to try to correctly
interpret the HID specification on this topic and then to try to word my
explanation below.

As agreed on the list, I have looked into the patch provided on the
bugzilla bug #68621 and have verified that it does in fact fix the issue
with the adapter.

This v2 patch set contains the original patch provided by Valtteri and
an additional patch to make the device fully operational.

As mentioned in a prior email, not dropping the out of range value
produces expected results from the resulting joydev file (when used with
jstest). The evdev file (when tested with evtest) correctly reports a
minimum of -1 and a maximum of 1 but also returns events with values of
-2 and 1. I'm not too sure how this will affect certain applications but
from my tests the device works fine despite this.

However, I'm not entirely sure that replacing the other fix with this
fix is completely correct, I'll try to explain my reasoning:

Firstly, the value reported by the device is still unusual and does not
correctly represent the state of the device.

The next point is a bit more confusing so I'll try to go over my
reasoning:

This new patch is based on the idea that "null values should not be
ignored when the 'No Null Position/Null State' flag is 0."

This contradicts §5.10 of the HID 1.11 specification which states:

"If an 8-bit field is declared and the range of valid values is 0 to
0x7F then any value between 0x80 and 0xFF will be considered out of
range and ignored when received. The initialization of null values in a
report is much easier if they are all the same."

This sentence even in context appears to make no mention of the "No Null
Position/Null State" bit which seems to suggest that all values which
are out of logical range should be ignored.

I think this sentence does not contradict §6.2.2.5 (page 31) which
states this about the "No Null Position/Null State" bit:

"Indicates whether the control has a state in which it is not sending
meaningful data."

Which suggests that leaving the bit unset means "the control is always
sending meaningful data" as this can simply be interpreted to mean that
the control should never be reporting out-of-range values, not that out
of range values should stop being ignored.

However, part of the Universal Serial Bus HID Usage Tables document
appears to contradict this interpretation to some extent.
§A.4 (page 132) states:

"The No Null Position flag indicates that there is never a state in
which it is not sending meaningful data. The returned values are Null =
No event (outside of the Logical Minimum / Logical Maximum range) 1 =
Stat Not Ready, 2 = Stat Ready, or 3 = Err Not a loadable character."

Which suggests that the control would report a null value despite the
"No Null Position" flag. However, this seems to conflict with an earlier
mention of the "Stat Not Ready" usage in §3.4.2.1 which states:

"The array field never returns an index of NULL because one usage is
always valid. An example is Stat Not Ready on the Alphanumeric Display
page."

The two other annotated examples mentioning this flag (§A.3.1, §A.3.2)
do not have the same contradictory wording suggesting that this was
possibly a mistake.

Personally I am not entirely sure I am interpreting everything
correctly, but it seems that the "No Null Position/Null State" bit is
not prescriptive on how the data should be handled but rather
descriptive of what data should be expected.

-- 
Tomasz Kramkowski

Tomasz Kramkowski (1):
  HID: usbhid: add quirk for innomedia INNEX GENESIS/ATARI adapter

Valtteri Heikkilä (1):
  HID: reject input outside logical range only if null state is set

 drivers/hid/hid-ids.h           | 3 +++
 drivers/hid/hid-input.c         | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 3 files changed, 5 insertions(+)

-- 
2.11.0


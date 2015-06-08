From: simon@mungewell.org
Subject: Handling Controllers with Acc/Gyro/Mag via HID system
Date: Mon, 8 Jun 2015 11:41:12 -0400
Message-ID: <195dff9bd065db7e618280cb7c6eb5a9.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:36920 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbbFHPlO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jun 2015 11:41:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Frank Praznik <frank.praznik@oh.rr.com>

Hi all,
I'm in the process of fixing the HID descriptor for the PS3 Move
Controller. which has a particularly convoluted layout for it's
Accelormeters, Gyros and Magnetometers involving 2 sets of data per output
report.

https://github.com/nitsch/moveonpc/wiki/Input-report

The plan is/was to massage the HID descriptor so the first set of
Accels/Gyro/Mag appear in a set a axis, as a simple way of getting to this
data.

The Magnetometers are only 12 bits, and if 'we' want the HID system to be
able to process these as an axis the data needs to be shuffled. Previously
for the Sony SixAxis Accels was done in 'sony_raw_event'.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-sony.c?id=refs/tags/v4.1-rc7#n1035


My reshuffle would be:
---
                /* Need to fix order and shared nibble of 12bit Temp/Mags */
                /* 8e 4. .. .. .. .. -> Temp = 0x08E4 */
                /* .. .1 51 .. .. .. -> MagX = 0x0151 */
                /* .. .. .. 02 1. .. -> MagZ = 0x0021 */
                /* .. .. .. .. .2 98 -> MagY = 0x0298 */

                __u8 tmp;
                tmp = rd[38];
                rd[38] = (((rd[37] & 0xF0) >> 4) | ((rd[39] & 0x0F) << 4));
                rd[37] = (((tmp & 0xF0) >> 4) | ((rd[37] & 0x0F) << 4));
                rd[39] = (((rd[39] & 0xF0) >> 4) | ((tmp & 0x0F) << 4));

                tmp = rd[41];
                rd[41] = (((rd[40] & 0xF0) >> 4) | ((rd[42] & 0x0F) << 4));
                rd[40] = (((tmp & 0xF0) >> 4) | ((rd[40] & 0x0F) << 4));
                rd[42] = (((rd[42] & 0xF0) >> 4) | ((tmp & 0x0F) << 4));
---

This works, however I have noticed that this affects/reshuffles the output
of '/dev/hidraw0', which would 'corrupt' the data going into the existing
user-mode drivers (such as psmoveapi).

Is there a 'better' place/way to reshuffle this data, or is this just how
it needs to be?

Given that more controllers are coming with 'motion' controls, is there a
framework in place for unifying support?

Cheers,
Simon.





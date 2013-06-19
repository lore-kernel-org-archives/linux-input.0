From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Posiflex 0d3a:a000 touchscreen press not recognized in kernel
 3.9.4
Date: Wed, 19 Jun 2013 17:56:56 +0200
Message-ID: <51C1D4C8.5040201@gmail.com>
References: <51C159C5.7070702@gmx.de> <CAN+gG=HCREVXCsQjGjyJApR=U=TO4Kvaa1s+X-UEVe6akyj-7Q@mail.gmail.com> <51C17882.4050206@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3568 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756651Ab3FSP5E (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Jun 2013 11:57:04 -0400
In-Reply-To: <51C17882.4050206@gmx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jan Kandziora <jjj@gmx.de>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Jan,

On 06/19/2013 11:23 AM, Jan Kandziora wrote:
> Am 19.06.2013 09:50, schrieb Benjamin Tissoires:
>>
>> Ok, I will need at least the dmesg log and the output of hid-recorder
>> [1] if your device is handled through hid-generic.
>> Hid-replay will then allow me to virtually plug your device on my
>> laptop so that I can replay and find out why the btn_left events are
>> not emitted anymore.
>>
> Logs are attached. I've first pressed onto the center of the touch, then
> onto the lower right corner, then drawn a wave line from upper left to
> lower left, then from lower left to upper right.
> 
> Thanks for your help.
> 
> 	Jan
> 

Thanks for the logs. The problem comes from a commit introduced in 3.3 which discards the BTN_LEFT information.

If possible, can you apply and test the following patch?

Cheers,
Benjamin

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 19 Jun 2013 17:49:05 +0200
Subject: [PATCH] HID: input: fix false positive out of range values

Commit 6da7066906e977d42104a859c490f5f9a300488c introduced in 3.3
"HID: ignore absolute values which don't fit between logical min and max"
prevents some Posiflex touch screen to work because they do not provide
logical min and max for their buttons.
Thus, logical min and max are at 0, discarding the buttons events, and
preventing the device to report appropriate X Y.

Adding a check on "min < max" solves the problem.

Reported-by: Jan Kandziora <jjj@gmx.de>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c526a3c..930f1bb 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1045,6 +1045,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 	 * section 5.10 and 6.2.25
 	 */
 	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
+	    (field->logical_minimum < field->logical_maximum) &&
 	    (value < field->logical_minimum ||
 	     value > field->logical_maximum)) {
 		dbg_hid("Ignoring out-of-range value %x\n", value);
-- 
1.8.2.1


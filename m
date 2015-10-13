From: rnd@nic.fi
Subject: [PATCH] HID: reject input outside logical range only if null state
 is set
Date: Tue, 13 Oct 2015 08:59:32 +0300
Message-ID: <01431f646f00a0ce0995e07578b61bae@be13.mail.saunalahti.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:51167 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbbJMGFF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2015 02:05:05 -0400
Received: from cfwo-22-2.mail.saunalahti.fi (cfwo-22.mail.saunalahti.fi [62.142.5.121])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id DF4E64002E
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2015 08:59:32 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by cfwo-22-2.mail.saunalahti.fi (Postfix) with ESMTP id CDB8120076
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2015 08:59:32 +0300 (EEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org

Kernel 3.19.0 one-line fix for an issue in drivers/hid/hid-input.c wher=
e=20
USB HID control null state flag is not checked when rejecting inputs=20
outside logical minimum-maximum range. The check should be made as per=20
USB HID specification 1.11, section 6.2.2.5, p.31. I have no resources=20
for large-scale testing, but this fixes problems with the game=20
controller I have (INNEX NES Controller USB).

More details: https://bugzilla.kernel.org/show_bug.cgi?id=3D68621


Signed-Off-by: Valtteri Heikkil=C3=A4 <rnd@nic.fi>
--- a/drivers/hid/hid-input.c 2015-05-25 09:58:49.743527141 +0800
+++ b/drivers/hid/hid-input.c 2015-05-25 11:04:13.201191432 +0800
@@ -1097,6 +1097,7 @@
* don't specify logical min and max.
*/
if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
+ (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
(field->logical_minimum < field->logical_maximum) &&
(value < field->logical_minimum ||
value > field->logical_maximum)) {



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

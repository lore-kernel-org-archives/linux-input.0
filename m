From: Neubert Stefan <NES@hekatron.de>
Subject: [eGalax] touchscreen hid-multitouch not working
Date: Fri, 17 Jun 2016 17:30:45 +0200
Message-ID: <7516900B5A02D0418146BC21F0D1804B81C9AAACC5@SRV-EXC2.heka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.hekatron.com ([217.6.209.182]:46735 "EHLO mail.hekatron.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139AbcFQPkw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2016 11:40:52 -0400
Content-Language: de-DE
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

I have one of those eGalax usb touchcontroller with VID 0x0eef and PID 0x0001.
With Linux raspberrypi 4.4.13-v7+ #1 SMP Thu Jun 16 14:39:49 CEST 2016 armv7l GNU/Linux
the hid-multitouch module creates two input events

Available devices:
/dev/input/event0:      eGalax Inc. USB TouchController Pen
/dev/input/event1:      eGalax Inc. USB TouchController

event0 is displaying some output with evtest while touching but not event1.
Same like in http://www.spinics.net/lists/linux-input/msg35682.html

If I do
# echo 3 0eef 0001 16 > /sys/bus/hid/drivers/hid-multitouch/new_id
before plugging in the touchscreen event1 is working and also my touch applications.

I tried the suggested udev rule to set quirks but it does not work.
In hid_multitouch.c I added a pr_info in mt_probe to see the difference
with or without adding the new_id.

Without new_id set mt_probe has VID:ffffffff PID:ffffffff in hid_device_id *id and
QUIRKS:a0000148 in hid_device *hdev.

With new_id set mt_probe has VID:eef PID:1 in hid_device_id *id QUIRKS:80000148
in hid_device *hdev.

I tried to add the the vid/pid to mt_devices but still getting VID:ffffffff PID:ffffffff
in mt_probe.

Can anyone point me to the right direction how to get the eGalax touchscreen working
without unplugging -> rmmod hid-multitouch -> modprobe hid-multitouch -> echo to new_id -> plug in?

Regards

Stefan


HEKATRON Technik GmbH
Bruehlmatten 3a - 9
D-79295 Sulzburg
Reg.-Ger. Freiburg HRB 300243
Geschaeftsfuehrer:
Michael Roth, Armin Berchtold
Telefon +49 7634 500-0
Telefax +49 7634 500-316

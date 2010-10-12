From: Maulik Mankad <mankad.maulik@gmail.com>
Subject: Re: [RFT]patch to remove kernel thread for runtime pm from usbhid
Date: Tue, 12 Oct 2010 18:29:52 +0530
Message-ID: <AANLkTim_RN54GrLQ7ZAodwX-GHJ2knCEK-Ugd7FE7-rz@mail.gmail.com>
References: <201010121000.50465.oneukum@suse.de>
	<201010121339.49932.oneukum@suse.de>
	<AANLkTimfK2JeAf2DMV_qw3a4UiZwQKJQfF2HNNU=RWP8@mail.gmail.com>
	<201010121640.48586.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34367 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab0JLNGU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 09:06:20 -0400
In-Reply-To: <201010121640.48586.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input <linux-input@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>

On Tue, Oct 12, 2010 at 8:10 PM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Dienstag, 12. Oktober 2010, 14:10:42 schrieb Maulik Mankad:
>> On Tue, Oct 12, 2010 at 5:09 PM, Oliver Neukum <oneukum@suse.de> wro=
te:
>
>> > Thank you. Do both devices support remote wakeup? How much sleep t=
ime
>> > was generated?
>> >
>>
>> Reading the wakeup node (as below) shows that its enabled.
>>
>> cat /sys/bus/usb/devices/1-1/manufacturer
>> Dell
>>
>> # cat /sys/bus/usb/devices/1-1/power/wakeup
>> enabled
>>
>> My test was basically using the HID device post enumeration, and mak=
e
>> sure that data transfers work reliably.
>>
>> I can test more if you provide steps as per your need.
>
> Very good! Please do a
> echo "auto" >/sys/bus/usb/devices/1-1/power/level
> and do the test. After that I'd like to have the content of
> active_duration =A0connected_duration =A0runtime_active_time =A0runti=
me_enabled =A0runtime_status =A0runtime_suspended_time =A0runtime_usage=
 =A0wakeup_count
> in /sys/bus/usb/devices/1-1/power/

Below are some logs from my tests. I gave below two commands to suspend=
 the bus.

(1) echo 0 > /sys/bus/usb/devices/1-1/power/autosuspend

(2) echo auto > /sys/bus/usb/devices/1-1/power/control
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
usb usb1: usb wakeup-resume
usb usb1: usb auto-resume
hub 1-0:1.0: hub_resume
hub 1-0:1.0: port 1: status 0303 change 0004
hub 1-0:1.0: state 7 ports 1 chg 0002 evt 0000
usb 1-1: usb wakeup-resume
usb 1-1: finish resume
usb 1-1: usb auto-suspend
hub 1-0:1.0: resume on port 1, status 0
hub 1-0:1.0: port 1, status 0303, change 0004, 1.5 Mb/s
hub 1-0:1.0: hub_suspend
usb usb1: bus auto-suspend
musb_bus_suspend 2311: trying to suspend as a_host while active
usb usb1: bus suspend fail, err -16
hub 1-0:1.0: hub_resume
hub 1-0:1.0: port 1: status 0303 change 0004
hub 1-0:1.0: state 7 ports 1 chg 0002 evt 0000
usb 1-1: usb wakeup-resume
usb 1-1: finish resume
usb 1-1: usb auto-suspend
hub 1-0:1.0: resume on port 1, status 0
hub 1-0:1.0: port 1, status 0303, change 0004, 1.5 Mb/s
hub 1-0:1.0: hub_suspend
usb usb1: bus auto-suspend
musb_bus_suspend 2311: trying to suspend as a_host while active
usb usb1: bus suspend fail, err -16
hub 1-0:1.0: hub_resume
hub 1-0:1.0: port 1: status 0303 change 0004
hub 1-0:1.0: state 7 ports 1 chg 0002 evt 0000
usb 1-1: usb wakeup-resume
usb 1-1: finish resume
usb 1-1: usb auto-suspend
hub 1-0:1.0: resume on port 1, status 0
hub 1-0:1.0: port 1, status 0303, change 0004, 1.5 Mb/s
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Note that the bus keeps suspending and when I press a key on the
keyboard I see logs related to wakeup-resume.

Also I see the below entries under /sys/bus/usb/devices/1-1/power/

 ls /sys/bus/usb/devices/1-1/power/
active_duration  connected_duration  level    wakeup
autosuspend      control             persist

cat /sys/bus/usb/devices/1-1/power/active_duration
64289

cat /sys/bus/usb/devices/1-1/power/connected_duration
224015

cat /sys/bus/usb/devices/1-1/power/persist
1

cat /sys/bus/usb/devices/1-1/power/control
auto

I don't see the runtime entries. Any idea why is this so? I have
applied your patch to 2.6.35 kernel where my device works.

Has this something to do with the kernel version I am using / some
option to be turned on in menuconfig?

Regards,
Maulik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

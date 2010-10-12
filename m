From: Maulik Mankad <mankad.maulik@gmail.com>
Subject: Re: [RFT]patch to remove kernel thread for runtime pm from usbhid
Date: Tue, 12 Oct 2010 17:40:42 +0530
Message-ID: <AANLkTimfK2JeAf2DMV_qw3a4UiZwQKJQfF2HNNU=RWP8@mail.gmail.com>
References: <201010121000.50465.oneukum@suse.de>
	<AANLkTi=AWMWPH7N035n0Tk+8PcWgu10LzGbLQfpSefO1@mail.gmail.com>
	<201010121339.49932.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52207 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068Ab0JLMKt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 08:10:49 -0400
In-Reply-To: <201010121339.49932.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input <linux-input@vger.kernel.org>, linux-pm@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

On Tue, Oct 12, 2010 at 5:09 PM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Dienstag, 12. Oktober 2010, 13:34:33 schrieb Maulik Mankad:
>> On Tue, Oct 12, 2010 at 1:30 PM, Oliver Neukum <oneukum@suse.de> wrote:
>
>> > This patch removes the dedicated work queue and thus the kernel thread
>> > used to wake up USB HID devices. It is replaced with the use of
>> > the async API which didn't exist when runtime pm was introduced to
>> > usbhid.
>> >
>> > Signed-off-by: Oliver Neukum <oneukum@suse.de>
>> > ---
>>
>> Tested on OMAP4 SDP with USB Keyboard and USB Mouse using 'evtest' program.
>
> Thank you. Do both devices support remote wakeup? How much sleep time
> was generated?
>

Reading the wakeup node (as below) shows that its enabled.

cat /sys/bus/usb/devices/1-1/manufacturer
Dell

# cat /sys/bus/usb/devices/1-1/power/wakeup
enabled

My test was basically using the HID device post enumeration, and make
sure that data transfers work reliably.

I can test more if you provide steps as per your need.

Regards,
Maulik

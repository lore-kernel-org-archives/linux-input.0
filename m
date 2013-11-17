From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Re: [PATCH] HID: sony: Add force feedback support for Dualshock3 USB
Date: Sun, 17 Nov 2013 17:30:51 +0100
Message-ID: <CANq1E4RN2vpFvLcT6jdPw59wyJN-cBfFRQhMFzak7kJpPL86Nw@mail.gmail.com>
References: <1384021557-24106-1-git-send-email-sven@narfation.org>
	<f26febe04a776d22c913ed3ade3a8d90.squirrel@mungewell.org>
	<1567991.TNa7UhjX8Q@sven-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:63639 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab3KQQaw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 11:30:52 -0500
Received: by mail-lb0-f173.google.com with SMTP id u14so644308lbd.4
        for <linux-input@vger.kernel.org>; Sun, 17 Nov 2013 08:30:51 -0800 (PST)
In-Reply-To: <1567991.TNa7UhjX8Q@sven-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sven Eckelmann <sven@narfation.org>
Cc: Simon Wood <simon@mungewell.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>

Hi

On Sun, Nov 17, 2013 at 10:36 AM, Sven Eckelmann <sven@narfation.org> wrote:
> On Saturday 16 November 2013 17:30:25 simon@mungewell.org wrote:
>> This patch appears to work OK with my DualShock/SixAxis controller (USB
>> connection), but causes a machine lockup when used with my Intec wired
>> controller.
>>
>> The Intec controller works OK up to the point when I start rumble,
>> sometimes the motor runs some times it doesn't. I am using SDL2's
>> 'testhaptic' application.
>
> Thanks a lot for this bug report. The testhaptic was a good testcase because
> it is a heavy user and can reproduce the problem quite easily. I've only
> tested it using testrumble and own programs which didn't seem to trigger the
> problem here. The problem is easy to explain:
>
>  * usb_control_msg/usb_interrupt_msg/usb_bulk_msg/... may sleep
>  * sony_play_effect may gets called in an softirq context (atomic)
>
> So it is a bad choice to use hid_output_raw_report (which calls
> usb_control_msg) in a ff_memless control function. I will just send a revert
> patch in some minutes.

Yeah, the input-ff callbacks cannot be handled inline. You also get
deadlocks with the input-spinlock. In the wiimote driver I simply
dispatch the ff-events to a workqueue. You can have a look at
drivers/hid/hid-wiimote-modules.c. You can get some ordering-problems
then, but these can usually be ignored as they just collapse events.

The related commit was:

commit f50f9aabf32db7414551ffdfdccc71be5f3d6e7d
Author: David Herrmann <dh.herrmann@gmail.com>
Date:   Wed Oct 2 13:47:28 2013 +0200

    HID: wiimote: fix FF deadlock

Thanks
David

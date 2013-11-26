From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 4/4 v3] Input: wacom - add SW_TOUCH to include/uapi/linux/input.h
Date: Tue, 26 Nov 2013 12:38:09 -0800
Message-ID: <CAF8JNh+=3kYSR_wwVRw3PMicyZgWWDXBWPjB0jrcBd8JCa11XQ@mail.gmail.com>
References: <1384545602-15549-1-git-send-email-pingc@wacom.com>
	<20131126025928.GD31517@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:56609 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757990Ab3KZUiK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Nov 2013 15:38:10 -0500
Received: by mail-lb0-f173.google.com with SMTP id u14so4938635lbd.32
        for <linux-input@vger.kernel.org>; Tue, 26 Nov 2013 12:38:09 -0800 (PST)
In-Reply-To: <20131126025928.GD31517@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jason Gerecke <killertofu@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, Peter Hutterer <peter.hutterer@who-t.net>

On Mon, Nov 25, 2013 at 6:59 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Ping,
>
> On Fri, Nov 15, 2013 at 12:00:02PM -0800, Ping Cheng wrote:
>>> @@ -856,6 +856,7 @@ struct input_keymap_entry {
>>  #define SW_FRONT_PROXIMITY   0x0b  /* set = front proximity sensor active */
>>  #define SW_ROTATE_LOCK               0x0c  /* set = rotate locked/disabled */
>>  #define SW_LINEIN_INSERT     0x0d  /* set = inserted */
>> +#define SW_TOUCH             0x0e  /* set = touch switch turned on (touch events off) */
>
> I do not think we should be adding this as is as it seems to be very
> wacom-specific. I'd rather call it something else, like SW_MUTE_DEVICE
> or similar.

Thank you Dmitry for reviewing the patch. I can change the event to
SW_MUTE_DEVICE.

> I also wonder if this should really be a switch: can you query it's
> state?

Yes, it is a hardware switch. The state is posted periodically from the device.

> What happen if user plugs in the device, engages the switch and
> then [re]loads the driver?

The state will be updated in the driver, with this patch.

> Will the state be still signalled properly?

Sure.

> What about suspend/resume or hibernation?

Since the state is updated regularly, it won't be lost when system wakes up.

Basically, we are dealing with a hardware switch, which is controlled
by end users. Firmware and driver can not do much about it except
reporting its state.

Does this answer your questions?

Ping

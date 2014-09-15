From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: add new gamepad LED constants
Date: Tue, 16 Sep 2014 00:15:08 +0200
Message-ID: <CANq1E4TK1=mD0Xh5KuydoONqiex79HggvoM9XRhorogmxqBqhw@mail.gmail.com>
References: <1410750811-11156-1-git-send-email-michaelwr@google.com>
	<CANq1E4RY8cF1de4_rdS3Whjrf0bboYMtii4_nYNM2mEJuAKMfQ@mail.gmail.com>
	<CAON4U=OTzqOYDCeT-rFM8trvD80_kQxirZ+Yu5nOjc84v15XLA@mail.gmail.com>
	<20140915215728.GB13468@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:38144 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152AbaIOWPJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Sep 2014 18:15:09 -0400
Received: by mail-ie0-f175.google.com with SMTP id at20so5271677iec.6
        for <linux-input@vger.kernel.org>; Mon, 15 Sep 2014 15:15:08 -0700 (PDT)
In-Reply-To: <20140915215728.GB13468@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Wright <michaelwr@android.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Michael Wright <michaelwr@google.com>, Jiri Kosina <jkosina@suse.cz>

Hi

On Mon, Sep 15, 2014 at 11:57 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Sep 15, 2014 at 11:03:47AM -0700, Michael Wright wrote:
>> > Why not introduce all 8 player LEDs as described in the document? You
>> > should be safe increasing LED_MAX to 0x1f.
>>
>> Wasn't sure if it was safe to bump it since it could potentially break apps
>> until they recompile against the new API.
>
> I'd rather we did not add any new input LED definitions but rather
> looked into switching to LED subsystem, at least for new LEDs.

Why? The LED subsystem lacks any unprivileged API to control LEDs.
There's no cdev to control write-access to the LED API. /sys has never
been intended as unprivileged API so I'd really prefer if we add
proper input codes to control those. At least I cannot see the
advantage of the led subsystem over input EV_LED codes. Care to
elaborate?

Thanks
David

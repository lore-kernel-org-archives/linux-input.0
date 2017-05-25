From: Andy Lutomirski <luto@kernel.org>
Subject: Re: Dell XPS 13 9350 touchpad is busted in 4.12-rc
Date: Wed, 24 May 2017 21:25:00 -0700
Message-ID: <CALCETrUECMG+VerBSszA=__DG4Vj1xsWXdf51EdSHQym5M7HpQ@mail.gmail.com>
References: <CALCETrW3fuwiV82JrFkZ5ytb+VRPwpHDOvWBD4Q5zcWF_1ePcQ@mail.gmail.com>
 <alpine.LSU.2.20.1705250023170.26873@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941724AbdEYEZX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 May 2017 00:25:23 -0400
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com [209.85.213.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0715C239F2
        for <linux-input@vger.kernel.org>; Thu, 25 May 2017 04:25:22 +0000 (UTC)
Received: by mail-vk0-f49.google.com with SMTP id x71so85812648vkd.0
        for <linux-input@vger.kernel.org>; Wed, 24 May 2017 21:25:21 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.20.1705250023170.26873@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, Benjamin Tissoires <btissoir@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Allen Hung <allen_hung@dell.com>, Jason Gerecke <jason.gerecke@wacom.com>, Aaron Armstrong Skomra <skomra@gmail.com>, Ping Cheng <pingc@wacom.com>

On Wed, May 24, 2017 at 3:26 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Wed, 24 May 2017, Andy Lutomirski wrote:
>
>> I just build from Linus' tree from Saturday (ef82f1ad), and touchpad
>> input is busted on my laptop.  The device is still there and evtest
>> still shows events, but something is wrong and libinput either thinks
>> I'm not moving at all or I'm trying to teleport to the edge of the
>> screen.
>>
>> Is this a known problem or should I try to track it down?
>
> Did this work properly in 4.11?

I confess to not having tested 4.11, for 4.11-rc7 works.

>
> Is this G11 based chipset? (IOW, is this device driven by wacom driver?).
> If so, 6f107fab8 and/or 60a2218698 might be potential candidates.

I don't think so.

On a good kernel, I see:

/dev/input/event10:    DLL0704:01 06CB:76AE Touchpad

That thing is here, and the driver is hid-multitouch:

/sys/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-8/i2c-DLL0704:01/0018:06CB:76AE.0001/input/input13

On 4.12-rc, I see a SynPC/2 Synaptics Touchpad instead, attached to
i8042/serio1.

The culprit appears to be:

i2c_designware.1: controller timed out
i2c_hid i2c-DLL0704:01: hid_descr_cmd failed

I'm wondering whether something like
9143059fafd4eebed2d43ffb5455178d4010e60a could be involved.

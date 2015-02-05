From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Mayflash / Dragonrise GameCube controller adapter recognized as
 tablet, not joystick
Date: Wed, 4 Feb 2015 16:48:38 -0800
Message-ID: <CAKdAkRTU5a8MTstcJXgqAcfAKgjKUz=64aKP11TPaJKcCytK3w@mail.gmail.com>
References: <CABFQKmN7Lzr2GzZ4d+HgbzMRDe_NBxJDL81qMpaOGOV07LYwag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:61684 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161223AbbBEAsj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 19:48:39 -0500
Received: by mail-la0-f41.google.com with SMTP id gm9so4703600lab.0
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2015 16:48:38 -0800 (PST)
In-Reply-To: <CABFQKmN7Lzr2GzZ4d+HgbzMRDe_NBxJDL81qMpaOGOV07LYwag@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Rodland <andrew@cleverdomain.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Andrew,

On Wed, Feb 4, 2015 at 4:34 PM, Andrew Rodland <andrew@cleverdomain.org> wrote:
> Hi all,
>
> I recently bought a "Mayflash GameCube Controller Adapter for Wii U &
> PC USB". It has 4 GameCube controller ports, and a switch to tell it
> whether you're plugging it into a Wii or a PC. The docs say that in PC
> mode it works out of the box on Windows & Mac, with their driver being
> required for force-feedback, so it's a semi-standard HID device.
>
> With the switch set to "WII U", it's recognized as a hid-generic
> device, but the descriptors are nonsense and it doesn't generate any
> events. Fair enough.
>
> With the switch set to "PC" it's recognized, the descriptors make a
> lot more sense, and it sends events -- in fact it moves the cursor on
> my X display! For some reason it's getting recognized as a
> mouse/tablet instead of a joystick, so joydev refuses to take
> ownership of it, and X's evdev driver does. I suspect it's due to some
> mistake in the report descriptors, but I'm not quite expert enough to
> say.

>From the list of events you posted below it seems the device needs
HID_QUIRK_MULTI_INPUT to split it into 4 individual input devices.

Thanks.

-- 
Dmitry

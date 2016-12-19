From: Marcel Hasler <mahasler@gmail.com>
Subject: Re: [PATCH] HID: usbhid: fix more Mayflash adapters (HID_QUIRK_MULTI_INPUT)
Date: Mon, 19 Dec 2016 11:28:48 +0100
Message-ID: <CAOJOY2MJTsx0ZADD5QGsJVpWPj=fYLnvgRtfJAb5TUiU7F40=g@mail.gmail.com>
References: <20161213002305.GA30732@dtor-ws> <alpine.LSU.2.20.1612191119280.19203@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36401 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755083AbcLSK33 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Dec 2016 05:29:29 -0500
Received: by mail-io0-f194.google.com with SMTP id b194so18552805ioa.3
        for <linux-input@vger.kernel.org>; Mon, 19 Dec 2016 02:29:28 -0800 (PST)
In-Reply-To: <alpine.LSU.2.20.1612191119280.19203@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Rodland <andrew@cleverdomain.org>, linux-input@vger.kernel.org

Hello

2016-12-19 11:19 GMT+01:00 Jiri Kosina <jikos@kernel.org>:
> On Mon, 12 Dec 2016, Dmitry Torokhov wrote:
>
>> From: Andrew Rodland <andrew@cleverdomain.org>
>>
>> Add "Mayflash GameCube Controller Adapter for Wii U and PC USB" and
>> "Mayflash PS3 Game Controller Adapter" to the list of devices needing
>> HID_QUIRK_MULTI_INPUT. These devices have 4 controller ports, and without
>> the quirk they all become one very large joystock device. With the quirk
>> they're recognized as 4 separate joysticks.
>>
>> Signed-off-by: Andrew Rodland <andrew@cleverdomain.org>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=115841
>> [dtor: picked up Andrew's patch, added the PS3 controller data from
>>  bugzilla info]
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> This is already in as b2554000f5b ("HID: usbhid: Add quirks for
> Mayflash/Dragonrise GameCube and PS3 adapters").
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

What maybe still should be added, is the "Mayflash Dolphin-bar" (PID
0x1803, see the Bugzilla entry mentioned above).

Best regards
Marcel

2016-12-19 11:19 GMT+01:00 Jiri Kosina <jikos@kernel.org>:
> On Mon, 12 Dec 2016, Dmitry Torokhov wrote:
>
>> From: Andrew Rodland <andrew@cleverdomain.org>
>>
>> Add "Mayflash GameCube Controller Adapter for Wii U and PC USB" and
>> "Mayflash PS3 Game Controller Adapter" to the list of devices needing
>> HID_QUIRK_MULTI_INPUT. These devices have 4 controller ports, and without
>> the quirk they all become one very large joystock device. With the quirk
>> they're recognized as 4 separate joysticks.
>>
>> Signed-off-by: Andrew Rodland <andrew@cleverdomain.org>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=115841
>> [dtor: picked up Andrew's patch, added the PS3 controller data from
>>  bugzilla info]
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> This is already in as b2554000f5b ("HID: usbhid: Add quirks for
> Mayflash/Dragonrise GameCube and PS3 adapters").
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

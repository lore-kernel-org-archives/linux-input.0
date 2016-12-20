From: Marcel Hasler <mahasler@gmail.com>
Subject: Re: [PATCH] HID: usbhid: fix more Mayflash adapters (HID_QUIRK_MULTI_INPUT)
Date: Tue, 20 Dec 2016 22:21:52 +0100
Message-ID: <CAOJOY2MFTt7773ReTjF=89N6Ess6=DHC1_3UVXCmSS6yLzpS8Q@mail.gmail.com>
References: <20161213002305.GA30732@dtor-ws> <alpine.LSU.2.20.1612191119280.19203@cbobk.fhfr.pm>
 <CAGNp=Nxi7-_dKar3SOUUvGksxQvuy0AfzqtM8Szpq9P7deEwZw@mail.gmail.com> <alpine.LSU.2.20.1612191137270.19203@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:33612 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754604AbcLTVWe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Dec 2016 16:22:34 -0500
Received: by mail-io0-f196.google.com with SMTP id p13so23805222ioi.0
        for <linux-input@vger.kernel.org>; Tue, 20 Dec 2016 13:22:33 -0800 (PST)
In-Reply-To: <alpine.LSU.2.20.1612191137270.19203@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Robert de Rooy <robert.de.rooy@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Hi

2016-12-19 11:38 GMT+01:00 Jiri Kosina <jikos@kernel.org>:
> On Mon, 19 Dec 2016, Marcel Hasler wrote:
>
>> What maybe still should be added, is the "Mayflash Dolphin-bar" (PID
>> 0x1803, see the Bugzilla entry mentioned above).
>
> On Mon, 19 Dec 2016, Robert de Rooy wrote:
>
>> Thanks for this,
>>
>> Any chance we can also get the same quirk added for the Mayflash Dolphinbar?
>> It has four different operating modes, when set to "mode 3", it emulates 4
>> PC USB joysticks and has the same problem and needs the
>> HID_QUIRK_MULTI_INPUT.
>>
>> When set to mode 3, the USB id is: 0079:1803
>>
>> I tested it locally by booting with usbhid.quirks=0x79:0x1803:0x40
>>
>> Regarding the other modes, mode 1 and 2 already work as it just emulates a
>> USB keyboard/mouse. mode 4 is special, and supposedly now works with the
>> latest versions of the Dolphin emulator for Linux.
>
> Could either of you please submit a proper patch on top of b255400, so
> that I could queue it?
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

I just submitted a patch against the latest git.

Best regards
Marcel

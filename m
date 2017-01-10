From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: Method to power off HID device from driver?
Date: Mon, 9 Jan 2017 18:28:11 -0800
Message-ID: <CANndSKkeMtLp6S2MRXFHTrdyUnVQ7HqwyKB2F-pqbgJFPh8A9w@mail.gmail.com>
References: <CANndSKn1JE0Fnxgn9rpUyR1fUv7GM_Y4xwpfevSUiOYnVSYYig@mail.gmail.com>
 <CANndSK=-V0DXWh=XCr=GUAyWvQ0ZKrRfDdkvhFMbVWTj57+uiQ@mail.gmail.com>
 <D5A9B8BF-4720-4BB4-826E-CCA150D2976F@gmail.com> <1481168348.2286.11.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36297 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754125AbdAJC2M (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 9 Jan 2017 21:28:12 -0500
Received: by mail-oi0-f50.google.com with SMTP id u143so122511524oif.3
        for <linux-input@vger.kernel.org>; Mon, 09 Jan 2017 18:28:12 -0800 (PST)
In-Reply-To: <1481168348.2286.11.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Cameron Gutman <aicommander@gmail.com>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>

On Wed, Dec 7, 2016 at 7:39 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Tue, 2016-12-06 at 19:20 -0800, Cameron Gutman wrote:
>> Hi,
>>
>> > On Dec 6, 2016, at 4:25 PM, Roderick Colenbrander <roderick@gaikai.
>> > com> wrote:
>> >
>> > Hi,
>> >
>> > I looked a bit deeper and found EV_PWR, though it isn't clearly
>> > defined, but it is used in some places for purposes like this.
>> > Would
>> > this be an acceptable method?
>> >
>>
>> I am interested in this too. I recently implemented the ability to
>> turn off wireless Xbox 360 controllers in [0], but there is no way
>> to activate this functionality without suspending the whole system.
>> Some folks [1] have asked for this ability in other scenarios.
>>
>> [0]: Commit f712a5a05228058f6b74 ("Input: xpad - power off wireless
>>                                    360 controllers on suspend")
>> [1]: https://github.com/paroj/xpad/issues/52
>
> Ditto the PS3 BD remote driver, when moving to the kernel, lost its
> ability to suspend after X minutes, which drains the AA batteries
> inside it.
>
> In the original system, the remote would get disconnected after less
> than a couple of minutes, and reconnect as soon as you pressed a
> button, and make sure that button got sent to the device.
>
> Would be great if we could control this from user-space.

>From the sounds of it various others are interested in the ability to
trigger a device disconnect as well. Since I don't think any of us
have a good enough understanding of the HID / input frameworks, I'm
adding Benjamin and Jiri. Maybe they have some good ideas on how to
tackle this.

Thanks,
Roderick

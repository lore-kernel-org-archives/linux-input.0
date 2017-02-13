From: Paulo Costa <me@paulo.costa.nom.br>
Subject: Re: [PATCH] Input: add LED_0..LED_15 define
Date: Sun, 12 Feb 2017 23:03:03 -0200
Message-ID: <CADbEYbncQyFLg7Jq3pGBc2JfOh+2H6FYZ+XPRjnZEcEm7uVVtQ@mail.gmail.com>
References: <20170208004141.30540-1-me@paulo.costa.nom.br> <CAKdAkRSL1uqCTbyX8Wmh+DA=vs6nmOCU-F88Ceizh7acOf=SNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34973 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdBMBDF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Feb 2017 20:03:05 -0500
Received: by mail-wr0-f196.google.com with SMTP id o16so22024357wra.2
        for <linux-input@vger.kernel.org>; Sun, 12 Feb 2017 17:03:04 -0800 (PST)
In-Reply-To: <CAKdAkRSL1uqCTbyX8Wmh+DA=vs6nmOCU-F88Ceizh7acOf=SNw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

2017-02-10 22:54 GMT-02:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Paulo,
>
> On Tue, Feb 7, 2017 at 4:41 PM, Paulo Costa <me@paulo.costa.nom.br> wrote:
>> Some input devices have many controllable leds that don't fit any standard function (e.g., the Wiimote has 4 controllable LEDs)
>>
>> Just as we have BTN_0..BTN_9 for generic buttons, LED_0...LED_15 can now be used to control generic leds.
>
> Generic LEDs should use LED subsystem; we are not going to be adding
> more LED definitions to input.
>
> Thanks.
>
> --
> Dmitry

Hello, Dmitry,

IMHO, whenever those leds are part of a bigger input device,
using EV_LED makes more sense.

But it's your call, thanks for looking into it.

Paulo

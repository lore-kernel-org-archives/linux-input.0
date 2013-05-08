From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [RFC 24/26] HID: wiimote: support Nintendo Wii U Pro Controller
Date: Wed, 8 May 2013 19:25:04 +0200
Message-ID: <CANq1E4SnpEV4Rp3w9B-Ex8B5w7JMYm6Pt7YHj0DH1P3i+3_TzQ@mail.gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
	<1367788390-29835-25-git-send-email-dh.herrmann@gmail.com>
	<CAFmpkyhFHS1CHDLTRbGdYe5B5XkW-JyavZotvffZT3BnkQSdOA@mail.gmail.com>
	<CANq1E4Q9X7+e_HSbB2Y0GykgJAuF9ui1x1GtssiwOXWKhVUfvQ@mail.gmail.com>
	<CAFmpkyiSw3_mXG-bokbcu-wTUAQmMDBYvqpKQg5eT8Ke+vAPrA@mail.gmail.com>
	<CANq1E4T9eoBVvbq8J+2ps5CJ-9G1782j7TjanqWLJVUCQ1k60g@mail.gmail.com>
	<CAFmpkyigapfb52ke-8vvKcwqmF8EVsUF8md-0kFTHHDxDzKxRA@mail.gmail.com>
	<20130508170536.GA30057@core.coreip.homeip.net>
	<CAFmpkyj90KoGgLeOqb3x00qBQ7Hmj3Fd_tXuWujx08QueV_9uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:51933 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583Ab3EHRZE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 May 2013 13:25:04 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so3741114ief.12
        for <linux-input@vger.kernel.org>; Wed, 08 May 2013 10:25:04 -0700 (PDT)
In-Reply-To: <CAFmpkyj90KoGgLeOqb3x00qBQ7Hmj3Fd_tXuWujx08QueV_9uQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi Todd

On Wed, May 8, 2013 at 7:20 PM, Todd Showalter <todd@electronjump.com> wrote:
> On Wed, May 8, 2013 at 1:05 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>
>> Or you have your library that provides ABS->BTN translation.
>>
>> You can even have your API structured such that consumer provides list
>> of events it is interested in and the library tries to synthesize
>> missing events if it can.
>
>     That's in the plans.
>
>> So we already have:
>>
>> #define BTN_A                   0x130
>> #define BTN_B                   0x131
>> #define BTN_C                   0x132
>> #define BTN_X                   0x133
>> #define BTN_Y                   0x134
>> #define BTN_Z                   0x135
>> #define BTN_TL                  0x136
>> #define BTN_TR                  0x137
>> #define BTN_TL2                 0x138
>> #define BTN_TR2                 0x139
>> #define BTN_SELECT              0x13a
>> #define BTN_START               0x13b
>> #define BTN_MODE                0x13c
>> #define BTN_THUMBL              0x13d
>> #define BTN_THUMBR              0x13e
>>
>> So if we really want to have BTN_NORTH, etc, we want to alias existing
>> ones.
>
>     The problem is that the alias differs with hardware.  BTN_A would be:
>
> - BTN_SOUTH on xbox gamepads
> - BTN_EAST on nintendo gamepads and ouya
>
>     Nintendo is:
>
> A -> WEST
> B -> SOUTH
> X -> NORTH
> Y -> EAST
>
>    While Microsoft is:
>
> A -> SOUTH
> B -> EAST
> X -> WEST
> Y -> NORTH
>
>     They're mirror images of each other. So just aliasing is going to
> break something.

No. Just ignore BTN_A/B/X/Y, use BTN_EAST/WEST/NORTH/SOUTH instead.
Only for legacy gamepads with wrong mappings you might reuse these. So
we basically overwrite the old names.
So you no longer care for BTN_A/B/X/Y and they will no longer
represent the labels of the buttons, but instead the location.

Regards
David

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Demand for hid_input.c's process
Date: Mon, 11 Sep 2017 14:20:21 -0700
Message-ID: <CAKdAkRRF4rvZ3rt9KJaEQ-_hn+faxvCHDDBbAx35dQJNOsAyJw@mail.gmail.com>
References: <DB6PR0701MB25351C528313F0F9303BD4178B680@DB6PR0701MB2535.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34282 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdIKVUX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Sep 2017 17:20:23 -0400
Received: by mail-vk0-f54.google.com with SMTP id o22so11087666vke.1
        for <linux-input@vger.kernel.org>; Mon, 11 Sep 2017 14:20:22 -0700 (PDT)
In-Reply-To: <DB6PR0701MB25351C528313F0F9303BD4178B680@DB6PR0701MB2535.eurprd07.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Takeuchi, Toshiki" <toshiki.takeuchi@wacom.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>

Hi Takeuchi,

On Sun, Sep 10, 2017 at 8:06 PM, Takeuchi, Toshiki
<toshiki.takeuchi@wacom.com> wrote:
> Dear Sir or Madam
>
> I'm facing a problem because of the implementation in "hid_input.c".
> The function, =E2=80=9Chidinput_configure_usage()=E2=80=9D handles many u=
sage.
> However, usage=3D0x45(Eraser) is not supported on usage-page =E2=80=9CHID=
_UP_DIGITIZER=E2=80=9D.
> So, this function add key =E2=80=9CBTN_MISC=E2=80=9D to map (because unkn=
own usage) then.
> I=E2=80=99d like to add the key which is endemic to eraser like =E2=80=9C=
BTN_ERASER=E2=80=9D.

The event code for the eraser is BTN_TOOL_RUBBER:

#define BTN_TOOL_PEN            0x140
#define BTN_TOOL_RUBBER         0x141
#define BTN_TOOL_BRUSH          0x142
#define BTN_TOOL_PENCIL         0x143
#define BTN_TOOL_AIRBRUSH       0x144
#define BTN_TOOL_FINGER         0x145
#define BTN_TOOL_MOUSE          0x146
#define BTN_TOOL_LENS           0x147

> Could you please add the process to =E2=80=9Chidinput_configure_usage()=
=E2=80=9D?
> Or, if you can=E2=80=99t, could you please permit me to fix the process?

Please send a patch with proposed changes.

Thanks.

--=20
Dmitry

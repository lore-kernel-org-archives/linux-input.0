From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Dell XPS 13 Fn key bug?
Date: Wed, 1 Feb 2017 16:16:13 -0800
Message-ID: <CAKdAkRQ=jCsQvPb8vK1byYYAbLSEeBHpMMDuMGhgwdqVKvQ_yg@mail.gmail.com>
References: <20170125084732.5hawvooeegtw4wwc@zenon.in.qult.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:35712 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdBBAQO (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Feb 2017 19:16:14 -0500
Received: by mail-ua0-f173.google.com with SMTP id y9so326805uae.2
        for <linux-input@vger.kernel.org>; Wed, 01 Feb 2017 16:16:14 -0800 (PST)
In-Reply-To: <20170125084732.5hawvooeegtw4wwc@zenon.in.qult.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Ignacy_Gaw=C4=99dzki?= <bugs@qult.net>, Mario Limonciello <Mario_Limonciello@dell.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Jan 25, 2017 at 12:47 AM, Ignacy Gaw=C4=99dzki <bugs@qult.net> wrot=
e:
> Hi,
>
> There is a bug in the processing of the Fn key on the first generation
> of Dell XPS 13 laptops (at least models L321X and L322X have the problem)=
.
> It happens with the combinations for Home, End, Page Up and Page Down
> keys, achieved with pressing Fn with respectively Left, Right, Up and
> Down.  If the Fn key is released before the other key, the release of
> the other key is not passed through.  In that case, an auto-repeat of
> the key may activate itself until any other key is pressed.
>
> This is confirmed by running evtest:
>
> Event: time 1485332907.361701, type 4 (EV_MSC), code 4 (MSC_SCAN), value =
cf
> Event: time 1485332907.361701, type 1 (EV_KEY), code 107 (KEY_END), value=
 1
> Event: time 1485332907.659714, type 4 (EV_MSC), code 4 (MSC_SCAN), value =
cd
>
> The second MSC_SCAN happens when the Fn key is released and after it,
> until any key is pressed again, the End key is considered pressed and
> auto-repeating eventually starts.
>
> Another similar situation happens if for instance the Right key is
> pressed, then the Fn key is pressed before the Right key is released.
> The subsequent release of the Right key is not passed through:
>
> Event: time 1485333101.589438, type 4 (EV_MSC), code 4 (MSC_SCAN), value =
cd
> Event: time 1485333101.589438, type 1 (EV_KEY), code 106 (KEY_RIGHT), val=
ue 1
> Event: time 1485333101.959561, type 4 (EV_MSC), code 4 (MSC_SCAN), value =
cf

OK, so 'cd' is scancode for KEY_RIGHT and 'cf' is scancode for
KEY_END, and it seems that implementation of FN handling is very naive
as it emits "release" keycodes for the state FN is currently in, not
the state it was when key was pressed.

Ideally Dell would fix that. Mario, any chance of that?

Thanks.

--=20
Dmitry

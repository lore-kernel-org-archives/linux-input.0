From: Benjamin Valentin <benpicco@googlemail.com>
Subject: Re: [PATCH] Input: xpad - sync supported devices with 360Controller
Date: Tue, 9 May 2017 01:08:42 +0200
Message-ID: <20170509010843.6f24c1a7@nashorn>
References: <20170504231544.335e8f42@nashorn>
        <20170504231714.16ea40d2@nashorn>
        <5f9b48e9-053c-2118-2026-5dcbc7705100@gmail.com>
        <20170505195021.27121915@nashorn>
        <20170506191024.01eefa59@nashorn>
        <842f5c93-9788-2bb9-1ced-bb88ce60d231@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33382 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdEHXIu (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 8 May 2017 19:08:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id y10so18671321wmh.0
        for <linux-input@vger.kernel.org>; Mon, 08 May 2017 16:08:49 -0700 (PDT)
In-Reply-To: <842f5c93-9788-2bb9-1ced-bb88ce60d231@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>, "Pierre-Loup A. Griffais" <eduke32@plagman.net>, Daniel Tobias <dan.g.tob@gmail.com>

On Sat, 6 May 2017 14:19:58 -0700
Cameron Gutman <aicommander@gmail.com> wrote:
=20
> If the device type is uncertain, we should definitely not add them to
> the the list. Doing so may regress them by overriding the
> autodetection done in xpad_probe().
>
> [=E2=80=A6]
>
> There's really no reason to add an entry like "Generic Controller".
> Gamepads work perfectly fine without being included in this list, as
> long as their VIDs are in xpad_table[], since we already derive the
> correct XTYPE for unknown pads using the USB interface descriptor in
> xpad_probe().
>=20
> The only value that this table has is for gamepads that need quirks
> like MAP_TRIGGERS_TO_BUTTONS and similar, and simply having a nicer
> name to display than "Generic X-Box pad". If we don't have either, I
> don't think it's worth adding them here.

Ah I didn't know this! That's reassuring as otherwise it would have been
an impossible battle to track down all the Xbox compatible controllers
and add them to an ever growing list :)

It looks like 360Controller also detecs wheels and flight sticks at run-tim=
e,
at least for Xbox One peripherals [0]. I don't have hardware to test this
unfortunately.

> > This patch depends on my previous series which sorts the USB IDs
> > and syncs them with the xboxdrv userspace driver. =20
>=20
> At this point, I'd bundle all 4 patches into a v2 of your initial
> series to make it easier for Dmitry to keep them all straight.

As he already merged the three first ones, I guess I'll just resend this one
with the generic/uncertain ones stripped.

[0] https://github.com/360Controller/360Controller/blob/master/360Controlle=
r/Controller.cpp#L587

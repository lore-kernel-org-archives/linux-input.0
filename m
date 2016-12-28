From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: increasing LED_MAX and INPUT_DEVICE_ID_LED_MAX?
Date: Wed, 28 Dec 2016 10:56:17 -0800
Message-ID: <CAKdAkRQO-4wCuF_bE-FdoVPouXxQSoTKfVA2p=JYQBwWA=y=kg@mail.gmail.com>
References: <20161222210306.GE8919@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:33282 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbcL1S4T (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Dec 2016 13:56:19 -0500
Received: by mail-ua0-f171.google.com with SMTP id i68so109443694uad.0
        for <linux-input@vger.kernel.org>; Wed, 28 Dec 2016 10:56:19 -0800 (PST)
In-Reply-To: <20161222210306.GE8919@pixar.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Lars R. Damerow" <lars@pixar.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Lars,

On Thu, Dec 22, 2016 at 1:03 PM, Lars R. Damerow <lars@pixar.com> wrote:
> Hello,
>
> I'm trying to use a range of P. I. Engineering's X-keys (like this one: h=
ttp://xkeys.com/xkeys/xk60.php) on Linux.
>
> The XK-60 mostly works when it's plugged in, but buttons on the last four=
 columns don't do anything. I figured out that this is because of how the e=
vents get coded in the input system. Button events from the XK-60's generic=
 event device are marked as type EV_LED, and the event code seems to repres=
ent the button's column on the device, starting at 10 for the leftmost colu=
mn.
>
> Since LED_MAX is set to 0x0f, only the first six columns of buttons can r=
eport events, and the remaining columns set their code higher than LED_MAX,=
 causing the input system to drop those events.
>
> I patched my kernel to increase LED_MAX and INPUT_DEVICE_ID_LED_MAX to 0x=
20, and after that all of the XK-60's buttons worked.
>
> Would it be acceptable to make this change upstream, or should this probl=
em be solved a different way (e.g., tweaking the events so that they're EV_=
KEY instead of EV_LED, though I wouldn't want them to autorepeat)?

No, we do not want to extend LED range to allow device report buttons
as leds. You need to teach hid-input to parse the descriptors better
for your device.

Thanks.

--=20
Dmitry

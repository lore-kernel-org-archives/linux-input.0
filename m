From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/4] platform/x86: intel-vbtn: Add support for several
 more switches/buttons
Date: Sun, 5 Nov 2017 14:31:57 +0200
Message-ID: <CAHp75VfxpUJRdp9hKnPnJ7-7Kfo=DnTm-NRvE-KCQ2ZJ6eehNA@mail.gmail.com>
References: <b8013fda-0f69-41d7-ade3-98ca861dc30d@rwthex-w2-a.rwth-ad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:43252 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752571AbdKEMb7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 5 Nov 2017 07:31:59 -0500
In-Reply-To: <b8013fda-0f69-41d7-ade3-98ca861dc30d@rwthex-w2-a.rwth-ad.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Stefan_Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Cc: Platform Driver <platform-driver-x86@vger.kernel.org>, Andy Shevchenko <andy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, AceLan Kao <acelan.kao@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Darren Hart <dvhart@infradead.org>

On Fri, Nov 3, 2017 at 9:03 PM, Stefan Br=C3=BCns
<stefan.bruens@rwth-aachen.de> wrote:
> Currently, intel-vbtn only supports the most relevant buttons, although
> there are several more events, mostly in use by convertibles.
>
> This series adds support for three more events. One of these events
> is a switch (SW_*) event, which is currently not working when using
> sparse keymaps. The first patch fixes this combination.
>
> The second patch adds support for the SW_TABLET_MODE switch, which
> is used by current convertibles.
>
> The third patch adds support for the KEY_ROTATE_DISPLAY. On the Dell
> XPS 12 (9Q33), rotation lock is implemented as a button to toggle
> between locked and unlocked state. In locked state, the accelerometer
> should be ignored, while in unlocked the screen contents should
> autorotate based on the tablet orientation. The same functionality
> is likely implemented as a switch (SW_ROTATE_LOCK event) on different
> hardware.
>
> The fourth patch adds support for the "Windows logo" button/key found on
> the XPS 12 display (i.e. in tablet mode, it is the only key reachable).
> The Lenovo Helix 2 has an equivalent touch button. The event currently
> uses KEY_MENU, although a distinct key code may be a better choice.
>

All, except first, are applied to my review and testing queue, thanks!

>
> Stefan Br=C3=BCns (4):
>   Input: sparse-keymap - send sync event for KE_SW/KW_VSW
>   platform/x86: intel-vbtn: support SW_TABLET_MODE
>   platform/x86: intel-vbtn: support KEY_ROTATE_DISPLAY
>   platform/x86: intel-vbtn: support panel front button
>
>  drivers/input/sparse-keymap.c     | 1 +
>  drivers/platform/x86/intel-vbtn.c | 6 ++++++
>  2 files changed, 7 insertions(+)
>
> --
> 2.14.3
>



--=20
With Best Regards,
Andy Shevchenko

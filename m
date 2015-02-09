From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH 0/4] HID: Improve handling of multimode Logitech handling wheels
Date: Mon, 9 Feb 2015 10:14:45 +0100
Message-ID: <CADbOyBQMhOGWNBiQPN8asK+gMnfaD-ogunotNX45uN0VyTBUOg@mail.gmail.com>
References: <1423240486-6714-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423240486-6714-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>
Cc: Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

On Fri, Feb 6, 2015 at 5:34 PM, Michal Mal=C3=BD
<madcatxster@devoid-pointer.net> wrote:
> This patch series improves handling of various Logitech gaming wheels=
 and
> allows switching between various compatibility modes which might be u=
seful
> to improve compatibility with very old games and testing purposes.
>
> Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
>
> Michal Mal=C3=BD (4):
>   Identify Logitech gaming wheels in compatibility modes accordingly =
to
>        Logitech specifications
>   Display the real wheel model and supported alternate modes through
>     sysfs. This applies only to multimode wheels.
>   Introduce a module parameter to disable automatic switch of Logitec=
h
>       gaming wheels from compatibility to native mode. This only appl=
ies
>     to     multimode wheels.
>   Allow switching of Logitech gaming wheels between available
>     compatibility modes through sysfs. This only applies to multimode
>     wheels.
>
>  .../ABI/testing/sysfs-driver-hid-logitech-lg4ff    |  45 ++
>  drivers/hid/hid-lg.c                               |   6 +
>  drivers/hid/hid-lg4ff.c                            | 608 +++++++++++=
+++++++---
>  3 files changed, 583 insertions(+), 76 deletions(-)
>
> --
> 2.2.2
>

Applied cleanly on kernel 3.17.8, and tested with:
- Logitech Formula Vibration Wheel
- Logitech MOMO (Black) Wheel
Everything keeps working like it was before, which is correct because
these wheels are no multimode wheels.

Tested-by: Elias Vanderstuyft <elias.vds@gmail.com>

Thanks,
Elias

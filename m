From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH v2 0/4] HID: hid-lg4ff: Improve handling of Logitech
 multimode gaming wheels
Date: Mon, 16 Feb 2015 22:58:03 +0100
Message-ID: <CADbOyBQxYXnyviptRkyABj1vH+9Q7W5ZMY6A9NQTf6=qw=GFuA@mail.gmail.com>
References: <1423965785-22930-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423965785-22930-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>
Cc: Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

On Sun, Feb 15, 2015 at 3:03 AM, Michal Mal=C3=BD
<madcatxster@devoid-pointer.net> wrote:
> This patch series improves handling of various Logitech gaming wheels=
 and
> allows switching between various compatibility modes which might be u=
seful
> to improve compatibility with very old games and testing purposes.
>
> Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
>
> v2: - Rebased against latest linux-next
>     - Document the newly introduced sysfs interfaces in appropriate c=
ommits
>     - Assume that we are targeting kernel version 4.1
>     - Fix a misleading error message regarding unsupported wheel mode
>
> Michal Mal=C3=BD (4):
>   Identify Logitech gaming wheels in compatibility modes accordingly =
to
>     Logitech specifications
>   Display the real wheel model and supported alternate modes through
>     sysfs. This applies only to multimode wheels.
>   Introduce a module parameter to disable automatic switch of Logitec=
h
>     gaming wheels from compatibility to native mode. This only applie=
s
>     to multimode wheels.
>   Allow switching of Logitech gaming wheels between available
>     compatibility modes through sysfs. This only applies to multimode
>     wheels.
>
>  .../ABI/testing/sysfs-driver-hid-logitech-lg4ff    |  45 ++
>  drivers/hid/hid-lg.c                               |   6 +
>  drivers/hid/hid-lg4ff.c                            | 605 +++++++++++=
+++++++---
>  3 files changed, 580 insertions(+), 76 deletions(-)
>
> --
> 2.3.0
>

Applied cleanly on kernel 3.18.6, and retested with:
- Logitech Formula Vibration Wheel
- Logitech MOMO (Black) Wheel
Everything keeps working like it was before, which is correct because
these wheels are no multimode wheels.

Tested-by: Elias Vanderstuyft <elias.vds@gmail.com>

Thanks,
Elias

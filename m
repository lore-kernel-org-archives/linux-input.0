From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [git pull] Input updates for 2.6.34-rc3
Date: Tue, 6 Apr 2010 08:33:50 -0700
Message-ID: <m2j6cb013311004060833k76a89ad4r4ee848ea8f5492d4@mail.gmail.com>
References: <20100406063051.GB1895@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.211.172]:62391 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0DFPeM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Apr 2010 11:34:12 -0400
In-Reply-To: <20100406063051.GB1895@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Apr 5, 2010 at 11:30 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Linus,
>
> Please pull from:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git://git.kernel.org/pub/scm/linux/kernel/=
git/dtor/input.git for-linus
> or
> =C2=A0 =C2=A0 =C2=A0 =C2=A0master.kernel.org:/pub/scm/linux/kernel/gi=
t/dtor/input.git for-linus
>
> to receive updates for the input subsystem.
>
> Changelog:
> ---------
>
> Chase Douglas (1):
> =C2=A0 =C2=A0 =C2=A0Input: ALPS - add signature for HP Pavilion dm3 l=
aptops
>
> Dmitry Torokhov (1):
> =C2=A0 =C2=A0 =C2=A0Input: sparse-keymap - implement safer freeing of=
 the keymap
>
> Dominik Brodowski (1):
> =C2=A0 =C2=A0 =C2=A0Input: i8042 - spelling fix
>
> H Hartley Sweeten (1):
> =C2=A0 =C2=A0 =C2=A0Input: matrix_keypad - allow platform to disable =
key autorepeat
>
> Henrik Rydberg (3):
> =C2=A0 =C2=A0 =C2=A0Input: bcm5974 - retract efi-broken suspend_resum=
e
> =C2=A0 =C2=A0 =C2=A0Input: clarify the no-finger event in multitouch =
protocol
> =C2=A0 =C2=A0 =C2=A0Input: update the status of the Multitouch X driv=
er project
>
> Yong Wang (1):
> =C2=A0 =C2=A0 =C2=A0Input: sparse-keymap - free the right keymap on e=
rror
>
>
> Diffstat:
> --------
>
> =C2=A0Documentation/input/multi-touch-protocol.txt | =C2=A0 23 ++++++=
++---
> =C2=A0drivers/input/input.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A09 ++++-
> =C2=A0drivers/input/keyboard/matrix_keypad.c =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A04 +-
> =C2=A0drivers/input/mouse/alps.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0drivers/input/mouse/bcm5974.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 -
> =C2=A0drivers/input/serio/i8042.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0drivers/input/sparse-keymap.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0 52 ++++++++++++++++---------
> =C2=A0include/linux/input/matrix_keypad.h =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A02 +
> =C2=A08 files changed, 65 insertions(+), 29 deletions(-)
>
> --
> Dmitry
>

I'm still waiting on some review for my TSC2046 touchscreen driver.
Last time I inquired about it, I was told it would be reviewed, but
there has not been any movement at all on it, and it's been out for
review for several months now.  Do I need to do more work on it?  Is
there something else needed?

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

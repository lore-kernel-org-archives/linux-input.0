From: Daniel Kurtz <djkurtz@google.com>
Subject: Re: [PATCH 0/5] Input: serio_raw - add monitor/replay debugging interface
Date: Tue, 14 Feb 2012 11:18:38 +0800
Message-ID: <CAGS+omDWrSyLtDYWAubyc5F=BUqKOnKmCnyWPn5nNcoREar_aw@mail.gmail.com>
References: <1328084386-31110-1-git-send-email-clchiou@chromium.org> <1328671497-20880-1-git-send-email-clchiou@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64910 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab2BNDS6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Feb 2012 22:18:58 -0500
Received: by iacb35 with SMTP id b35so5447558iac.19
        for <linux-input@vger.kernel.org>; Mon, 13 Feb 2012 19:18:58 -0800 (PST)
In-Reply-To: <1328671497-20880-1-git-send-email-clchiou@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Che-Liang Chiou <clchiou@chromium.org>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, Feb 8, 2012 at 11:24 AM, Che-Liang Chiou <clchiou@chromium.org>=
 wrote:
>
> The serio_raw driver is designed to provide "raw access" to mice, key=
boards
> etc; thus, a driver accessing serio_raw may live entirely in userland=
=2E
>
> However, serio_raw lacks testability. =A0It is practically impossible=
 to do
> regression tests on changes to a serio_raw -based userland driver. =A0=
On the other
> hand, the kernel's input subsystem has good testability support. =A0W=
ith the help
> of tools like utouch-evemu, we may capture and replay input events fo=
r evdev
> drivers in regression tests.
>
> This patchset contains extensions to the serio_raw driver which add d=
ebugfs
> entries for monitoring and replaying byte sequence between a userland=
 driver
> and device. =A0These byte sequences can be used in regression tests o=
f the
> userland driver. =A0This patchset closes the gap between serio_raw an=
d the input
> subsystem regarding testability.
>
> This patchset is successfully applied on kernel version 3.3-rc2.
>
> Che-Liang Chiou (5):
> =A0Input: serio_raw - return proper result when serio_raw_read fails
> =A0Input: serio_raw - extract queue interface
> =A0Input: serio_raw - factor out common pattern of write
> =A0Input: serio_raw - add debugfs interface
> =A0Input: serio_raw - implement debugfs interface

=46or patches 3-5:
Reviewed-by: Daniel Kurtz <djkurtz@google.com>

=46or patch 1 (and its implication on queue_read() in patch 2, I'd
prefer to hear feedback from the list.

-Daniel

>
> =A0drivers/input/serio/serio_raw.c | =A0394 +++++++++++++++++++++++++=
++++++++------
> =A01 files changed, 337 insertions(+), 57 deletions(-)
>
> --
> 1.7.7.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html




--
Daniel Kurtz=A0|=A0Software Engineer=A0|=A0djkurtz@google.com=A0|=A0650=
=2E204.0722
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

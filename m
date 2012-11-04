From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/1] HID: microsoft, fix invalid rdesc for 3k kbd
Date: Sun, 4 Nov 2012 22:06:49 +0100
Message-ID: <CAMuHMdWzNxhs1+14qwr0=G+_uGVWm9QKb4wBDBy-6rx5+pxv7w@mail.gmail.com>
References: <1350646126-28537-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:47959 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab2KDVGu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Nov 2012 16:06:50 -0500
In-Reply-To: <1350646126-28537-1-git-send-email-jslaby@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, stable@vger.kernel.org

On Fri, Oct 19, 2012 at 1:28 PM, Jiri Slaby <jslaby@suse.cz> wrote:
> +       if ((quirks & MS_RDESC_3K) && *rsize =3D=3D 106 &&
> +                       !memcmp((char []){ 0x19, 0x00, 0x29, 0xff },
> +                               &rdesc[94], 4)) {

Which version of gcc are you using?

I'm getting (m68k-linux-gnu-gcc 4.1.2):

drivers/hid/hid-microsoft.c:51:18: error: macro "memcmp" passed 6
arguments, but takes just 3
drivers/hid/hid-microsoft.c: In function =E2=80=98ms_report_fixup=E2=80=
=99:
drivers/hid/hid-microsoft.c:50: error: =E2=80=98memcmp=E2=80=99 undecla=
red (first use
in this function)
drivers/hid/hid-microsoft.c:50: error: (Each undeclared identifier is
reported only once
/drivers/hid/hid-microsoft.c:50: error: for each function it appears in=
=2E)

Extracted into this test case:

---snip---
#include <string.h>

#define memcmp(a, b, c) memcmp((a), (b), (c))

int f(unsigned char *rdesc)
{
    return memcmp((char []){ 0x19, 0x00, 0x29, 0xff }, &rdesc[94], 4);
}
---snip---

it also fails with gcc-3.4/4.1/4.2/4.3/4.4 of Ubuntu 10.04 on amd64.

Interestingly, it doesn't fail if I remove the #define for memcmp. So i=
t seems
to work if memcmp() is a real function, not a #define.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

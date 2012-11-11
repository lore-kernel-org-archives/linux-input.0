From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/1] HID: microsoft, fix invalid rdesc for 3k kbd
Date: Sun, 11 Nov 2012 17:35:05 +0100
Message-ID: <CAMuHMdXvBwFsGzApwR9pTUd55-c5zu0Fu4wOt=MeRabNtjQOLQ@mail.gmail.com>
References: <1350646126-28537-1-git-send-email-jslaby@suse.cz>
	<CAMuHMdWzNxhs1+14qwr0=G+_uGVWm9QKb4wBDBy-6rx5+pxv7w@mail.gmail.com>
	<5096EE29.8090304@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:53340 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab2KKQfH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Nov 2012 11:35:07 -0500
In-Reply-To: <5096EE29.8090304@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Sun, Nov 4, 2012 at 11:37 PM, Jiri Slaby <jslaby@suse.cz> wrote:
> On 11/04/2012 10:06 PM, Geert Uytterhoeven wrote:
>> On Fri, Oct 19, 2012 at 1:28 PM, Jiri Slaby <jslaby@suse.cz> wrote:
>>> +       if ((quirks & MS_RDESC_3K) && *rsize =3D=3D 106 &&
>>> +                       !memcmp((char []){ 0x19, 0x00, 0x29, 0xff }=
,
>>> +                               &rdesc[94], 4)) {
>>
>> Which version of gcc are you using?
>
> 4.7.1. But that indeed fails too if memcmp is a macro. This is of cou=
rse
> not the case for x86, so that I didn't hit that. I will post a patch =
to
> change this to standard array accesses. (This looked prettier though.=
)

BTW, you also have to add

#include <linux/string.h>

as on some configs, I get

drivers/hid/hid-microsoft.c:50: error: =E2=80=98memcmp=E2=80=99 undecla=
red (first use
in this function)

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

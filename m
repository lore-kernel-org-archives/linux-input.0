From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] input: cros_ec_keyb_clear_keyboard() depends on CONFIG_PM_SLEEP
Date: Tue, 18 Jun 2013 10:39:10 +0200
Message-ID: <CAMuHMdVL=9m6zB_Jc+hE=iZr7LBT+vb9ckc2c-yxPJOvM-wrPQ@mail.gmail.com>
References: <1368049529-8168-1-git-send-email-geert@linux-m68k.org>
	<CAPnjgZ3Akf0+LKBt4c5HQX5c8PhL+zuvvHWrDpVj0W++GiOanA@mail.gmail.com>
	<20130515064248.GB24297@core.coreip.homeip.net>
	<20130617231638.GV7998@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:51039 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab3FRIjL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Jun 2013 04:39:11 -0400
In-Reply-To: <20130617231638.GV7998@zurbaran>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Glass <sjg@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lk <linux-kernel@vger.kernel.org>

On Tue, Jun 18, 2013 at 1:16 AM, Samuel Ortiz <sameo@linux.intel.com> w=
rote:
> On Tue, May 14, 2013 at 11:42:48PM -0700, Dmitry Torokhov wrote:
>> On Wed, May 08, 2013 at 09:25:56PM -0600, Simon Glass wrote:
>> > On Wed, May 8, 2013 at 3:45 PM, Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
>> > > If CONFIG_PM_SLEEP is not set:
>> > >
>> > > drivers/input/keyboard/cros_ec_keyb.c:211: warning: =E2=80=98cro=
s_ec_keyb_clear_keyboard=E2=80=99 defined but not used
>> > >
>> > > Move the definition of cros_ec_keyb_clear_keyboard() inside the =
section
>> > > protected by #ifdef CONFIG_PM_SLEEP to fix this.
>> > >
>> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> >
>> > Acked-by: Simon Glass <sjg@chromium.org>
>>
>> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> Could you please forward this to Linus as I do not have this driver =
in
>> my branch yet.
> I guess you took that one now ? Or are you expecting me to merge it ?

=46WIW, I also have it in my exotic-arch-fixes branch, now destined for=
 3.11.

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

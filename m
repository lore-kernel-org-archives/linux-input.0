From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Mon, 16 Mar 2015 13:50:01 -0500
Message-ID: <550725D9.20805@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com>	<201502202141.16017@pali>	<54EE1917.4020805@dell.com>	<201502252145.22577@pali>	<CAN+gG=EY-gyNKyEyfXw8hTDL8L4TR8OQLM2g+uLUUv_HM3mHWA@mail.gmail.com>	<5506E8D2.60207@dell.com> <CAOFGe97na_mw-_AHJn6zyxVb-kDAxntjEgvXRcy6eg7uPfhQ8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:10360 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbbCPSuS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 14:50:18 -0400
In-Reply-To: <CAOFGe97na_mw-_AHJn6zyxVb-kDAxntjEgvXRcy6eg7uPfhQ8A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Ekstrand <jason@jlekstrand.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?UTF-8?B?UGFsaSBS?= =?UTF-8?B?b2jDoXI=?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>


On 03/16/2015 12:10 PM, Jason Ekstrand wrote:
> On Mon, Mar 16, 2015 at 7:29 AM, Mario Limonciello
> <mario_limonciello@dell.com> wrote:
> It's nothing about the wireless.  I swapped it out for an intel card
> on day 3 or so.
>
> Yes, I am almost 100% sure that this affects suspend/resume.  Prior to
> the _REV hack, my laptop *never* suspended correctly.  Now it
> regularly suspends just fine.  I also double-checked that rebasing on
> Linus' master didn't affect it.  With the _REV hack it doesn't
> suspend.  Without it, it's just fine.
>
> I don't know much about suspend/resume but is it possible that the
> problem is the kernel not being able to properly shut down the sound
> card?
Thanks for that confirmation.  That does sound like a very likely candidate that it was because the audio device was in the wrong state.

> That matches what I've seen.  With the _REV hack, I see nothing about
> HDA in dmesg and I get different audio messages than with an _OSI of
> Windows 2009.
>
> I look forward to seeing the update.  Thanks for working on this!
> --Jason Ekstrand
Sure.  In in the interim, here is the patch you can apply to your local DSDT and put in the initramfs to see what it will look like w/ A02.  This will leave the touchpad in I2C and audio in HDA.

--- DSDT.A01    2015-02-18 18:12:44.891286890 -0600
+++ DSDT.A02    2015-03-03 23:17:24.075746660 -0600
@@ -21567,6 +21567,7 @@
                  {
                      ACOS = 0x80
                      ACSE = Zero
+                    OSTP = One
                  }
              }
          }


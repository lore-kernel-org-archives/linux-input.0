From: Jason Ekstrand <jason@jlekstrand.net>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Mon, 16 Mar 2015 13:42:23 -0700
Message-ID: <CAOFGe95VzKhvrFES9DHD4TB08XVd+pEMbDGVZ=fdAiDFLT9gVg@mail.gmail.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com>
	<201502202141.16017@pali>
	<54EE1917.4020805@dell.com>
	<201502252145.22577@pali>
	<CAN+gG=EY-gyNKyEyfXw8hTDL8L4TR8OQLM2g+uLUUv_HM3mHWA@mail.gmail.com>
	<5506E8D2.60207@dell.com>
	<CAOFGe97na_mw-_AHJn6zyxVb-kDAxntjEgvXRcy6eg7uPfhQ8A@mail.gmail.com>
	<550725D9.20805@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <550725D9.20805@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 16, 2015 at 11:50 AM, Mario Limonciello
<mario_limonciello@dell.com> wrote:
>
> On 03/16/2015 12:10 PM, Jason Ekstrand wrote:
>>
>> On Mon, Mar 16, 2015 at 7:29 AM, Mario Limonciello
>> <mario_limonciello@dell.com> wrote:
>> It's nothing about the wireless.  I swapped it out for an intel card
>> on day 3 or so.
>>
>> Yes, I am almost 100% sure that this affects suspend/resume.  Prior to
>> the _REV hack, my laptop *never* suspended correctly.  Now it
>> regularly suspends just fine.  I also double-checked that rebasing on
>> Linus' master didn't affect it.  With the _REV hack it doesn't
>> suspend.  Without it, it's just fine.
>>
>> I don't know much about suspend/resume but is it possible that the
>> problem is the kernel not being able to properly shut down the sound
>> card?
>
> Thanks for that confirmation.  That does sound like a very likely candidate
> that it was because the audio device was in the wrong state.
>
>> That matches what I've seen.  With the _REV hack, I see nothing about
>> HDA in dmesg and I get different audio messages than with an _OSI of
>> Windows 2009.
>>
>> I look forward to seeing the update.  Thanks for working on this!
>> --Jason Ekstrand
>
> Sure.  In in the interim, here is the patch you can apply to your local DSDT
> and put in the initramfs to see what it will look like w/ A02.  This will
> leave the touchpad in I2C and audio in HDA.
>
> --- DSDT.A01    2015-02-18 18:12:44.891286890 -0600
> +++ DSDT.A02    2015-03-03 23:17:24.075746660 -0600
> @@ -21567,6 +21567,7 @@
>                  {
>                      ACOS = 0x80
>                      ACSE = Zero
> +                    OSTP = One
>                  }
>              }
>          }
>

Thanks,
I'm now running a hacked up kernel that's Torvalds' tree from Saturday
morning (same as before) + a patch from Benjamin to fix the touchpad +
the DSDT hack given above.  With that, I have HDA audio (not I2S)
which is working.  Also, suspend/resume now works properly with this
new cocktail.
--Jason

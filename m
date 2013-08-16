From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2 1/2] input: document gamepad API and add extra keycodes
Date: Fri, 16 Aug 2013 23:39:44 +0200
Message-ID: <CANq1E4SxGTKoL+OXDaYN5S1x-GXbg7ym+e8ivCywe2FMqQgCvg@mail.gmail.com>
References: <1371303165-1802-1-git-send-email-dh.herrmann@gmail.com>
	<1371303165-1802-2-git-send-email-dh.herrmann@gmail.com>
	<20130626160727.GA32420@core.coreip.homeip.net>
	<alpine.LNX.2.00.1306271147150.3538@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1306271147150.3538@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Jiri

On Thu, Jun 27, 2013 at 11:47 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 26 Jun 2013, Dmitry Torokhov wrote:
>
>> On Sat, Jun 15, 2013 at 03:32:44PM +0200, David Herrmann wrote:
>> > --- a/include/uapi/linux/input.h
>> > +++ b/include/uapi/linux/input.h
>> > @@ -507,10 +507,14 @@ struct input_keymap_entry {
>> >
>> >  #define BTN_GAMEPAD                0x130
>> >  #define BTN_A                      0x130
>> > +#define BTN_SOUTH          0x130
>>
>> Could we do:
>>
>> #define BTN_SOUTH             0x130
>> #define BTN_A                 BTN_SOUTH
>>
>> so that it is clear that BTN_A, BTN_B, etc are legacy definitions and
>> not an accidental typos that need their own key codes.
>
> Makes sense, will do that modification.
>
>> Otherwise:
>>
>> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Thanks Dmitry. Will be taking it (with the above modification) through my
> tree.

Hm, I just noticed that this got merged without the
Documentation/input/gamepad.txt description. Was this intentional?
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d09bbfd2a8408a995419dff0d2ba906013cf4cc9

Regards
David

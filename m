From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 2/4] Input - synaptics: do not release extra buttons once
 they are pressed
Date: Mon, 2 Feb 2015 17:14:09 -0500
Message-ID: <CAN+gG=HBw6FYtVbgm=rLNEK5amxHkEqwTRtagTj14_Uf_iUv2Q@mail.gmail.com>
References: <1422475807-15033-1-git-send-email-benjamin.tissoires@redhat.com>
	<1422475807-15033-3-git-send-email-benjamin.tissoires@redhat.com>
	<20150202214640.GC23909@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:51879 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933531AbbBBWOL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Feb 2015 17:14:11 -0500
In-Reply-To: <20150202214640.GC23909@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Feb 2, 2015 at 4:46 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Jan 28, 2015 at 03:10:05PM -0500, Benjamin Tissoires wrote:
>> The current code releases the extra buttons right after they are pressed.
>> As soon as a new serio report comes in, the hw state is reset to 0
>> and so the buttons are released.
>>
>> Check for the report type before acting on the current extra buttons
>> state.
>
> No:
>
> "If Ext is 0 (if bit 1 of bytes 1 and 4 are the same) then there are no
> external buttons being pressed (or all external buttons have been
> released)." - Synaptics PS/2 TouchPad Interfacing Guide PN:
> 511-000275-01 Rev. B
>

Hmm, indeed, the current code follows the spec. Yeah! a new firmware bug!

So when I dumped the ps/2 reports, I clearly saw the release report
being sent with the Ext bit to 1, and other reports were in between
with no information (because no fingers were on the touchpad).

I may have access to the hardware tomorrow if the snow has been
removed from the roads, but tonight, I won't be able to test anything
:(

Cheers,
Benjamin

>
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> ---
>>  drivers/input/mouse/synaptics.c | 10 +++++++---
>>  drivers/input/mouse/synaptics.h |  3 +++
>>  2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
>> index 0d12664..d58863b 100644
>> --- a/drivers/input/mouse/synaptics.c
>> +++ b/drivers/input/mouse/synaptics.c
>> @@ -688,7 +688,7 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
>>               }
>>
>>               if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) &&
>> -                 ((buf[0] ^ buf[3]) & 0x02)) {
>> +                 SYN_REPORT_EXT_BUTTONS(buf)) {
>>                       switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)) {
>>                       default:
>>                               /*
>> @@ -792,8 +792,12 @@ static void synaptics_report_buttons(struct psmouse *psmouse,
>>               input_report_key(dev, BTN_BACK, hw->down);
>>       }
>>
>> -     for (i = 0; i < SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap); i++)
>> -             input_report_key(dev, BTN_0 + i, hw->ext_buttons & (1 << i));
>> +     if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) &&
>> +         SYN_REPORT_EXT_BUTTONS(psmouse->packet)) {
>> +             for (i = 0; i < SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap); i++)
>> +                     input_report_key(dev, BTN_0 + i,
>> +                                      hw->ext_buttons & (1 << i));
>> +     }
>>  }
>>
>>  static void synaptics_report_mt_data(struct psmouse *psmouse,
>> diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
>> index 6faf9bb..0b2b711 100644
>> --- a/drivers/input/mouse/synaptics.h
>> +++ b/drivers/input/mouse/synaptics.h
>> @@ -115,6 +115,9 @@
>>  #define SYN_NEWABS_RELAXED           2
>>  #define SYN_OLDABS                   3
>>
>> +/* synaptics extended button packet */
>> +#define SYN_REPORT_EXT_BUTTONS(buf)  (((buf)[0] ^ (buf)[3]) & 0x02)
>> +
>>  /* amount to fuzz position data when touchpad reports reduced filtering */
>>  #define SYN_REDUCED_FILTER_FUZZ              8
>>
>> --
>> 2.1.0
>>
>
> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

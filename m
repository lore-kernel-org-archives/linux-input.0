From: Shawn Nematbakhsh <shawnn@chromium.org>
Subject: Re: [PATCH] Input: trackpoint - Optimize trackpoint init to use
 power-on reset
Date: Tue, 9 Apr 2013 14:53:44 -0700
Message-ID: <CALaWCOOBnsn-mcyp3V1hiP4CwBze9mzEoTV_jeM6gm6kKBZ60Q@mail.gmail.com>
References: <1364326601-16571-1-git-send-email-shawnn@chromium.org>
	<20130328053218.GB2812@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:41722 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936356Ab3DIVxp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Apr 2013 17:53:45 -0400
Received: by mail-ve0-f169.google.com with SMTP id d10so7026466vea.28
        for <linux-input@vger.kernel.org>; Tue, 09 Apr 2013 14:53:45 -0700 (PDT)
In-Reply-To: <20130328053218.GB2812@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: JJ Ding <dgdunix@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chung-yih Wang <cywang@chromium.org>

Hi Dmitry,

Thanks for the review. Comments in-line.

On Wed, Mar 27, 2013 at 10:32 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Shawn,
>
> On Tue, Mar 26, 2013 at 12:36:41PM -0700, Shawn Nematbakhsh wrote:
>> The trackpoint driver sets various parameter default values, all of
>> which happen to be power-on defaults (Source: IBM TrackPoint Engineering
>> Specification, Version 4.0. Also confirmed by empirical data).
>>
>> By sending the power-on reset command to reset all parameters to
>> power-on state, we can skip the lengthy process of programming all
>> parameters. In testing, ~2.5 secs of time writing parameters was reduced
>> to .35 seconds waiting for power-on reset to complete.
>>
>> Signed-off-by: Shawn Nematbakhsh <shawnn@chromium.org>
>> ---
>>  drivers/input/mouse/trackpoint.c | 223 +++++++++++++++++++++++++--------------
>>  drivers/input/mouse/trackpoint.h |   7 +-
>>  2 files changed, 149 insertions(+), 81 deletions(-)
>>
>> diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
>> index f310249..17e9b36 100644
>> --- a/drivers/input/mouse/trackpoint.c
>> +++ b/drivers/input/mouse/trackpoint.c
>> @@ -20,6 +20,26 @@
>>  #include "trackpoint.h"
>>
>>  /*
>> + * Power-on Reset: Resets all trackpoint parameters, including RAM values,
>> + * to defaults.
>> + * Returns zero on success, non-zero on failure.
>> + */
>> +static int trackpoint_power_on_reset(struct ps2dev *ps2dev)
>> +{
>> +     unsigned char results[2];
>> +
>> +     if (ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, TP_COMMAND)) ||
>> +         ps2_command(ps2dev, results, MAKE_PS2_CMD(0, 2, TP_POR))) {
>> +             return -1;
>> +     }
>> +
>> +     /* POR response should be 0xAA00 or 0xFC00 */
>> +     if ((results[0] != 0xAA && results[0] != 0xFC) || results[1] != 0x00)
>> +             return -1;
>
> I am a bit concerned about this. 0xfc00 indicates POR failure. In this
> case shouldn't we try to reset the device, issue another POR and bail if
> it fails again?
>

Yes, you are correct. I just now posted v2 to fix this. Now, on
0xfc00, we attempt one retry. On subsequent 0xfc00, we fail POR and
attempt to set parameters manually.

>>
>>  static struct attribute *trackpoint_attrs[] = {
>>       &psmouse_attr_sensitivity.dattr.attr,
>> @@ -179,6 +241,9 @@ static struct attribute *trackpoint_attrs[] = {
>>       &psmouse_attr_press_to_select.dattr.attr,
>>       &psmouse_attr_skipback.dattr.attr,
>>       &psmouse_attr_ext_dev.dattr.attr,
>> +     &psmouse_attr_twohand.dattr.attr,
>> +     &psmouse_attr_source_tag.dattr.attr,
>> +     &psmouse_attr_mb.dattr.attr,
>
> What is the benefit of adding these 3 new attributes?
>

Previously, these attributes were handled in a special way -- the
corresponding TP values were set to default, but the attributes were
not exported. Now, they are set to default and exported. It makes for
cleaner code.

I see no good use for these attributes other than driver hacking. I
can remove them if you think it's best.

> Thanks.
>
> --
> Dmitry

Thanks,

Shawn

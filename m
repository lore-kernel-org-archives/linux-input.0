From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Subject: Re: [RFC v2 0/1] User-space HID I/O Driver
Date: Thu, 26 Apr 2012 15:19:20 -0300
Message-ID: <CAAngNMbj3tzeDFvbm7KmHHR6vOYc02gq1d5aqeisgSD+N6HixA@mail.gmail.com>
References: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com>
	<CAAngNMa0npQwBv+y_giRTOeLUMYiEnwWw4-cA+xMiRRsK732Mw@mail.gmail.com>
	<CAAngNMaOHRRfTy5yT9ys0Cv5yB5t-zEVxwcZWuK64BEA4oRy2g@mail.gmail.com>
	<alpine.LNX.2.00.1204031513070.9041@pobox.suse.cz>
	<CAAngNMYx4YcC8kEuZkEgojbFLf7BtchTCEDs927P+oqfr_oKnQ@mail.gmail.com>
	<CAKT1EBesnson8JR+rTFtQyjATUj09QhR99Lg=ouN4aCeJJbviQ@mail.gmail.com>
	<CANq1E4SZQCjNstK2Fbwce5TxzYkRv=avDbyP7AthvABno76+bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:59586 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757030Ab2DZSTV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Apr 2012 14:19:21 -0400
Received: by dadz8 with SMTP id z8so1915067dad.10
        for <linux-input@vger.kernel.org>; Thu, 26 Apr 2012 11:19:20 -0700 (PDT)
In-Reply-To: <CANq1E4SZQCjNstK2Fbwce5TxzYkRv=avDbyP7AthvABno76+bA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, chen.ganir@ti.com, linux-bluetooth@vger.kernel.org, anderson.lizardo@openbossa.org, marcel@holtmann.org

On Thu, Apr 26, 2012 at 2:54 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Claudio
>
> On Thu, Apr 26, 2012 at 7:22 PM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>> Hi David/Jiri,
> [snip]
>>
>> The basic features are now working, we have tested HoG keyboard and
>> mouse. The major features missing related to HID are output/feature
>> reports, and suspend.
>
> Output reports should be working. Only thing missing is feature input
> reports. They are not implemented yet. However, what driver (except
> hidraw and picolcd) uses them?
>
>> My HID knowledge is quite limited but it seems that output reports a=
re
>> not working on uhid, at least I didn't see events from the host. Eve=
n
>> for USB keyboard it doesn't work, do you have any pointers?
>
> Do you actually handle the UHID_OUTPUT and UHID_OUTPUT_EV events from
> UHID? I have looked at the HoG code recently and haven't seen any cod=
e
> that correctly parses UHID_OUTPUT_EV packets? These packets contain
> LED (capslock, numlock etc.) updates so the keyboard can actually set
> them. They also contain BELL/SOUND codes for such devices. Only other
> non-standard stuff is sent through UHID_OUTPUT reports. If there are
> problems with it, I can help implementing this.
>

We're handling these events, but this code has not been sent to the
mailing list yet. We're going to re-send the same patchset as before,
with comments fixed, and send a RFC for the output reports handling
afterwards.

> Regarding UHID, I will send an updated version this weekend which
> mainly improves the internal buffer handling. The API will stay the
> same, however, I might implement the feature input reports, then
> everything should be ready for merging upstream (if the review cycles
> go well ;)).
>

Good to hear that! We've been using it on a daily basis to work on the
HoG implementation and haven't noticed any major issue.

--=20
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

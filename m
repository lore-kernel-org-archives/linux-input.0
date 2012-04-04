From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Subject: Re: [RFC v2 0/1] User-space HID I/O Driver
Date: Wed, 4 Apr 2012 19:59:57 -0300
Message-ID: <CAAngNMYx4YcC8kEuZkEgojbFLf7BtchTCEDs927P+oqfr_oKnQ@mail.gmail.com>
References: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com>
	<CAAngNMa0npQwBv+y_giRTOeLUMYiEnwWw4-cA+xMiRRsK732Mw@mail.gmail.com>
	<CAAngNMaOHRRfTy5yT9ys0Cv5yB5t-zEVxwcZWuK64BEA4oRy2g@mail.gmail.com>
	<alpine.LNX.2.00.1204031513070.9041@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50423 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932515Ab2DDW75 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Apr 2012 18:59:57 -0400
Received: by pbcun15 with SMTP id un15so810198pbc.19
        for <linux-input@vger.kernel.org>; Wed, 04 Apr 2012 15:59:57 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1204031513070.9041@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org, chen.ganir@ti.com, claudio.takahasi@openbossa.org, linux-bluetooth@vger.kernel.org, anderson.lizardo@openbossa.org, marcel@holtmann.org

On Tue, Apr 3, 2012 at 7:14 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 3 Apr 2012, Joao Paulo Rechi Vita wrote:
>
>> >> This is the second revision of the UHID driver. It basically allo=
ws to register
>> >> hid_ll_drivers in user-space. This is needed to implement Bluetoo=
th HoG (HID
>> >> over GATT) as discussed earlier.
>> >>
>> >
>> > We have a first prototype implementation of the HoG plugin working
>> > with the uhid driver \o/
>> >
>>
>> I'm having problems with modifiers keys (they don't work). The USB-H=
ID
>> spec says that for each modifier key pressed a bit have to be set on
>> the modifiers byte (byte 2) of the report array. Dumping the data bo=
th
>> on the HoG plugin on bluetoothd and through hidraw for the created H=
ID
>> device shows that these bits are being set correctly.
>>
>> Any idea of what could be wrong or additional checks that can be per=
formed?
>
> So hidraw shows the respective bits set properly, but they are not co=
ming
> out of /dev/input/eventX, right?
>

Exactly.

> How about /syse/kernel/debug/hid/<device>/events, does it show the ev=
ents?
>

Thanks for the help, but it wasn't needed. The problem was actually on
the userspace HoG->HID parsing, we're adding an additional 0x00 byte
to the beginning of the array. Now modifiers works!

--=20
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

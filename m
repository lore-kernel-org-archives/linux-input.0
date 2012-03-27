From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Subject: Re: [RFC v2 0/1] User-space HID I/O Driver
Date: Tue, 27 Mar 2012 15:43:07 -0300
Message-ID: <CAAngNMa0npQwBv+y_giRTOeLUMYiEnwWw4-cA+xMiRRsK732Mw@mail.gmail.com>
References: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49199 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880Ab2C0SnI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Mar 2012 14:43:08 -0400
Received: by yhmm54 with SMTP id m54so207519yhm.19
        for <linux-input@vger.kernel.org>; Tue, 27 Mar 2012 11:43:07 -0700 (PDT)
In-Reply-To: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chen.ganir@ti.com, claudio.takahasi@openbossa.org, linux-bluetooth@vger.kernel.org, anderson.lizardo@openbossa.org, marcel@holtmann.org

Hello all,

On Mon, Mar 26, 2012 at 5:20 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi
>
> This is the second revision of the UHID driver. It basically allows t=
o register
> hid_ll_drivers in user-space. This is needed to implement Bluetooth H=
oG (HID
> over GATT) as discussed earlier.
>

We have a first prototype implementation of the HoG plugin working
with the uhid driver \o/

I'll send a RFC to the linux-bluetooth mailing list later, but I think
it's nice to give some feedback on the uhid module here as well.

The only problem I've encountered while testing it was that it doesn't
seem to work if I set the 'bus' field on the struct uhid_create_req to
BUS_BLUETOOTH. Initially I thought this was just metadata, but
changing it to BUS_USB makes it work.

Additionally, I don't know if you forgot or did it on purpose, but you
didn't add the uhid example to samples/Kconfig and sample/Makefile.

> Changes:
> =C2=A0- Improved documentation
> =C2=A0- Added example which emulates a 3-button mouse with wheel in u=
ser-space

I've (partially) tested the example, on a X-less virtual machine. I'll
try it on a box with X so I can attach the virtual mouse to a pointer
in X and see the cursor moving.

> =C2=A0- Fixed some remaining bugs
>
> I didn't change any major parts. I checked that writev/readv work cor=
rectly and
> I documented how to use it in ./Documentation/hid/uhid.txt.
>
> For a full example please see ./samples/uhid/uhid-example.c.
>
> While developing it I also considered moving HIDP to user-space. If w=
e do BT-HoG
> in user-space, it should be easier to also move HIDP to user-space. T=
he current
> in-kernel HIDP is buggy, anyway.
>
> Still open points:
> =C2=A0- How do I get a proper "parent" pointer for uhid->hid->dev.par=
ent? I could use
> =C2=A0 the uhid misc device as parent or is there some device-struct =
inside "struct
> =C2=A0 file"?
> =C2=A0- Should user-space be able to provide "uniq" and "phys" names =
for HID-devices?
> =C2=A0- uhid_event is quite big (>4KB) which makes uhid_device really=
 big (~70KB).
> =C2=A0 Should I allocate the ring-buffer dynamically to avoid this?
> =C2=A0- Should I provide the quirks field to user-space? Probably as =
part of
> =C2=A0 UHID_START?
> =C2=A0- Could someone review x32 COMPAT stuff? I tried to align all t=
he public
> =C2=A0 structures correctly so I could even remove the __packed attri=
bute. Anyway, I
> =C2=A0 thought keeping it is probably better for future extensions.
>
> I spent some time on the locks and they seem all fine. I couldn't fin=
d any
> races.
>
> Jiri, Marcel, could you review the design and tell me what you think?
>
> A short notice about the protocol:
> User-space is allowed to send only as much data as is needed for the =
event. That
> is, when sending the UHID_DESTROY event (which has no payload) it wou=
ld be
> actually enough to only send a __u32 field (ev->type) with write().
> This is not to speed up the write()s or read()s but rather to allow e=
xtending
> the uhid_event structure in the future. We can actually add arbitrary=
 extra
> event-types and still keep ABI compatibility. Therefore, I thought of=
 adding an
> "uhid_version" field to UHID_CREATE so user-space can define what UHI=
D protocol
> it is using.
>
> Regards
> David
>
> David Herrmann (1):
> =C2=A0HID: User-space I/O driver support for HID subsystem
>
> =C2=A0Documentation/hid/uhid.txt =C2=A0| =C2=A0152 ++++++++++++++
> =C2=A0drivers/hid/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 21 ++
> =C2=A0drivers/hid/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
2 +-
> =C2=A0drivers/hid/uhid.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A047=
3 +++++++++++++++++++++++++++++++++++++++++++
> =C2=A0include/linux/Kbuild =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
1 +
> =C2=A0include/linux/uhid.h =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 84 +++=
+++++
> =C2=A0samples/uhid/Makefile =C2=A0 =C2=A0 =C2=A0 | =C2=A0 10 +
> =C2=A0samples/uhid/uhid-example.c | =C2=A0381 +++++++++++++++++++++++=
+++++++++++
> =C2=A08 files changed, 1123 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 Documentation/hid/uhid.txt
> =C2=A0create mode 100644 drivers/hid/uhid.c
> =C2=A0create mode 100644 include/linux/uhid.h
> =C2=A0create mode 100644 samples/uhid/Makefile
> =C2=A0create mode 100644 samples/uhid/uhid-example.c
>
> --
> 1.7.9.4
>



--=20
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

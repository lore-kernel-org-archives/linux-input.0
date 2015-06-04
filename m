From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 0/5] HID: wacom: Support tablets with pen and touch on
 same interface
Date: Thu, 04 Jun 2015 10:34:32 -0700
Message-ID: <55708C28.5020705@gmail.com>
References: <1433380697-28612-1-git-send-email-killertofu@gmail.com> <20150604141846.GB2495@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33108 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908AbbFDReg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Jun 2015 13:34:36 -0400
Received: by padj3 with SMTP id j3so33727058pad.0
        for <linux-input@vger.kernel.org>; Thu, 04 Jun 2015 10:34:35 -0700 (PDT)
In-Reply-To: <20150604141846.GB2495@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On 6/4/2015 7:18 AM, Benjamin Tissoires wrote:
> Hi Jason,
>=20
> On Jun 03 2015 or thereabouts, Jason Gerecke wrote:
>> I've recently got my hands on a device which has an I2C sensor that =
sends
>> both pen and touch reports from a single interface. To userspace, it=
 shows
>> up as a single input device which blends both the report types (e.g.=
 it has
>> ABS_PRESSURE for the pen, and ABS_MT_POSITION_X for the touch). This=
 patch
>> set modifies the driver to be able to handle devices which place bot=
h pen
>> and touch on a the same interface. It does this by treating the pen,=
 touch,
>> and pad (which was already special-cased) independently. If a device=
 has
>> the appropriate device_type, one or more of pen/touch/pad input devi=
ces
>> will be created, initialized, and used to send data to userspace.
>>
>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>=20
> This all seems sensible. I gave a quick look yesterday and could not
> found any obvious problem, but I'd like to review it more thoroughly
> before giving my rev-by (and do a little bit of testing too).
>=20
> I don't believe there will be any problems for the series, besides th=
e
> Bamboo PAD. Have you tested on this?
>=20
> Cheers,
> Benjamin
>=20

I don't have a Bamboo PAD to test with, but carefully looking at each
interface's HID descriptor makes me think you may be right. The debug
interface in particular uses a WACOM_VENDORDEFINED_PEN application
collection and will be marked as WACOM_DEVICETYPE_PEN instead of
WACOM_DEVICETYPE_TOUCH.

The smallest fix that should do the trick would be to just swap the
device_type in 'wacom_setup_device_quirks'. Alternatively, we could onl=
y
allow the debug interface to be probed, set the touch device type flag
(in addition to the automatically-set pen flag), and extend the IRQ
function to explicitly handle pen events. The alternative is a bit more
work (and we'd need somebody with a device to test it...) but I think
might make the codepath for the Bamboo PAD a bit easier to follow.

--=20
Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one /
(That is to say, eight) to the two, /
But you can=E2=80=99t take seven from three, /
So you look at the sixty-fours....

>>
>> Jason Gerecke (5):
>>   HID: wacom: Simplify 'wacom_update_name'
>>   HID: wacom: Treat features->device_type values as flags
>>   HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD device_type
>>   HID: wacom: Split apart 'wacom_setup_pentouch_input_capabilites'
>>   HID: wacom: Introduce new 'touch_input' device
>>
>>  drivers/hid/wacom.h     |   4 +-
>>  drivers/hid/wacom_sys.c | 194 +++++++++++++++----------
>>  drivers/hid/wacom_wac.c | 379 ++++++++++++++++++++++++++-----------=
-----------
>>  drivers/hid/wacom_wac.h |  15 +-
>>  4 files changed, 332 insertions(+), 260 deletions(-)
>>
>> --=20
>> 2.4.1
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

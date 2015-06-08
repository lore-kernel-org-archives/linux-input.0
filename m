From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 0/5] HID: wacom: Support tablets with pen and touch on
 same interface
Date: Mon, 08 Jun 2015 10:49:41 -0700
Message-ID: <5575D5B5.8040408@gmail.com>
References: <1433380697-28612-1-git-send-email-killertofu@gmail.com> <20150608155947.GD18162@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36766 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbbFHRtr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jun 2015 13:49:47 -0400
Received: by pdjm12 with SMTP id m12so109487345pdj.3
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2015 10:49:46 -0700 (PDT)
In-Reply-To: <20150608155947.GD18162@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On 6/8/2015 8:59 AM, Benjamin Tissoires wrote:
> Hi again,
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
> So, besides the typo in 5/5, the series is:
> Reviewed-by: Bnejamin Tissoires <benjamin.tissoires@redhat.com>
>=20
> I'll send a follow up patch to fix the Bamboo PAD extra interface onc=
e
> this will land in Jiri's tree.
>=20
> Cheers,
> Benjamin
>=20
>=20
Just stumbled across a bug with wireless operation (missing pad device)=
=2E
Hopefully Jiri hasn't merged anything yet :)

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

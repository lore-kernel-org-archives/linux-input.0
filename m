From: Amit Nagal <helloin.amit@gmail.com>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 03:30:54 -0700
Message-ID: <AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>
	<4C2A1FA0.6020704@signal11.us>
	<alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60480 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab0F3Kaz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 06:30:55 -0400
In-Reply-To: <alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Alan Ott <alan@signal11.us>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

HI ,

is it possible to add these ioctls to hidraw interface ?

1)

ioctl with which application can get  input / output feature report and=
 size .

2)

ioctl  which sets a flag so that when device sends a report , report
id & report type  is prefixed
to output of read() .
i mean when application calls read , it gets input report as <report
id ><report type ><payload >
right now we get <payload > only .

this kind of read() output  helps in situation where a application
specific payload is dispersed
across multiple input reports but using same report id .
the functionality which is desired above is same as provided by
HIDDEV_FLAG_REPORT
for  hiddev  interface .

Thanx & Regards
Amit Nagal



On Wed, Jun 30, 2010 at 2:26 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 29 Jun 2010, Alan Ott wrote:
>
>> > i am trying to send a vendor specific HID report from a userspace =
host
>> > program to vendor usb hid device
>> > using HIDRAW interface .
>> >
>> >
>> > but when i send report in the format< =A0"Report ID "(0th byte )>
>> > <Report ID (1st byte )> =A0< =A0"data payload">
>> > i am getting perfect report response from usb device .
>> > =A0 where we use usb_control_msg as =A0:
>> >
>> > ret =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
>> > =A0 =A0 =A0 =A0 =A0 =A0 HID_REQ_SET_REPORT,
>> > =A0 =A0 =A0 =A0 =A0 =A0 USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_I=
NTERFACE,
>> > =A0 =A0 =A0 =A0 =A0 =A0 cpu_to_le16(((HID_OUTPUT_REPORT + 1)<< =A0=
8) | *buf),
>> > =A0 =A0 =A0 =A0 =A0 =A0 interface->desc.bInterfaceNumber, buf + 1,=
 count - 1,
>> > =A0 =A0 =A0 =A0 =A0 =A0 USB_CTRL_SET_TIMEOUT);
>> >
>> >
>>
>> I thought I'd be able to just go check the HID specification and be =
able to
>> say that the report number is not sent as part of the payload for Se=
t_Report
>> devices, since it would be redundant because the Report ID is sent o=
ver in the
>> wValue field.
>>
>> Unfortunately, I was not able to see that clearly laid out in the HI=
D
>> specification in the section on Set_Report. I did however find langu=
age saying
>> "if a Report ID tag was used in the Report descriptor, all reports i=
nclude a
>> single byte ID prefix," in section 8.1, Report Types.
>>
>> I did some tests with the Windows implementation, and indeed, when n=
umbered
>> reports are used in the HID descriptor, the Windows implementation w=
ill send
>> the report ID as the first byte of the payload.
>>
>> Based on the language in the HID spec, and the behavior of Windows, =
I believe
>> the buf+1, count-1 to be a bug.
>>
>> Jiri, what do you think? Can you confirm?
>
> Correct, it is a bug indeed.
>
> Does any of you guys already have a patch handy which I could apply?
> Otherwise I'll fix it myself.
>
> Thanks for spotting it,
>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

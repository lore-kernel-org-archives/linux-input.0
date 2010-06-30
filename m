From: Amit Nagal <helloin.amit@gmail.com>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 09:40:23 -0700
Message-ID: <AANLkTimb_xMYTZYAm51lmHEkYvrvegwbmkUyJldxYA-f@mail.gmail.com>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>
	<4C2A1FA0.6020704@signal11.us>
	<alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
	<AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>
	<alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>
	<AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com>
	<4C2B3E6B.7060703@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44199 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab0F3QkZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 12:40:25 -0400
In-Reply-To: <4C2B3E6B.7060703@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>, Xiaofan Chen <xiaofanc@gmail.com>

Hi  ,

ok i explain my requirements again .


(1)

the hid device  i am  dealing with does not tell in its payload
protocol specifications
how many input and output reports it will support and what will be the
their respective size . the only thing it tells is payload data will
be in the format
<Report ID> <Payload > .

 >If you know what type of device you are talking to, then you shouldn'=
t
> really need to parse the descriptor in software, because you'll know =
what
> the device supports, right?
>

No , this information is not available to me in advance .
the application should parse the report descriptor currently
and identify the no of input and output reports currently available
along with their sizes .

infact in my view , it does make sense to get <Report ID> <Report Len >
from report descriptor only , as a device protocol specification may ch=
ange
for its  future releases . and no of reports may increase .
so its better to get this information from report descriptor only sent
by the device .


(2)

now lets consider the case for sending report to device .

different output reports have different sizes .

so depending upon application payload length ,

i have to select which < output report ID > should be used .

so hid_write should be

buff[0] =3D  < Output Report ID having Report Len >=3D application payl=
oad >
buff[1....n] =3D <payload data > .

since i need to know dynamically which output report id should be used
i stressed the need for ioctl which can fetch  the basic information
 <Report ID ><Report Len> parsed from report descriptor send by the dev=
ice .

i agree hidraw interface sends / receives raw events and
this functionalty indeed is required by my application ,
but still to send report , i need to choose report id depending
upon application payload size .
Also report id and report length information supported is not
described in device protocol specs .

i think hidraw interface should provide support for
<report id > <report len > information as application needs to
dynamically provides information
to buff[0] =3D <Report ID> ( we cannot hardcode this value )

(3)

now lets consider the case for hid device read .

the syntax is read( fd , buff , count );

what i want is

buff[0]  =3D <Input Report ID>
buff[1...n] =3D <Report Payload >

Yes i agree the < Report type > information is not required .

as i explained previously one application payload can be split across
multiple reports using same <Report Id >

so if Report ID information also comes in buff[0]
it becomes easy to identify one application payload spilt across multip=
le
reports using same <Report ID>.


(4)

Regarding libusb / libhid usage ,
the usb device i am using is a composite device
having hid and audio interfaces .

is it possible to claim audio interface from kernel space
and hid interface from user space ?

Thanx & Regards
Amit Nagal
















On Wed, Jun 30, 2010 at 5:54 AM, Alan Ott <alan@signal11.us> wrote:
> On 06/30/2010 07:14 AM, Amit Nagal wrote:
>>
>> sorry my mistake :
>>
>> what i wanted to ask was ioctl with which application can get
>> input / output / feature<REPORT ID> =A0and< =A0REPORT LEN> =A0.
>>
>> Thanx& =A0Regards
>> Amit Nagal
>
> Amit,
>
> There is a new ioctl() staged for the new merge window which will get=
 and
> set feature reports. It is used like this:
>
> =A0 =A0 =A0 =A0/* Set Feature */
> =A0 =A0 =A0 =A0buf[0] =3D 0x9; /* Report Number */
> =A0 =A0 =A0 =A0buf[1] =3D 0xff; /* data */
> =A0 =A0 =A0 =A0buf[2] =3D 0xff;
> =A0 =A0 =A0 =A0buf[3] =3D 0xff;
> =A0 =A0 =A0 =A0res =3D ioctl(fd, HIDIOCSFEATURE(4), buf);
>
> Is that what you're asking for, or are you asking for something which=
 will
> tell you which reports are _available_ on the device, and what their =
lengths
> are? There is currently no way to report which reports are _available=
_. As
> Jiri said, HIDRAW does not do any parsing of the report descriptor. A=
ll data
> is passed "raw" from the user application to the device.
>
> If you know what type of device you are talking to, then you shouldn'=
t
> really need to parse the descriptor in software, because you'll know =
what
> the device supports, right?
>
> Alan.
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Amit Nagal <helloin.amit@gmail.com>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 00:56:05 -0700
Message-ID: <AANLkTimeMlK_nciq_dQ0i1VA13KyKfIgC0JYYdQynV20@mail.gmail.com>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>
	<4C2A1FA0.6020704@signal11.us>
	<AANLkTimpF7h-L-qaR-YCBKwr2xRfkOQwQIXKAZDcdDA0@mail.gmail.com>
	<AANLkTikzQ93oJc0-TYuAmiYnq-UaNqOW6H80Cg449gS6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54305 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab0F3H4H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 03:56:07 -0400
In-Reply-To: <AANLkTikzQ93oJc0-TYuAmiYnq-UaNqOW6H80Cg449gS6@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Xiaofan Chen <xiaofanc@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

Hi ,

Also i want to bring to notice the following facts regarding hidraw int=
erface :

1)

 it seems no documentation is available in the linux kernel regarding
hidraw interface usage .
it should be available like the hiddev interface file hiddev.txt .
(though  on browising over net i do find hidraw.txt , but it shud be
there in linux kernel documentation ) .

2)
no ioctl is available to fetch input / output / feature report id and s=
ize .
userspace application has to  parse report descriptor on its own and
fetch report id and size .
if some ioctl is there to fetch report id and size . it is much more
convinient for the application
to use hidraw interface .



thanx and regards
Amit Nagal

On Wed, Jun 30, 2010 at 12:39 AM, Amit Nagal <helloin.amit@gmail.com> w=
rote:
> Hi ,
>
>
> Thanx for the reply .
>
> The below discussions clears the ambiguity regarding =A0 <report id >=
 usage =A0.
>
> I hope some patch regarding the same bug fix will be there for hidraw
> interface .
>
> Thanx & regards
> Amit Nagal
>
>
>
> On Tue, Jun 29, 2010 at 4:32 PM, Xiaofan Chen <xiaofanc@gmail.com> wr=
ote:
>> On Wed, Jun 30, 2010 at 12:30 AM, Alan Ott <alan@signal11.us> wrote:
>>
>>> I thought I'd be able to just go check the HID specification and be=
 able to
>>> say that the report number is not sent as part of the payload for S=
et_Report
>>> devices, since it would be redundant because the Report ID is sent =
over in
>>> the wValue field.
>>>
>>> Unfortunately, I was not able to see that clearly laid out in the H=
ID
>>> specification in the section on Set_Report. I did however find lang=
uage
>>> saying "if a Report ID tag was used in the Report descriptor, all r=
eports
>>> include a single byte ID prefix," in section 8.1, Report Types.
>>>
>>> I did some tests with the Windows implementation, and indeed, when =
numbered
>>> reports are used in the HID descriptor, the Windows implementation =
will send
>>> the report ID as the first byte of the payload.>>
>>> Based on the language in the HID spec, and the behavior of Windows,=
 I
>>> believe the buf+1, count-1 to be a bug.
>>>
>>
>> Yes I think it is a bug.
>>
>> And the HID specification states:
>> "If a Report ID tag was used in the Report descriptor, all reports
>> include a single byte ID prefix. If the Report ID tag was not used, =
all
>> values are returned in a single report and a prefix ID is not includ=
ed
>> in that report."
>>
>> My understanding is like the following and testing confirms it.
>> 1) when HID device has explicit report IDs, then the report IDs will
>> be transmitted on the bus.
>> 2) when the HID device does not use report ID at all (implicit repor=
t ID 0),
>> then this report ID 0 is not transmitted on the bus
>>
>> Reference:
>> http://www.microchip.com/forums/tm.aspx?m=3D494711
>> http://libusb.6.n5.nabble.com/Missing-first-byte-when-reading-HID-Fe=
ature-Reports-with-ID-td9460.html
>> (we spent quite some efforts to get the libusb-1.0 Windows native
>> HID backend to deal with report ID correctly).
>>
>> --
>> Xiaofan http://sourceforge.net/projects/libusb-win32/
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Amit Nagal <helloin.amit@gmail.com>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 00:39:56 -0700
Message-ID: <AANLkTikzQ93oJc0-TYuAmiYnq-UaNqOW6H80Cg449gS6@mail.gmail.com>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>
	<4C2A1FA0.6020704@signal11.us>
	<AANLkTimpF7h-L-qaR-YCBKwr2xRfkOQwQIXKAZDcdDA0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61527 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab0F3Hj5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 03:39:57 -0400
In-Reply-To: <AANLkTimpF7h-L-qaR-YCBKwr2xRfkOQwQIXKAZDcdDA0@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Xiaofan Chen <xiaofanc@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

Hi ,


Thanx for the reply .

The below discussions clears the ambiguity regarding   <report id > usage  .

I hope some patch regarding the same bug fix will be there for hidraw
interface .

Thanx & regards
Amit Nagal



On Tue, Jun 29, 2010 at 4:32 PM, Xiaofan Chen <xiaofanc@gmail.com> wrote:
> On Wed, Jun 30, 2010 at 12:30 AM, Alan Ott <alan@signal11.us> wrote:
>
>> I thought I'd be able to just go check the HID specification and be able to
>> say that the report number is not sent as part of the payload for Set_Report
>> devices, since it would be redundant because the Report ID is sent over in
>> the wValue field.
>>
>> Unfortunately, I was not able to see that clearly laid out in the HID
>> specification in the section on Set_Report. I did however find language
>> saying "if a Report ID tag was used in the Report descriptor, all reports
>> include a single byte ID prefix," in section 8.1, Report Types.
>>
>> I did some tests with the Windows implementation, and indeed, when numbered
>> reports are used in the HID descriptor, the Windows implementation will send
>> the report ID as the first byte of the payload.>>
>> Based on the language in the HID spec, and the behavior of Windows, I
>> believe the buf+1, count-1 to be a bug.
>>
>
> Yes I think it is a bug.
>
> And the HID specification states:
> "If a Report ID tag was used in the Report descriptor, all reports
> include a single byte ID prefix. If the Report ID tag was not used, all
> values are returned in a single report and a prefix ID is not included
> in that report."
>
> My understanding is like the following and testing confirms it.
> 1) when HID device has explicit report IDs, then the report IDs will
> be transmitted on the bus.
> 2) when the HID device does not use report ID at all (implicit report ID 0),
> then this report ID 0 is not transmitted on the bus
>
> Reference:
> http://www.microchip.com/forums/tm.aspx?m=494711
> http://libusb.6.n5.nabble.com/Missing-first-byte-when-reading-HID-Feature-Reports-with-ID-td9460.html
> (we spent quite some efforts to get the libusb-1.0 Windows native
> HID backend to deal with report ID correctly).
>
> --
> Xiaofan http://sourceforge.net/projects/libusb-win32/
>

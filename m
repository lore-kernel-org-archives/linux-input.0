From: Xiaofan Chen <xiaofanc@gmail.com>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 22:09:58 +0800
Message-ID: <AANLkTil0S747k-MomthJW4dv2WwB-abjZmGmxf3fH59y@mail.gmail.com>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>
	<4C2A1FA0.6020704@signal11.us>
	<alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
	<AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>
	<alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>
	<AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com>
	<4C2B3E6B.7060703@signal11.us>
	<AANLkTilzYu3mA3vDzuVyxngTcltgKEoNKYrdenz1Z-VG@mail.gmail.com>
	<alpine.LNX.2.00.1006301505490.13809@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56553 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab0F3OKA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 10:10:00 -0400
In-Reply-To: <alpine.LNX.2.00.1006301505490.13809@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Alan Ott <alan@signal11.us>, Amit Nagal <helloin.amit@gmail.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

On Wed, Jun 30, 2010 at 9:06 PM, Jiri Kosina <jkosina@suse.cz> wrote:

>> Sorry I do not know much about hidraw. However, if HIDraw is so
>> "raw", what are the benefits of HIDRAW compared to using libusb?
>
> It's independent on transport below HID protocol. I.e. it works for
> Bluetooth HID devices as well (and any potential HID devices over
> different transport protocol that might come in the future).

Thanks. This makes sense.

>> Then there is also libhid which is on top of libusb.
>
> Which is basically comparable to hiddev -- i.e. USB only, and performs
> report processing and parsing.
>

Some of us in the libusb mailing list have this desire to
create a real cross-platform HID API (which libhid is
trying to do but without real success -- at least under
Windows since there is no real Windows port) on top
of libusb-1.0.

The new libusb-1.0 Windows backend can directly
use the native HID API. And I create a ticket to ask
for a native HID backend for Mac OS X and I believe
it can be done.
http://www.libusb.org/ticket/33

I am not so sure if it is necessary to create a native hidraw
backend for Linux or not. But the advantage of transport-independent
HID device seems to be a good one. I think Windows native HID API
also support non-USB device. Not so sure about Mac OS X though
since I do not use Mac and do not know Mac.

-- 
Xiaofan

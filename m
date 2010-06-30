From: Xiaofan Chen <xiaofanc@gmail.com>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 21:04:59 +0800
Message-ID: <AANLkTilzYu3mA3vDzuVyxngTcltgKEoNKYrdenz1Z-VG@mail.gmail.com>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>
	<4C2A1FA0.6020704@signal11.us>
	<alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
	<AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>
	<alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>
	<AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com>
	<4C2B3E6B.7060703@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58860 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab0F3NFN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 09:05:13 -0400
In-Reply-To: <4C2B3E6B.7060703@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Amit Nagal <helloin.amit@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

On Wed, Jun 30, 2010 at 8:54 PM, Alan Ott <alan@signal11.us> wrote:
> Is that what you're asking for, or are you asking for something which will
> tell you which reports are _available_ on the device, and what their lengths
> are? There is currently no way to report which reports are _available_. As
> Jiri said, HIDRAW does not do any parsing of the report descriptor. All data
> is passed "raw" from the user application to the device.
>
> If you know what type of device you are talking to, then you shouldn't
> really need to parse the descriptor in software, because you'll know what
> the device supports, right?
>

Sorry I do not know much about hidraw. However, if HIDraw is so
"raw", what are the benefits of HIDRAW compared to using libusb?
Then there is also libhid which is on top of libusb.

-- 
Xiaofan

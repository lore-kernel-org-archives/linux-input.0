From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 15:06:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006301505490.13809@pobox.suse.cz>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com> <4C2A1FA0.6020704@signal11.us> <alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz> <AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com> <alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>
 <AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com> <4C2B3E6B.7060703@signal11.us> <AANLkTilzYu3mA3vDzuVyxngTcltgKEoNKYrdenz1Z-VG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:60987 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab0F3NGv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 09:06:51 -0400
In-Reply-To: <AANLkTilzYu3mA3vDzuVyxngTcltgKEoNKYrdenz1Z-VG@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiaofan Chen <xiaofanc@gmail.com>
Cc: Alan Ott <alan@signal11.us>, Amit Nagal <helloin.amit@gmail.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

On Wed, 30 Jun 2010, Xiaofan Chen wrote:

> > Is that what you're asking for, or are you asking for something which will
> > tell you which reports are _available_ on the device, and what their lengths
> > are? There is currently no way to report which reports are _available_. As
> > Jiri said, HIDRAW does not do any parsing of the report descriptor. All data
> > is passed "raw" from the user application to the device.
> >
> > If you know what type of device you are talking to, then you shouldn't
> > really need to parse the descriptor in software, because you'll know what
> > the device supports, right?
> 
> Sorry I do not know much about hidraw. However, if HIDraw is so
> "raw", what are the benefits of HIDRAW compared to using libusb?

It's independent on transport below HID protocol. I.e. it works for 
Bluetooth HID devices as well (and any potential HID devices over 
different transport protocol that might come in the future).

> Then there is also libhid which is on top of libusb.

Which is basically comparable to hiddev -- i.e. USB only, and performs 
report processing and parsing.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

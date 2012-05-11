From: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>
Subject: Re: [PATCH/RFC v2] HID: logitech: read all 32 bits of report type
 bitfield
Date: Fri, 11 May 2012 09:50:00 -0300
Message-ID: <4FAD0AF8.6010504@osvaldobarrera.com.ar>
References: <4FA217B7.7070908@osvaldobarrera.com.ar> <20120503055051.GA15960@burratino> <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com> <20120506031428.GA20044@hugoo.com.ar> <20120506055508.GA21209@burratino> <4FA6162F.1020408@osvaldobarrera.com.ar> <20120506062309.GB26002@burratino> <20120511050639.GA13777@hugoo.com.ar> <CAE7qMroedSu_-GJ3mye0vnKtQKiS1jEuDAkk75=qdTVQMTgaxQ@mail.gmail.com> <20120511072231.GA5733@burratino> <20120511073928.GB5733@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from customer-static-210-108-249.iplannetworks.net ([190.210.108.249]:42216
	"EHLO hyperion.ubertech.com.ar" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1757998Ab2EKMty (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 08:49:54 -0400
In-Reply-To: <20120511073928.GB5733@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org, Jiri Kosina <jkosina@suse.cz>

On 2012-05-11 04:39, Jonathan Nieder wrote:
> From: Nestor Lopez Casado <nlopezcasad@logitech.com>
> 
> On big-endian systems (e.g., Apple PowerBook), trying to use a
> logitech wireless mouse with the Logitech Unifying Receiver does not
> work with v3.2 and later kernels.  The device doesn't show up in
> /dev/input.  Older kernels work fine.
> 
> That is because the new hid-logitech-dj driver claims the device.  The
> device arrival notification appears:
> 
> 	20 00 41 02 00 00 00 00 00 00 00 00 00 00 00
> 
> and we read the report_types bitfield (02 00 00 00) to find out what
> kind of device it is.  Unfortunately the driver only reads the first 8
> bits and treats that value as a 32-bit little-endian number, so on a
> powerpc the report type seems to be 0x02000000 and is not recognized.
> 
> Even on little-endian machines, connecting a media center remote
> control (report type 00 01 00 00) with this driver loaded would
> presumably fail for the same reason.
> 
> Fix both problems by using get_unaligned_le32() to read all four
> bytes, which is a little clearer anyway.  After this change, the
> wireless mouse works on Hugo's PowerBook again.
> 
> Addresses http://bugs.debian.org/671292
> 
> [jn: with commit message and tweaked to use get_unaligned instead of
>  copying onto the stack]
> 
> Reported-by: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Cc: <stable@vger.kernel.org>
> ---
> Change since v1: fixed attribution.
> 
> I had been wondering why the patch you sent before didn't fix Hugo's
> problem while the effectively identical patch I sent did.  The only
> explanation I can think of is an error introduced in applying the
> patch by hand.
> 
<patch snipped>

I'd hate to think I screwed up applying such a simple patch, but it's
the only thing I can think of as well.

Thanks again to both of you for your time and effort, and for your
timely responses on this issue!

I hope this makes it to the main branch soon!

Cheers, and good luck to both,

-- 
Hugo Osvaldo Barrera

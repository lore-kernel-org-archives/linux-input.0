From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH/RFC v2] HID: logitech: read all 32 bits of report type
 bitfield
Date: Fri, 11 May 2012 12:55:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1205111254520.17928@pobox.suse.cz>
References: <4FA217B7.7070908@osvaldobarrera.com.ar> <20120503055051.GA15960@burratino> <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com> <20120506031428.GA20044@hugoo.com.ar> <20120506055508.GA21209@burratino> <4FA6162F.1020408@osvaldobarrera.com.ar>
 <20120506062309.GB26002@burratino> <20120511050639.GA13777@hugoo.com.ar> <CAE7qMroedSu_-GJ3mye0vnKtQKiS1jEuDAkk75=qdTVQMTgaxQ@mail.gmail.com> <20120511072231.GA5733@burratino> <20120511073928.GB5733@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51315 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758226Ab2EKKz1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 06:55:27 -0400
In-Reply-To: <20120511073928.GB5733@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org

On Fri, 11 May 2012, Jonathan Nieder wrote:

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

If Nestor is really the original author of this patch, his Signed-off-by: 
is necessary.

Nestor, please?

Thanks,

-- 
Jiri Kosina
SUSE Labs

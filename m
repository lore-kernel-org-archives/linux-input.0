From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH] hid-magicmouse: Correct parsing of large X and Y motions.
Date: Tue, 06 Jul 2010 07:55:12 -0400
Message-ID: <87lj9oakpr.fsf@troilus.org>
References: <878w5qaspq.fsf@troilus.org>
	<AANLkTim9R0ur7r2Y3r3bOMIRSM7JYVcZdGZ0QMaYvK4X@mail.gmail.com>
	<1278360120.2425.97.camel@cndougla> <87wrt9acu5.fsf@troilus.org>
	<1278363118.10426.15.camel@cndougla> <87sk3xa8f3.fsf@troilus.org>
	<702744BC498BAE41B3AA631D95EC463058B3CFD77F@NOK-EUMSG-01.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48085 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753000Ab0GFLzQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jul 2010 07:55:16 -0400
Received: by mail-qy0-f182.google.com with SMTP id 7so2455276qyk.13
        for <linux-input@vger.kernel.org>; Tue, 06 Jul 2010 04:55:14 -0700 (PDT)
In-Reply-To: <702744BC498BAE41B3AA631D95EC463058B3CFD77F@NOK-EUMSG-01.mgdnok.nokia.com>
	(ext-phil's message of "Tue, 6 Jul 2010 13:23:03 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext-phil.2.carmody@nokia.com
Cc: chase.douglas@canonical.com, pinglinux@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org

ext-phil.2.carmody@nokia.com writes:

[snip]
>>+/* Function shamelessly borrowed from hid-core.c. */
>>+
>>+static s32 snto32(__u32 value, unsigned n)
>>+{
>>+       switch (n) {
>>+       case 8:  return ((__s8)value);
>>+       case 16: return ((__s16)value);
>>+       case 32: return ((__s32)value);
>
> Beware - this relies on sane behaviour from the current and future compilers, as the C standard doesn't mandate what should happen when shortening out of range signed values. [n869.txt: 6.3.1.1.#3]

That's good to know.  There's probably some much more complicated, but
portable, way to write the operation -- I suspect we'll continue to rely
on the compiler to be sane.

>>+       }
>>+       return value & (1 << (n - 1)) ? value | (-1 << n) : value;
>
> That signed left shift, however, is good old fashioned undefined behaviour. [n869.txt 6.5.7.#4]

Which version is that from?  The copy of C99 I have says the resulting
value is -1 * (2 ** n) if that value can be represented.  (A 6 May 2005
committee draft of TC2 says the same thing.)  Until n > 31, the behavior
should be standard-defined.

Michael

From: <ext-phil.2.carmody@nokia.com>
Subject: RE: [PATCH] hid-magicmouse: Correct parsing of large X and Y
 motions.
Date: Tue, 6 Jul 2010 15:05:03 +0200
Message-ID: <702744BC498BAE41B3AA631D95EC463058B3CFD780@NOK-EUMSG-01.mgdnok.nokia.com>
References: <878w5qaspq.fsf@troilus.org>
	<AANLkTim9R0ur7r2Y3r3bOMIRSM7JYVcZdGZ0QMaYvK4X@mail.gmail.com>
	<1278360120.2425.97.camel@cndougla> <87wrt9acu5.fsf@troilus.org>
	<1278363118.10426.15.camel@cndougla> <87sk3xa8f3.fsf@troilus.org>
	<702744BC498BAE41B3AA631D95EC463058B3CFD77F@NOK-EUMSG-01.mgdnok.nokia.com>,<87lj9oakpr.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18459 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789Ab0GFNFi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jul 2010 09:05:38 -0400
In-Reply-To: <87lj9oakpr.fsf@troilus.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mdpoole@troilus.org
Cc: chase.douglas@canonical.com, pinglinux@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org

From: ext Michael Poole [mdpoole@troilus.org]
>ext-phil.2.carmody@nokia.com writes:
>
>[snip]
>>>+/* Function shamelessly borrowed from hid-core.c. */
>>>+
>>>+static s32 snto32(__u32 value, unsigned n)
>>>+{
>>>+       switch (n) {
>>>+       case 8:  return ((__s8)value);
>>>+       case 16: return ((__s16)value);
>>>+       case 32: return ((__s32)value);
>>
>> Beware - this relies on sane behaviour from the current and future compilers, as the C standard doesn't mandate what should happen when shortening out of range signed values. [n869.txt: 6.3.1.1.#3]
>
>That's good to know.  There's probably some much more complicated, but
>portable, way to write the operation -- I suspect we'll continue to rely
>on the compiler to be sane.
>
>>>+       }
>>>+       return value & (1 << (n - 1)) ? value | (-1 << n) : value;
>>
>> That signed left shift, however, is good old fashioned undefined behaviour. [n869.txt 6.5.7.#4]
>
>Which version is that from?

A text version of n869, which looks like it suffered a little in conversion to not-quite-ASCII.

>  The copy of C99 I have says the resulting
>value is -1 * (2 ** n) if that value can be represented.  (A 6 May 2005
>committee draft of TC2 says the same thing.)  Until n > 31, the behavior
>should be standard-defined.

Looking at the pdfs, agreed, My mistake. I shall have to 'fix' the non-ASCII in my text version, as I much prefer greppable text to pdfs.

Phil
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [patch 03/22] input: AD7879 Touchscreen driver
Date: Fri, 6 Mar 2009 10:07:36 -0000
Message-ID: <8A42379416420646B9BFAC9682273B6D09407E53@limkexm3.ad.analog.com>
References: <200903041958.n24Jws9R028400@imap1.linux-foundation.org> <8A42379416420646B9BFAC9682273B6D09407D59@limkexm3.ad.analog.com> <20090306100510.GC24864@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:31496 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbZCFKHk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2009 05:07:40 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20090306100510.GC24864@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org, cooloney@kernel.org, randy.dunlap@oracle.com



>From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>
>Hi Michael,
>
>On Fri, Mar 06, 2009 at 09:48:17AM -0000, Hennerich, Michael wrote:
>>
>> Hi Dmitry,
>>
>> Is there a schedule when this and my other patch get merged mainline?
>>
>> [patch 01/22] input/touchscreen driver: add support AD7877
touchscreen
>> driver
>>
>> Do you have any concerns or is there something that should be done
>> differently?
>
>I have some concerns with regard to locking in the driver. I had a
>preliminary patch but I need to look at it again.
>
>--
>Dmitry

Hi Dmitry,

I reworked the locking, it's now done differently.

-Michael

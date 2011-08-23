From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 3/4] Input: ad714x - use DMA-safe buffers for spi_write()
Date: Tue, 23 Aug 2011 08:02:43 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E6D067EC@LIMKCMBX1.ad.analog.com>
References: <1313957345-22608-1-git-send-email-dmitry.torokhov@gmail.com>
 <1313957345-22608-3-git-send-email-dmitry.torokhov@gmail.com>
 <4E5240F8.3050205@analog.com> <201108220939.17702.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:18739
	"EHLO DB3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751643Ab1HWHDC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Aug 2011 03:03:02 -0400
In-Reply-To: <201108220939.17702.dmitry.torokhov@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Drivers <Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

Dmitry Torokhov wrote on 2011-08-22:
> On Monday, August 22, 2011 04:43:52 AM Michael Hennerich wrote:
>> On 08/21/2011 10:09 PM, Dmitry Torokhov wrote:
>>> spi_write() requires use of DMA-safe (cacheline aligned) buffers.
>>> Also use the same buffers when reading data since to avoid extra
>>> locking and potential memory allocation in spi_write_then_read().
>>>
>>> Signed-off-by: Dmitry Torokhov<dtor@mail.ru>
>>
>> Looks good - one piece of the original patch set got lost.
>
> Aww, sorry about that.
>
>> See below - patch follows.
>
> Thank you very much, I'll fold it in your original patch - no reason
> for having a known broken change in the tree if it can be corrected.
>

Thanks!

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



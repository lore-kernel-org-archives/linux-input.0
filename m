From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] MAINTAINERS: Add an entry for the input MT protocol
Date: Thu, 24 Jun 2010 00:56:10 +0200
Message-ID: <4C22910A.5050408@euromail.se>
References: <1277330664-13884-1-git-send-email-rydberg@euromail.se> <201006231554.46440.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:54462 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458Ab0FWW40 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jun 2010 18:56:26 -0400
In-Reply-To: <201006231554.46440.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, "David S. Miller" <davem@davemloft.net>

Dmitry Torokhov wrote:
> On Wednesday, June 23, 2010 03:04:24 pm Henrik Rydberg wrote:
>> This patch adds a maintainer for the input multitouch (MT) protocol,
>> such that get_maintainer.pl selects it whenever an MT event is present
>> in the patch.
>>
>> Cc: Joe Perches <joe@perches.com>
>> Cc: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
>> ---
>>  MAINTAINERS |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6d119c9..32157c8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3858,6 +3858,13 @@ S:	Maintained
>>  F:	drivers/char/isicom.c
>>  F:	include/linux/isicom.h
>>
>> +MULTITOUCH INPUT MT PROTOCOL
> 
> Should we call the section "INPUT MULTITOUCH (MT) PROTOCOL" and move
> it closer to the main INPUT section so that if anyone looks in MAINTAINERS
> directly they'd see both entries? 

Yes, thought about it too.

Henrik

>> +M:	Henrik Rydberg <rydberg@euromail.se>
>> +L:	linux-input@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/input/multi-touch-protocol.txt
>> +K:	ABS_MT
>> +
>>  MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER
>>  M:	Felipe Balbi <felipe.balbi@nokia.com>
>>  L:	linux-usb@vger.kernel.org
> 


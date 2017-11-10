From: =?UTF-8?Q?S=c3=a9bastien_Szymanski?=
        <sebastien.szymanski@armadeus.com>
Subject: Re: [PATCH 1/3] HID: cp2112: fix interface specification URL
Date: Fri, 10 Nov 2017 10:05:35 +0100
Message-ID: <8af16807-1e7e-2a80-82a7-1c7d685337b4@armadeus.com>
References: <1509621164-28830-1-git-send-email-sebastien.szymanski@armadeus.com>
 <nycvar.YFH.7.76.1711091245160.32604@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:38082 "EHLO
        9.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdKJJti (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Nov 2017 04:49:38 -0500
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 8A194F3639
        for <linux-input@vger.kernel.org>; Fri, 10 Nov 2017 10:43:16 +0100 (CET)
In-Reply-To: <nycvar.YFH.7.76.1711091245160.32604@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Julien Boibessot <julien.boibessot@armadeus.com>

On 11/09/2017 12:45 PM, Jiri Kosina wrote:
> On Thu, 2 Nov 2017, Sébastien Szymanski wrote:
> 
>> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
>> ---
>>  drivers/hid/hid-cp2112.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
>> index 078026f..28e3c18 100644
>> --- a/drivers/hid/hid-cp2112.c
>> +++ b/drivers/hid/hid-cp2112.c
>> @@ -21,7 +21,7 @@
>>   * Data Sheet:
>>   *   http://www.silabs.com/Support%20Documents/TechnicalDocs/CP2112.pdf
>>   * Programming Interface Specification:
>> - *   http://www.silabs.com/Support%20Documents/TechnicalDocs/AN495.pdf
>> + *   https://www.silabs.com/documents/public/application-notes/an495-cp2112-interface-specification.pdf
>>   */
> 
> I've applied patches 1 and 2 (with stable anotation) for now. Thanks,
> 

Thanks, I've send a v2 of patch 3.

Regards,

P.S: I don't see patch 1 on your cgit, is it normal?

-- 
Sébastien Szymanski
Software engineer, Armadeus Systems
Tel: +33 (0)9 72 29 41 44
Fax: +33 (0)9 72 28 79 26

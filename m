From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH v3] HID: apple: Use country code to detect ISO keyboards
Date: Thu, 8 Jun 2017 09:15:08 -0600
Message-ID: <CAMMLpeTLcR5w+uECCF2t=OQUo+pGrJdvVSLSZAnqPCLqjB5dyQ@mail.gmail.com>
References: <20170602152839.7810-1-alexhenrie24@gmail.com> <alpine.LSU.2.20.1706081402540.30709@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34852 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbdFHPPa (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Jun 2017 11:15:30 -0400
Received: by mail-wr0-f172.google.com with SMTP id q97so19967709wrb.2
        for <linux-input@vger.kernel.org>; Thu, 08 Jun 2017 08:15:29 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.20.1706081402540.30709@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: benjamin.tissoires@redhat.com, jirislaby@gmail.com, stefan@glasen-hardt.de, ryan@finnie.org, Johannes Thumshirn <morbidrsa@gmail.com>, dan@pwienterprises.com, Andreas Krist <andreas.krist@gmail.com>, rydberg@bitmath.org, Lukas Wunner <lukas@wunner.de>, linux-input@vger.kernel.org

2017-06-08 6:03 GMT-06:00 Jiri Kosina <jikos@kernel.org>:
> On Fri, 2 Jun 2017, Alex Henrie wrote:
>
>> At least on newer laptops, Apple uses the same USB ID for both ISO and
>> ANSI keyboards. However, they have been good about filling in the
>> bCountryCode field in the HID descriptor on all of their keyboards. A
>> value of 13 indicates an ISO layout and other values indicate various
>> country-specific ANSI layouts.
>>
>> With this patch, users of Apple US keyboards will no longer have to run
>> `echo 0 > /sys/module/hid_apple/parameters/iso_layout` to get a working
>> tilde key.
>>
>> Please test this patch and send feedback if you have a Macbook or an
>> Apple keyboard.
>>
>> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>
> Applied to for-4.13/apple. Thanks,

Thank you!

-Alex

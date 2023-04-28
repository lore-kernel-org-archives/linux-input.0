Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BFBC77B60
	for <linux-input@archiver.kernel.org>; Fri, 28 Apr 2023 23:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjD1XPF (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 28 Apr 2023 19:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjD1XPE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Apr 2023 19:15:04 -0400
Received: from endrift.com (endrift.com [173.255.198.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB4649D5
        for <linux-input@vger.kernel.org>; Fri, 28 Apr 2023 16:15:03 -0700 (PDT)
Received: from [192.168.0.22] (unknown [50.47.218.115])
        by endrift.com (Postfix) with ESMTPSA id 40301A05B;
        Fri, 28 Apr 2023 16:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=endrift.com; s=2020;
        t=1682723702; bh=KYBnmMzZfR8uMfC6i8pwQRMQKxZvuPwAR+zt7ntuhO0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TK49VKTOet1toEXzGKO9u7rx9WigoEq1J1y9e7DWKJ1L/gpKekC59DeV0YjFuJXN/
         nLy/uYvHrRdDgUaEPTYympdK2tn5p1Uc56mvoARoTX4GsgawuNrmMI8GnRiqGEz3Pn
         OCIYk13noywVAG40a/HuxtbVFRcMVpqqI7rMjiutT2ebC4uQa6xkB/6FLWeb/IPILR
         faAh3aanth47xDJJ/Ihg/FnwZ0JNSgC5JA1KR6smljytkeT0mtDUlArnxsNPZFRm+0
         X2Rri/MpkIp48DJfrxhOoeaJ7qoYEBHmV0uCNFcAcfO05xkiyNanbrY6CyNTtMVExc
         xWiCQeSnrY7SQ==
Message-ID: <2be8ff85-57d3-fd80-adcd-a7dc50c2e27d@endrift.com>
Date:   Fri, 28 Apr 2023 16:15:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] Input: xpad - Move Xbox 360 magic packet sending
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-input@vger.kernel.org
References: <20230419022414.1790979-1-vi@endrift.com>
 <facb01dd-e704-4900-8f4c-6d6972e75176@kili.mountain>
From:   Vicki Pfau <vi@endrift.com>
In-Reply-To: <facb01dd-e704-4900-8f4c-6d6972e75176@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Dmitry,

On 4/18/23 21:28, Dan Carpenter wrote:
> On Tue, Apr 18, 2023 at 07:24:14PM -0700, Vicki Pfau wrote:
>> This moves the sending of the magic packet introduced in db7220c48d8d from
>> xpad_probe to xpad_start_input to ensure that xpad->dev->dev exists in the
>> event that an error occurs. This should also fix issues with suspend that may
>> occur with some controllers.
>>
>> Fixes: db7220c48d8d ("Input: xpad - fix support for some third-party controllers")
>> Signed-off-by: Vicki Pfau <vi@endrift.com>
> 
> Can you add the syzbot stuff as well and a Reported-by tag for
> Dongliang Mu as well.
> 
> Reported-by: syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Link: https://groups.google.com/g/syzkaller-bugs/c/iMhTgpGuIbM

Do I need to add these to the commit myself and resend, or, barring code revisions, can this be added when you cherry-pick into the tree?

> 
> regards,
> dan carpenter
> 

Vicki

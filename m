Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5508CC77B7A
	for <linux-input@archiver.kernel.org>; Wed, 24 May 2023 06:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbjEXGPm (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 24 May 2023 02:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239460AbjEXGPl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 May 2023 02:15:41 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 23:15:37 PDT
Received: from so254-18.mailgun.net (so254-18.mailgun.net [198.61.254.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36543189
        for <linux-input@vger.kernel.org>; Tue, 23 May 2023 23:15:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=hexchain.org;
 q=dns/txt; s=smtp; t=1684908935; x=1684916135; h=Content-Transfer-Encoding:
 Content-Type: In-Reply-To: From: From: References: Cc: To: To: Subject:
 Subject: MIME-Version: Date: Message-ID: Sender: Sender;
 bh=GUARewsXAraIxbibc/Wy/aksR920CDjWgytLUfCB+Ys=;
 b=S1OOx3oAPs9YoC0WtmNvzp3cumVpPuxmiwmSINd8ElA8U93RAjCQz2qZI0uNCrR7TNFR//BLD77sYvunfiOfnWvAPVuI+HZJJ5YaykR48ZKMPHomd0k77Njl3gmxoueVwRJe8kEDwi/jCvxwunMVYKbcUXbHyNxx8HlOqdi+vx4xtYL1DFAW8E1WuE8xUdlI5+ToMudcrgofsAfTUEIAMHAwSE6RHeCdk/A/aiQm7hBabfH87Y2v/j2WjEChWRbqKMOr8p62RFjscocz893Rms8Ie8GA11j1qhXT+Gs0fZwblY+goKjO2tmtg3JSdBvMuYOTPrrujx/a29KTnvptvg==
X-Mailgun-Sending-Ip: 198.61.254.18
X-Mailgun-Sid: WyI5NzJmZCIsImxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZyIsIjE5MjUxOCJd
Received: from [192.168.40.116] (254.248.75.138.unknown.m1.com.sg [138.75.248.254]) by
 addb09e5ecfc with SMTP id 646daa5ae97a44e9b711e2ac; Wed, 24 May 2023 06:10:34
 GMT
Sender: linux@hexchain.org
Message-ID: <ee2c30a5-3927-d892-2a66-00cd513c3899@hexchain.org>
Date:   Wed, 24 May 2023 14:10:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: amd_sfh driver causes kernel oops during boot
To:     Bagas Sanjaya <bagasdotme@gmail.com>, stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, linux-input@vger.kernel.org,
        Basavaraj Natikar <basavaraj.natikar@amd.com>
References: <f40e3897-76f1-2cd0-2d83-e48d87130eab@hexchain.org>
 <ZG2LXN2+Sa2PWJqz@debian.me>
Content-Language: en-US
From:   Haochen Tong <linux@hexchain.org>
In-Reply-To: <ZG2LXN2+Sa2PWJqz@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

On 5/24/23 11:58, Bagas Sanjaya wrote:
> On Wed, May 24, 2023 at 01:27:57AM +0800, Haochen Tong wrote:
>> Hi,
>>
>> Since kernel 6.3.0 (and also 6.4rc3), on a ThinkPad Z13 system with Arch
>> Linux, I've noticed that the amd_sfh driver spews a lot of stack traces
>> during boot. Sometimes it is an oops:
> 
> What last kernel version before this regression occurs? Do you mean
> v6.2?
> 

I was using 6.2.12 (Arch Linux distro kernel) before seeing this regression.


Thanks.


Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B2DC4338F
	for <linux-input@archiver.kernel.org>; Sat, 21 Aug 2021 15:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107BB61214
	for <linux-input@archiver.kernel.org>; Sat, 21 Aug 2021 15:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhHUPYC (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 21 Aug 2021 11:24:02 -0400
Received: from phobos.denx.de ([85.214.62.61]:46112 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231732AbhHUPYC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Aug 2021 11:24:02 -0400
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F036481269;
        Sat, 21 Aug 2021 17:23:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1629559401;
        bh=yh0i/kE6QHPQaHE/wyeDdIDV5NZJul2OST7ya/kGsSs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qKBzxcrGVCTAiL5UFkEA+hN4XrYuGShAjLNRWNqtzlquZa2wSCNHmcl4mnyAFqftF
         GLyoF9j5NhhxILmrMHznz+JKF8vsYI7CEjH20uNTViNB2xBTmuZw16+R97BYbt4UDD
         ejrTSzhPfX1qRIpmxuE/taNDN5rFOhS5arLPW9AC0qYR8brRqiHNbY4bVciCCaFUyJ
         IFn4La49hSKe3z46LnnyIzkrm0ibsYaras2klqWG/71ZVlL2lC2mBNkY4ioSweIPkV
         /ig/DQN8TFOn7jHMB1wGssWPBcTIapvqlfsJviaP1nHMUTSdPvqP/BJidj2nmMBnfQ
         6MKNYvJPUbbTA==
Subject: Re: [PATCH v3] dt-bindings: input: tsc2005: Convert to YAML schema
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     devicetree@vger.kernel.org, Michael Welling <mwelling@ieee.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@dh-electronics.com,
        linux-input@vger.kernel.org
References: <20210620210708.100147-1-marex@denx.de>
 <YPtjPkOwwU7Xe1dC@google.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <0b0f2511-6075-e83f-b374-ac650b17e49a@denx.de>
Date:   Sat, 21 Aug 2021 17:23:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YPtjPkOwwU7Xe1dC@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On 7/24/21 2:47 AM, Dmitry Torokhov wrote:
> On Sun, Jun 20, 2021 at 11:07:08PM +0200, Marek Vasut wrote:
>> Convert the TI TSC2004/TSC2005 DT bindings to YAML schema.
>>
[...]
> 
> Applied, thank you.

Did the patch get lost somewhere ?
Shouldn't this be in linux-next by now ?

Thanks

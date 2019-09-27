Return-Path: <SRS0=hN40=XW=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E870C4360C
	for <linux-input@archiver.kernel.org>; Fri, 27 Sep 2019 06:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3164721841
	for <linux-input@archiver.kernel.org>; Fri, 27 Sep 2019 06:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="j2YY8iv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbfI0Gp4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 27 Sep 2019 02:45:56 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:47232 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfI0Gp4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 27 Sep 2019 02:45:56 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id E9EBEA00D9;
        Fri, 27 Sep 2019 08:45:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1569566754;
        bh=pUebQPdyWldWGMS1APoRRu91MKyCTCRm8Sn7GfPKrAo=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=j2YY8iv3Ifwi53S3gqXvCYH87qw+LuZyfr5aiXp4oK6FASc2K9RCHsW6BmWgYfYf0
         OyzsazK8Al5GfqyzKG5qjvOrU4G2jh80+bYRs8yOavK7/njemItjSlqsq75/6bPoHD
         fw+2Smk8CWUrb8fSES+nDzS4axkBTuy5lgT23N+w=
Subject: Re: [PATCH input-next 1/4] dt-bindings: input: Convert mpr121 binding
 to json-schema
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
References: <1567424417-3914-1-git-send-email-michal.vokac@ysoft.com>
 <1567424417-3914-2-git-send-email-michal.vokac@ysoft.com>
 <20190903065615.GA17646@bogus>
 <29307819-fcac-cbf8-0439-23c831d87278@ysoft.com>
Message-ID: <ddda5144-3a4a-ca16-5aa3-dd6f6619c365@ysoft.com>
Date:   Fri, 27 Sep 2019 08:45:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <29307819-fcac-cbf8-0439-23c831d87278@ysoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On 17. 09. 19 16:16, Michal Vokáč wrote:
> On 03. 09. 19 8:56, Rob Herring wrote:
>> On Mon, Sep 02, 2019 at 01:40:14PM +0200, Michal Vokáč wrote:
>>> Convert the mpr121 binding to DT schema format using json-schema.
>>>
>>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>>> ---
>>> Hi Rob,
>>>
>>> I will appreciate your help converting this binding. Currently
>>> the scheme is not valid and the error output of dt_binding_check
>>> is not really helpful.
>>
>> What's the error? I don't see anything obvious.
> 
> After some trial & error attempts I found few issues:
> 
>   - Wrong placement of description for wakeup-source. Solved.
>   - Missing coma between <KEY_4>, <KEY_5> values in the example. Solved.
>   - DTC complained about invalid reg property length in the example.
>     Solved by placing the mpr121 subnode into i2c {}; node and adding
>     #address-cells and #size-cells properties.
>   - The linux,keycodes property also requires type definition. Unresolved.
> 
>     What type should be used? Neither uint32-array nor uint32-matrix work.
>     The linux,keycodes list is not correctly validated against the maxItems
>     value. When I set maxItems less then the number of keycodes, it does not
>     complain.

Hi Rob, maybe this went through the cracks unnoticed?

>>> Also, who shoud be the maintainer of this binding?
>>> I put Dmitry in there as he is the input subsystem maintainer but
>>> I am not sure it is correct.
>>
>> My preference is the author or driver maintainer.
> 
> Then Dmitry seems to be the best match here I think.
> 
>>>   .../bindings/input/fsl,mpr121-touchkey.yaml        | 64 ++++++++++++++++++++++
>>>   .../devicetree/bindings/input/mpr121-touchkey.txt  | 30 ----------
>>>   2 files changed, 64 insertions(+), 30 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/input/fsl,mpr121-touchkey.yaml
>>>   delete mode 100644 Documentation/devicetree/bindings/input/mpr121-touchkey.txt
> 


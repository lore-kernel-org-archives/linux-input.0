Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MONEY_NOHTML,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9452AC433ED
	for <linux-input@archiver.kernel.org>; Thu,  1 Apr 2021 22:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DE06105A
	for <linux-input@archiver.kernel.org>; Thu,  1 Apr 2021 22:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhDAWYz (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 1 Apr 2021 18:24:55 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:53882 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhDAWYz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 1 Apr 2021 18:24:55 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id DCF76B04C4F
        for <linux-input@vger.kernel.org>; Fri,  2 Apr 2021 00:24:53 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:references:to:from:from:subject:subject; s=dkim; t=
        1617315893; x=1618179894; bh=eUNH9JCigSWjXMgzJBifLYckuPQkEREt8nx
        Fxxvn8OA=; b=czphOzgSDiiFiZA74gnuvGetKdwnikJ0F76gD4+2E1Qzoxk9GB6
        Kp5sOok+YgplLteCmaohFhutF8XOw+emy8DkqG/kr78v9qIiIwtGxGVFkxJ4O7qH
        cDhYI08xTUUugq3Kn6q2brnxWM9eFjw9Y5CehxEJLWKzpgZhOvq3377Y=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 62DcZguyendc for <linux-input@vger.kernel.org>;
        Fri,  2 Apr 2021 00:24:53 +0200 (CEST)
Received: from [192.168.50.18] (146-241-168-220.dyn.eolo.it [146.241.168.220])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 1F879B04A49;
        Fri,  2 Apr 2021 00:24:53 +0200 (CEST)
Subject: Re: [PATCH 2/3] dt-bindings: touchscreen: Add HY46XX bindings
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Rob Herring <robh@kernel.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210305163834.70924-1-giulio.benetti@benettiengineering.com>
 <20210305163834.70924-3-giulio.benetti@benettiengineering.com>
 <20210306194120.GA1075725@robh.at.kernel.org>
 <9cd14c69-9c30-a68c-dfd1-396613b5185a@micronovasrl.com>
Message-ID: <e60aa57b-1641-105a-fb57-9b5803054f3a@micronovasrl.com>
Date:   Fri, 2 Apr 2021 00:24:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <9cd14c69-9c30-a68c-dfd1-396613b5185a@micronovasrl.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Il 01/04/2021 20:37, Giulio Benetti ha scritto:
>>
>> Needs a vendor prefix here and all the custom properties.
> 
> Sorry but I can't understand this ^^^, I've checked a lot of other yaml
> files but couldn't find something related to this. Can you help me by
> pointing me an example?
> 

Found in example-schema.yaml, sorry for the noise

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

Return-Path: <SRS0=eGih=X5=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA976C4360C
	for <linux-input@archiver.kernel.org>; Fri,  4 Oct 2019 07:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E6B2247F
	for <linux-input@archiver.kernel.org>; Fri,  4 Oct 2019 07:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="ienhC/lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfJDHkr (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 4 Oct 2019 03:40:47 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:45626 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbfJDHkq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 4 Oct 2019 03:40:46 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 7CF80A2C3F;
        Fri,  4 Oct 2019 09:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1570174844;
        bh=gYP5EFBwJLEogj3C7QmhBdPV1miRpuRzROMYVZLeLn8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ienhC/lpI6i0pFHDODJ/c+PlIP3EMs8+C6hh7A15hvGJpM4O4QvEHaD3qXff6Ls0o
         LmDjqFjKFlngPl92FNgUKsKuOtTUziJWbjsxeExeAlX4iLUWvrWYkXkNIW/mYkYfbT
         Liqp9YQCXht+08vPMv48h9nWNPf564OSR9IJs1WI=
Subject: Re: [PATCH v2 2/5] dt-bindings: input: Convert mpr121 binding to
 json-schema
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <1569940180-11417-1-git-send-email-michal.vokac@ysoft.com>
 <1569940180-11417-3-git-send-email-michal.vokac@ysoft.com>
 <CAL_Jsq+DTyVKn4je=_kARoo43wr_fhyxXUEZWEDhHDZ2pDiqPQ@mail.gmail.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <44000610-75bb-7243-8ca3-411832745817@ysoft.com>
Date:   Fri, 4 Oct 2019 09:40:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+DTyVKn4je=_kARoo43wr_fhyxXUEZWEDhHDZ2pDiqPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On 03. 10. 19 21:09, Rob Herring wrote:
> On Tue, Oct 1, 2019 at 9:29 AM Michal Vokáč <michal.vokac@ysoft.com> wrote:
>>
>> Convert the mpr121 binding to DT schema format using json-schema.
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>> Changes since v1:
>>   - Extract the common input properties into the input.yaml schema.
>>   - Fix the wakeup-source description.
>>   - Fix the example to pass validation. Put the mpr121 device sub-node
>>     into a i2c {} node.
>>
>> Rob, the linux,keycodes property is not valid as it is.
>> If I put the minItems and maxItems into the common schema, it is valid
>> and the min/max length check works fine. What could be wrong?
>>
>> The error is not very specific..
> 
> That's a side effect of an 'allOf' somewhere in the meta-schema.
> 
>> $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/input/fsl,mpr121-touchkey.yaml
>>    SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
>> /home/vokac/development/sources/linux-fslc/Documentation/devicetree/bindings/input/fsl,mpr121-touchkey.yaml: ignoring, error in schema 'linux,keycodes'
>> warning: no schema found in file: /home/vokac/development/sources/linux-fslc/Documentation/devicetree/bindings/input/fsl,mpr121-touchkey.yaml
>> /home/vokac/development/sources/linux-fslc/Documentation/devicetree/bindings/Makefile:33: recipe for target 'Documentation/devicetree/bindings/processed-schema.yaml' failed
>> make[3]: *** [Documentation/devicetree/bindings/processed-schema.yaml] Error 255
>> /home/vokac/development/sources/linux-fslc/Makefile:1264: recipe for target 'dt_binding_check' failed
> 
> I'm working on a fix for this. It's a problem in the meta-schema.

OK, thanks a lot!
Michal

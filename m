Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63C6C48BE8
	for <linux-input@archiver.kernel.org>; Sun, 13 Jun 2021 19:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B246124B
	for <linux-input@archiver.kernel.org>; Sun, 13 Jun 2021 19:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhFMTpQ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 13 Jun 2021 15:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhFMTpP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 13 Jun 2021 15:45:15 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC95C061574;
        Sun, 13 Jun 2021 12:43:13 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2070480412;
        Sun, 13 Jun 2021 21:43:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1623613388;
        bh=+mfGQ/TWK4Pg8XN7ph4PE9cUaE57WSFl8YmuDW3L1eU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S7Si6KXOSsOVaFBsj9TdI5VgI4j/WdBNMY/WLD33I+BjARLSSdITauNealUQobAaA
         Z8frtGwGyzbpK0PFpQIy1hRTK+saOhPxlHXgVaBd44mzNN0FxIofVlABsWLq2V5E19
         sWnQSvMGZaypFL5kWkoJDZBK4Vw4JmAA3onZOZR5FfaagNQza9vleovskuWt6fIlVB
         YCNw8Qo4Oed/9WhV/hUEsymsgDcctpKwzXiTx67KMd+slWYKR+iEKigC51WpHLvvHw
         NkmdVgQtu3dKCafm1j5bmBMfKiUx0nCAn+TS1kwh9QDylG+/iZgx1Iv9CFOGEskagJ
         ZHUBelrxFfSRg==
Subject: Re: [PATCH] dt-bindings: input: touchscreen: ilitek_ts_i2c: Absorb
 ili2xxx bindings
To:     =?UTF-8?B?Sm9lIEh1bmcgKOa0qumKmOmZvSk=?= <joe_hung@ilitek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?B?THVjYSBIc3UgKOW+kOWYiemNiik=?= <luca_hsu@ilitek.com>
References: <c381ee2526074e02b6058c489f85cfdaee582713.1623419587.git.geert+renesas@glider.be>
 <9b1b2a44-348e-5453-d767-d5c69a0869a7@denx.de>
 <CAMuHMdXE0kipUm6wqHsrFurFkviU_nRJJB7cg6z1XwEvpEewGQ@mail.gmail.com>
 <YMOsRzfDnZ/iApwD@google.com> <9d901eb1-6408-6b4f-1377-03c394d440c4@denx.de>
 <b30e65d0847949b497c635dd1d5035ac@ilitek.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <c9850c77-523e-3f25-a771-dc6e84ae8bde@denx.de>
Date:   Sun, 13 Jun 2021 21:43:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b30e65d0847949b497c635dd1d5035ac@ilitek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On 6/12/21 7:52 AM, Joe Hung (洪銘陽) wrote:
> Hi Marek,

Hi,

> I'm the committer of "ilitek_ts_i2c.c" driver.
> The so-called "Lego" series was listed below, as listed in ilitek_ts_i2c.yaml
> It's the newer series with different protocol and control flow to ILITEK IC FW.
> 
> - ilitek,ili2130
> - ilitek,ili2131
> - ilitek,ili2132
> - ilitek,ili2316
> - ilitek,ili2322
> - ilitek,ili2323
> - ilitek,ili2326
> - ilitek,ili2520
> - ilitek,ili2521
> 
>> The older driver also supports 251x . What exactly is "Lego" series ?
> More specifically, Lego series support "252x", not "2510".
> The older driver support 210x and 251x, which has older protocol.
> 
>> In fact, is there documentation for the different ILI2xxx touchscreen controllers ? So far, all the information I had was pulled from the various forks of downstream example code.
> If it need for a doc. to distinguish it, I am glad to support/arrange, and where should I put those description to ?

I think the older ili251x has protocol V5 and the lego series has 
protocol V6 or something like that, right ? If that's the case, maybe it 
would be useful to clarify that and that the protocols are incompatible, 
so others don't get confused by those two drivers.

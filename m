Return-Path: <SRS0=o5X5=AG=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDE3C433E1
	for <linux-input@archiver.kernel.org>; Thu, 25 Jun 2020 10:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 583B920706
	for <linux-input@archiver.kernel.org>; Thu, 25 Jun 2020 10:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404002AbgFYKq5 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:46:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35432 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403997AbgFYKq5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Jun 2020 06:46:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id EE3D42A422E
Subject: Re: [PATCH v7] dt-bindings: mfd: Convert ChromeOS EC bindings to
 json-schema
To:     Lee Jones <lee.jones@linaro.org>, Ikjoon Jang <ikjn@chromium.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nicolas Boitchat <drinkcat@chromium.org>,
        linux-input@vger.kernel.org
References: <20200306085513.76024-1-ikjn@chromium.org>
 <20200417101333.GA3737@dell>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <ab5adcd1-18f2-9b1c-8c5d-744f7a0e5579@collabora.com>
Date:   Thu, 25 Jun 2020 12:46:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200417101333.GA3737@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Lee,

On 17/4/20 12:13, Lee Jones wrote:
> On Fri, 06 Mar 2020, Ikjoon Jang wrote:
> 
>> Convert the ChromeOS EC bindings to json-schema.
>>
>> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
>> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>  .../devicetree/bindings/mfd/cros-ec.txt       |  76 -----------
>>  .../bindings/mfd/google,cros-ec.yaml          | 129 ++++++++++++++++++
>>  2 files changed, 129 insertions(+), 76 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/mfd/cros-ec.txt
>>  create mode 100644 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> 
> Applied, thanks.
> 

I don't see this patch applied, I am missing something?

Thanks,
 Enric

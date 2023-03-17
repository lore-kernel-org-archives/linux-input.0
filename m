Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDECC74A5B
	for <linux-input@archiver.kernel.org>; Fri, 17 Mar 2023 10:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCQKg4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 17 Mar 2023 06:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCQKgz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Mar 2023 06:36:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C085B59438
        for <linux-input@vger.kernel.org>; Fri, 17 Mar 2023 03:36:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h8so4837334plf.10
        for <linux-input@vger.kernel.org>; Fri, 17 Mar 2023 03:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679049413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2csMlvOny2JhJw4m82pTJ+QASfAKXeYQUn4r9A31HI=;
        b=peMYv8hbXebuK86B8NsAYTASHmhdk4Z6wsUr9GP3ftaG2Y+H17UnFkP6sd7OJy2Ge3
         jq9Zmr6ON1/fAv7crq7LLs6fPYd/oi25EeLQXMCSAGwOTy0fcxRcXC9qXNcUCoubjPOE
         ZSvA5xahR34nQ8cvp1SpPMivTzJ7T0XhSwkIqUd+gD+1R7Xpg78H9U3G7ZAHPe2cuAJV
         tf6AqLcvID657rA8EpTdDjCabedaOrlUObslv2ohcstdTiBUovdxaoYoL43jcZrtJEC3
         keOT+nJ7uu8SuD9bRvEcA78QaIFIgUWP3uMUo1ZPRhlRtqJLcWFbUjklNiPPUZsf/wq1
         /ysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679049413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2csMlvOny2JhJw4m82pTJ+QASfAKXeYQUn4r9A31HI=;
        b=CCsUdoD7cEQWcLbPQPZwpHarl7mQx2lWog8zeY6X8BS2F0+aFdGMnFWVl5Okgx47GH
         vnQwhmpTWD8vk+c+naOmuws74wjaNg0/2z0URQrJgCsKgQoTocDsS9KE4PstIRhc3pWz
         oSY1Azv+nHBX+P6+CzlW0jttP5r7yYbY7fyk9rNF2NoHlX71My7JN0ITvYK5g3cq+WNc
         zD7UYTPMqY73ySbtGRmNYlhRfmPiKOjsQG8s2t0Rhofa9CZ7s0OULUOf24glmkqgGgfT
         E3dtCrACn53OyTuqXKY4hGnB1d0/hutQ4v2BJZr1un4bN9ck/kgfdpp4KStLg1ute3Dq
         1/1A==
X-Gm-Message-State: AO0yUKUITc99nuTiJwLvB4b6OSN9supQ4QTaOntLWqUml5ZT8pF9JbFc
        7wrkdmzEH0nTGBFcKzBNwMk=
X-Google-Smtp-Source: AK7set8bfb5od9L02KsvAP29KE8BU3AuSon7nr+AUXn9yFC8qntKUTtFvgWOG7MDsuZvp+noF4t6YQ==
X-Received: by 2002:a17:902:c702:b0:1a1:82cc:5ae5 with SMTP id p2-20020a170902c70200b001a182cc5ae5mr5703619plp.13.1679049413149;
        Fri, 17 Mar 2023 03:36:53 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d084:8252:e846:af61])
        by smtp.gmail.com with ESMTPSA id ja13-20020a170902efcd00b001a1a31953a8sm1257655plb.130.2023.03.17.03.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 03:36:52 -0700 (PDT)
Date:   Fri, 17 Mar 2023 03:36:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: goodix - Add Lenovo Yoga Book X90F to
 nine_bytes_report DMI table
Message-ID: <ZBRCwUIJBcotSoXh@google.com>
References: <20230315134442.71787-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315134442.71787-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, Mar 15, 2023 at 02:44:42PM +0100, Hans de Goede wrote:
> The Android Lenovo Yoga Book X90F / X90L uses the same goodix touchscreen
> with 9 bytes touch reports for its touch keyboard as the already supported
> Windows Lenovo Yoga Book X91F/L, add a DMI match for this to
> the nine_bytes_report DMI table.
> 
> When the quirk for the X91F/L was initially added it was written to
> also apply to the X90F/L but this does not work because the Android
> version of the Yoga Book uses completely different DMI strings.
> Also adjust the X91F/L quirk to reflect that it only applies to
> the X91F/L models.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

-- 
Dmitry

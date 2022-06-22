Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC786C43334
	for <linux-input@archiver.kernel.org>; Wed, 22 Jun 2022 00:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiFVAhM (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 21 Jun 2022 20:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiFVAhL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Jun 2022 20:37:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0550130548;
        Tue, 21 Jun 2022 17:37:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p5so8741556pjt.2;
        Tue, 21 Jun 2022 17:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43e0IMJkjwy0ez4+pVCyAXyrlo7v5WsBoPt9azMbqOk=;
        b=gL4iUzmu9T/qhWz70ZhTjiS/0csbHdH7qEdMoUbLERr4rAdjRG3C+PtKX5x4fgTaeT
         +Sor7Q/ICkFVC79rddPRjSoIWcQ8VmYv09dLlX5HMQS4Azhlq5dzmbW2O48OpvCbhSS0
         1o8N3iRAm2DhqBSJr8MqAA+STjzka+QLEPCiLlUioTdKuvcHkysaa+UHlY0KhQfW7xnT
         kdKPdLIh+cpE7E/QkVfKAms2nc3Qm7HFXRT1XEjQPQAsiyNPVm0o4+zHjzMail1/UgTa
         Jr2xgajwjj3zxFaCC2DTYKfPY0MteilAUDhfcW0ofYq9GOvC4HgaS1POLbFNGzGCLMiA
         Rb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43e0IMJkjwy0ez4+pVCyAXyrlo7v5WsBoPt9azMbqOk=;
        b=l4jJHj+PFu+dqEdU1CdrFqZJVJIe2x5svBky2qQerr7dTW6I+jeXT6aJdKGfGcC4QD
         nDLRMfb1Oa0OSz1/Z0MbT5MG/tmZjkPAR83/jXX4ASDlRiOd8WUythrNPQuX4gUPEbiM
         6B/ncUgvRde1TdB0OEVFVr5VyQJbUGlZ0Sp/L/L+qc61jdtoRCHx8m6fJqiH57ueH3p1
         7eoAPheQD86iYPi0OMizHY2k9+OG3mRmdEfWPCAXLPxj2GTy7NNBlviIE3UTMToKv06Q
         tWMyrWRK9Unj7sLJXX954boL/wBfJyU/eQVQSwarVvhJDpf/fQppt8SRtoX86wxV/nH8
         Tl8g==
X-Gm-Message-State: AJIora/apk0kWZ3ujIUoABQnTsscu/oAWxC8LBXk9i3mgnuuZ9aIfEY6
        Iz7eeP2tEqTvylpFESPlcvmgeSeE8Co4IDwyuP0=
X-Google-Smtp-Source: AGRyM1s8hDDaH7dfyxNNOifT1cMC5ZM9xF/T4Akfw+tR6ClJV6eJrCKdXk22vnmrNvky8i7gMjk83Xs/LUkB7k1A3gM=
X-Received: by 2002:a17:90b:1c11:b0:1e7:8bd2:697d with SMTP id
 oc17-20020a17090b1c1100b001e78bd2697dmr46489380pjb.90.1655858229485; Tue, 21
 Jun 2022 17:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5D7z=Eg=WYgzrpqn9VoU8HxMeBbEZiv9KLjMVD1_kRo+w@mail.gmail.com>
 <20200701224145.GA3616172@bjorn-Precision-5520> <YrHPA+TBKZU/RuSz@smile.fi.intel.com>
 <87o7ym2fcv.wl-maz@kernel.org> <CAOMZO5B6606rwWoG-ydEz2UQpnj9QhUK2b5dCHRtp9u=Pe4new@mail.gmail.com>
 <128b8f7dffe45dc241ad571e8a273a2e@kernel.org>
In-Reply-To: <128b8f7dffe45dc241ad571e8a273a2e@kernel.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 21 Jun 2022 21:36:57 -0300
Message-ID: <CAOMZO5DmKJia+6O_H3oUP64HQsaac3kDTOKx_UwG0tWJd1bsxw@mail.gmail.com>
Subject: Re: mxs_lradc_ts: Warning due to "0 is an invalid IRQ number"
To:     Marc Zyngier <maz@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Marc,

On Tue, Jun 21, 2022 at 1:39 PM Marc Zyngier <maz@kernel.org> wrote:

> I'm not sure I can help you further on that. '10' seems to be
> the correct interrupt for the interrupt number (irq index 0 in
> the lradc device).

As your proposed changes improve things (no more irq 0 warning is seen and the
touchscreen irq is registered), please submit it formally, if you have a chance.

You can add:

Tested-by: Fabio Estevam <festevam@gmail.com>

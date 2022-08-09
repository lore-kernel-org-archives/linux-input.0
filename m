Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3003C25B06
	for <linux-input@archiver.kernel.org>; Tue,  9 Aug 2022 07:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbiHIH3x (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 9 Aug 2022 03:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbiHIH3v (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 9 Aug 2022 03:29:51 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9D320F58
        for <linux-input@vger.kernel.org>; Tue,  9 Aug 2022 00:29:50 -0700 (PDT)
Date:   Tue, 09 Aug 2022 07:29:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1660030186; x=1660289386;
        bh=fayOQDMd/PIWFyagVAiWbk5bupPGTprmhHwG5PCk1bw=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=FchnhQikPHAKTypNXdxlTYoDTEgnwpJWiARJBcC6HumYp3CtbRFKCN1DrItE7lKSE
         WuWfhPVL9usmzp8Xvf7CYVCdqKvwoc2PaC3DDr3Atc1ij5+/YEIdW9SYs7bghbq7y6
         wN30muvHp4HWXe/2Q1JZup3LB5O8SeuhdZR2Goxj8+zPJkYrc/60hdb6NF/nXfD96V
         iRSRRBZ3pB0Tx8eKmTKDipzLIathMNqhLWUHRDLSgishweMBJnNxrJLNFV48dvWZ0W
         sdiNuMgvf3If0NptmZ58ewdNvkDAL/S0aXUZvhP+hZAxlUwA8AXH8bnnOBuVdvw2wn
         E2yCxcBqB3UGA==
To:     markuss.broks@gmail.com
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linmengbo0689@protonmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, robh+dt@kernel.org,
        rydberg@bitmath.org, ~postmarketos/upstreaming@lists.sr.ht
Reply-To: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: Re: [PATCH 0/3] Add support for Imagis IST3038B
Message-ID: <20220809072845.9855-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

> Tested by Lin Meng-Bo on Samsung Galaxy Core Prime.
>
> Cc: Lin Meng-Bo <linmengbo0689@protonmail.com>

As we discussed before, actually it's not real IST3038B.
Instead, it should be IST30XXB with chip ID 0x300b300b, which can be
identified with
(0x40000000 | IST3038C_DIRECT_ACCESS)
, while IST3038C uses
(0x40001000 | IST3038C_DIRECT_ACCESS), similarly.

So I would suggest to hold IST3038B patches since I don't really have one.

Best regards,

Lin

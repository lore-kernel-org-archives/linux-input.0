Return-Path: <SRS0=RHiL=D2=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C07C433E7
	for <linux-input@archiver.kernel.org>; Mon, 19 Oct 2020 12:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2345F222C3
	for <linux-input@archiver.kernel.org>; Mon, 19 Oct 2020 12:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="dY0ATRRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgJSMxO (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 19 Oct 2020 08:53:14 -0400
Received: from mail-40141.protonmail.ch ([185.70.40.141]:53405 "EHLO
        mail-40141.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgJSMxO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Oct 2020 08:53:14 -0400
Date:   Mon, 19 Oct 2020 12:53:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1603111991;
        bh=+RaXHwwamZ1EOj3yremEf8kauSUCk1hTCgWdKFgnrBk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=dY0ATRRKV5WTsvbLCvupPYhnTUzcr8bkyvm+nPA4qqtiL+IpUwrfsZGdNRwe2boE4
         Qelc3Q6lD2XT5WQfXCkO3zKagV65PlFdh8AnK6TQmY7V+Jchci3H8Mfah4Ozq1Ioji
         VFQwsamdpvRW5+0JTPGytYlPQ0UaKmKHYkXtYGlY=
To:     Coiby Xu <coiby.xu@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Helmut Stult <helmut.stult@schinfo.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: add polling mode based on connected GPIO chip's pin status
Message-ID: <eA5pt2nxH5jB_qgxYEAHbUxK5Rxww6DE2IpvFKGrvMyZvM2nZbqil2egzmycszz06jij2B69JG-dqNQ5XLuufMzUm10bxLJ2xHoj9UEY5jk=@protonmail.com>
In-Reply-To: <20201019005412.rifxrvpdxu574jag@Rk>
References: <20201016131335.8121-1-coiby.xu@gmail.com> <T2SIcFVxZ81NUwKLDbSESA7Wpm7DYowEiii8ZaxTPtrdXZZeHLq5iZPkN5BLlp-9C6PLwUZOVwNpMdEdPSRZcAG4MmDt-tfyKZoQYJ0KHOA=@protonmail.com> <20201017004556.kuoxzmbvef4yr3kg@Rk> <FWsXxqGztJgszUpmNtKli8eOyeKP-lxFeTsjs2nQAxgYZBkT3JNTU3VdHF4GbQVS_PvKiqbfrZXI7vaUHA_lXTxjPX-WjkNEOdiMUetO8IQ=@protonmail.com> <20201017140541.fggujaz2klpv3cd5@Rk> <fRxQJHWq9ZL950ZPGFFm_LfSlMjsjrpG7Y63gd7V7iV647KR8WIfZ4-ljLeo0n4X3Gpu1KIEsMVLxQnzAtJdUdMydi_b0-vjIVb304Da1bQ=@protonmail.com> <20201019005412.rifxrvpdxu574jag@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

> [...]
> You have been directly contributing to this patch because several
> improvements of next version are from you. I experienced a similar
> situation when submitting patches for QEMU. The only difference is
> that the feedbacks on the QEMU patches were also given in the format
> of patch. Or do you think a reviewed-by tag from you after you think
> the next version is of production quality is a better way to credit
> you?

Thanks, but there is no need for any tag from me. I am no maintainer/review=
er of/for
the affected subsystem.

> [...]


Regards,
Barnab=C3=A1s P=C5=91cze

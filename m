Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B0AC4338F
	for <linux-input@archiver.kernel.org>; Wed, 28 Jul 2021 12:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6386023D
	for <linux-input@archiver.kernel.org>; Wed, 28 Jul 2021 12:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbhG1Mg4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 28 Jul 2021 08:36:56 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:54931 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234676AbhG1Mgz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Jul 2021 08:36:55 -0400
Date:   Wed, 28 Jul 2021 14:36:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1627475813;
        bh=Fzj0zgMnylU3D0dQBALH+sR4ieu2clA1UcSq9ysCLDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pGTIt5SK2lwqn8EPD+q5Q79hna95kCR7KSeiwlYOcXjE41tXzilE1/WyZ+rbI7H9t
         9kwJ64UD3tvO468MbjJzWbgcvSFlgg75PqoI3NvYNZFlEn12RgSFFGl01i39JawRgt
         Y7Jvgn4hJ5I4Ta199Y9ZSIPmwf/YiQdkV58xNeZo=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Ben Chen <ben_chen@bizlinktech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] HID: cmedia: add support for HS-100B mute button
Message-ID: <dbd96e4f-8554-4bce-a3ed-b483db285060@t-8ch.de>
References: <20210720202708.341057-1-linux@weissschuh.net>
 <nycvar.YFH.7.76.2107281151280.8253@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YFH.7.76.2107281151280.8253@cbobk.fhfr.pm>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mi, 2021-07-28T11:51+0200, Jiri Kosina wrote:
> On Tue, 20 Jul 2021, Thomas Weißschuh wrote:
> 
> > These chips report mute button events in bit 4 of their report without it
> > being part of the report descriptor.
> > Use a custom descriptor that maps this bit.

> Applied, thanks Thomas.

Thanks Jiri!

Thomas

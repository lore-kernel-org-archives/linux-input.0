Return-Path: <SRS0=wqHz=7L=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90178C433E0
	for <linux-input@archiver.kernel.org>; Fri, 29 May 2020 14:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6887720721
	for <linux-input@archiver.kernel.org>; Fri, 29 May 2020 14:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="DYbGBfuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgE2OqR (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 29 May 2020 10:46:17 -0400
Received: from out0.migadu.com ([94.23.1.103]:46104 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgE2OqQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 May 2020 10:46:16 -0400
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2020 10:46:15 EDT
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=default;
        t=1590762982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xAl1ADflJmWJtGjhanry7967LG7bPD3eSpOhwdpC2M=;
        b=DYbGBfuLbazDx2QUp6jGyqLat20shXYymXUFG0Zr8fj/cRI42MaTEYzzjYOdU9OFYyT1wc
        4f0pkPjwoDbhOC7L/zvaCYLWaFZJGuuaUXsujb/ADBhq5U19D6/IzyS7eFujxgzgZU6YWM
        iWAySGL5GFUQeEWhMgqrZvF2/ZESxqM=
Date:   Fri, 29 May 2020 14:36:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   kl@kl.wtf
Message-ID: <de074a35c727b8ba193477cb2508e1af@kl.wtf>
Subject: Re: [PATCH] Input: evdev - per-client waitgroups
To:     linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20200429184126.2155-1-kl@kl.wtf>
References: <20200429184126.2155-1-kl@kl.wtf>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

April 29, 2020 8:41 PM, "Kenny Levinsen" <kl@kl.wtf> wrote:=0A=0A> All ev=
dev clients share a common waitgroup. On new input events, this=0A> waitg=
roup is woken once for every client that did not filter the events,=0A> l=
eading to duplicated and unwanted wakeups.=0A> =0A> Split the shared wait=
group into per-client waitgroups for more=0A> fine-grained wakeups.=0A> =
=0A> Signed-off-by: Kenny Levinsen <kl@kl.wtf>=0A> ---=0A> drivers/input/=
evdev.c | 19 +++++++++----------=0A> 1 file changed, 9 insertions(+), 10 =
deletions(-)=0A=0AHere's a 1-month ping for lack of better idea. Apologie=
s if that's not the right thing to do, just worried that things might hav=
e been lost to the great inbox event horizon.

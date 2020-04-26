Return-Path: <SRS0=b02c=6K=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A422CC54FCB
	for <linux-input@archiver.kernel.org>; Sun, 26 Apr 2020 18:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B69D2070A
	for <linux-input@archiver.kernel.org>; Sun, 26 Apr 2020 18:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="k75zGohZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgDZSPw (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:15:52 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:63337 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgDZSPv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 26 Apr 2020 14:15:51 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 499GLC1DQ9zDY;
        Sun, 26 Apr 2020 20:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1587924949; bh=LLoOzAvLD7C4p+NfULVwebW8Si59PUK0pEfcNYs87dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k75zGohZ2RqPHx/Bc7TjhsSSfPIfat1RVKxhNC63bnHZktMJ9dpjxwp3pHIqRD6RT
         YBhlCv2Tqy3oURZ7Drp2N6AMGceOe57odEKxDQgpr3uTczH6iN81WZh+gb3WvTxzDd
         xCmVmKFRv9KZKieTTWAV7b2rjo7oaGBBpyxIpqYOXiV3279ht/MQ+ws2MEAD9JETIW
         NA7GjRGe9gL8NNRP1yP91UiuDhxfWgc7FOCaUbkL7Sp30GPxg5KmifYoO0hM0jhRb1
         gLZoZa8y4LvBMPi5GL3nEZoPl4Tb/fQmrRp0aG1GJwbJN6BacLQ6Zpv82P8lNXAFjf
         afLHF5eZVW1iA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 26 Apr 2020 20:15:45 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     David Heidelberg <david@ixit.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        James Chen <james.chen@emc.com.tw>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Liu <scott.liu@emc.com.tw>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/10] input: elants: remove unused axes
Message-ID: <20200426181545.GC15436@qmqm.qmqm.pl>
References: <cover.1587916846.git.mirq-linux@rere.qmqm.pl>
 <b6cb0f810eec2d5c6245d6128502eebd342ca02a.1587916846.git.mirq-linux@rere.qmqm.pl>
 <0f66e93c-9c71-73d0-90b8-15e0802a79c5@gmail.com>
 <20200426172954.GA15436@qmqm.qmqm.pl>
 <8b39ab58-dfc2-323c-3b25-4e9023cf8f0d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b39ab58-dfc2-323c-3b25-4e9023cf8f0d@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, Apr 26, 2020 at 08:45:14PM +0300, Dmitry Osipenko wrote:
> 26.04.2020 20:29, Michał Mirosław пишет:
> > On Sun, Apr 26, 2020 at 07:35:47PM +0300, Dmitry Osipenko wrote:
> >> 26.04.2020 19:11, Michał Mirosław пишет:
> >>> Driver only ever reports MT events and input_mt_init_slots() sets up
> >>> emulated axes already.  Clear the capabilities not generated directly
> >>> and move MT axes setup, so they are visible by input_mt_init_slots().
> >>>
> >>> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> >>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> >>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> >>> ---
> >>> v4: reword commitmsg; reorder axis setup
> >>> ---
> >>
> >> Legacy pointer emulation doesn't work using v4. I think it will be
> >> better to drop this patch for now and add this hunk to the patch #4:
> > 
> > Have you tried it together with the next patch? It adds
> > touchscreen_parse_properties() to initialize axes also from DT, and
> > should be equivalent to the hunk you proposed.
> 
> Yes, the touchscreen_parse_properties() takes bool multitouch for the
> argument, and thus, it needs to be applied to both MT/non-MT cases.
> 
> https://elixir.bootlin.com/linux/v5.7-rc2/source/drivers/input/touchscreen/of_touchscreen.c#L64

input_mt_init_slots() should copy MT axes to non-MT if they are
described before the call.

With v5 applied, I can see in evtest MT and non-MT events.

Best Regards,
Michał Mirosław

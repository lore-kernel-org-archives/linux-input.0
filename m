Return-Path: <SRS0=SPD7=IE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E662AC433DB
	for <linux-input@archiver.kernel.org>; Sat,  6 Mar 2021 11:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36626501A
	for <linux-input@archiver.kernel.org>; Sat,  6 Mar 2021 11:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhCFLub (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:50:31 -0500
Received: from 19.mo1.mail-out.ovh.net ([178.32.97.206]:57278 "EHLO
        19.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhCFLuB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 6 Mar 2021 06:50:01 -0500
X-Greylist: delayed 4546 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Mar 2021 06:50:01 EST
Received: from player794.ha.ovh.net (unknown [10.110.171.96])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 12DE61F663D
        for <linux-input@vger.kernel.org>; Sat,  6 Mar 2021 11:34:08 +0100 (CET)
Received: from etezian.org (213-243-141-64.bb.dnainternet.fi [213.243.141.64])
        (Authenticated sender: andi@etezian.org)
        by player794.ha.ovh.net (Postfix) with ESMTPSA id ACFA8189DE25E;
        Sat,  6 Mar 2021 10:34:00 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-104R00514333635-2488-4637-90a3-dac8af8f3e7f,
                    9571E067575576FF419ADF64CFE3CE9644992B38) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 213.243.141.64
Date:   Sat, 6 Mar 2021 12:33:59 +0200
From:   Andi Shyti <andi@etezian.org>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     andi@etezian.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] input: s6sy761: fix coordinate read bit shift
Message-ID: <YENal0wZTYvKNN+6@jack.zhora.eu>
References: <20210305185710.225168-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305185710.225168-1-caleb@connolly.tech>
X-Ovh-Tracer-Id: 6530219462860784343
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddtkedgudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihesvghtvgiiihgrnhdrohhrgheqnecuggftrfgrthhtvghrnheptdfgudduhfefueeujeefieehtdeftefggeevhefgueellefhudetgeeikeduieefnecukfhppedtrddtrddtrddtpddvudefrddvgeefrddugedurdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Caleb,

On Fri, Mar 05, 2021 at 06:58:10PM +0000, Caleb Connolly wrote:
> The touch coordinate register contains the following:
> 
>         byte 3             byte 2             byte 1
> +--------+--------+ +-----------------+ +-----------------+
> |        |        | |                 | |                 |
> | X[3:0] | Y[3:0] | |     Y[11:4]     | |     X[11:4]     |
> |        |        | |                 | |                 |
> +--------+--------+ +-----------------+ +-----------------+
> 
> Bytes 2 and 1 need to be shifted left by 4 bits, the least significant
> nibble of each is stored in byte 3. Currently they are only
> being shifted by 3 causing the reported coordinates to be incorrect.
> 
> This matches downstream examples, and has been confirmed on my
> device (OnePlus 7 Pro).
> 
> Fixes: 0145a7141e59 ("Input: add support for the Samsung S6SY761
> touchscreen")
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi

Return-Path: <SRS0=yABA=YB=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE810C10F14
	for <linux-input@archiver.kernel.org>; Tue,  8 Oct 2019 13:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB104206BB
	for <linux-input@archiver.kernel.org>; Tue,  8 Oct 2019 13:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfJHNFZ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:05:25 -0400
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:44327 "EHLO
        3.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbfJHNFZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Oct 2019 09:05:25 -0400
X-Greylist: delayed 3004 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Oct 2019 09:05:24 EDT
Received: from player711.ha.ovh.net (unknown [10.109.160.76])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id EA3FC2077B1
        for <linux-input@vger.kernel.org>; Tue,  8 Oct 2019 13:45:31 +0200 (CEST)
Received: from etezian.org (85-76-98-218-nat.elisa-mobile.fi [85.76.98.218])
        (Authenticated sender: andi@etezian.org)
        by player711.ha.ovh.net (Postfix) with ESMTPSA id B934DA9C95CC;
        Tue,  8 Oct 2019 11:45:20 +0000 (UTC)
Date:   Tue, 8 Oct 2019 14:45:20 +0300
From:   Andi Shyti <andi@etezian.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andi Shyti <andi@etezian.org>,
        Andi Shyti <andi.shyti@samsung.com>,
        Simon Shields <simon@lineageos.org>,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: mms114: document melfas,mms345l binding
Message-ID: <20191008114520.GD4015@jack.zhora.eu>
References: <20191007203343.101466-1-stephan@gerhold.net>
 <20191007203343.101466-3-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20191007203343.101466-3-stephan@gerhold.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Ovh-Tracer-Id: 8564439116743557869
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrheelgdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
Message-ID: <20191008114520.X3NLtTowh1GjmpJ4DUTX8opjsLnk2oAzFjQpCMDP1UU@z>

Hi Stephan,

On Mon, Oct 07, 2019 at 10:33:42PM +0200, Stephan Gerhold wrote:
> The mms114 driver now supports MMS345L; document the
> melfas,mms345l binding that is used for it.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi

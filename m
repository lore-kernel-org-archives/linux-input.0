Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C28AE7F153
	for <linux-input@archiver.kernel.org>; Fri, 29 Sep 2023 10:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjI2KWa (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 29 Sep 2023 06:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjI2KW3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2023 06:22:29 -0400
X-Greylist: delayed 351 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Sep 2023 03:22:26 PDT
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593C1F9
        for <linux-input@vger.kernel.org>; Fri, 29 Sep 2023 03:22:26 -0700 (PDT)
Received: from [192.168.42.20] (p5b164245.dip0.t-ipconnect.de [91.22.66.69])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPSA id F3D662FC0052;
        Fri, 29 Sep 2023 12:16:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1695982594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RmQlQdO0r9RSMsKdbG/5LYQ8R2NehpYBH23HUtOkI24=;
        b=QPONAGe4cGKAFgr4aie/c2u13qE3IitfeZ+SdcLvDEMi57153YQ2HX7L/imhrjkF7nDy0+
        r0vj2zcJw98zOA6XGpVxWJWot17eunrnCfI+9ahTkxDot5b2DPvCfny98zdoGtJLsjWWec
        rUJ8jhM9O5qPGGPLFg0hGVl4Axq7tnM=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <0e966f98-5e32-cc34-95a6-ea1503936449@tuxedocomputers.com>
Date:   Fri, 29 Sep 2023 12:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To:     hdegoede@redhat.com
Cc:     chenhuacai@kernel.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mkorpershoek@baylibre.com, tiwai@suse.de,
        wsa+renesas@sang-engineering.com, wse@tuxedocomputers.com
References: <0e2b5e9d-d68f-59dd-6e9c-b5cdabc086c2@redhat.com>
Subject: Re: [PATCH] Fix strange behavior of touchpad on Clevo NS70PU
Content-Language: en-US
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <0e2b5e9d-d68f-59dd-6e9c-b5cdabc086c2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

I just checked and saw that this never got merged. So I wanted to gently bump it.

Kind regards,

Werner Sembach


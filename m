Return-Path: <SRS0=Cf0f=BD=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8503AC433E1
	for <linux-input@archiver.kernel.org>; Fri, 24 Jul 2020 09:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F0E820767
	for <linux-input@archiver.kernel.org>; Fri, 24 Jul 2020 09:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l79+wlNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgGXJHf (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgGXJHf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Jul 2020 05:07:35 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719C6C0619D3
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2020 02:07:34 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a32so6409899qtb.5
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2020 02:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0XN62WCRa1pXTHUD/QOWulTItxVVusARLdvW2gpROro=;
        b=l79+wlNCSw5qF6AF5l9NBywRv28h5WTk96QzYsoqFYdRCcFWRfxgoigCJI6i/UVTkr
         4YGqAFN5oQiabzOyxylbgZzbKbflwOudA4+djOjyRv1VGVcO3uD/p66/PLk8PJ6ZaYbs
         mHfeBVf0hrpzHHrbiWRZqA8R/cQLW0sp1I9SDNX5/y565C57AC2MjHDkOu7uNucL9eag
         4+r4o0FRIJtpV4t2XpEl2m4WMN1CdeadAReWtAfg9nvbAn8otGCr+UutAxHN3a9VaUVV
         28U64CZ7eigJSskx9APAoBHPm5HDyeKjICcokqPbdnnUKKQKBTv+QuZ7KrzPIx/akCpD
         2qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0XN62WCRa1pXTHUD/QOWulTItxVVusARLdvW2gpROro=;
        b=r6ddjZtTFxN013PObrVgXbrXn/Aj/jXlYmZHl9YQgdAGl/jCu94E6+rzwhgZeEPUL1
         BHZOX5FPBRTa4Z4+RsPTMPcbGXmm8/sLB64Gy9+oKLDsbASpkslbqn/DONJRjHDYZpN4
         lhaU/2LqHG2AVLBP32xWj8L731BSFkbPVA+5IO4jSq3+LZvaVgzv1hTIFhS9z4dlYujt
         DqCw8tJiyROY1vvY7PU/aNY3pXpxJKFhpu6iyOb37ZVdlHbfJNYLcQ5wzbxxFORgdSwN
         RIig5UzyaJY75kqyuBzH0L58av4B9nbOrn/MMzZFVmsotQxLdabr9PHtbbO4jQlIVkuR
         28yg==
X-Gm-Message-State: AOAM530fvMPmHPBwT1RhSv8MWWslEZypXizOv5gabC3YMblELHXj6R1j
        qcsLzHaxvhX8a3zLsK2FioDPEJhfN6rC7PoQO9AmCMhmXzw=
X-Google-Smtp-Source: ABdhPJwWyMlSMsCO20YAK4eBk+kP2cGeHfDxGRLQo8L9s2DTmT00P68hvMOgwkilsFYrPrkqB8cKtBHywpip1U+EmsE=
X-Received: by 2002:ac8:6758:: with SMTP id n24mr6930226qtp.124.1595581653335;
 Fri, 24 Jul 2020 02:07:33 -0700 (PDT)
MIME-Version: 1.0
From:   Matteo Croce <technoboy85@gmail.com>
Date:   Fri, 24 Jul 2020 11:06:57 +0200
Message-ID: <CAFnufp3HJgwSpvPy4G0W++cp9kCL+R2fM-cjDiSC3NKGhCiEPw@mail.gmail.com>
Subject: elan_i2c fail
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

I have a Lenovo t490s, and sometimes at boot the touchpad is not working.
When it fails the syslog says:

psmouse serio1: elantech: assuming hardware version 4 (with firmware
version 0x7f3001)
psmouse serio1: elantech: Synaptics capabilities query result 0x90, 0x18, 0x0f.
psmouse serio1: elantech: Elan sample query result 00, 2f, c9
psmouse serio1: elantech: Trying to set up SMBus access
elan_i2c 0-0015: failed to get FW checksum: -71
elan_i2c: probe of 0-0015 failed with error -71

Is it a known issue? I'm using a vanilla 5.7.9 kernel.

-- 
Matteo Croce
perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

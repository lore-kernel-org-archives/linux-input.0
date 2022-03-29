Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAED8C4332F
	for <linux-input@archiver.kernel.org>; Tue, 29 Mar 2022 14:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiC2OiT (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 29 Mar 2022 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiC2OiJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Mar 2022 10:38:09 -0400
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720F6A8896;
        Tue, 29 Mar 2022 07:36:26 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id D0E58C800A5;
        Tue, 29 Mar 2022 16:36:24 +0200 (CEST)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from; s=
        default; t=1648564584; x=1650378985; bh=mwk28r+YUt5VtDxvGU+YNM5W
        xjrEC6zJD/ONPuLlN2g=; b=AhxkweHIcP20yOiEeEHINLcSoh2nbjqET/YAtb+d
        XGzkoV7QmnXTxuKfcamCzzEROQ5X+OKpKe6gAWQmjzVBxor8E3/gsI/hDgRo9xfp
        4IdawH1V1dWvFGVzvh+F/e/aDfSQcnI+lLnWTej5uxCaJZ91PY6C0aXfjgcieaQi
        vT0=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id Xi7qPlpoVKeX; Tue, 29 Mar 2022 16:36:24 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 5BD02C800A2;
        Tue, 29 Mar 2022 16:36:24 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, hdegoede@redhat.com, samuel@cavoj.net,
        wse@tuxedocomputers.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] input/i8042: Rework quirk tables
Date:   Tue, 29 Mar 2022 16:36:18 +0200
Message-Id: <20220329143622.31394-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Revision 5 with some fixes based on feedback by Hans de Goede.

The 1st patch is minor housekeeping.

The 2nd patch merges the tables together. Minor fixes in 5th revision and
no more duplication of ASUS devices

The 3rd patch add optional debug output to see which quirks get applied. In
5th revision this no longer breaks compilation on non x86 platforms.

The 4th patch adds a list of Clevo devices that need multiple quirks.
With the reworked table they don't need to be inserted multiple times now,
which was required in v1 and v2 of this patch.

I also included the extra quirk for the Clevo NS7xMU, which was a separate
patch before.

The added Clevo devices are now only identified by their board name as this
is the only somewhat reliable string that might not be changed by resellers.



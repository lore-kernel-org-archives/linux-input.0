Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EDFC83013
	for <linux-input@archiver.kernel.org>; Tue,  1 Dec 2020 08:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6560C206D8
	for <linux-input@archiver.kernel.org>; Tue,  1 Dec 2020 08:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgLAIgR (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 1 Dec 2020 03:36:17 -0500
Received: from mail.v3.sk ([167.172.186.51]:58874 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727343AbgLAIgR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 1 Dec 2020 03:36:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7F238E070D;
        Tue,  1 Dec 2020 08:32:40 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id idyA1Q4AdZg2; Tue,  1 Dec 2020 08:32:40 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3184CE06C5;
        Tue,  1 Dec 2020 08:32:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z9J0qottMIDi; Tue,  1 Dec 2020 08:32:40 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 0121FDF9A4;
        Tue,  1 Dec 2020 08:32:39 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Add driver for power button on Dell Wyse 3020
Date:   Tue,  1 Dec 2020 09:35:31 +0100
Message-Id: <20201201083533.1724287-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

please consider applying the patches chained to this message. It's a
rather simple driver for a power button on Dell Ariel board along with
the Device Tree binding document.

Compared to previous version, it fixes a validation warning in the DT
bindings. Change logs are present in individual patches.

Thank you
Lubo



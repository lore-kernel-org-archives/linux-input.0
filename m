Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F21C3E8C5
	for <linux-input@archiver.kernel.org>; Sun, 29 Nov 2020 14:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F9220719
	for <linux-input@archiver.kernel.org>; Sun, 29 Nov 2020 14:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgK2Oc1 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 29 Nov 2020 09:32:27 -0500
Received: from mail.v3.sk ([167.172.186.51]:57040 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbgK2Oc1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 29 Nov 2020 09:32:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 02ED0DFA00;
        Sun, 29 Nov 2020 14:19:01 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id j7ravqHqDd0P; Sun, 29 Nov 2020 14:19:00 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8B4D8DF887;
        Sun, 29 Nov 2020 14:19:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BIV-dPy_fT-4; Sun, 29 Nov 2020 14:19:00 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 55F88DF5C9;
        Sun, 29 Nov 2020 14:19:00 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add driver for power button on Dell Wyse 3020
Date:   Sun, 29 Nov 2020 15:21:43 +0100
Message-Id: <20201129142145.1526022-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

please consider applying the patches chained to this message. It's a
rather simple driver for a power button on Dell Ariel board along with
the Device Tree binding document.

Compared to previous version, endianness issues are fixed and I
connected a Reviewed-by for the binding doc that I failed to before.
Change logs are present in individual patches.

Note that this set is versioned "v2", but I've sent the previous version
(both unversioned) out twice before, because I've forgotten about
the previous submission before. Sorry if it caused a confusion.

Thank you
Lubo



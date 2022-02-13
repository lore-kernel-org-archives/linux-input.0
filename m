Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5B1C43217
	for <linux-input@archiver.kernel.org>; Sun, 13 Feb 2022 21:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbiBMV4l (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 13 Feb 2022 16:56:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238480AbiBMV4l (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 13 Feb 2022 16:56:41 -0500
Received: from zeus.flokli.de (mail.zeus.flokli.de [88.198.15.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E35419B;
        Sun, 13 Feb 2022 13:56:31 -0800 (PST)
Received: from localhost (ip-178-200-100-055.um45.pools.vodafone-ip.de [178.200.100.55])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: flokli@flokli.de)
        by zeus.flokli.de (Postfix) with ESMTPSA id A8E9F1299FB8;
        Sun, 13 Feb 2022 21:49:48 +0000 (UTC)
From:   Florian Klink <flokli@flokli.de>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] HID: lenovo: Add support for ThinkPad TrackPoint
Date:   Sun, 13 Feb 2022 22:49:21 +0100
Message-Id: <20220213214924.32407-1-flokli@flokli.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This is a re-roll of v3, fixing the block comment alignment warning
checkpatch.pl is complaining about.

It's still complaining about line length of the comment next to the
magic numbers, but as those comments appear the same in hid-bigbenff.c,
I assume that's fine.



Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8B1C433DB
	for <linux-input@archiver.kernel.org>; Sat, 23 Jan 2021 13:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FE222B2A
	for <linux-input@archiver.kernel.org>; Sat, 23 Jan 2021 13:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbhAWNuE (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:50:04 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:45897 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbhAWNuB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 23 Jan 2021 08:50:01 -0500
Received: from envy.fritz.box ([82.207.207.243]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQ6C0-1lPOUD0vMO-00M25O; Sat, 23 Jan 2021 14:47:21 +0100
From:   mail@richard-neumann.de
To:     nehal-bakulchandra.shah@amd.com, sandeep.singh@amd.com,
        mail@richard-neumann.de, corbet@lwn.net, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/8] Updated MAINTAINERS
Date:   Sat, 23 Jan 2021 14:47:09 +0100
Message-Id: <20210123134716.13414-2-mail@richard-neumann.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210123134716.13414-1-mail@richard-neumann.de>
References: <20210123134716.13414-1-mail@richard-neumann.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XW9SFnlWxVaoceXMzqNb5ooPpIJTWb6yglbN3g4FFpJ0Yff8hS0
 4a+7dbrNaHjPjOuXH5f9df0Z79yl5oJdi/2AYPGS5HC6JuVHZieNL9740x1XtxJWe7HCF5q
 /HHrRKuV/mOfj8XvgFa3eNgXtDyw+Hpl8co0/44k4zze1SpT9gA6v0ym4RmqrDrR2VEZ1yV
 kuVmclzdewH+g4RmUgY3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U4kGFz4a+Zo=:gOwnLCqpRxbtsFvEbHZoaW
 m9NT4MzV2c+PPNXlyTIDnvGFdLs72TZxZ4sBsEPmZgUqcc53vmWHjQF6bQENbYpwvAmSUghC5
 R/51I5OEg4k0aM8iVteBqM2Ukn8zPSXmTiH0FbDXuEsg2a88EIZZMiSg7dJfGDyoDwNdKogt8
 XyU8wkfnL+G3L6GKFDHP76ryahnp/S1oYU6CdGXHOFV32i+eK8VeeO8eFddibs5Fo7USpS3t1
 yi30M1YIZZelYe14zH0DOy23haMzSvB3K+uh5HBINENVRPu/CUuB2Ze6lIhVz14jYlCkg8guJ
 6oyefclgE4PduupfUr7MkSlTghkfbJYDPkP9ju4lxvIpKAUyrqp+eZZlLz4oGZEJjkorqvwS4
 5cUtjWxgJReguKfLmi56N1xXlWsvQVeTbygcrsti6L/b9+FZ3g1G9/UTRrFZQ8NGXVu+lDG4E
 ZwU9ssdA2Q==
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Richard Neumann <mail@richard-neumann.de>

Added Richard Neumann to the maintainers of the AMD Sensor Fusion Hub driver.

Signed-off-by: Richard Neumann <mail@richard-neumann.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f79ec98bbb29..54df795a16d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -958,6 +958,7 @@ F:	drivers/net/ethernet/amd/xgbe/
 AMD SENSOR FUSION HUB DRIVER
 M:	Nehal Shah <nehal-bakulchandra.shah@amd.com>
 M:	Sandeep Singh <sandeep.singh@amd.com>
+M:	Richard Neumann <mail@richard-neumann.de>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/hid/amd-sfh*
-- 
2.30.0


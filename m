Return-Path: <SRS0=IGfu=2T=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B5CC2D0DA
	for <linux-input@archiver.kernel.org>; Sun, 29 Dec 2019 19:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE0220748
	for <linux-input@archiver.kernel.org>; Sun, 29 Dec 2019 19:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfL2TeT (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 29 Dec 2019 14:34:19 -0500
Received: from relay-b03.edpnet.be ([212.71.1.220]:53271 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfL2TeT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 29 Dec 2019 14:34:19 -0500
X-ASG-Debug-ID: 1577647292-0a881838821e9eb50001-vblZzk
Received: from zotac.vandijck-laurijssen.be (77.109.105.251.adsl.dyn.edpnet.net [77.109.105.251]) by relay-b03.edpnet.be with ESMTP id cFzFThlghWR1FNZt; Sun, 29 Dec 2019 20:21:32 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.251.adsl.dyn.edpnet.net[77.109.105.251]
X-Barracuda-Apparent-Source-IP: 77.109.105.251
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 9F44BC02E48;
        Sun, 29 Dec 2019 20:21:31 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-input@vger.kernel.org
Cc:     linux-can@vger.kernel.org
Subject: [RFC] input: cap11xx: plasma globe proof
Date:   Sun, 29 Dec 2019 20:21:11 +0100
X-ASG-Orig-Subj: [RFC] input: cap11xx: plasma globe proof
Message-Id: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
X-Barracuda-Connect: 77.109.105.251.adsl.dyn.edpnet.net[77.109.105.251]
X-Barracuda-Start-Time: 1577647292
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 707
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6218 1.0000 0.8575
X-Barracuda-Spam-Score: 0.86
X-Barracuda-Spam-Status: No, SCORE=0.86 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78985
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hey,

I built a raspberry-pi wakeup for my kids. Recently, one of them bought
a plasma globe. That globe leaves an electrostatic field that disturbes
the cap11xx when it operates with default settings.
So I grabbed the datasheet and started modifying the configuration.
This is the result that should apply to other scenarios as well.

The patch series improves the cap11xx in 2 ways.
It adds support for a cap1208 as on the explorer hat of Pimoroni,
and allows to run in polling mode (the explorer hat omitted the irq,
or I didn't find it).
It then exposes the major configuration parts of the chip so one can
tune it to her/his needs.

Please feel free to comment

Kind regards,
Kurt


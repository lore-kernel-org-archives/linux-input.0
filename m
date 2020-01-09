Return-Path: <SRS0=H8lw=26=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4DEC282DD
	for <linux-input@archiver.kernel.org>; Thu,  9 Jan 2020 20:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C84A2072A
	for <linux-input@archiver.kernel.org>; Thu,  9 Jan 2020 20:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgAIUDi (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:03:38 -0500
Received: from relay-b01.edpnet.be ([212.71.1.221]:55991 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgAIUDi (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Jan 2020 15:03:38 -0500
X-ASG-Debug-ID: 1578600215-0a7ff5137d2f8c060001-vblZzk
Received: from zotac.vandijck-laurijssen.be (77.109.104.28.adsl.dyn.edpnet.net [77.109.104.28]) by relay-b01.edpnet.be with ESMTP id aCZF7qO2B6CDuv2i; Thu, 09 Jan 2020 21:03:35 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.104.28.adsl.dyn.edpnet.net[77.109.104.28]
X-Barracuda-Apparent-Source-IP: 77.109.104.28
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 4F32FC36217;
        Thu,  9 Jan 2020 21:03:35 +0100 (CET)
Date:   Thu, 9 Jan 2020 21:03:34 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-input@vger.kernel.org
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC] input: cap11xx: plasma globe proof
Message-ID: <20200109200334.GA19438@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [RFC] input: cap11xx: plasma globe proof
Mail-Followup-To: linux-input@vger.kernel.org, linux-can@vger.kernel.org
References: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.104.28.adsl.dyn.edpnet.net[77.109.104.28]
X-Barracuda-Start-Time: 1578600215
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 814
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9963 1.0000 4.2994
X-Barracuda-Spam-Score: 4.30
X-Barracuda-Spam-Status: No, SCORE=4.30 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79234
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Ping?

On zo, 29 dec 2019 20:21:11 +0100, Kurt Van Dijck wrote:
> Hey,
> 
> I built a raspberry-pi wakeup for my kids. Recently, one of them bought
> a plasma globe. That globe leaves an electrostatic field that disturbes
> the cap11xx when it operates with default settings.
> So I grabbed the datasheet and started modifying the configuration.
> This is the result that should apply to other scenarios as well.
> 
> The patch series improves the cap11xx in 2 ways.
> It adds support for a cap1208 as on the explorer hat of Pimoroni,
> and allows to run in polling mode (the explorer hat omitted the irq,
> or I didn't find it).
> It then exposes the major configuration parts of the chip so one can
> tune it to her/his needs.
> 
> Please feel free to comment
> 
> Kind regards,
> Kurt
> 

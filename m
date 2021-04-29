Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3BCC433ED
	for <linux-input@archiver.kernel.org>; Thu, 29 Apr 2021 20:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5DD7613AD
	for <linux-input@archiver.kernel.org>; Thu, 29 Apr 2021 20:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhD2UUV (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 29 Apr 2021 16:20:21 -0400
Received: from vps.thesusis.net ([34.202.238.73]:37460 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhD2UUU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Apr 2021 16:20:20 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Apr 2021 16:20:20 EDT
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id 201FE2EC90;
        Thu, 29 Apr 2021 16:14:11 -0400 (EDT)
Received: from vps.thesusis.net ([IPv6:::1])
        by localhost (vps.thesusis.net [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id 89QMLZuC1OIo; Thu, 29 Apr 2021 16:14:10 -0400 (EDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id D9C722ECB9; Thu, 29 Apr 2021 16:14:10 -0400 (EDT)
References: <87o8dw52jc.fsf@vps.thesusis.net>
User-agent: mu4e 1.5.7; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     xen-devel@lists.xenproject.org
Cc:     linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: Xen Virtual Keyboard modalias breaking uevents
Date:   Thu, 29 Apr 2021 16:10:09 -0400
In-reply-to: <87o8dw52jc.fsf@vps.thesusis.net>
Message-ID: <87fsz84zn1.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


It appears that input/input.c is responsible for the insane modalias
length.  If I am reading input_print_modalias() correctly, it appends a
"k" plus every key code that the keyboard supports, and the Xen Virtual
Keyboard supports a lot of keycodes.  Why does it do this?

Phillip Susi writes:

> So I have finally drilled down to the modalias for the Xen Virtual
> Keyboard driver being so long ( over 2KB ) that it causes an -ENOMEM
> when trying to add it to the environment for uevents.  This causes
> coldplug to fail, which causes the script doing coldplug as part of the
> debian-installer init to fail, which causes a kernel panic when init
> exits, which then for reasons I have yet to understand, causes the Xen
> domU to reboot.
>
> Why is this modalias so huge?  Can we pare it down, or or is there
> another solution to get uevents working on this device again?  Maybe the
> environment block size needs to be increased?  I don't know.


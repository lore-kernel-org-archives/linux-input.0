Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615DAC433ED
	for <linux-input@archiver.kernel.org>; Fri, 30 Apr 2021 00:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F29613CE
	for <linux-input@archiver.kernel.org>; Fri, 30 Apr 2021 00:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhD3AUz (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 29 Apr 2021 20:20:55 -0400
Received: from vps.thesusis.net ([34.202.238.73]:37550 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhD3AUy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Apr 2021 20:20:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id 6E9B22ECD1;
        Thu, 29 Apr 2021 20:20:07 -0400 (EDT)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oj1xF6OGsgDn; Thu, 29 Apr 2021 20:20:07 -0400 (EDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 3B0DE2ECD0; Thu, 29 Apr 2021 20:20:07 -0400 (EDT)
References: <87o8dw52jc.fsf@vps.thesusis.net> <87fsz84zn1.fsf@vps.thesusis.net> <YIszOwADJ8jdBov8@google.com>
User-agent: mu4e 1.5.7; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-input@vger.kernel.org
Subject: Re: Xen Virtual Keyboard modalias breaking uevents
Date:   Thu, 29 Apr 2021 20:11:03 -0400
In-reply-to: <YIszOwADJ8jdBov8@google.com>
Message-ID: <87o8dw8vyg.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


Dmitry Torokhov writes:

> Not every keyboard, but all keycodes above KEY_MIN_INTERESTING which is
> KEY_MUTE, so that interested handlers could match on devices they are
> interested in without first opening them or poking through sysfs.

/Shouldn't/ they be reading sysfs attributes to find that information
out though?  Isn't modalias there to help modprobe find the right module
that wants to bind to this device, which doesn't happen for input
devices?  If user space is looking at this information then isn't it
getting it by reading from sysfs anyway?

What in user space looks at input devices other than X and Wayland?  And
those aren't looking for particular "interesting" keys are they?

> I don't know why Xen keyboard exports that many keycodes ;) In general,
> my recommendation is to mirror the physical device when possible, and
> instantiate several devices so there is 1:1 relationship between virtual
> and physical devices.

Xen guys: any input as to why it supports so many "interesting" keys?


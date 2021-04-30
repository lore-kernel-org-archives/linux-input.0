Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EEEC433B4
	for <linux-input@archiver.kernel.org>; Fri, 30 Apr 2021 00:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6C5613ED
	for <linux-input@archiver.kernel.org>; Fri, 30 Apr 2021 00:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhD3A7w (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 29 Apr 2021 20:59:52 -0400
Received: from vps.thesusis.net ([34.202.238.73]:37604 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhD3A7w (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Apr 2021 20:59:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id 849F72ECDB;
        Thu, 29 Apr 2021 20:59:04 -0400 (EDT)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PUoBqIdkD_Xa; Thu, 29 Apr 2021 20:59:04 -0400 (EDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 3F4522ECDA; Thu, 29 Apr 2021 20:59:04 -0400 (EDT)
References: <87o8dw52jc.fsf@vps.thesusis.net> <87fsz84zn1.fsf@vps.thesusis.net> <YIszOwADJ8jdBov8@google.com> <87o8dw8vyg.fsf@vps.thesusis.net> <YItQ72UkqyKuHEk4@google.com>
User-agent: mu4e 1.5.7; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-input@vger.kernel.org
Subject: Re: Xen Virtual Keyboard modalias breaking uevents
Date:   Thu, 29 Apr 2021 20:57:38 -0400
In-reply-to: <YItQ72UkqyKuHEk4@google.com>
Message-ID: <87im448u5j.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


Dmitry Torokhov writes:

> Userspace may or may not have access to sysfs (it does not have to be
> mounted)

How would userspace even enumerate the input devices and read their
modalias without sysfs?

Return-Path: <SRS0=nYcE=3Z=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53406C33CA1
	for <linux-input@archiver.kernel.org>; Wed,  5 Feb 2020 10:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302FD2051A
	for <linux-input@archiver.kernel.org>; Wed,  5 Feb 2020 10:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgBEKDa (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 5 Feb 2020 05:03:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:49576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbgBEKDa (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 5 Feb 2020 05:03:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20D77B001;
        Wed,  5 Feb 2020 10:03:28 +0000 (UTC)
Message-ID: <1580897005.9756.3.camel@suse.com>
Subject: Re: [PATCH v5] USB: HID: random timeout failures tackle try.
From:   Oliver Neukum <oneukum@suse.com>
To:     Lauri Jakku <lja@iki.fi>, benjamin.tissoires@redhat.com
Cc:     jikos@kernel.org, linux-input@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Date:   Wed, 05 Feb 2020 11:03:25 +0100
In-Reply-To: <20200204175238.3817-1-lja@iki.fi>
References: <20200204175238.3817-1-lja@iki.fi>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Am Dienstag, den 04.02.2020, 19:52 +0200 schrieb Lauri Jakku:
> -- v1 ------------------------------------------------------------
> send, 20ms apart, control messages, if error is timeout.
> 
> There is multiple reports of random behaviour of USB HID devices.
> 
> I have mouse that acts sometimes quite randomly, I debugged with
> logs others have published that there is HW timeouts that leave
> device in state that it is errorneus.
> 
> To fix this I introduced retry mechanism in root of USB HID drivers.
> 
> Fix does not slow down operations at all if there is no -ETIMEDOUT
> got from control message sending. If there is one, then sleep 20ms
> and try again. Retry count is 20 witch translates maximium of 400ms
> before giving up.
> 
> NOTE: This does not sleep anymore then before, if all is golden.

This is well if retries help. In case any other form of error handling,
such as a reset, are needed, these retries will hamper recovery.
It seems to me that you really should use a separate function
for this.

	Regards
		Oliver


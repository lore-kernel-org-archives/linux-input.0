Return-Path: <SRS0=x15/=ZS=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0ADC432C0
	for <linux-input@archiver.kernel.org>; Tue, 26 Nov 2019 07:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DEA20748
	for <linux-input@archiver.kernel.org>; Tue, 26 Nov 2019 07:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574754519;
	bh=O++3T8/sx6V7GdtA0Mt4QIhtOHZoPhBeRMtFfrbA8po=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=hp/we1+UuP+YPDeFmos+yLHyJOP3HqZOVSRX+WQhLW6KnieoDajY1QXcdDldgYQCr
	 p79smsaev0BCDDqAD+j8Ko8qIPa/FBLedRccM8bY2QK0L7DzJPjhLQaizRjSs0YVt6
	 AKQEfkfPK9F0rk6MpYlnufzlj7ZIwCBzaB9F1nC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfKZHsi (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 26 Nov 2019 02:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfKZHsi (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Nov 2019 02:48:38 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BC4C20727;
        Tue, 26 Nov 2019 07:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574754517;
        bh=O++3T8/sx6V7GdtA0Mt4QIhtOHZoPhBeRMtFfrbA8po=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nLJfMRYQIt3/QHhYsJoaGJDjKAQM3riYgs40eVQOJgthbPLIoBbGhwbUWhVVzQR08
         a34y7Qdn+hIGX3rvZVj6mYFfD6AKANF73rqmP9XRT82E+vQ3JOYKWOpvvCn5CU4iar
         8YVK+VdOUfhrCC35nctPAJjqMJWQIQYYHDJohSpo=
Date:   Tue, 26 Nov 2019 08:48:33 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
cc:     syzbot <syzbot+ec5f884c4a135aa0dbb9@syzkaller.appspotmail.com>,
        andreyknvl@google.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: INFO: rcu detected stall in hub_event
In-Reply-To: <Pine.LNX.4.44L0.1911251622420.1565-100000@iolanthe.rowland.org>
Message-ID: <nycvar.YFH.7.76.1911260848090.1799@cbobk.fhfr.pm>
References: <Pine.LNX.4.44L0.1911251622420.1565-100000@iolanthe.rowland.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 25 Nov 2019, Alan Stern wrote:

> #syz test: https://github.com/google/kasan.git 46178223

Alan, did you get a test result from syzbot on this patch? My mailbox 
doesn't seem to have it.

Thanks,

-- 
Jiri Kosina
SUSE Labs


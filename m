Return-Path: <SRS0=4q52=6N=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24292C83000
	for <linux-input@archiver.kernel.org>; Wed, 29 Apr 2020 19:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33A521D79
	for <linux-input@archiver.kernel.org>; Wed, 29 Apr 2020 19:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588189713;
	bh=KvYlEUXkK+PUsHr1w5AnUqjWqIRHSUm9pdRu2b3JXSc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=a3j14yf9p5M0v9qukmw9odLOk7e4XmC9VwNSDohbrVyJm8aHNkyYhy0+VJZ7ytbvV
	 Zk2rxg8NjrwZAsOtFi3SXotYndp8cwxHS7dsMxeSIBJom6sWWNiMXxzDj5TggN5ilK
	 h+B6lK2rYI0Jr2FwfT0ESQtNBUj6OJgRhiquorwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgD2Tsc (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgD2Tsc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Apr 2020 15:48:32 -0400
Received: from pobox.suse.cz (unknown [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2069B206D6;
        Wed, 29 Apr 2020 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588189407;
        bh=KvYlEUXkK+PUsHr1w5AnUqjWqIRHSUm9pdRu2b3JXSc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gNXMVZOKu20UOyMRlvh/WAl35MxB6IHcwHyLpY9sOlbaPdG7QyjXx25x3lore8L1T
         5IwtTrRnVigu8MtSyDo2VwbabEkw4VBjfgokpOgvtJutM/puHjcBESu65EVXJsqOP1
         OuPAvXfqOiGD29uI+ozGV92OkyPrRrIUrCcY27A8=
Date:   Wed, 29 Apr 2020 21:43:24 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jason Gerecke <killertofu@gmail.com>
cc:     linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Jason Gerecke <jason.gerecke@wacom.com>, stable@vger.kernel.org
Subject: Re: [PATCH] HID: wacom: Report 2nd-gen Intuos Pro S center button
 status over BT
In-Reply-To: <20200424210400.220712-1-jason.gerecke@wacom.com>
Message-ID: <nycvar.YFH.7.76.2004292142500.19713@cbobk.fhfr.pm>
References: <20200424210400.220712-1-jason.gerecke@wacom.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 24 Apr 2020, Jason Gerecke wrote:

> The state of the center button was not reported to userspace for the
> 2nd-gen Intuos Pro S when used over Bluetooth due to the pad handling
> code not being updated to support its reduced number of buttons. This
> patch uses the actual number of buttons present on the tablet to
> assemble a button state bitmap.
> 
> Link: https://github.com/linuxwacom/xf86-input-wacom/issues/112
> Fixes: cd47de45b855 ("HID: wacom: Add 2nd gen Intuos Pro Small support")
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Cc: stable@vger.kernel.org # v5.3+

Applied, thanks Jason.

-- 
Jiri Kosina
SUSE Labs


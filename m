Return-Path: <SRS0=Yr/4=44=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E366C10F27
	for <linux-input@archiver.kernel.org>; Wed, 11 Mar 2020 11:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518C321D56
	for <linux-input@archiver.kernel.org>; Wed, 11 Mar 2020 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583924450;
	bh=MUYZ7/lqrcry2vw0YbC0ytS06So9vPrZnBUmtcQGdcE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Hr+3QkNqOjjaM1rLAzW1iMUO0DHBwbLthxVoQHp5OF8K32jBqhIlBMbkXXCWrTVoC
	 pcQWuF//LtA3qDKUSn5iqi3t1ycw8MPmoRDDwF9w3O7SzdoDfNF47/5GSNoi3aW9CM
	 +Toh2SXM5BEuDLztgkiwTdX0CYV7fgc06+tuUzgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgCKLAu (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728973AbgCKLAt (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Mar 2020 07:00:49 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C42821655;
        Wed, 11 Mar 2020 11:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583924449;
        bh=MUYZ7/lqrcry2vw0YbC0ytS06So9vPrZnBUmtcQGdcE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ch+G2Nu0ekYSPLi39I57RW4bSANtPJJF3T+gxKNwG6H7jCvZvgiCOKHtzJi6aRo/C
         oLi7VhrrAUlI6YfSthR3GMH6vdd3riy/PWxfzdlwDFcV6zgUicJeJQDRNoRhCW5Dmh
         WdEnNkfARGNfsNbUfxy1O8xTugnwvLm2kdtAEkhA=
Date:   Wed, 11 Mar 2020 12:00:46 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
cc:     Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] HID: hid-sensor-custom: Use scnprintf() for avoiding
 potential buffer overflow
In-Reply-To: <20200311073824.7431-1-tiwai@suse.de>
Message-ID: <nycvar.YFH.7.76.2003111200300.19500@cbobk.fhfr.pm>
References: <20200311073824.7431-1-tiwai@suse.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 11 Mar 2020, Takashi Iwai wrote:

> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().

Queued this one in for-5.6/upstream-fixes as well. Thank you Takashi,

-- 
Jiri Kosina
SUSE Labs


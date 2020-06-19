Return-Path: <SRS0=fuUz=AA=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FA1C433E0
	for <linux-input@archiver.kernel.org>; Fri, 19 Jun 2020 12:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145C8207E8
	for <linux-input@archiver.kernel.org>; Fri, 19 Jun 2020 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592569119;
	bh=LI9u7kc/25TtJ3itbsp5DGPssVdV+Pj0IPfgNcIbq1I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=LrBnz21vLxXmywIXldYLkTRPZFsnlr4ICce/cZIdrKnCEsNK3+N+60BP2uKvEZmyB
	 FpuWysx2WAnlm8Si09M19BU/3bdVgkgIS+4rB+AWZ9mNN0JruMKTsOmQl2finmlttF
	 qUbxFfs+slEjpIIiYvs5d+q1jXhsKZbYH2Roo4Yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgFSMSh (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732896AbgFSMS0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jun 2020 08:18:26 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E5B207E8;
        Fri, 19 Jun 2020 12:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592569105;
        bh=LI9u7kc/25TtJ3itbsp5DGPssVdV+Pj0IPfgNcIbq1I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Vcjc+trrKQ+sj/HP+Qt1x2GI6MTxbMq/qHqsKG0Clytcd9FJN5RKpnxO0Mfiy9MT0
         MDlYWkeQHLmNNR/ujm84ablAACZT0wRweJ7yLEoufTKsD/K8avbQ+V0fXacy1grou/
         WN+i98+Psn0y8fAPwzw16Ukk0LjXtdaPrvnkQxwI=
Date:   Fri, 19 Jun 2020 14:18:23 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Daniel Morse <dmorse@speedfox.co.uk>
cc:     David Herrmann <dh.herrmann@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Subject: Re: [PATCH v3] HID: Wiimote: Treat the d-pad as an analogue stick
In-Reply-To: <CANFaMLGkbpO515c5MMKmH4MXcCKK-88qbVitQX3tizwF+iq3_g@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2006191416120.13242@cbobk.fhfr.pm>
References: <CANFaMLHQwNf3GnPYAxR-ryrYmO-wVmsEHijzVHEYozUt0EzDJw@mail.gmail.com> <nycvar.YFH.7.76.2006190924380.13242@cbobk.fhfr.pm> <CANq1E4RK_QymZwTB_PORc20K9QaJ=Tonuj7_RJQUj-xvqdjH8g@mail.gmail.com> <nycvar.YFH.7.76.2006191340260.13242@cbobk.fhfr.pm>
 <CANFaMLGkbpO515c5MMKmH4MXcCKK-88qbVitQX3tizwF+iq3_g@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 19 Jun 2020, Daniel Morse wrote:

> Does that apply to the version I attached as well as the version in
> the body of the email? There isn't much I can do about the version in
> the body of the email as I'm on gmail.

That one is ok when it comes to patch damage, but doesn't have proper 
metadata (changelog, author, etc).

I've fixed that up manually (and applied the patch), but if you could fix 
this for any further submissions, I'd appreciate it :)

Thanks,

-- 
Jiri Kosina
SUSE Labs


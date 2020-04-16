Return-Path: <SRS0=d6Rb=6A=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CC1C3815B
	for <linux-input@archiver.kernel.org>; Thu, 16 Apr 2020 19:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66652222D
	for <linux-input@archiver.kernel.org>; Thu, 16 Apr 2020 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587065981;
	bh=oeXqg4Uz21hvCN3wmWUjN4JFnUaz5tc5mND5b0ompJM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=uc6CE3G54XIXFugfsNg/2JJTvXCqa1VJXLaEqoCre1w4QIUSTvDJWoXJ0mgfW7kZC
	 BQBHwMbbr/fypRLz1SmsKoEUYyNYzhpuXDMVM2ZdVGz1vwsrCm0P/Yu32qHovloiX1
	 d4e1ygqCdeAsjKIODQQPsZkFAhaf9lK6fm4D5v1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgDPTjl (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 16 Apr 2020 15:39:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgDPTjk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Apr 2020 15:39:40 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F5D21BE5;
        Thu, 16 Apr 2020 19:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587065980;
        bh=oeXqg4Uz21hvCN3wmWUjN4JFnUaz5tc5mND5b0ompJM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=CxlT/4Fn46PPatB8z8hTpOtDy7cQcTexnJv+UorsodgfIxS9UXdtflhNS1m9+Tz8l
         DQc4FIJ8QuOp64967cZupb1uiz00B+5SDBADM0Igj5EH+wr75FgkFlXEqouPsyWHBQ
         5Pw4T952yEORSM2KeJHh73hyODhtzRIwrgcUmxc8=
Date:   Thu, 16 Apr 2020 21:39:36 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Gerecke, Jason" <killertofu@gmail.com>
cc:     linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Aaron Armstrong Skomra <aaron.skomra@wacom.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] Revert "HID: wacom: generic: read the number of expected
 touches on a per collection basis"
In-Reply-To: <20200408145837.21961-1-jason.gerecke@wacom.com>
Message-ID: <nycvar.YFH.7.76.2004162139190.19713@cbobk.fhfr.pm>
References: <20200408145837.21961-1-jason.gerecke@wacom.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 8 Apr 2020, Gerecke, Jason wrote:

> From: Jason Gerecke <killertofu@gmail.com>
> 
> This reverts commit 15893fa40109f5e7c67eeb8da62267d0fdf0be9d.

Pushed to hid.git#for-5.7/upstream-fixes, sorry for the delay.

-- 
Jiri Kosina
SUSE Labs


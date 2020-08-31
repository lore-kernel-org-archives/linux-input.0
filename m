Return-Path: <SRS0=K583=CJ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3870C433E2
	for <linux-input@archiver.kernel.org>; Mon, 31 Aug 2020 06:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC23B208A9
	for <linux-input@archiver.kernel.org>; Mon, 31 Aug 2020 06:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598857049;
	bh=/i+fglmFPn7He2c9igYRYCXSnXzevtrKVSPdJ+g0vG8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Jq6xZ3uuhhrnztcCyUicwcmoGgbtCgyxJ/XYydtR0jygJXQkhUeO+gSocI7yxbk35
	 UECxxjOy8M+W1r4U3qvcFi1maGk7xXjJsn6PgmvyuO53TxtGa2iwRm1YOjlsStD4sc
	 L+sfaMXxfTeWZQHloU2n8EgaNmXe3aGxSm5jcYew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHaG53 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgHaG52 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Aug 2020 02:57:28 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E972072D;
        Mon, 31 Aug 2020 06:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598857047;
        bh=/i+fglmFPn7He2c9igYRYCXSnXzevtrKVSPdJ+g0vG8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=axOXCNCeW+Rn3kLPw8YeD35//jlHHtOzcW/4X99BUOdC698O2OlbrPSG18OFFNk2z
         1QGcbQEh6g0IXgjGmuL4PsUJ+24yB+2nXD30yRF2MeALKfSXmWsMPhjKU+cOp3+q0b
         Nmk4dEKDivQpNlX6x3Pc+HcG4oJ/wFgUp/T1EKaA=
Date:   Mon, 31 Aug 2020 08:57:24 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Nirenjan Krishnan <nirenjan@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: Set INCREMENT_USAGE_ON_DUPLICATE for all
 Saitek X52 devices
In-Reply-To: <20200831004859.493827-2-nirenjan@gmail.com>
Message-ID: <nycvar.YFH.7.76.2008310857160.27422@cbobk.fhfr.pm>
References: <20200831004859.493827-1-nirenjan@gmail.com> <20200831004859.493827-2-nirenjan@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, 30 Aug 2020, Nirenjan Krishnan wrote:

> The Saitek X52 family of joysticks has a pair of axes that were
> originally (by the Windows driver) used as mouse pointer controls. The
> corresponding usage page is the Game Controls page, which is not
> recognized by the generic HID driver, and therefore, both axes get
> mapped to ABS_MISC. The quirk makes the second axis get mapped to
> ABS_MISC+1, and therefore made available separately.
> 
> One Saitek X52 device is already fixed. This patch fixes the other two
> known devices with VID/PID 06a3:0255 and 06a3:0762.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


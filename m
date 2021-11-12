Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B68CC433EF
	for <linux-input@archiver.kernel.org>; Fri, 12 Nov 2021 10:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47DC860C4A
	for <linux-input@archiver.kernel.org>; Fri, 12 Nov 2021 10:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhKLKbl (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 12 Nov 2021 05:31:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234904AbhKLKbl (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 12 Nov 2021 05:31:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22E5060E53;
        Fri, 12 Nov 2021 10:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636712931;
        bh=edGlg7jEYaoqRxaXHjm95SDvkvY2On/I0eEe3IUKDjg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=QGdJZFzYqBGFaRtfurhmVPPbNUH6xtbol9hessPRnW8fd54g4f5C/Q7YbRJB6t51Y
         FhIoNRfQWxvqxVDz4WawMslju/eMWnUO8tQ1oE9zwaYjQ+THey1ANEWpD1ADTyDEej
         Tlxlo25i5/vLbyKkCNnSicQONfUABc6ZRHf/TYwI1mkviArOj9N/5C3Wic8bBu/ud0
         KOlFqEP0qCxwtjzfuPd1wwu8UaNOImQL/plHVCl0blQiSXoTiM0rBX7bR236DBoin+
         2ri0ZjIGm0oemRPa2M1qn/UaHJ46VlXb+s/ChhsY2xNQR0a0NYk3/SA2Eln1S6s054
         1vmHrCkAfMvHw==
Date:   Fri, 12 Nov 2021 11:28:48 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Vin=EDcius_Angiolucci_Reis?= <angiolucci@gmail.com>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com
Subject: Re: [PATCH] Revert "HID: hid-asus.c: Maps key 0x35 (display off) to
 KEY_SCREENLOCK"
In-Reply-To: <20211111224735.29665-1-angiolucci@gmail.com>
Message-ID: <nycvar.YFH.7.76.2111121128370.12554@cbobk.fhfr.pm>
References: <20211111224735.29665-1-angiolucci@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 11 Nov 2021, Vinícius Angiolucci Reis wrote:

> This reverts commit 2ea5999d07d2a0ab6ad92ccf65524707f2c5e456.
> 
> As Dmitry Torokhov pointed out, the previous code (KEY_DISPLAY_OFF) is
> actually correct. The real issue is that current desktop environments
> don't deal it properly. Mapping it to another event does not solve the
> issue.
> 
> So I'm reverting that change, keeping key 0x35 mapped to KEY_DISPLAY_OFF
> 
> Signed-off-by: Vinícius Angiolucci Reis <angiolucci@gmail.com>

Queued for 5.16-rc, thanks.

-- 
Jiri Kosina
SUSE Labs


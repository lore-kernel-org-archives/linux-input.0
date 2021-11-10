Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6245CC433EF
	for <linux-input@archiver.kernel.org>; Wed, 10 Nov 2021 12:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A50661264
	for <linux-input@archiver.kernel.org>; Wed, 10 Nov 2021 12:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhKJMXa (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:23:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231371AbhKJMXa (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 10 Nov 2021 07:23:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82C9361260;
        Wed, 10 Nov 2021 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636546842;
        bh=UrdBpADFfFHOSeO47GMEckEv90RwEREP5PvrOPjFpac=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Qgbdu3+cqWcg30ewY9pVTZ8NSE2CnR5qqlT8tzwXsjk5KNvsfE1TyQlaF6HSA6ZDh
         OLWoUYBW4jyStRFDUOcyjkHaSwS0aCJFFK0tp9Z+jNTLOQSrXyBhOYOQ+rGk8TCZMR
         BTAfXTHJ+DcX/Ztn7pJ9YxkKVCM6bpHgVNTjZk+x1UcYd6TE22aNpm8b409iICZ0Ix
         /cK0MTR2SwCEtG4cdV8KekSkRcx+5XE8RgSJjsmemcy9S7zWl4Vn6BEsCpHKECXy5y
         FPQIi/JBPGX1ZtzQFRoDLpVHWjjVPwQRwEg00bJo8JGno/QWKqwR8Oy7yg9ylcmwDW
         ab79SuEAyijzA==
Date:   Wed, 10 Nov 2021 13:20:39 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
cc:     linux-input@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] mod_devicetable: fix kdocs for ishtp_device_id
In-Reply-To: <20211110121655.675664-1-linux@weissschuh.net>
Message-ID: <nycvar.YFH.7.76.2111101320170.12554@cbobk.fhfr.pm>
References: <20211110150639.7db57ae2@canb.auug.org.au> <20211110121655.675664-1-linux@weissschuh.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 10 Nov 2021, Thomas Weißschuh wrote:

> The kdocs were copied from another device_id struct and not adapted.
> 
> Fixes: fa443bc3c1e4 ("HID: intel-ish-hid: add support for MODULE_DEVICE_TABLE()")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

I've added

	Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

and applied, thanks.

-- 
Jiri Kosina
SUSE Labs


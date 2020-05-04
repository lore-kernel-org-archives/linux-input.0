Return-Path: <SRS0=FPR3=6S=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01B7C3A5A9
	for <linux-input@archiver.kernel.org>; Mon,  4 May 2020 09:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B25220757
	for <linux-input@archiver.kernel.org>; Mon,  4 May 2020 09:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588584344;
	bh=PG1LiMmNjX0w4OUUE6ZoNfoz7Ed5StVx6gNe5iKBeLo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=KzbLx4ugbBfnTrcrCs93ChZws9xFL+JzqlOAJZnICuQq186cxUiq0PHcX5ho+F0js
	 s/hS7KP82bNBqi1f5wnXUWwLwNJWRB/Gx+cuIge9H+LyVxT/gMI7z2dlkHwmuOBHe3
	 DHfIMCUh2K5x76ZVTLGBc74xc9Lh6sT+u1HbbTxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgEDJZo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 4 May 2020 05:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbgEDJZn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 4 May 2020 05:25:43 -0400
Received: from pobox.suse.cz (unknown [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFD6D20735;
        Mon,  4 May 2020 09:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588584343;
        bh=PG1LiMmNjX0w4OUUE6ZoNfoz7Ed5StVx6gNe5iKBeLo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=JRXXIUZ88V0UM8EMS7hsCfgG/xmhW57BsJjQi2vctM8cjl6PeeN/X+weZFsQiKQIu
         al3q9mKzspDwzYuOO0pNLekW0bD0jDWzarUsb9xYDEk0twEqG3GN55EqS8a/qtDNbj
         ZG7pc27Q0z2USLLiBFsatUijHnXbFB6DFM/+Gz5Q=
Date:   Mon, 4 May 2020 11:25:40 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: [PATCH] HID: quirks: Add HID_QUIRK_NO_INIT_REPORTS quirk for
 Dell K12A keyboard-dock
In-Reply-To: <20200502181842.113831-1-hdegoede@redhat.com>
Message-ID: <nycvar.YFH.7.76.2005041125300.19713@cbobk.fhfr.pm>
References: <20200502181842.113831-1-hdegoede@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, 2 May 2020, Hans de Goede wrote:

> Add a HID_QUIRK_NO_INIT_REPORTS quirk for the Dell K12A keyboard-dock,
> which can be used with various Dell Venue 11 models.
> 
> Without this quirk the keyboard/touchpad combo works fine when connected
> at boot, but when hotplugged 9 out of 10 times it will not work properly.
> Adding the quirk fixes this.
> 
> Cc: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


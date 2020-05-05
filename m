Return-Path: <SRS0=vRrv=6T=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65213C47254
	for <linux-input@archiver.kernel.org>; Tue,  5 May 2020 15:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4179621841
	for <linux-input@archiver.kernel.org>; Tue,  5 May 2020 15:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588691763;
	bh=hNsGZR3Bkm7w/yrDlOV47G33od9URXWYyfDUInUwyiY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=O2oUxI4eOjHwsGUQsNRB13YXiTcVPT252rDEbBqfVE9rlm+QnzOi+J6cR2utyXsHm
	 aqmSBQzJ74QRPyG+DYxvjk8B8+xLXRthSuX1BkZ/DUGpDArmtX2tyoT0W78YOKDztS
	 l/Gq8tLx6kYR5DZWxG/CRrBGgtPLa7X8Rg/FucnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgEEPQC (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 5 May 2020 11:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729335AbgEEPQC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 5 May 2020 11:16:02 -0400
Received: from pobox.suse.cz (unknown [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA65A206A5;
        Tue,  5 May 2020 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588691762;
        bh=hNsGZR3Bkm7w/yrDlOV47G33od9URXWYyfDUInUwyiY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Y4rLc9F7Po5YbLHFiPKtcMaSZ5W6lRaQDqRdybA2qvQ/7EV7753kjKoam0JqwxW1c
         8GofSkHYu5zxIu7S5dL/KZCyFHgwLr2071rqZ9L60mwIMdb6XPF526u9eGp4a1ELui
         ZqynbJwsl0BZ+3xsPKZ0YI2XHJfuxAdCOxatp/fU=
Date:   Tue, 5 May 2020 17:15:58 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Julian Sax <jsbc@gmx.de>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: add Schneider SCL142ALM to descriptor
 override
In-Reply-To: <20200505151042.122157-1-jsbc@gmx.de>
Message-ID: <nycvar.YFH.7.76.2005051715490.25812@cbobk.fhfr.pm>
References: <20200505151042.122157-1-jsbc@gmx.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 5 May 2020, Julian Sax wrote:

> This device uses the SIPODEV SP1064 touchpad, which does not
> supply descriptors, so it has to be added to the override list.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


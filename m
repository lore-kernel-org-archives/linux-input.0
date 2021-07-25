Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1A4C4338F
	for <linux-input@archiver.kernel.org>; Sun, 25 Jul 2021 06:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71CF60F36
	for <linux-input@archiver.kernel.org>; Sun, 25 Jul 2021 06:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhGYFxG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 25 Jul 2021 01:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230254AbhGYFxF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 25 Jul 2021 01:53:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EF4360F26;
        Sun, 25 Jul 2021 06:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627194815;
        bh=U/hYEE1OVprwCnEk8+RALl3+djTf3jgW7aTzSufxkcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n59b6KXd/8T2HS5q/PtyZJ3H0ID12sPEg5qD5NXRi/LwaWLuSe5CPY3daC6E26ToN
         tfvBrBH9CYb0usweebgma2T5lTS1LPkLcPVd2PON+6bCTILAtxpqZhWsaOYyKw82p3
         3XUHEM/OKqT6GhiS42609Ad07gAsucqBjM7rtBWI=
Date:   Sun, 25 Jul 2021 08:33:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid-elo: update the reference count of the usb device
 structure
Message-ID: <YP0Fuz4iNOqrYvgi@kroah.com>
References: <20210724202434.GA528986@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724202434.GA528986@pc>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, Jul 24, 2021 at 09:24:34PM +0100, Salah Triki wrote:
> Use usb_get_dev() and usb_put_dev() in order to update the reference
> count of the usb device structure.

Why?

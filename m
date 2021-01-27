Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FE8C433DB
	for <linux-input@archiver.kernel.org>; Wed, 27 Jan 2021 13:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BC72074D
	for <linux-input@archiver.kernel.org>; Wed, 27 Jan 2021 13:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhA0NvI (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 27 Jan 2021 08:51:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231207AbhA0NuH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 27 Jan 2021 08:50:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1D192074D;
        Wed, 27 Jan 2021 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611755364;
        bh=4uJ/v/kBjFZkiPYhQ+KPTVoWjAfpfgl/dGwCKUecysQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uaW9rMa9+pb5vjWc3CUKopPJq9oz70Gpni6yQpk5iUhOyYBaaKKXl7g5GL7Fe8kfO
         a4iLbc2glLkg5mqbiOcDgxi8sd2io2BQepl3fWZGdH8U63jekg1bsbOJqZPawX13/Y
         HdGHToNr4iatFQdOVCzCj3o3xUzFePuktpO4jNhQ=
Date:   Wed, 27 Jan 2021 14:49:21 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] add IRQF_NO_AUTOEN for request_irq
Message-ID: <YBFvYStmGeChUJlO@kroah.com>
References: <20210107223926.35284-1-song.bao.hua@hisilicon.com>
 <848fb07c3073401bbbe15db71f5922c9@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <848fb07c3073401bbbe15db71f5922c9@hisilicon.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Jan 21, 2021 at 09:38:28PM +0000, Song Bao Hua (Barry Song) wrote:
> Hi Thomas, Greg, Dmitry, Marc,
> Any further comment on this new API? 

It's not my subsystem, I'll let the irq maintainers handle it :)

thanks,

greg k-h

Return-Path: <SRS0=OZNg=6Z=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6AFC54E8D
	for <linux-input@archiver.kernel.org>; Mon, 11 May 2020 16:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E730F20769
	for <linux-input@archiver.kernel.org>; Mon, 11 May 2020 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589214586;
	bh=zRDkDfVfjnpNgmAvhKkgOw02zl7haTcp+VFVx/goDc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l8wB7R71LBAMU6HDP6fnpGiGhyNCNJz8m3EB6GzULzkdA/9DPcwxtxJxBo+nrGCiA
	 QmMbja+CpTD7eBD6NIXcwHAAZc97M7LFCTL2oyAuqZsILdWbYYsSGFpjqp5iFn9GVS
	 ut3mRT8PuotLC3VjNYMrJEbcD/gnY/w24QAChZHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgEKQ3p (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 11 May 2020 12:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbgEKQ3p (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 May 2020 12:29:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 465072070B;
        Mon, 11 May 2020 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589214584;
        bh=zRDkDfVfjnpNgmAvhKkgOw02zl7haTcp+VFVx/goDc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OICiURn93tXudidSvHjuXM4EZj2p+Hj1iInoHjEncr+1S0dZHAW2duMYG1fMFWgtm
         pyOKCO9ev9nqK7Fs++5WnsynW0eVfbLzVUb/mwc4lpEztPXxe74AoyeZoxgH/x3Dan
         CO6QalrKzn039HMXmnNBhuRaNsRmvR79AWbyJJw0=
Date:   Mon, 11 May 2020 18:21:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        kernel@collabora.com
Subject: Re: [PATCH 6/6] tty/sysrq: Add configurable handler to execute a
 compound action
Message-ID: <20200511162113.GC2221063@kroah.com>
References: <20200511135918.8203-1-andrzej.p@collabora.com>
 <20200511135918.8203-7-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511135918.8203-7-andrzej.p@collabora.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, May 11, 2020 at 03:59:18PM +0200, Andrzej Pietrasiewicz wrote:
> Some userland might want to execute e.g. 'w' (show blocked tasks), followed
> by 's' (sync), followed by 1000 ms delay and then followed by 'c' (crash)
> upon a single magic SysRq. Or one might want to execute the famous "Raising
> Elephants Is So Utterly Boring" action. This patch adds a configurable
> handler, triggered with 'C', for this exact purpose. The user specifies the
> composition of the compound action using syntax similar to getopt, where
> each letter corresponds to an individual action and a colon followed by a
> number corresponds to a delay of that many milliseconds, e.g.:
> 
> ws:1000c
> 
> or
> 
> r:100eis:1000ub

Cute, but why?  Who needs/wants this type of thing?

And again, no documentation :(

greg k-h

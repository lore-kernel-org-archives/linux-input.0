Return-Path: <SRS0=OZNg=6Z=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D32C54E8E
	for <linux-input@archiver.kernel.org>; Mon, 11 May 2020 16:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 457F52070B
	for <linux-input@archiver.kernel.org>; Mon, 11 May 2020 16:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589214583;
	bh=n0T8CPx7nqEYjHPik6TeHQbKTFQFAYFcFOayQjf9Xf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YHVJ1l+906QJq4Sd9JgjEmh8HDRUq3GIgxMmAtsB0V8a0em/CacIIL0k3/RMfkuT6
	 tQjwVPf54A2B3fxkhX14hYCqjvVUAOF262QPhVcjtXbaXAw3bHvfK36GMkuuK5Pfoo
	 kjeBHMHpqIrhca2Yx+D9u3z39drIjNFf53k1+1BQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgEKQ3m (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 11 May 2020 12:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbgEKQ3m (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 May 2020 12:29:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC57C206D7;
        Mon, 11 May 2020 16:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589214582;
        bh=n0T8CPx7nqEYjHPik6TeHQbKTFQFAYFcFOayQjf9Xf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1iuz8NWX+oX7wZRn4+AGLJxrhVXEBjhCQJlZ7HNsgp/eEGUkm582Ty5ESsqEsDRO
         Na7eHYXDF4xwf4FRWeULbtggxY15/OGgKJbpOIA22Mfvpv1TQDUy1FoDKoFs+9Bx2p
         xyhsXkg4wOF5q1vkJtaIQmpDXq5px0FyJ02W81MY=
Date:   Mon, 11 May 2020 18:20:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        kernel@collabora.com
Subject: Re: [PATCH 5/6] tty/sysrq: Add configurable handler to signal a
 process
Message-ID: <20200511162017.GB2221063@kroah.com>
References: <20200511135918.8203-1-andrzej.p@collabora.com>
 <20200511135918.8203-6-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511135918.8203-6-andrzej.p@collabora.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, May 11, 2020 at 03:59:17PM +0200, Andrzej Pietrasiewicz wrote:
> Some userland might want to implement a policy to signal a configured
> process with a configured signal. This patch adds necessary kernel-side
> infrastructure and the newly added handler is triggered with
> Alt-Shift-SysRq-s. Optionally the userland can also specify the expected
> name of parent process of the victim.

THat's crazy, what "userspace" wants to do something like this that
can't just do it by running a program?  Why force the kernel to do it
for them?

And you don't document any of this :(

greg k-h

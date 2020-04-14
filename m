Return-Path: <SRS0=0BCR=56=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E056BC2BA19
	for <linux-input@archiver.kernel.org>; Tue, 14 Apr 2020 09:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97872076A
	for <linux-input@archiver.kernel.org>; Tue, 14 Apr 2020 09:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586855879;
	bh=YsmZBVpIc4B7O5IpTFE3k08A2Cn0DMN/SxP6LAJOrz0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=aPVxgXD+FPxSVLTEg8GdgD6O5WXnAE6O9IKugaz1ENnTOnVbih8Ls7dxtAWq3z8tw
	 nfuW/JNglamMTJXuIEzDt/hMZY9pNEc5dpjwBOP5vkRPdolwCz6c/74I2dNdxOmTdZ
	 taPEOSr+9IxefItLipa7e698yiyod/bpQjoyEhXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437536AbgDNJR7 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437500AbgDNJR6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Apr 2020 05:17:58 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9E60206E9;
        Tue, 14 Apr 2020 09:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586855878;
        bh=YsmZBVpIc4B7O5IpTFE3k08A2Cn0DMN/SxP6LAJOrz0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=zhjWBA/bYOAKUD++YGVxKmVQNVKl5PU7gxqQRliak99zBmB//vBjJ3LTJqVbB4YST
         JJZjps+r9TLTbtBaHp7trjLYDCiAO/nyF7YHTA2QBgRSV4muMFnspwU1kLIzOTNqJe
         UULnQMY+If62dA+EcdR4CikdmlLyT0HyGqsyhxRI=
Date:   Tue, 14 Apr 2020 11:17:54 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] HID: fix typo in Kconfig
In-Reply-To: <20200412090743.8236-1-christophe.jaillet@wanadoo.fr>
Message-ID: <nycvar.YFH.7.76.2004141117450.19713@cbobk.fhfr.pm>
References: <20200412090743.8236-1-christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


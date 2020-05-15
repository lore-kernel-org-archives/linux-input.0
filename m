Return-Path: <SRS0=rXP/=65=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDABC433E0
	for <linux-input@archiver.kernel.org>; Fri, 15 May 2020 20:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3515F2073E
	for <linux-input@archiver.kernel.org>; Fri, 15 May 2020 20:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589572858;
	bh=e4X2hu0tzluzxhD81apSEnQovQ+dE4ivGX8ynORov9I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=iEI0YfQgtsUcZXEgKUHysXXmq6lrubsCqOaLXwjX5XycqkR2L2LBt8GKw1o89+1VG
	 q4WHh3VX1ir5wp4Bgc8IT5IeFZ7sLAJp+Cbjz3GH2ANjnhnrPglQhttldLCNuSYhtc
	 kVMktCM9flOTcnbDeQpWa6mgCOZ8oJbbmH/Kww1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgEOUA5 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 15 May 2020 16:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgEOUA5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 15 May 2020 16:00:57 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CE6E20727;
        Fri, 15 May 2020 20:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589572857;
        bh=e4X2hu0tzluzxhD81apSEnQovQ+dE4ivGX8ynORov9I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Jq+niRT/7kQus5tGZH6FCj7pK3bWwGobMApHw0ikmNw2P/A79TwK3w6jMJVLlj4JR
         a9Mj6QpvIISKrtG59UjN2tmv3PGymHARN2Wko3D1/NEv7FjiMjp3/tYnt4JBsxzNsa
         B/Lnzkh5BvyhyIW3nSRtcxI6/jDBNmnWQueYrRIk=
Date:   Fri, 15 May 2020 22:00:54 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Cristian Klein <cristian.klein@elastisys.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: Re: [PATCH] Add quirks for Trust Panora Graphic Tablet
In-Reply-To: <20200508152604.21143-1-cristian.klein@elastisys.com>
Message-ID: <nycvar.YFH.7.76.2005152200440.25812@cbobk.fhfr.pm>
References: <20200508152604.21143-1-cristian.klein@elastisys.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 8 May 2020, Cristian Klein wrote:

> The Trust Panora Graphic Tablet has two interfaces. Interface zero
> reports pen movement, pen pressure and pen buttons. Interface one
> reports tablet buttons and tablet scroll. Both use the mouse protocol.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


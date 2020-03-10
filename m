Return-Path: <SRS0=z83X=43=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7168C10F27
	for <linux-input@archiver.kernel.org>; Tue, 10 Mar 2020 13:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D55424649
	for <linux-input@archiver.kernel.org>; Tue, 10 Mar 2020 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846544;
	bh=FaMTD2na3NDedgKSwXsZVOGx7i/nxquek6psyjDM3Lo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=1nxXbyS//4ijTMB3/UP2v4YpQo7EP8jkWQhEjYCMbQbrsnscv94o6JfY+Lke9KgpS
	 aXxgimoXq4XUvRYHsg6uDah6tc1Z5xXGt5yZO1ckbCGDS5WheET6ybUtv71rbVMvih
	 74Zmui18ChdsE1/ixPDUqo06cKGTASBqpitOjvYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgCJNWU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730239AbgCJNWT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 10 Mar 2020 09:22:19 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E39208E4;
        Tue, 10 Mar 2020 13:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583846539;
        bh=FaMTD2na3NDedgKSwXsZVOGx7i/nxquek6psyjDM3Lo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nOHUzyv8eb4NIsmREF9QILrzXXWOx92nJ+aS2RDg1Dv7jNtzGLBsZOeyveMA7AQVV
         Cq8vn5QKZbw+kqb6EA5V7asq10eKRxLNL69aHKd+KpzRG/coxJDSXCz2f2nx0TCNRr
         L6a5/PaJXVH3SRWycAiQbGPnBxTmEZsULi5zIptM=
Date:   Tue, 10 Mar 2020 14:22:16 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@archlinux.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH] HID: logitech-dj: add support for the static device in
 the Powerplay mat/receiver
In-Reply-To: <5a93677bd6238a9d7928e4fd16a8915faeb5f19e.camel@archlinux.org>
Message-ID: <nycvar.YFH.7.76.2003101301280.19500@cbobk.fhfr.pm>
References: <20200115201811.3271284-1-lains@archlinux.org>  <nycvar.YFH.7.76.2002121449191.3144@cbobk.fhfr.pm> <5a93677bd6238a9d7928e4fd16a8915faeb5f19e.camel@archlinux.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 12 Feb 2020, Filipe Laíns wrote:

> > > +	/* custom receiver device (eg. powerplay) */
> > > +	if (hidpp_report->device_index == 7) {
> > > +		workitem.reports_supported |= HIDPP;
> > > +	}
> > > +
> > 
> > I guess we can't do anything else than to trust Logitech that they will 
> > not assign conflicting device_index ID in the future to something that 
> > will not be HID++, right?
> > 
> > Or is this properly documented somewhere?
> > 
> > Thanks,
> 
> 
> CCing Nestor
> 
> Yes, we need to trust Logitech on this. There's isn't anything
> documented regarding this AFAIK.
> 
> Even if Logitech released a device with index 7 that didn't support
> HID++, it wouldn't be that big of an issue. We would just end up with a
> hidraw node which would export a vendor page report descriptor but the
> device wouldn't actually reply to anything.

Given the silence from Nestor, I guess we can just apply this for 5.7; 
pushing to for-5.7/logitech branch.

Thanks,

-- 
Jiri Kosina
SUSE Labs


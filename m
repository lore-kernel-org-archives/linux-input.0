Return-Path: <SRS0=ejGl=DJ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BD0C4363D
	for <linux-input@archiver.kernel.org>; Fri,  2 Oct 2020 12:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7474820719
	for <linux-input@archiver.kernel.org>; Fri,  2 Oct 2020 12:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601643324;
	bh=5AJyIErWdlrgMYlEMAq+TO9asL7HgMDK0TTNyge8YO4=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=qbdqXei5ItsV72qymROdqSqgEsfrqbLY8++I6bCFLSg8bOx5fIEfCSkj9Fp2257/w
	 Jp96qVUdduCXi0bUOsTvgw+6y9VBP4ajtX0zzJZICfGHjWRoh6xMdDGyXXUc/keYLa
	 MmMYHM9CUiQ+YbnQxpSYGjXTAyvDhF0EosN2TI2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJBMzX (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 2 Oct 2020 08:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBMzX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 2 Oct 2020 08:55:23 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F529206DC;
        Fri,  2 Oct 2020 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601643323;
        bh=5AJyIErWdlrgMYlEMAq+TO9asL7HgMDK0TTNyge8YO4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=lcHFzgqDzd+7/14/hfQkWGSQBbQl3E2M5rJOmDJHooiwsfL8t+ChP9U7Rja4WJe2q
         G92kbsMn8vGdkX4wQeFsodsmI7mjHdlrHRf+RzgQH9DBwZWFeLtiXI5RIq7ZL05DGA
         arQTxLKktZLmuTIRj7YVI7GtaKGM0GZCK6qUCch0=
Date:   Fri, 2 Oct 2020 14:55:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Jiri Slaby <jslaby@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 0/2] Add configurable handler to execute a compound
 action
Message-ID: <20201002125522.GB3350322@kroah.com>
References: <20200818112825.6445-1-andrzej.p@collabora.com>
 <20201002123158.GA3346786@kroah.com>
 <95030036-87fe-8c61-6fc6-c60452d8ca96@collabora.com>
 <9bd7ff2e-ddf3-f950-54ad-c143e9c60daa@collabora.com>
 <20201002124529.GI438822@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002124529.GI438822@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, Oct 02, 2020 at 02:45:29PM +0200, Daniel Vetter wrote:
> On Fri, Oct 02, 2020 at 02:36:33PM +0200, Andrzej Pietrasiewicz wrote:
> > W dniu 02.10.2020 o 14:33, Andrzej Pietrasiewicz pisze:
> > > W dniu 02.10.2020 o 14:31, Greg Kroah-Hartman pisze:
> > > > On Tue, Aug 18, 2020 at 01:28:23PM +0200, Andrzej Pietrasiewicz wrote:
> > > > > This is a follow-up of this thread:
> > > > > 
> > > > > https://www.spinics.net/lists/linux-input/msg68446.html
> > > > 
> > > > lore.kernel.org is easier to pull stuff from :)
> > > > 
> > > > Anyway, what ever happened to this series?  Is there a newer one
> > > > somewhere?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > > 
> > > 
> > > https://lkml.org/lkml/2020/8/18/440
> > > 
> > > Andrzej
> > 
> > Sorry about confusion.
> > 
> > This is the same thing, so there is nothing newer.
> 
> Maybe split out the s/V/v/ in drm so I can pick that up? Alternatively
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch> if Greg takes it all.

I'll take the first patch now, the second one is a bit more odd...

thanks for the ack.

greg k-h

Return-Path: <SRS0=ejGl=DJ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DB9C4363D
	for <linux-input@archiver.kernel.org>; Fri,  2 Oct 2020 12:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E0B0206DB
	for <linux-input@archiver.kernel.org>; Fri,  2 Oct 2020 12:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601641927;
	bh=ZVTBTWpaXNDYJNbWfQNi1qKOGlwVmGs4Bzh19RKFm9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JbKMKVD4QNVKWBQKd55Ud8GzUUkm8ONlD0QWbz7DXCNX/Tz0DImwucxbaqKMEkI+Z
	 5pNyJwgOeGtLlcE/gSsdRBjHk3/y1JmNHLjJBtVcWklJkI8Iz4oa3biJmqIHgq9c9B
	 9mKAFFNWh0kxZLb3CgqolPdq8X487JuQ4LVk8rmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbgJBMcA (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 2 Oct 2020 08:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgJBMb7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 2 Oct 2020 08:31:59 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4201D206DB;
        Fri,  2 Oct 2020 12:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601641919;
        bh=ZVTBTWpaXNDYJNbWfQNi1qKOGlwVmGs4Bzh19RKFm9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EHt6IXDY6zcns+00sqHOrQbhw/SCas0gVD83+e5bpvfNQUn65EOLwngK2EIRyVYWX
         IV+LQHpyQXEuFE5C7+y0Z3knm/RnGpQA121kB2KK3WkYb50TZPhkKWRtVVe28AeoJL
         AViyszR0MIBpO1mJxK7HBXGOhPHhzT65fe3lyUXg=
Date:   Fri, 2 Oct 2020 14:31:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jiri Slaby <jslaby@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 0/2] Add configurable handler to execute a compound
 action
Message-ID: <20201002123158.GA3346786@kroah.com>
References: <20200818112825.6445-1-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818112825.6445-1-andrzej.p@collabora.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, Aug 18, 2020 at 01:28:23PM +0200, Andrzej Pietrasiewicz wrote:
> This is a follow-up of this thread:
> 
> https://www.spinics.net/lists/linux-input/msg68446.html

lore.kernel.org is easier to pull stuff from :)

Anyway, what ever happened to this series?  Is there a newer one
somewhere?

thanks,

greg k-h

Return-Path: <SRS0=VovD=Z6=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3C6C43603
	for <linux-input@archiver.kernel.org>; Sun,  8 Dec 2019 00:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7B224679
	for <linux-input@archiver.kernel.org>; Sun,  8 Dec 2019 00:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575763639;
	bh=M7YFDrfsP98aHjcTFmDSkdeQQZQR99Y+Wunr3u7VZBk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=t4GWguBdMsaS28LKXpWjOnsDA8CsGtYaDX/CsgK/pRWqAKVyLxKjF7z57V9aFI2j3
	 m+ZfVvWArbFiaAyTgkBCSEdGKi4JsWfnotzE0ynVCI9Q1EZnI2abj1njFW7nPRKrFi
	 Bdppru2ZUhvKxblvB7Wcwr7uP/+K8/ZjJTUKLisc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfLHAHT (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 7 Dec 2019 19:07:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfLHAHT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 7 Dec 2019 19:07:19 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 333682176D;
        Sun,  8 Dec 2019 00:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575763638;
        bh=M7YFDrfsP98aHjcTFmDSkdeQQZQR99Y+Wunr3u7VZBk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=1TY4b7uPfggkxhFT+TY3ACqYiMTBwLT2da6upkhSP9ffdWP65lHcYCNWxCaVLoSdI
         nNqzfhmSQZ+33DwsBzNTLbncAzpH2IXNJw6CaWZR0LORJF34o81IxGrRrLHI2Au6KE
         eU8U9cK9EaBIOthIBFlz5Iupe4m6Q3Q60w8XZmh0=
Date:   Sun, 8 Dec 2019 01:07:02 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jani Nikula <jani.nikula@intel.com>
cc:     =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, ville.syrjala@linux.intel.com,
        linux-input@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v2 11/14] HID: picoLCD: constify fb ops
In-Reply-To: <871rtji02a.fsf@intel.com>
Message-ID: <nycvar.YFH.7.76.1912080106260.4603@cbobk.fhfr.pm>
References: <cover.1575022735.git.jani.nikula@intel.com> <8678a9a3566279c881bb4db944850eef35d0a4bb.1575022735.git.jani.nikula@intel.com> <20191202094047.34525a7d@aether.lan.sysophe.eu> <871rtji02a.fsf@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 5 Dec 2019, Jani Nikula wrote:

> >> Now that the fbops member of struct fb_info is const, we can start
> >> making the ops const as well.
> >>
> >> v2: fix	typo (Christophe de Dinechin)
> >
> > Fine with me.
> > I don't think going through drm-misc would trigger any conflict, but
> > adding Jiri to CC for the case there was any preference.
> >
> > Acked-by: Bruno Prémont <bonbons@linux-vserver.org>
> 
> No response, may I proceed with merging this through drm-misc please?

I have been off the grid the past week, sorry for belated response. Feel 
free to add

	Acked-by: Jiri Kosina <jkosina@suse.cz>

and take it through your tree.

-- 
Jiri Kosina
SUSE Labs


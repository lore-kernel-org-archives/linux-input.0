Return-Path: <SRS0=fPDO=EJ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEB5C82630
	for <linux-input@archiver.kernel.org>; Tue,  3 Nov 2020 10:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F192072C
	for <linux-input@archiver.kernel.org>; Tue,  3 Nov 2020 10:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604399796;
	bh=Eg2L7GMc+D/grmQRd+uDIOy1N1FwECV5+z+rWhgWBGQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=YolY0Jw+CufpDjSbqNOAH4vrM40rKlyF+vbuAZ0SCFCByxWhA6I3yK5zroLiCfqj7
	 fCA/yAlWPQBUrHXtG6VvfT6nKh9aIMZ2QiwMPxESe5ESbnoK0ZxL1/E0LmYhIA7Hxq
	 Lkm7iZKn9ko+mev4e3SEkdbD+hG2P1oM/FQ6tQzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgKCKgb (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 3 Nov 2020 05:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgKCKdp (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 3 Nov 2020 05:33:45 -0500
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2547206F1;
        Tue,  3 Nov 2020 10:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604399624;
        bh=Eg2L7GMc+D/grmQRd+uDIOy1N1FwECV5+z+rWhgWBGQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lpRPtrFVwYxL28XMFETMMxsPcUfVkgyNCQIQ8OpGteT5bulqB2GAnBJe7sO4JaVpX
         0JskbgnRi3JlwQPsrtXdRdaGSk8QE/dRmM6zZuwJkopHgHaFgOMy1Qxf2XX2EnpRGB
         OvlcPvCdlX4NoR2TrUxlUXgB3ngwvrirPz+DjiXg=
Date:   Tue, 3 Nov 2020 11:33:39 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Sandeep Singh <Sandeep.Singh@amd.com>,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH v8 1/4] SFH: Add maintainers and documentation for AMD
 SFH based on HID framework
In-Reply-To: <alpine.DEB.2.21.2010300902220.16621@felia>
Message-ID: <nycvar.YFH.7.76.2011031133080.18859@cbobk.fhfr.pm>
References: <20201009200138.1847317-1-Sandeep.Singh@amd.com> <20201009200138.1847317-2-Sandeep.Singh@amd.com> <alpine.DEB.2.21.2010300902220.16621@felia>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 30 Oct 2020, Lukas Bulwahn wrote:

> > From: Sandeep Singh <sandeep.singh@amd.com>
> > 
> > Add Maintainers for AMD SFH(SENSOR FUSION HUB) Solution and work flow
> > document.
> > 
> > Co-developed-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> > Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> > Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
> > ---
> >  Documentation/hid/amd-sfh-hid.rst | 145 ++++++++++++++++++++++++++++++
> >  Documentation/hid/index.rst       |   1 +
> >  MAINTAINERS                       |   8 ++
> >  3 files changed, 154 insertions(+)
> >  create mode 100644 Documentation/hid/amd-sfh-hid.rst
> >
> 
> I do not know where something went wrong here, but it seems that
> the git commit 302f0dad8c97 ("SFH: Add maintainers and 
> documentation for AMD SFH based on HID framework") on next-20201030 
> dropped the addition of the rst file compared to this patch v8 here.

Thanks for spotting this, that was me fat-fingering conflict resolution. 
I've now pushed out a fix.

-- 
Jiri Kosina
SUSE Labs


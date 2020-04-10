Return-Path: <SRS0=1/AT=52=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F1EC2BA19
	for <linux-input@archiver.kernel.org>; Fri, 10 Apr 2020 00:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D43920B1F
	for <linux-input@archiver.kernel.org>; Fri, 10 Apr 2020 00:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586479637;
	bh=wJYs6lkSvNsuhACwK5W8u2c2QF4FqGBMCSr375KwCG4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=XJdNKI2fsUMUDlXgNgvyX36hM9nwCo3EVzVPK8lA3Ini2qJ107KvzWneci+ZMf6fc
	 O/VhJ5lfVdKzb5qugmvUNpDEa6tTbKcGkJm0HSEiLThkiRu5vRybIGXhrsQoWuLR85
	 0PuzE4BiRVrjuMGFl/MbElVkjGlJm14UWqpk+79o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgDJArQ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbgDJArQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Apr 2020 20:47:16 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06AED20768;
        Fri, 10 Apr 2020 00:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586479636;
        bh=wJYs6lkSvNsuhACwK5W8u2c2QF4FqGBMCSr375KwCG4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=B1U0KbGI0cvJP+BKZ7ebNhuWSgk01kTViaKevH/IPT9PrgKRaPeqUeJ8L256zbdrC
         vqPMSXYsoxd7brYWpj4HBDvsW3FAASWelvTP+7bsDtUuFywM/5jozVZg3oSEKVSs8A
         bcmTuvRsT73JAjrefHYYWoEo3tKGD/ZAFyO+OtFY=
Date:   Fri, 10 Apr 2020 02:47:13 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Masaki Ota <masaki.ota@alpsalpine.com>
cc:     Xiaojian Cao <xiaojian.cao@cn.alps.com>,
        Artem Borisov <dedsa2002@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] HID: alps: Refactor axis resolution logic
In-Reply-To: <TYAPR01MB3871E974EFE06EBF40074470ECDE0@TYAPR01MB3871.jpnprd01.prod.outlook.com>
Message-ID: <nycvar.YFH.7.76.2004100245260.19713@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2004100019450.19713@cbobk.fhfr.pm> <20200409230009.22551-1-dedsa2002@gmail.com> <TYAPR01MB3871E974EFE06EBF40074470ECDE0@TYAPR01MB3871.jpnprd01.prod.outlook.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 10 Apr 2020, Masaki Ota wrote:

> Hi, Cao-san,
> 
> Do you know AUI1657 device? This device looks U1. I think recent all U1 
> devices work as PTP. Linux also supports PTP, so I think we should add 
> something ID to Linux source code. (I remember a something flag is 
> already exist.)

That's actually partially covered by Artem's 1/1 patch you have not been 
CCed on -- please see it here:

	http://lore.kernel.org/r/20200405235517.18203-1-dedsa2002@gmail.com

If this could be made more generic to cover a group of devices all-in-one, 
that'd be even better of course.

Thanks,

-- 
Jiri Kosina
SUSE Labs


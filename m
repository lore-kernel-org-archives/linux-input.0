Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB53C433DB
	for <linux-input@archiver.kernel.org>; Mon,  8 Mar 2021 16:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56FFC6522B
	for <linux-input@archiver.kernel.org>; Mon,  8 Mar 2021 16:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhCHQgB (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 8 Mar 2021 11:36:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:31798 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhCHQfp (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 8 Mar 2021 11:35:45 -0500
IronPort-SDR: MAFuZstgiFWPCSb+5dFfh1wTu5D3MfLjSXssUp8uqdrgzeQc05FNJosceiiZBCXywUir/6wW+Y
 bxv6QyF5vI1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="167974030"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="167974030"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:35:45 -0800
IronPort-SDR: YiJNZGNGSZNsZsmLEzU/9Lnz/d1uyF5tA289sbh6idydDGnR7J6p+q8sDvRcA4hdR68XtPbFr4
 yBQyHWUTt7fw==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="402882554"
Received: from arohrbax-mobl.amr.corp.intel.com ([10.209.91.130])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:35:45 -0800
Message-ID: <aa32083cdc9a08b502ab23ef0235f5b648e4c438.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/3] HID: intel-ish-hid: Drop if block with an always
 false condition
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Mar 2021 08:35:44 -0800
In-Reply-To: <nycvar.YFH.7.76.2103081716200.12405@cbobk.fhfr.pm>
References: <20210206151348.14530-1-uwe@kleine-koenig.org>
         <nycvar.YFH.7.76.2103081107250.12405@cbobk.fhfr.pm>
         <31028f589e27e246bb3b4b693caeb0b8eae3a285.camel@linux.intel.com>
         <nycvar.YFH.7.76.2103081716200.12405@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 2021-03-08 at 17:16 +0100, Jiri Kosina wrote:
> On Mon, 8 Mar 2021, Srinivas Pandruvada wrote:
> 
> > > > A remove callback is only ever called for a bound device. So
> > > > there
> > > > is no
> > > > need to check for device or driver being NULL.
> > > 
> > > Srinivas, any objections to this patchset? The cleanups look good
> > > to
> > > me. 
> > Sorry, I missed this series.
> > No objection for taking these patches.
> 
> Thanks. Applied with your Acked-by:
> If you disagree with that interpretation of your statement above,
> please 
> holler :)
I agree. 
For record:
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks,
Srinivas

> 
> Thanks,
> 


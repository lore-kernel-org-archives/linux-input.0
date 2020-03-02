Return-Path: <SRS0=OSNE=4T=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B623CC3F2D2
	for <linux-input@archiver.kernel.org>; Mon,  2 Mar 2020 11:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977FD2080C
	for <linux-input@archiver.kernel.org>; Mon,  2 Mar 2020 11:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgCBLJf (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:09:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:30313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgCBLJf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 2 Mar 2020 06:09:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 03:09:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,506,1574150400"; 
   d="scan'208";a="440097172"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2020 03:09:30 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j8ix2-00677E-TG; Mon, 02 Mar 2020 13:09:32 +0200
Date:   Mon, 2 Mar 2020 13:09:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, nikolas@gnu.org,
        gregkh@linuxfoundation.org, maowenan@huawei.com
Subject: Re: [PATCH] input: keyboard: applespi: Use new structure for SPI
 transfer delays
Message-ID: <20200302110932.GS1224808@smile.fi.intel.com>
References: <20200227124534.23399-1-sergiu.cuciurean@analog.com>
 <20200229032616.GA27264@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229032616.GA27264@innovation.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, Feb 28, 2020 at 07:26:16PM -0800, Life is hard, and then you die wrote:
> On Thu, Feb 27, 2020 at 02:45:34PM +0200, Sergiu Cuciurean wrote:

...

> > -	wr_t->delay_usecs = SPI_RW_CHG_DELAY_US;
> > +	wr_t->delay.value = SPI_RW_CHG_DELAY_US;
> > +	wr_t->delay.unit = SPI_DELAY_UNIT_USECS;
> 
> Looks good to me and tested to confirm things still work.

Ronald, we have the established tags for such, like Tested-by:, Reviewed-by:.

-- 
With Best Regards,
Andy Shevchenko



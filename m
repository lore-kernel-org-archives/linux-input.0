Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9245EC5519F
	for <linux-input@archiver.kernel.org>; Wed, 25 Nov 2020 12:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28392206F7
	for <linux-input@archiver.kernel.org>; Wed, 25 Nov 2020 12:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK1ypnpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgKYM5W (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 25 Nov 2020 07:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgKYM5W (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Nov 2020 07:57:22 -0500
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BE97206E5;
        Wed, 25 Nov 2020 12:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606309041;
        bh=pNjDI+ni4PDHllmLPf9AZXrBAM9gk/RybMSX8i/GbMM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gK1ypnpU7g7t4wC/BNSYZeGlf4LFYNjER8BV45o1/bkQThmYFRMfMEe7x3t7R/MUo
         K9dLE6w4gXg4desZRRGO2T87NjkJmZK+lLzlPVH2OmUeJ61ehROy739/ypI6RIQvtL
         qmzys0dghXfxcWvpmQQBRXvllbV2YxXNkqlHDOk8=
Date:   Wed, 25 Nov 2020 13:57:18 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
cc:     srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel-ish-hid: Remove unnecessary assignment to
 variable rv
In-Reply-To: <20201110032049.187404-1-jingxiangfeng@huawei.com>
Message-ID: <nycvar.YFH.7.76.2011251356520.3441@cbobk.fhfr.pm>
References: <20201110032049.187404-1-jingxiangfeng@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 10 Nov 2020, Jing Xiangfeng wrote:

> This assignment to rv is unused in an error path. So remove it.
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp-hid.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
> index b8aae69ad15d..393bed0abee9 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
> @@ -211,10 +211,8 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
>  	struct ishtp_hid_data *hid_data;
>  
>  	hid = hid_allocate_device();
> -	if (IS_ERR(hid)) {
> -		rv = PTR_ERR(hid);
> -		return	-ENOMEM;
> -	}
> +	if (IS_ERR(hid))
> +		return PTR_ERR(hid);
>  

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs


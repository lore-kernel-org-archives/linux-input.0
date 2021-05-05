Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C46C433B4
	for <linux-input@archiver.kernel.org>; Wed,  5 May 2021 12:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 131E6613BF
	for <linux-input@archiver.kernel.org>; Wed,  5 May 2021 12:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhEEMiI (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 5 May 2021 08:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233295AbhEEMiH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 5 May 2021 08:38:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D6BE613BC;
        Wed,  5 May 2021 12:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620218230;
        bh=fdtoiOO8qA6Z15EU3pkpce86bDIJDbnRKUIpVmpH880=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=IXgiXhy6NOI2gMa6vixpLEtJSHF4czwOYOHahqaiFyQA6bJfskwv1X4ykyeC0eI2M
         IDs2vu/QZK7pJ5lC1NuTRUptPrcvTKH6Y0dyjs7/CPLUmTE2UMwN4IbQvZjKVT0eeS
         KR/gRG7wxxTpxY+CVSpIXZv04o4fa3mgPIhea4WcCMNWVxxd7Tw4uhBnrsBHMhP8c/
         9HJgBYwDEtReiCYEsRBbwSmW7Tlyj1aBrmWCo+iGfz2D4QqNY92EjQcPoG38pE87Fj
         6bC/i+4Ad03gh4wdlZXWccntL223HbBbtnm96DDiiF3XHrViyCt5d5+VC52ImSJvr5
         7XCG8wtTdwySA==
Date:   Wed, 5 May 2021 14:37:07 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     jic23@kernel.org, benjamin.tissoires@redhat.com,
        jiapeng.chong@linux.alibaba.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: hid-sensor-hub: Return error for hid_set_field()
 failure
In-Reply-To: <20210415185232.2617398-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.2105051436580.28378@cbobk.fhfr.pm>
References: <20210415185232.2617398-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 15 Apr 2021, Srinivas Pandruvada wrote:

> In the function sensor_hub_set_feature(), return error when hid_set_field()
> fails.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied this one, thanks.

-- 
Jiri Kosina
SUSE Labs


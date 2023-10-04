Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C10E7C4E9
	for <linux-input@archiver.kernel.org>; Wed,  4 Oct 2023 18:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243718AbjJDSvv (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 4 Oct 2023 14:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244308AbjJDSvu (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 4 Oct 2023 14:51:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CACC6
        for <linux-input@vger.kernel.org>; Wed,  4 Oct 2023 11:51:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502C1C433C7;
        Wed,  4 Oct 2023 18:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445505;
        bh=vZgRLrHKbqTqaHMV05a0bFnbhmj9Rte/xaqv06i5N6s=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=oIcVJcQ21wIAf/JC9rwzAHCrawz9B4MN3YspeSeCjp//a6W5lbpch24bp1FXTg6HG
         6BXgapSlK8xEjAzpMgJqYp90nlHp7nxAQMHRzOt7zs4IrhOnhx9qenvtRKHsCfr4m5
         erYE3ElDDKidZ1sgQroJpCuWticf0fCZVQwZy7ugwBjPfee6E6iYXiaF0eWkZAITZX
         6338kooPbFXZlzeBBRF4UiHFJbmr8OEciYsrMqKmfuNKCPt1W0fBrSq92AuXH5/GQu
         nZkkFqPWTie4Qbk33S6dcUF8AFmUxZLA44XjAEurdrxvq8UR17jjOmRySJ+P9KYyoU
         og/dV7qCUWQSQ==
Date:   Wed, 4 Oct 2023 20:49:07 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: nvidia-shield: Select POWER_SUPPLY Kconfig option
In-Reply-To: <875y478ngn.fsf@nvidia.com>
Message-ID: <nycvar.YFH.7.76.2310042048280.3534@cbobk.fhfr.pm>
References: <20230917151850.62505-1-rrameshbabu@nvidia.com> <nycvar.YFH.7.76.2309181656130.14216@cbobk.fhfr.pm> <875y478ngn.fsf@nvidia.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 18 Sep 2023, Rahul Rameshbabu wrote:

> >> Battery information reported by the driver depends on the power supply 
> >> subsystem. Select the required subsystem when the HID_NVIDIA_SHIELD 
> >> Kconfig option is enabled.
> >> 
> >> Fixes: 3ab196f88237 ("HID: nvidia-shield: Add battery support for Thunderstrike")
> >> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> >> ---
> >>  drivers/hid/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> >> index e11c1c803676..dc227f477601 100644
> >> --- a/drivers/hid/Kconfig
> >> +++ b/drivers/hid/Kconfig
> >> @@ -792,6 +792,7 @@ config HID_NVIDIA_SHIELD
> >>  	tristate "NVIDIA SHIELD devices"
> >>  	depends on USB_HID
> >>  	depends on BT_HIDP
> >> +	select POWER_SUPPLY
> >
> > Is there a reason not to do it the standard way using 'depends on', and 
> > not vice versa?
> 
> I originally used 'depends on' for POWER_SUPPLY. I took a look at
> drivers/hid/Kconfig and saw that all modules that depended on
> POWER_SUPPLY in the hid subsystem used 'select' instead. I figured I
> should follow the trend.

You are right.

I still don't like the fact that we are forcefully selecting POWER_SUPPLY 
like this, but that's a 6.7 material.

Appplied, thanks.

-- 
Jiri Kosina
SUSE Labs


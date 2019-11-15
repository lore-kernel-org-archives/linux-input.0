Return-Path: <SRS0=EPtW=ZH=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FD6C432C3
	for <linux-input@archiver.kernel.org>; Fri, 15 Nov 2019 12:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7175620748
	for <linux-input@archiver.kernel.org>; Fri, 15 Nov 2019 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573820396;
	bh=D9S3VSGTvWOdRbV3dXxe7gABwmh/r9W90KNMpfEfZBo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=lheCo/ZevBZrwDc2LQpOvrKhqvwWDQxQu2OLgHXbSPS3M1+5T6yQa2cI/JbAKh4xN
	 k7CV0mnkDxW8bOIooIGGFeXOu+/4mEo295kJQJiAEhaQUsZCwP9HuppCUBT5EzE5GI
	 kyToefpbdg+AEKSLdFoi2JYorUD29NYad/GBcq3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfKOMT4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfKOMTz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 15 Nov 2019 07:19:55 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3505820740;
        Fri, 15 Nov 2019 12:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573820395;
        bh=D9S3VSGTvWOdRbV3dXxe7gABwmh/r9W90KNMpfEfZBo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=2PDyJs/hpTmrhdORNKT0Glk686WSq6WE8C9peDDTLaFHMz/3KNJXNXVldVXL1u0X4
         h4IY7tocxHx21c7eYBvZ8CzdiTmIeJ17dZwcWmNQkeysFXlLopirsjgTbZH8HvHSLp
         Fgs8iaLsqbIv9JG7VVISu/hdtbk3YezJOajrTEIc=
Date:   Fri, 15 Nov 2019 13:19:52 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: Silence intermittent get_battery_capacity
 errors
In-Reply-To: <20191114143046.238711-1-hdegoede@redhat.com>
Message-ID: <nycvar.YFH.7.76.1911151319450.1799@cbobk.fhfr.pm>
References: <20191114143046.238711-1-hdegoede@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 14 Nov 2019, Hans de Goede wrote:

> My Logitech M185 (PID:4038) 2.4 GHz wireless HID++ mouse is causing
> intermittent errors like these in the log:
> 
> [11091.034857] logitech-hidpp-device 0003:046D:4038.0006: hidpp20_batterylevel_get_battery_capacity: received protocol error 0x09
> [12388.031260] logitech-hidpp-device 0003:046D:4038.0006: hidpp20_batterylevel_get_battery_capacity: received protocol error 0x09
> [16613.718543] logitech-hidpp-device 0003:046D:4038.0006: hidpp20_batterylevel_get_battery_capacity: received protocol error 0x09
> [23529.938728] logitech-hidpp-device 0003:046D:4038.0006: hidpp20_batterylevel_get_battery_capacity: received protocol error 0x09
> 
> We are already silencing error-code 0x09 (HIDPP_ERROR_RESOURCE_ERROR)
> errors in other places, lets do the same in
> hidpp20_batterylevel_get_battery_capacity to remove these harmless,
> but scary looking errors from the dmesg output.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 8e91e2f06cb4..cd9193078525 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -1102,6 +1102,9 @@ static int hidpp20_batterylevel_get_battery_capacity(struct hidpp_device *hidpp,
>  	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
>  					  CMD_BATTERY_LEVEL_STATUS_GET_BATTERY_LEVEL_STATUS,
>  					  NULL, 0, &response);
> +	/* Ignore these intermittent errors */
> +	if (ret == HIDPP_ERROR_RESOURCE_ERROR)
> +		return -EIO;
>  	if (ret > 0) {
>  		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
>  			__func__, ret);

Applied, thanks Hans.

-- 
Jiri Kosina
SUSE Labs


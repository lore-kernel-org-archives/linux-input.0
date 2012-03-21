From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [PATCH 1/3] HID: wacom: Remove CONFIG_HID_WACOM_POWER_SUPPLY
 option
Date: Wed, 21 Mar 2012 21:43:42 +0000
Message-ID: <1332366222.3463.3.camel@pldmachine>
References: <1332184114-30354-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:49324 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757705Ab2CUVn6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Mar 2012 17:43:58 -0400
In-Reply-To: <1332184114-30354-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: chris@cnpbagwell.com, linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Ping <pinglinux@gmail.com>

Dnia 2012-03-19, pon o godzinie 19:08 +0000, Przemo Firszt pisze:
> This option was ment as a safety mechanism in case the system treats the wacom
> tablet battery as the main power supply. It's no longer required as now we can
> distinguish between system power supply and device power supply.
> 
> Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
> ---
Jiri,
I just noticed that there is one more CONFIG_HID_WACOM_POWER_SUPPLY in
drivers/hid/hid-wacom.c that needs to be removed. If you didn't apply it
yet I'd like to resend all 3 patches or if you alredy did it I just
submit a fix patch.
-- 
Regards,
Przemo Firszt


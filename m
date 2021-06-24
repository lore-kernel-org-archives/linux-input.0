Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBEDC49EA5
	for <linux-input@archiver.kernel.org>; Thu, 24 Jun 2021 13:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D35613C3
	for <linux-input@archiver.kernel.org>; Thu, 24 Jun 2021 13:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFXN3S (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 24 Jun 2021 09:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhFXN3S (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Jun 2021 09:29:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68BFD61074;
        Thu, 24 Jun 2021 13:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624541219;
        bh=Z5RpeZUVxCdnt3wBN/6yt62Dz6n8RjGJQhupaQlo8DM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ifCbq/gjQNLmGqQu6A1ti1Tgdz5JBiJsreBTWk6xM3lYA3vwl9UL5WFeiknok1XpV
         Izip4nU0e2CoLl2EMwwsRZ5BcDqK5T//SrzgFcWl1iPJhPepyNz39kNq0p/SoDbcyt
         1ALv8mM79HC7G7FOuYbx15bYfBQRpMKE4BRsb52eEvl51OEij/vYjUSDAUcs+ftqPI
         Gy69Y8oK3mk0HtFlbh3R6iRaCRPf9pvLNruGciLa6F3fgDnSd+fJGXkhW4ixHZMOL0
         2iuO3Edh70rOyIUdxSdKbQJBLVnnyENR51F3OUtQFGnm99HFUYGqq7LEqFtfg2GHJ+
         ikIs0TQrn31Qg==
Date:   Thu, 24 Jun 2021 15:26:56 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jason Gerecke <killertofu@gmail.com>
cc:     linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <pinglinux@gmail.com>,
        Jason Gerecke <jason.gerecke@wacom.com>
Subject: Re: [PATCH] HID: wacom: Correct base usage for capacitive ExpressKey
 status bits
In-Reply-To: <20210623165809.101208-1-jason.gerecke@wacom.com>
Message-ID: <nycvar.YFH.7.76.2106241526510.18969@cbobk.fhfr.pm>
References: <20210623165809.101208-1-jason.gerecke@wacom.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 23 Jun 2021, Jason Gerecke wrote:

> The capacitive status of ExpressKeys is reported with usages beginning
> at 0x940, not 0x950. Bring our driver into alignment with reality.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
>  drivers/hid/wacom_wac.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 71c886245dbf..8f16654eca09 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -122,7 +122,7 @@
>  #define WACOM_HID_WD_TOUCHONOFF         (WACOM_HID_UP_WACOMDIGITIZER | 0x0454)
>  #define WACOM_HID_WD_BATTERY_LEVEL      (WACOM_HID_UP_WACOMDIGITIZER | 0x043b)
>  #define WACOM_HID_WD_EXPRESSKEY00       (WACOM_HID_UP_WACOMDIGITIZER | 0x0910)
> -#define WACOM_HID_WD_EXPRESSKEYCAP00    (WACOM_HID_UP_WACOMDIGITIZER | 0x0950)
> +#define WACOM_HID_WD_EXPRESSKEYCAP00    (WACOM_HID_UP_WACOMDIGITIZER | 0x0940)
>  #define WACOM_HID_WD_MODE_CHANGE        (WACOM_HID_UP_WACOMDIGITIZER | 0x0980)
>  #define WACOM_HID_WD_MUTE_DEVICE        (WACOM_HID_UP_WACOMDIGITIZER | 0x0981)
>  #define WACOM_HID_WD_CONTROLPANEL       (WACOM_HID_UP_WACOMDIGITIZER | 0x0982)

Applied, thanks Jason.

-- 
Jiri Kosina
SUSE Labs


Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406D8C54EE9
	for <linux-input@archiver.kernel.org>; Wed,  7 Sep 2022 15:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiIGPjv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-input@archiver.kernel.org>);
        Wed, 7 Sep 2022 11:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiIGPju (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2022 11:39:50 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258642124F;
        Wed,  7 Sep 2022 08:39:46 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id CE4D740003;
        Wed,  7 Sep 2022 15:39:43 +0000 (UTC)
Message-ID: <e907c9240fb2cc0c1e60e3610cfae15ff8125c49.camel@hadess.net>
Subject: Re: [v4 1/5] HID: core: Export hid_match_id()
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Wed, 07 Sep 2022 17:39:43 +0200
In-Reply-To: <20220830132549.7240-1-hadess@hadess.net>
References: <20220830132549.7240-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Jiri,

If those patches look good to you, would be great to get merged.
Benjamin doesn't have the bandwidth to test the patches on his own test
hardware right now, but I've been using them daily for a week now.

Cheers

On Tue, 2022-08-30 at 15:25 +0200, Bastien Nocera wrote:
> Export hid_match_id() so it can be used in device-specific drivers to
> implement their own matching with open-coding a match function.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  drivers/hid/hid-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index b7f5566e338d..72f8d8835b34 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2088,6 +2088,7 @@ const struct hid_device_id *hid_match_id(const
> struct hid_device *hdev,
>  
>         return NULL;
>  }
> +EXPORT_SYMBOL_GPL(hid_match_id);
>  
>  static const struct hid_device_id hid_hiddev_list[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS) },


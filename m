Return-Path: <SRS0=vRrv=6T=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77528C47257
	for <linux-input@archiver.kernel.org>; Tue,  5 May 2020 14:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57EA82073B
	for <linux-input@archiver.kernel.org>; Tue,  5 May 2020 14:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588689154;
	bh=vWrIPAhCVU5pkrkWbTMJL+fQ8rv8shB/5pgEn3wcNfY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=v2+y57Bi6LnRv//FM1PiK71W7Y3m0+FgcHDFCOMczM1g5ASVXk1mtVUEgE9UB5dLO
	 UY2shMYeM4AlcE0vtq6wWiCwy15D02pRvJuyPcOWnhMguMBlWmJGHgLcWM7ms50xpN
	 1FlxMcGQJaQyu/Qj/9jxv4idMGMRePP6oTQh2spk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgEEOcd (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 5 May 2020 10:32:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgEEOcd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 5 May 2020 10:32:33 -0400
Received: from pobox.suse.cz (unknown [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B66F206A5;
        Tue,  5 May 2020 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588689153;
        bh=vWrIPAhCVU5pkrkWbTMJL+fQ8rv8shB/5pgEn3wcNfY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bIEpeASbzU6m7TBkjNvb49WQ3ni99xoRUUy5grQ19uob0oV+dm/VZ+TKG9Aj6S5Bh
         nEC/d7oscUaoOuOD7MZlwO3ReXPDQTH6VnSctvXOBdKp1Fh8q8+lKeAwsObBQ+OrTI
         PKTyKFlhzI2nHZh43B5XVJEh3KtXVvFRMNAdkcxM=
Date:   Tue, 5 May 2020 16:32:30 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 3/6] HID: asus: Add hid_is_using_ll_driver(usb_hid_driver)
 check
In-Reply-To: <20200428142254.252063-3-hdegoede@redhat.com>
Message-ID: <nycvar.YFH.7.76.2005051631560.25812@cbobk.fhfr.pm>
References: <20200428142254.252063-1-hdegoede@redhat.com> <20200428142254.252063-3-hdegoede@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 28 Apr 2020, Hans de Goede wrote:

> Add a hid_is_using_ll_driver(usb_hid_driver) check to ensure that the
> parent device is an usb_interface, before casting the parent device
> pointer to an usb_interface pointer with to_usb_interface().
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/hid/hid-asus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index b3292ff3f61a..719eff589f92 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -842,7 +842,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	if (drvdata->quirks & QUIRK_IS_MULTITOUCH)
>  		drvdata->tp = &asus_i2c_tp;
>  
> -	if (drvdata->quirks & QUIRK_T100_KEYBOARD) {
> +	if ((drvdata->quirks & QUIRK_T100_KEYBOARD) &&
> +	    hid_is_using_ll_driver(hdev, &usb_hid_driver)) {
>  		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
>  

I am going to push the whole patchset to for-5.8/asus branch later today, 
but I guess this one should better be taken as 5.7 fix still, right?

Thanks,

-- 
Jiri Kosina
SUSE Labs


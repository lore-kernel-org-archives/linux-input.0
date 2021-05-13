Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC7DC433B4
	for <linux-input@archiver.kernel.org>; Thu, 13 May 2021 10:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048736142C
	for <linux-input@archiver.kernel.org>; Thu, 13 May 2021 10:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhEMKe6 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 13 May 2021 06:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231327AbhEMKe6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 May 2021 06:34:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA0AD610A0;
        Thu, 13 May 2021 10:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620902028;
        bh=qR4X3vbgzOOPhv4//F56g/ItG6l4XpOHC94Hi0kSd5k=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=N6eQ32bltBzzGn27ZG+QJ+MTWEFnQPlYp+kB3819Ixa/ZCbIMYZ0Szu/HvJ4kRSCq
         PFPyN1XJxkw0JjrmG62sMH/Tm+z5rHf0FksnLIqIomR5akt9iXwu1FznUcvbxWfAWJ
         VLfNpZ5BlHmDVrgxrWmjN4l75i40u0Xrx2RrpErvEggYYx0kugxpPzHXCSChfr7JXB
         eDx8FB8lqWDgGlu6Y6yPm70ioeuIybz/pdI+ITTqI1qLq6mvOVYdfMdMb4ksFulLAp
         cxyiSpXeqyewmgRq0IeZQrb5Db2MHTk4a2j5tAcBtQs7gIK5XTTwyDFiO+BnsbNpQX
         S9N245ZLIHIZw==
Date:   Thu, 13 May 2021 12:33:45 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 1/3] HID: asus: Cleanup Asus T101HA keyboard-dock
 handling
In-Reply-To: <20210306133716.453447-1-hdegoede@redhat.com>
Message-ID: <nycvar.YFH.7.76.2105131233300.28378@cbobk.fhfr.pm>
References: <20210306133716.453447-1-hdegoede@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, 6 Mar 2021, Hans de Goede wrote:

> There is no need to use a quirk and then return -ENODEV from the
> asus_probe() function to avoid that hid-asus binds to the hiddev
> for the USB-interface for the hid-multitouch touchpad.
> 
> The hid-multitouch hiddev has a group of HID_GROUP_MULTITOUCH_WIN_8,
> so the same result can be achieved by making the hid_device_id entry
> for the dock in the asus_devices[] table only match on HID_GROUP_GENERIC
> instead of having it match HID_GROUP_ANY.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-5.13/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs


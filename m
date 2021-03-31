Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109BAC433E0
	for <linux-input@archiver.kernel.org>; Wed, 31 Mar 2021 09:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE33F619CA
	for <linux-input@archiver.kernel.org>; Wed, 31 Mar 2021 09:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhCaJmd (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235042AbhCaJlx (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 31 Mar 2021 05:41:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C0CC619BB;
        Wed, 31 Mar 2021 09:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617183713;
        bh=JfZJ0BRXu9jl/hAMF1IC46jvvyTjFlYO4IRzCTrKA+k=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=m7t8QEBain1Jwj/kDm9iEDcqjDTmEYyq9tWklMeZ+/5PMU06Ta00BxYXuz2XWUhKt
         dnBMW6Xw4bu0emER4gNI2Yy66jNYxtoyYKqvfTsdu4EYcYx57sKlWc7Yv1l9Y4NupZ
         Zcen22Rvqm/7txgrvzS1gyQd1gP78RG1wLHzQfGYyC/IstBc1xAX+q5NQ3uyFjkQHH
         5EZZkZBYQQDTdGtIFroBsTnazTUnPW7ZoGWjEjmbUZHOZY5w5n2hQexiHcL+13WZ8n
         bwCuj+sxKOvWabw3D2kaHvB4mA+r1YK9rwsJq0B0HxtaEyuGPy9tkUpb6tRyf5SS37
         Pyt+Al6l3wwjw==
Date:   Wed, 31 Mar 2021 11:41:50 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     linux-input@vger.kernel.org
Subject: Re: [PATCH 1/3] HID: asus: Cleanup Asus T101HA keyboard-dock
 handling
In-Reply-To: <20210306133716.453447-1-hdegoede@redhat.com>
Message-ID: <nycvar.YFH.7.76.2103311141060.12405@cbobk.fhfr.pm>
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

Benjamin, could you please Ack this series, as it touches hid-multitouch, 
please?

Thanks,

-- 
Jiri Kosina
SUSE Labs


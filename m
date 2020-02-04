Return-Path: <SRS0=GsZw=3Y=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29719C2D0B1
	for <linux-input@archiver.kernel.org>; Tue,  4 Feb 2020 12:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F192D218AC
	for <linux-input@archiver.kernel.org>; Tue,  4 Feb 2020 12:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580820230;
	bh=cYXyp6yucZKpkP+bED2LK/GmxBcnK69PjEgzJQ0nZA0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZylZufVeCXbrhuToX6PRbjvo+QuCcVAdoGVRtHkm3namWuaG1E17dqPTb8pNVn8mZ
	 lKt8F7NZKWbmj04OQSvc9u7Nl+e6vicCFP0RmwN49S694PK6q8l3S8MVBZoI6x5v1A
	 wJXylMhF9yJI8JuHOzB3tVj2KKymbKiwDMgVU+Dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBDMnt (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 4 Feb 2020 07:43:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbgBDMnt (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 4 Feb 2020 07:43:49 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF4C2166E;
        Tue,  4 Feb 2020 12:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580820228;
        bh=cYXyp6yucZKpkP+bED2LK/GmxBcnK69PjEgzJQ0nZA0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=maS2hR7jVsTk/jbwApFiwrjZrD2Yg8UgUtyUwK9HSbB48kjl8o38KHQJ6M+TglyEY
         jYgrtl2mHBwBunR5ndvam2/0tFPokqfGNYCllvAe1xpk3mrcw1XvIAoWbHOVlKiqei
         Yone0NpgjNpsIVZZbQFWXs9UXG5DpqMI7N4JSku8=
Date:   Tue, 4 Feb 2020 13:43:43 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Johan Hovold <johan@kernel.org>
cc:     Lauri Jakku <lja@iki.fi>, oneukum@suse.com,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] USB: HID: random timeout failures tackle try.
In-Reply-To: <20200204123508.GJ26725@localhost>
Message-ID: <nycvar.YFH.7.76.2002041342460.26888@cbobk.fhfr.pm>
References: <20200204110658.32454-1-lja@iki.fi> <20200204123508.GJ26725@localhost>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 4 Feb 2020, Johan Hovold wrote:

> > Why modify usb-hid-core: No need to modify driver by driver.
> 
> Because you cannot decide how every use should handle timeouts.
> 
> Just fix up the driver that needs this.

I believe it will actually not be a particular driver, but perhaps a set 
of devices with b0rked USB implementation, and we could just introduce 
(another, oh well) per-device quirk list if needed.

Do we have any idea / indication how many devices out there actually 
require this?

Thanks,

-- 
Jiri Kosina
SUSE Labs


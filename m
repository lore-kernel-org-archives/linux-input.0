Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E823C25B08
	for <linux-input@archiver.kernel.org>; Wed, 17 Aug 2022 17:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiHQRsW (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 17 Aug 2022 13:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbiHQRsV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 Aug 2022 13:48:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0976F13D6C;
        Wed, 17 Aug 2022 10:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7246B81D4C;
        Wed, 17 Aug 2022 17:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219A4C433D6;
        Wed, 17 Aug 2022 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660758498;
        bh=oGNYkVCpNdKqGzZ/A1v7/SNpGbfJg9/ChuTQsjENTVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=icwLAD23/E4FKYmJ2m+WIryEl7O0qXny0tJX91xTkdyue6WKcy7Fl+/Ap31B7RGeb
         Pv4zhjOzBX4YqFTFXqGhZk6gfy7JkwZA/t+3HElHF1eNHGJmu3Bz7D3IuLr01OogxA
         4kJyUtgnLkonm66jD+zPcrJ7//x+h2nq8OHnP3/0=
Date:   Wed, 17 Aug 2022 19:48:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andri Yngvason <andri@yngvason.is>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: multitouch: Add memory barriers
Message-ID: <Yv0p38x60vE7WLry@kroah.com>
References: <20220817173234.3564543-1-andri@yngvason.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817173234.3564543-1-andri@yngvason.is>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, Aug 17, 2022 at 05:32:35PM +0000, Andri Yngvason wrote:
> This fixes broken atomic checks which cause a race between the
> release-timer and processing of hid input.
> 
> I noticed that contacts were sometimes sticking, even with the "sticky
> fingers" quirk enabled. This fixes that problem.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9609827458c37d7b2c37f2a9255631c603a5004c

Close, but not quite.  The documentation says how to format this, it
should look like:

Fixes: 9609827458c3 ("HID: multitouch: optimize the sticky fingers timer")

thanks,

greg k-h

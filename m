Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0D9C433EF
	for <linux-input@archiver.kernel.org>; Mon, 25 Apr 2022 09:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiDYJcY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-input@archiver.kernel.org>);
        Mon, 25 Apr 2022 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiDYJbW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 25 Apr 2022 05:31:22 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF96825EAF
        for <linux-input@vger.kernel.org>; Mon, 25 Apr 2022 02:27:53 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id E1C5A60009;
        Mon, 25 Apr 2022 09:27:50 +0000 (UTC)
Message-ID: <4df812355a26f9c7f732726b4e8dfbba01a40b8b.camel@hadess.net>
Subject: Re: [PATCH] MAINTAINERS: Add Wacom driver maintainers
From:   Bastien Nocera <hadess@hadess.net>
To:     Ping Cheng <pinglinux@gmail.com>, jikos@kernel.org
Cc:     linux-input@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>
Date:   Mon, 25 Apr 2022 11:27:50 +0200
In-Reply-To: <20220424053658.62328-1-ping.cheng@wacom.com>
References: <20220424053658.62328-1-ping.cheng@wacom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, 2022-04-23 at 22:36 -0700, Ping Cheng wrote:
> As suggested by Bastien and Jiri.
> 
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>

Good stuff, thanks!

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e8c2f611766..3d387a11ea36 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8749,6 +8749,14 @@ F:       drivers/hid/hid-sensor-*
>  F:     drivers/iio/*/hid-*
>  F:     include/linux/hid-sensor-*
>  
> +HID WACOM DRIVER
> +M:     Ping Cheng <ping.cheng@wacom.com>
> +M:     Jason Gerecke  <jason.gerecke@wacom.com>
> +L:     linux-input@vger.kernel.org
> +S:     Maintained
> +F:     drivers/hid/wacom.h
> +F:     drivers/hid/wacom_*
> +
>  HIGH-RESOLUTION TIMERS, CLOCKEVENTS
>  M:     Thomas Gleixner <tglx@linutronix.de>
>  L:     linux-kernel@vger.kernel.org


From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Elantech touchpad doesn't work on Fujitsu E556 laptop
Date: Wed, 5 Oct 2016 22:56:04 -0700
Message-ID: <20161006055604.GB36340@dtor-ws>
References: <e511d6de-1db4-5560-a56c-06846fb3bcfb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36672 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbcJFF4I (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 01:56:08 -0400
Received: by mail-pa0-f49.google.com with SMTP id ry6so4693818pac.3
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2016 22:56:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e511d6de-1db4-5560-a56c-06846fb3bcfb@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: William Linna <william.linna@gmail.com>
Cc: linux-input@vger.kernel.org, tiwai@suse.de

HI WIlliam,

On Fri, Sep 30, 2016 at 10:57:12AM +0300, William Linna wrote:
> Hi,
> 
> Elantech touchpad doesn't work on Fujitsu E556 laptop.
> 
> Touchpad doesn't move the cursor at all, and it seems to disturb
> keyboard too. If I accidentally hit the touchpad while typing, the
> key gets "stuck" (it keeps repeating until I press something else).
> 
> Fortunately, the touchpad works fine when I force crc_enabled on with:
> echo 1 > /sys/devices/platform/i8042/serio2/crc_enabled
> 
> or by applying the following patch, but replacing the U745 with E556:
> https://patchwork.kernel.org/patch/7570531/
> 
> See also:
> https://bugzilla.opensuse.org/show_bug.cgi?id=982131

Thank you for reporting. I just CCed you on a patch, it would be great
if you could give it a spin and let me know if it works for you.

Thanks.

-- 
Dmitry

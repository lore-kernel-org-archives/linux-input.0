From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 00/13] Input: Automated coccinelle cleanup (take 2)
Date: Sun, 22 Jan 2017 00:31:53 -0800
Message-ID: <20170122083153.GA1840@dtor-ws>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35506 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdAVIb4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Jan 2017 03:31:56 -0500
Content-Disposition: inline
In-Reply-To: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jan 21, 2017 at 10:45:52AM -0800, Guenter Roeck wrote:
> This patch series is the result of applying a set of coccinelle semantic
> patches to the input subsystem. The patches are only cleanup patches;
> there is little or no change in functionality.
> 
> This time around, the patches are combined into groups instead of per-file.
> Each patch has only a single coccinelle rule applied, and only affects a
> single directory in the input subsystem. 
> 
> As with the previous patch series, removed calls to platform_set_drvdata()
> and i2c_set_clientdata() deserve extra scrutiny from reviewers.
> 
> The conversion was done automatically with coccinelle using various semantic
> patches. The semantic patches and the scripts used to generate this commit
> log are either attached to the commits, or they are available at
> https://github.com/groeck/coccinelle-patches.
> 
> The series was build tested on kerneltests.org and by the 0day build system.
> 
> The patch series is based on v4.10-rc4, with input/next (sha 72d1f2346ded5)
> merged on top. For convenience, the series is available at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git input-base
> 
> ----------------------------------------------------------------
> Guenter Roeck (13):
>       Input: keyboard - Drop calls to platform_set_drvdata and i2c_set_clientdata
>       Input: misc - Drop calls to platform_set_drvdata and i2c_set_clientdata
>       Input: touchscreen - Drop calls to platform_set_drvdata and i2c_set_clientdata
>       Input: keyboard - Use local variables consistently
>       Input: misc - Use local variables consistently
>       Input: mouse  Use local variables consistently
>       Input: rmi4 - Use local variables consistently
>       Input: touchscreen - Use local variables consistently
>       Input: keyboard - drop unnecessary calls to device_init_wakeup
>       Input: misc - drop unnecessary calls to device_init_wakeup
>       Input: touchscreen - drop unnecessary calls to device_init_wakeup
>       Input: serio - drop unnecessary calls to device_init_wakeup
>       Input: misc - drop empty remove functions

Applied the lot, thank you.

-- 
Dmitry

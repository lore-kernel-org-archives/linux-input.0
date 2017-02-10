From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [GIT PULL] Immutable branch between MFD and Input due for the
 v4.11 merge window
Date: Fri, 10 Feb 2017 10:18:06 +0100
Message-ID: <7bb05b51-4cc2-9b19-0eca-7a318b9d9433@collabora.com>
References: <20170127105235.4727-1-enric.balletbo@collabora.com>
 <20170201175417.GA40720@dtor-ws> <20170208113910.bgwmoyttmddvihqj@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39637 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbdBJJSh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Feb 2017 04:18:37 -0500
In-Reply-To: <20170208113910.bgwmoyttmddvihqj@dell>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>

Lee,

On 08/02/17 12:39, Lee Jones wrote:
> Dmitry,
> 
>> Lee, can you please take it as well?
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-v4.11
> 
> for you to fetch changes up to cdd7950e7aa4a4d0d8ba71e3967aae6d25d09b03:
> 
>   input: cros_ec_keyb: Add non-matrix buttons and switches (2017-02-08 11:36:23 +0000)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD and Input due for the v4.11 merge window
> 
> ----------------------------------------------------------------
> Douglas Anderson (2):
>       mfd: cros-ec: Update cros_ec_commands.h for buttons and switches
>       input: cros_ec_keyb: Add non-matrix buttons and switches
> 

I see the above patches merged but not

 [PATCH] input: cros_ec_keyb: Add Tablet Mode switch.

Dmitry acked the patch and asked you if you can take patch. Is it possible for you include the patch? 


>  drivers/input/keyboard/cros_ec_keyb.c | 447 ++++++++++++++++++++++++++++++----
>  include/linux/mfd/cros_ec_commands.h  |  73 +++++-
>  2 files changed, 473 insertions(+), 47 deletions(-)
> 

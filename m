From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: pegasus_notetaker: add license information
Date: Sat, 25 Nov 2017 16:42:59 -0800
Message-ID: <20171126004259.xjl2icw3gbyg3hck@dtor-ws>
References: <20171118084518.8437-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34710 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbdKZAnD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Nov 2017 19:43:03 -0500
Content-Disposition: inline
In-Reply-To: <20171118084518.8437-1-martink@posteo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Martin,

On Sat, Nov 18, 2017 at 09:45:18AM +0100, Martin Kepplinger wrote:
> This adds an SPDX license identifier to this driver I wrote some time back.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
>  drivers/input/tablet/pegasus_notetaker.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
> index 47de5a81172f..cdf75c989469 100644
> --- a/drivers/input/tablet/pegasus_notetaker.c
> +++ b/drivers/input/tablet/pegasus_notetaker.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0

Should this be GPL-2.0+? The MODULE_LICENSE specifies that the module is
"GPL" which in kernel land means GPLv2+. Or we should change the module
license to strict "GPLv2"?

Also, why do we use C++ -style comments for this?

Greg, do you have any plans on dropping MODULE_LICENSE() altogether and
generating the appropriate string from SPDX markings in the source?
Doing this would prevent mismatches between license notices, SPDX tags
and MODULE_LCENSE() strings, which happen very often.

>  /*
>   * Pegasus Mobile Notetaker Pen input tablet driver
>   *

Thanks.

-- 
Dmitry

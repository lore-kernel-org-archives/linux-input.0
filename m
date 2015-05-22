From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] Update email-id of author
Date: Fri, 22 May 2015 09:59:17 -0700
Message-ID: <20150522165917.GC40101@dtor-ws>
References: <1430199988-17593-1-git-send-email-rajeevkumar.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36522 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757077AbbEVQ7V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 12:59:21 -0400
Received: by iepj10 with SMTP id j10so35547566iep.3
        for <linux-input@vger.kernel.org>; Fri, 22 May 2015 09:59:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1430199988-17593-1-git-send-email-rajeevkumar.linux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rajeev Kumar <rajeevkumar.linux@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Apr 28, 2015 at 11:16:28AM +0530, Rajeev Kumar wrote:
> rajeev-dlh.kumar@st.com email-id doesn't exist anymore as I have left the
> company.  Replace ST's id with Rajeev Kumar <rajeevkumar.linux@gmail.com>
> 
> Signed-off-by: Rajeev Kumar <rajeevkumar.linux@gmail.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/spear-keyboard.c      |    2 +-
>  include/linux/platform_data/keyboard-spear.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
> index f42a543..623d451 100644
> --- a/drivers/input/keyboard/spear-keyboard.c
> +++ b/drivers/input/keyboard/spear-keyboard.c
> @@ -3,7 +3,7 @@
>   * Based on omap-keypad driver
>   *
>   * Copyright (C) 2010 ST Microelectronics
> - * Rajeev Kumar<rajeev-dlh.kumar@st.com>
> + * Rajeev Kumar <rajeevkumar.linux@gmail.com>
>   *
>   * This file is licensed under the terms of the GNU General Public
>   * License version 2. This program is licensed "as is" without any
> diff --git a/include/linux/platform_data/keyboard-spear.h b/include/linux/platform_data/keyboard-spear.h
> index 9248e3a..5e3ff65 100644
> --- a/include/linux/platform_data/keyboard-spear.h
> +++ b/include/linux/platform_data/keyboard-spear.h
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2010 ST Microelectronics
> - * Rajeev Kumar<rajeev-dlh.kumar@st.com>
> + * Rajeev Kumar <rajeevkumar.linux@gmail.com>
>   *
>   * This file is licensed under the terms of the GNU General Public
>   * License version 2. This program is licensed "as is" without any
> -- 
> 1.7.9.5
> 

-- 
Dmitry

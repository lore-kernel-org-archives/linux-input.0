From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 8/8] Loongson: YeeLoong: add hotkey driver
Date: Sat, 28 Nov 2009 21:35:27 -0800
Message-ID: <20091129053527.GU6936@core.coreip.homeip.net>
References: <cover.1259414649.git.wuzhangjin@gmail.com> <739db9c7b5bab429d0df5a7c68f301aa12f1402d.1259414649.git.wuzhangjin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:32854 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbZK2FfZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2009 00:35:25 -0500
Received: by yxe26 with SMTP id 26so2244914yxe.4
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2009 21:35:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <739db9c7b5bab429d0df5a7c68f301aa12f1402d.1259414649.git.wuzhangjin@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com, linux-input@vger.kernel.org

On Sat, Nov 28, 2009 at 09:44:41PM +0800, Wu Zhangjin wrote:
>  
> +config YEELOONG_HOTKEY
> +	tristate "Hotkey Driver"
> +	depends on YEELOONG_VO
> +	select INPUT

I think this should be depend, not select. 

> +	select INPUT_EVDEV
> +	select SUSPEND

Does it break without SUSPEND? I am pretty sure that it will work fine
without EVDEV (however unlikely it is not present).

-- 
Dmitry

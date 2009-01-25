From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 09/10] HID: add compat support
Date: Sun, 25 Jan 2009 14:03:53 +0100
Message-ID: <497C6339.4040804__364.122648216103$1232890839$gmane$org@gmail.com>
References: <1210931362-18422-1-git-send-email-jirislaby@gmail.com>	 <1210931362-18422-2-git-send-email-jirislaby@gmail.com>	 <1210931362-18422-3-git-send-email-jirislaby@gmail.com>	 <1210931362-18422-4-git-send-email-jirislaby@gmail.com>	 <1210931362-18422-5-git-send-email-jirislaby@gmail.com>	 <1210931362-18422-6-git-send-email-jirislaby@gmail.com>	 <1210931362-18422-7-git-send-email-jirislaby@gmail.com>	 <1210931362-18422-8-git-send-email-jirislaby@gmail.com>	 <1210931362-18422-9-git-send-email-jirislaby@gmail.com> <3f9a31f40901232155q7f898f00l9a1cf16ca6c8fb75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f10.google.com ([209.85.219.10]:33601 "EHLO
	mail-ew0-f10.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568AbZAYND5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Jan 2009 08:03:57 -0500
In-Reply-To: <3f9a31f40901232155q7f898f00l9a1cf16ca6c8fb75@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com, gregkh@suse.de, Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@elte.hu>

Jaswinder Singh Rajput wrote:
> If you have any objections, then let me know, now it will look like this:

No objections from me, nice catch, thanks.

>  #endif /* HID_FF */
> 
> +#ifdef __KERNEL__
>  #ifdef CONFIG_HID_COMPAT
>  #define HID_COMPAT_LOAD_DRIVER(name)   \
>  /* prototype to avoid sparse warning */        \
> @@ -804,6 +805,7 @@ EXPORT_SYMBOL(hid_compat_##name)
>         extern void hid_compat_##name(void);    \
>         hid_compat_##name();                    \
>  } while (0)
> +#endif /* __KERNEL__ */
> 
>  #endif


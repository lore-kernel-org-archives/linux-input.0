From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v2 3/3] Add sixaxis plugin: USB pairing and LEDs settings
Date: Fri, 06 May 2011 02:14:38 +0100
Message-ID: <1304644488.16101.28.camel@novo.hadess.net>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
	 <1298628292-8842-4-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298628292-8842-4-git-send-email-ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jim Paris <jim-XrPbb/hENzg@public.gmane.org>, Ranulf Doswell <ralf-fD3LYpizeBGsTnJN9+BGXg@public.gmane.org>, "Pascal A . Brisset" <pascal44973-dXI0m6hRz7k@public.gmane.org>, Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Birchinger <joker-vQrvfurPyUjk1uMJSBkQmQ@public.gmane.org>, Filipe Lopes <falktx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Mikko Virkkila <virkkila-/1wQRMveznE@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 2011-02-25 at 11:04 +0100, Antonio Ospite wrote:
> +                       [AC_LANG_PROGRAM([[
> +                               #include <sys/ioctl.h>
> +                               #include <linux/hidraw.h>
> +                               #if ! (defined(HIDIOCSFEATURE) &&
> defined(HIDIOCGFEATURE))
> +                               #error "HIDIOCSFEATURE and
> HIDIOCGFEATURE are required (linux-libc-dev >= 2.6.3x)"
> +                               #endif
> +                               ]], 

The only part of the patch I have a problem with is this one.

I'd rather the code had:
#ifndef HIDIOCSFEATURE
#define HIDIOCSFEATURE bleh
#endif

And gracefully handled the ioctl not being available on the running
kernel (eg. "Not handling plugged in Sixaxis joypad because the kernel
lacks HIDIOCSFEATURE support").

The rest looks fine, and I'll be testing whether my Fedora 15 kernel has
the feature merged in yet (which would make testing your code much
easier).

Cheers

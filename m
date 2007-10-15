From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 1/8] m68k: Atari input drivers cleanup
Date: Mon, 15 Oct 2007 09:24:23 -0400
Message-ID: <d120d5000710150624p25a87bb0k19e21b8bec914be2@mail.gmail.com>
References: <20071013123123.085686856@mail.of.borg>
	 <20071013123412.197946192@mail.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764961AbXJONYh@vger.kernel.org>
In-Reply-To: <20071013123412.197946192@mail.of.borg>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>
List-Id: linux-input@vger.kernel.org

Hi Geert,

On 10/13/07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> m68k: Atari input drivers cleanup:
>  - memleak on failed init/register of input devices fixed
>  - correct keycodes table (Atari keycodes are almost, but not entirely, equal
>    to Linux keycodes).
>
> Signed-off-by: Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Looks much better, thank you.

>
> -       input_register_device(atakbd_dev);
> +       /* error check */
> +       if (input_register_device(atakbd_dev)) {
> +               input_free_device(atakbd_dev);
> +               return -ENOMEM;
> +       }
>

I'd be more happy if we returned real error reported by
input_register_device() instead of substituting it with -ENOMEM.

-- 
Dmitry

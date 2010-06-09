From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: fixup X86_MRST selects
Date: Wed, 9 Jun 2010 15:40:41 -0700
Message-ID: <201006091540.43122.dmitry.torokhov@gmail.com>
References: <20100609133443.38f1f957.sfr@canb.auug.org.au> <20100609152921.61fb7db9.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100609152921.61fb7db9.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jacob Pan <jacob.jun.pan@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, akpm <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

On Wednesday, June 09, 2010 03:29:21 pm Randy Dunlap wrote:
> +++ linux-next-20100609/drivers/input/keyboard/Kconfig
> @@ -70,9 +70,10 @@ config KEYBOARD_ATARI
>  
>  config KEYBOARD_ATKBD
>         tristate "AT keyboard" if EMBEDDED || !X86
> +       depends on !X86 || (X86 && !X86_MRST)

Should it be simply 'depends on !X86_MRST' and then we could kill
'!X86_MRST' conditionals in selects?

>         default y
>         select SERIO
> -       select SERIO_LIBPS2
> +       select SERIO_LIBPS2 if !X86_MRST
>         select SERIO_I8042 if X86 && !X86_MRST
>         select SERIO_GSCPS2 if GSC
>         help

Thanks.

-- 
Dmitry

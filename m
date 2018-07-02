From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/5] net: mac8390: Use standard memcpy_{from,to}io()
Date: Mon, 02 Jul 2018 22:39:05 +0900 (KST)
Message-ID: <20180702.223905.294108944941067854.davem@davemloft.net>
References: <20180702133532.5412-1-geert@linux-m68k.org>
        <20180702133532.5412-3-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702133532.5412-3-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: geert@linux-m68k.org
Cc: gerg@linux-m68k.org, dmitry.torokhov@gmail.com, deller@gmx.de, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon,  2 Jul 2018 15:35:29 +0200

> The mac8390 driver defines its own variants of memcpy_fromio() and
> memcpy_toio(), using similar implementations, but different function
> signatures.
> 
> Remove the custom definitions of memcpy_fromio() and memcpy_toio(), and
> adjust all callers to the standard signatures.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> This is a dependency for "m68k: Move mem*io define guards to
> <asm/kmap.h>".
> 
> Untested on real hardware, assembler output compared.

Acked-by: David S. Miller <davem@davemloft.net>

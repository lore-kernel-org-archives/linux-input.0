From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH 0/5] m68k: IO Fixes and Cleanups
Date: Tue, 3 Jul 2018 12:15:50 +1000
Message-ID: <53ec59b8-0483-6b02-6dae-9f1d44bc2c69@linux-m68k.org>
References: <20180702133532.5412-1-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702133532.5412-1-geert@linux-m68k.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, "David S . Miller" <davem@davemloft.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Geert,

On 02/07/18 23:35, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series contains fixes and cleanups for I/O accessors on m68k
> platforms (with MMU).
> 
> The first patch contains small fixes without any dependencies.
> Patches 2 and 3 make small adjustments to drivers that are dependencies
> for further cleanup.
> Patch 4 and 5 complete the cleanup.
> 
> Given the dependencies, I think it's easiest if the respective
> maintainers would provide their Acked-by, so all patches can go in
> through the m68k tree.
> 
> Thanks for your comments!

I like it alot. If we can just fix up the warnings caused by patch
number 1 I am more than happy to ack.

Regards
Greg


> Geert Uytterhoeven (5):
>    m68k/io: Add missing ioremap define guards, fix typo
>    net: mac8390: Use standard memcpy_{from,to}io()
>    Input: hilkbd - Add casts to HP9000/300 I/O accessors
>    m68k/io: Move mem*io define guards to <asm/kmap.h>
>    m68k/io: Switch mmu variant to <asm-generic/io.h>
> 
>   arch/m68k/include/asm/io.h          |  7 +++++
>   arch/m68k/include/asm/io_mm.h       | 40 +++--------------------------
>   arch/m68k/include/asm/io_no.h       | 12 ---------
>   arch/m68k/include/asm/kmap.h        |  7 ++++-
>   drivers/input/keyboard/hilkbd.c     |  4 +--
>   drivers/net/ethernet/8390/mac8390.c | 20 +++++++--------
>   6 files changed, 28 insertions(+), 62 deletions(-)
> 

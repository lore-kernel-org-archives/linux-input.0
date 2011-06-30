From: Stanislav Brabec <utx-ZsETY1VsSgLrBKCeMvbIDA@public.gmane.org>
Subject: Re: kernel panic in spi_complete() on spitz (PXA270)
Date: Thu, 30 Jun 2011 16:45:18 +0200
Message-ID: <1309445118.4406.47.camel@oct.suse.cz>
References: <1308845380.4533.54.camel@oct.suse.cz>
	<201106301352.21684.marek.vasut@gmail.com>
Reply-To: Zaurus PDA developers list <zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
In-Reply-To: <201106301352.21684.marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/zaurus-devel>,
	<mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/zaurus-devel>
List-Post: <mailto:zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/zaurus-devel>,
	<mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org
Errors-To: zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org
To: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

Marek Vasut wrote:
> On Thursday, June 23, 2011 06:09:40 PM Stanislav Brabec wrote:
> > Hallo.
> > 
> > These Oops and kernel panic were observed on a Zaurus (spitz) machine
> > (ARMv5, PXA270).
> 
> Looks similar to "Re: [PATCH v2] Input: Make ADS7846 independent on regulator"

I don't see any trace in that thread. But yes, I was testing your patch
from this thread. Without it, ADS7846 does not work on spitz (ADS7846
does not have any dedicated regulator there). I want to
add .needs_regulator bool to ads7846.c and send the patch again to the
list.

After sending the trace I was able to reproduced it several times by
attaching of external charger.

Then I tried to apply "[PATCH] MAX1111: Fix race condition causing NULL
pointer exception", connected charger that periodically disconnects and
not seen the crash again. No OOPS was seen after ~100 reconnects.

So I guess that MAX1111 AC voltage reading (via SPI) was involved in an
incorrect moment and race happened there and your MAX1111 race condition
fix fixes it.

-- 
Stanislav Brabec
http://www.penguin.cz/~utx

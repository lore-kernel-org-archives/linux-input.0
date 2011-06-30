From: Stanislav Brabec <utx-ZsETY1VsSgLrBKCeMvbIDA@public.gmane.org>
Subject: Re: kernel panic in spi_complete() on spitz (PXA270)
Date: Thu, 30 Jun 2011 18:13:26 +0200
Message-ID: <1309450406.4406.59.camel@oct.suse.cz>
References: <1308845380.4533.54.camel@oct.suse.cz>
	<201106301352.21684.marek.vasut@gmail.com>
	<1309445118.4406.47.camel@oct.suse.cz>
	<4E0C957F.8080807@compulab.co.il>
Reply-To: Zaurus PDA developers list <zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
In-Reply-To: <4E0C957F.8080807-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/zaurus-devel>,
	<mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/zaurus-devel>
List-Post: <mailto:zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/zaurus-devel>,
	<mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org
Errors-To: zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org
To: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

Igor Grinberg wrote:
> On 06/30/11 17:45, Stanislav Brabec wrote:
> I want to
> > add .needs_regulator bool to ads7846.c and send the patch again to the
> > list.
> 
> Please, don't...
> I thought we've finished discussing the regulator issue...

The discussion ended without a fix (at least for spitz). I seen two
proposals:
- As ADS7846 hardware does not require dedicated regulator, don't
  require it in driver and fail only on platforms that have a dedicated
  regulator.
- Use dummy regulators for all platforms without dedicated ADS7846
  regulator.

>1) add regulator definition for ads7846 into the board file
There is no dedicated regulator on spitz, ADS7846 uses common always-on
power supply.

>2) enable the CONFIG_REGULATOR_DUMMY in your kernel configuration
>3) use regulator_use_dummy_regulator() call in the board file.

OK, I will do 2 or 3. In the new kernel spitz has a regulator, but it is
not related to ADS7846. And it is actually broken:

I2C: i2c-0: PXA I2C adapter
Resetting I2C Controller Unit
 (null): i2c_pxa_abort: called in slave mode
i2c i2c-1: adapter [pxa_i2c-i2c.1] registered
i2c 1-000c: uevent
isl6271a 1-000c: probe
i2c i2c-1: master_xfer[0] R, addr=0x0c, len=1
i2c i2c-1: setting to bus master
i2c i2c-1: state:i2c_pxa_handler:981: ISR=00000442, ICR=000007e0, IBMR=03
i2c i2c-1: state:i2c_pxa_irq_txempty:932: ISR=00000002, ICR=000007e0, IBMR=03
i2c i2c-1: Retrying transmission
i2c i2c-1: setting to bus master
i2c i2c-1: state:i2c_pxa_handler:981: ISR=00000045, ICR=000007e1, IBMR=00
i2c i2c-1: state:i2c_pxa_irq_txempty:932: ISR=00000005, ICR=000017ee, IBMR=00
i2c i2c-1: state:i2c_pxa_handler:981: ISR=00000087, ICR=000017e6, IBMR=00
print_constraints: vcc_core range: 850 <--> 1600 mV at 1350 mV 
print_constraints: vcc_core range: 1100 mV 
isl6271a 1-000c: Failed to set supply vcc_core
isl6271a 1-000c: failed to register isl6271a
isl6271a: probe of 1-000c failed with error -16
i2c i2c-1: client [isl6271a] registered with bus id 1-000c
I2C: i2c-1: PXA I2C adapter
...
cpufreq: Didn't find vcc_core regulator

-- 
Stanislav Brabec
http://www.penguin.cz/~utx

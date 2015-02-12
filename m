From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFT/PATCH] Input: bfin_rotary - introduce open and close methods
Date: Wed, 11 Feb 2015 23:54:28 -0800
Message-ID: <20150212075428.GB7653@dtor-ws>
References: <20150206065603.GA40057@dtor-ws>
 <CAJxxZ0MGRWAduU2cdeQiU09629u=HNCu+ay62Niikhp==AgpBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:42175 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbbBLHyf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Feb 2015 02:54:35 -0500
Content-Disposition: inline
In-Reply-To: <CAJxxZ0MGRWAduU2cdeQiU09629u=HNCu+ay62Niikhp==AgpBw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Sonic Zhang <sonic.zhang@analog.com>, linux-input@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Hi Sonic,

On Fri, Feb 06, 2015 at 05:37:29PM +0800, Sonic Zhang wrote:
> Hi Dmitry,
> 
> After apply your patch manually to my blackfin kernel tree, I got
> kernel panic when probe the rotary.

Hmm, I found one potential issue that might cause panic, but it was
preexisting.... Anyway, I uploaded all bfin_rotary patches on top of
3.19 into bfin_rotary branch of my tree on kernel.org, can you please
grab them from there and try again?

Thanks!

> 
> NULL pointer access
> Kernel OOPS in progress
> Deferred Exception context
> CURRENT PROCESS:
> COMM=swapper PID=1  CPU=0
> invalid mm
> return address: [0x00167648]; contents of:
> 0x00167620:  f000  b068  0a08  1807  3038  3007  e801  0000
> 0x00167630:  05b3  0010  3044  6001  e3fc  da5a  b0a8  0c80
> 0x00167640:  191b  0000  6802  6000 [e511] 0075  ac4a  9710
> 0x00167650:  ac4a  6c22  9710  a3a2  a0a9  0c02  18ec  cc00
> 
> CPU: 0 PID: 1 Comm: swapper Not tainted
> 3.17.0-ADI-2014R1-pre-00455-ga5d060e-dirty #5
> task: 04025a20 ti: 04026000 task.ti: 04026000
> Compiled for cpu family 0x27fe (Rev 0), but running on:0x0000 (Rev 0)
> ADSP-BF609-0.0 500(MHz CCLK) 125(MHz SCLK) (mpu off)
> Linux version 3.17.0-ADI-2014R1-pre-00455-ga5d060e-dirty (sonic@nine)
> (gcc version 4.3.5 (ADI-mast5
> 
> SEQUENCER STATUS:               Not tainted
>  SEQSTAT: 00000027  IPEND: 8008  IMASK: ffff  SYSCFG: 2806
>   EXCAUSE   : 0x27
>   physical IVG3 asserted : <0xffa00744> { _trap + 0x0 }
>   physical IVG15 asserted : <0xffa00d68> { _evt_system_call + 0x0 }
>   logical irq   6 mapped  : <0xffa003bc> { _bfin_coretmr_interrupt + 0x0 }
>   logical irq   7 mapped  : <0x00008858> { _bfin_fault_routine + 0x0 }
>   logical irq  11 mapped  : <0x00007754> { _l2_ecc_err + 0x0 }
>   logical irq  13 mapped  : <0x00008858> { _bfin_fault_routine + 0x0 }
>   logical irq  39 mapped  : <0x0016a350> { _bfin_twi_interrupt_entry + 0x0 }
>   logical irq  40 mapped  : <0x0016a350> { _bfin_twi_interrupt_entry + 0x0 }
>   logical irq  62 mapped  : <0x00132438> { _adi_spi_tx_dma_isr + 0x0 }
>   logical irq  63 mapped  : <0x00132784> { _adi_spi_rx_dma_isr + 0x0 }
>   logical irq  64 mapped  : <0x0013282c> { _spi_irq_err + 0x0 }
>   logical irq  65 mapped  : <0x00132438> { _adi_spi_tx_dma_isr + 0x0 }
>   logical irq  66 mapped  : <0x00132784> { _adi_spi_rx_dma_isr + 0x0 }
>   logical irq  67 mapped  : <0x0013282c> { _spi_irq_err + 0x0 }
>  RETE: <0x00000000> /* Maybe null pointer? */
>  RETN: <0x04027cf4> /* kernel dynamic memory (maybe user-space) */
>  RETX: <0x00000480> /* Maybe fixed code section */
>  RETS: <0x0016763c> { _bfin_rotary_probe + 0x54 }
>  PC  : <0x00167648> { _bfin_rotary_probe + 0x60 }
> DCPLB_FAULT_ADDR: <0x000001d4> /* Maybe null pointer? */
> ICPLB_FAULT_ADDR: <0x00167648> { _bfin_rotary_probe + 0x60 }
> PROCESSOR STATE:
>  R0 : 00000000    R1 : 00000000    R2 : 00000400    R3 : 00000001
>  R4 : 0030c310    R5 : 002d6680    R6 : 002e7bd8    R7 : 00000000
>  P0 : 00000002    P1 : 002e86ac    P2 : 00000000    P3 : 002e8690
>  P4 : 002e7bcc    P5 : 0409930c    FP : 04027d10    SP : 04027c18
>  LB0: ffa015b8    LT0: ffa015b8    LC0: 00000000
>  LB1: 00094072    LT1: 00094062    LC1: 00000000
>  B0 : 0000001f    L0 : 00000000    M0 : 0402a400    I0 : 04027c44
>  B1 : 0000000e    L1 : 00000000    M1 : 002fa814    I1 : 0407846c
>  B2 : 00000020    L2 : 00000000    M2 : 00000000    I2 : 04028ac8
>  B3 : 0022aa6c    L3 : 00000000    M3 : 00000000    I3 : 0000001a
> A0.w: 00000000   A0.x: 00000000   A1.w: 00000000   A1.x: 00000000
> USP : 00000000  ASTAT: 02003004
> 
> Hardware Trace:
>    0 Target : <0x00003fe8> { _trap_c + 0x0 }
>      Source : <0xffa006d8> { _exception_to_level5 + 0xa0 } JUMP.L
>    1 Target : <0xffa00638> { _exception_to_level5 + 0x0 }
>      Source : <0xffa004f2> { _bfin_return_from_exception + 0x6 } RTX
>    2 Target : <0xffa004ec> { _bfin_return_from_exception + 0x0 }
>      Source : <0xffa00590> { _ex_trap_c + 0x70 } JUMP.S
>    3 Target : <0xffa00520> { _ex_trap_c + 0x0 }
>      Source : <0xffa0076e> { _trap + 0x2a } JUMP (P4)
>    4 Target : <0xffa00744> { _trap + 0x0 }
>       FAULT : <0x00167648> { _bfin_rotary_probe + 0x60 } P1 = [P2 + -0x54]
>      Source : <0x00167646> { _bfin_rotary_probe + 0x5e } 0x6000
>    5 Target : <0x0016763c> { _bfin_rotary_probe + 0x54 }
>      Source : <0x00102b50> { _platform_get_irq + 0x64 } RTS
>    6 Target : <0x00102b44> { _platform_get_irq + 0x58 }
>      Source : <0x00102b2c> { _platform_get_irq + 0x40 } IF CC JUMP pcrel
>    7 Target : <0x00102b0a> { _platform_get_irq + 0x1e }
>      Source : <0x00102b28> { _platform_get_irq + 0x3c } IF !CC JUMP pcrel (BP)
>    8 Target : <0x00102b14> { _platform_get_irq + 0x28 }
>      Source : <0x00102b08> { _platform_get_irq + 0x1c } JUMP.S
>    9 Target : <0x00102aec> { _platform_get_irq + 0x0 }
>      Source : <0x00167638> { _bfin_rotary_probe + 0x50 } JUMP.L
>   10 Target : <0x00167634> { _bfin_rotary_probe + 0x4c }
>      Source : <0x00167626> { _bfin_rotary_probe + 0x3e } IF CC JUMP pcrel
>   11 Target : <0x0016761e> { _bfin_rotary_probe + 0x36 }
>      Source : <0x000d9c04> { _devm_ioremap_resource + 0x38 } RTS
>   12 Target : <0x000d9bfe> { _devm_ioremap_resource + 0x32 }
>      Source : <0x000d9c46> { _devm_ioremap_resource + 0x7a } IF !CC
> JUMP pcrel (BP)
>   13 Target : <0x000d9c44> { _devm_ioremap_resource + 0x78 }
>      Source : <0x000d9b58> { _devm_ioremap_nocache + 0x3c } RTS
>   14 Target : <0x000d9b50> { _devm_ioremap_nocache + 0x34 }
>      Source : <0x00103bc8> { _devres_add + 0x48 } RTS
>   15 Target : <0x00103b9c> { _devres_add + 0x1c }
>      Source : <0x00103b96> { _devres_add + 0x16 } IF CC JUMP pcrel
> Kernel Stack
> Stack info:
>  SP: [0x04027d58] <0x04027d58> /* kernel dynamic memory (maybe user-space) */
>  Memory from 0x04027d50 to 04028000
> 04027d50: 000cda8c  0447f160 [04027d84] 00101cb4  002e7bd8  00301794
> 002fab6c  002e7c0c
> 04027d70: 04027da4  00301794  0030c310  04027da8  000cddc0  04027dac
> <00100950> 00101c4c
> 04027d90: 00301794  00000000  00000000  00000000  04027dec  040225ac
> 04070af0  04027dd4
> 04027db0: 0010199a  0447f160  048a7d80  002c6018  00000000  04027df0
> 04027dec  04027df0
> 04027dd0: 00101c4c  04027df0  00100f50  04027dfc  001020d8  00301794
> 002788e0  00271bb8
> 04027df0: 04027e14  001021ba  00301794  002e5234  00319710  048a7d80
> 04027e54  00273210
> 04027e10: 048a7d80  04027e30  00102f8e  002e5234  048a7d80  000d4b8a
> 04027ea0  0000105a
> 04027e30: 04027e44  00319722  00319710  048a7d80  002c6018  04027ea0
> <0000106e><00100100>
> 04027e50: 00200200  00319710  00000000  04027e94  04027e00  0030c322
> 04027e98  00026130
> 04027e70: 00325c64  04027e9c <0001bcde> 00000063  0081453f  002ea330
> 00216528  00000000
> 04027e90: 00000000  00000006  00000006  04027edc  04027edc  0030c28e
> 00325ef0  0031fc48
> 04027eb0: 0031fc28  00000007  002c6018  00000063  00291fb0  a8824141
> 002c56e0  00000063
> 04027ed0: 00000006  00000006  0030c310  04027f0c  0021402e  00216528
> 04025a20  040256e0
> 04027ef0: 040258c8  002ea284  002ea330  00216528  ffa00006  00216528
> 040258c8  0402feb0
> 04027f10:<ffa00014> 00216528  28060484  00214024  00000000  00000000
> 00008000  00000000
> 04027f30: 00000000  00000000  00000000  00000000  00000000  00000000
> 00000000  00000000
> 04027f50: 00000000  00000000  00000000  00000000  00000000  00000000
> 00000000  00000000
> 04027f70: 00000000  00000000  00000000  00000000  00000000  00000000
> 00000000  00000000
> 04027f90: 00000000  00000000  00000000  00000000  00000000  00000000
> 00000000  00000000
> 04027fb0: 00000000  00000000  00000000  00000000  00000000  00000000
> 00000000  00000000
> 04027fd0: 00000000  00000000  00000000  00000000  00000000  00000000
> 00000000  00000000
> 04027ff0: 00000000  00000000  ffffffff  00002806
> Return addresses in stack:
>     address : <0x00100950> { _bus_for_each_dev + 0x5c }
>     address : <0x0000106e> { _do_one_initcall + 0x6e }
>     address : <0x00100100> { _device_add + 0x3b4 }
>     address : <0x0001bcde> { _parse_args + 0x12e }
>     address : <0xffa00014> { _ret_from_fork + 0x14 }
> Modules linked in:
> Kernel panic - not syncing: Kernel exception
> ---[ end Kernel panic - not syncing: Kernel exception
> 
> 
> Regards,
> 
> Sonic Zhang

-- 
Dmitry

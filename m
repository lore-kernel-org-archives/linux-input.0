Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924307;
	b=lQwm1uPZ0GHvNtmLy6VEPJVdE01m7gf2nyx9WyqPJNZmkK5wqn39LufdMI5XAbhhB7iQ
	 WFmipSca9zFADn+9xtDhxe+WL2xhsLDN0TqZ75WNHdQLEkNDCPsc3EwD8YyOW64J+cQ4v
	 fG/1bhIdPTyLkK5OuxhugGrxEQAb5H2LRtF0t8zK4tU50N3nfAHwiyPgrLSQN1dcO9AwZ
	 lMXqMfqYN6bnfQDzqZfr+qzrgh+JRiUL7hM0ahLSDEetLlngcguc+4jASIG5qk1If7m+O
	 l2P3xVEcmQ6wuguht/ZBiqUmtvvpsOzV7ujR3LPhr/WvLo9ukBqolfIWQ5DFMvDeGcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924307;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=coQw/pjKP5s+yblH7PMp+lJnV2E2rZhvzsYmHLQwVOQ=;
	b=jvrfvc6Sg9ET9Qa1DyVOeoD0hlg8kpCTd6eSExhOcpSOz3sZjTSF3B27I2YbwPLnJVpY
	 MMDwXPJE6AfCFoR2UWWlcMJMIe6yNld118W4z8wQLHon4XVw1kvftXbetn/tmpdgKYrdM
	 9TCbEjq8f8BPeSlZRRh2aBE8Gl5Ygyl4IwM5Lx7CgOIumoT98wuCx/jbodFx4aIDTzklU
	 wGXwMkWZSEI1rMA4JHDnumq4//smUGk1ZHKmPztfW0ZlNxFF5wPvuLdsbwR80mdiPb3xh
	 VTQN311UThwna9QaaKLtpDpNg9LXFtUYZ6amj/b0U45vYEmbbxWX0Jjk0PNJLf2taCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLFf8uoQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA3606A896;
	Tue, 17 Nov 2026 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLFf8uoQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186FF1F000C7;
	Tue, 17 Nov 2026 14:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924307;
	bh=coQw/pjKP5s+yblH7PMp+lJnV2E2rZhvzsYmHLQwVOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QLFf8uoQaCvzNQPhWl3jEanWjUD657Ksl7ZzS5r6R7+f8bA6ToKxQIRiJCsQdmWOE
	 F4gvMM6X2hyBkb7LYdG0JgNyquET78KF66d4PndQFObVMTQ9Yxg3rWjrq8jau1GuWq
	 2xKL0Pq2eNUeU3ckpj11fTkpHbq9k/gf8Uo3m7u+6Z2gRo+oyW4+fyyoGp9HuLGMkW
	 5C5i27F7g4UPIeMzwq41XRC3h+hoSdOLGddN+T6kDspsr5xAZCq/TTrgBXjx/uY8MW
	 mXDNHkk1ljNz5dtPfbnnIIgy2xsMTsnqOWnqLUJpvPDolLko4etqUqc/W2c9F5vYLu
	 Y7PHKbEd1+BrQ==
Message-ID: <sashiko-outbox-218920@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 6/6] ARM: add the SiRF AT550 platform and YPL514si
 board
Reply-To: sashiko-reviews@lists.linux.dev
To: yy-Local-LLM <yogo.0917.sabu@gmail.com>, devicetree@vger.kernel.org
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117-at550-rfc-v1-v1-6-5879573cb825@gmail.com>
References: <20261117-at550-rfc-v1-v1-0-5879573cb825@gmail.com>
 <20261117-at550-rfc-v1-v1-6-5879573cb825@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:05:06 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] ARM: at550: non-real name yy-Local-LLM in Signed-off-by and
  MAINTAINERS
- [High] ARM: at550: ARCH_AT550 selects CPU_V6 without !SMP dependency
  in Kconfig
- [High] ARM: dts: at550: /memreserve/ causes ioremap_wc() failure in
  simplefb_probe()
- [Low] ARM: at550_defconfig: missing CONFIG_ARCH_MULTI_V7 disablement
- [Low] ARM: dts: unsorted subdir-y entry and missing newline in
  Makefile
--

commit 77bddca305316e26eed799b27f4f024275217704
Author: yy-Local-LLM <yogo.0917.sabu@gmail.com>

> ARM: add the SiRF AT550 platform and YPL514si board
>
> Add a minimal DT machine using standard IRQ, timer and simplefb paths.
> Describe the SoC and the firmware-configured YPL514si display. Leave
> usable memory and the divided counter rate for the bootloader to
> populate. Keep optional peripheral nodes disabled until firmware hands
> them over. Disable unvalidated board suspend; limit this board to SD PIO
> at 25 MHz. Document the RAM-boot contract and the missing
> cold-boot/clock-tree support.
>
> Signed-off-by: yy-Local-LLM <yogo.0917.sabu@gmail.com>

[Severity: High]
Documentation/process/submitting-patches.rst requires a real full human
name in the Signed-off-by trailer and in MAINTAINERS rather than a handle
or bot name (yy-Local-LLM).

[ ... ]

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 28fba538d5520..a4844a80b8d08 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -40,3 +40,5 @@ subdir-y +=3D vt8500
>  subdir-y +=3D xen
>  subdir-y +=3D xilinx
>  subdir-y +=3D zte
> +
> +subdir-y +=3D sirf
> \ No newline at end of file

[Severity: Low]
This isn't a bug, but the vendor subdirectories in this Makefile are kept
in alphabetical order (between sigmastar and socionext), without a blank
line, and the file is missing a trailing newline.

[ ... ]

> diff --git a/arch/arm/boot/dts/sirf/at550-ypl514si.dts b/arch/arm/boot/dt=
s/sirf/at550-ypl514si.dts
> new file mode 100644
> index 0000000000000..d45328fa09e82
> --- /dev/null
> +++ b/arch/arm/boot/dts/sirf/at550-ypl514si.dts
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/dts-v1/;
> +/memreserve/ 0xc0100000 0x40000;
> +#include "at550.dtsi"
> +
> +/ {
> +	model =3D "Yupiteru YPL514si";
> +	compatible =3D "yupiteru,ypl514si", "sirf,at550";
> +
> +	memory@c0000000 {
> +		device_type =3D "memory";
> +		/* The bootloader supplies the region allocated for Linux. */
> +		reg =3D <0xc0000000 0>;
> +	};
> +
> +	chosen {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		framebuffer@c0100000 {
> +			compatible =3D "simple-framebuffer";
> +			reg =3D <0xc0100000 0x3fc00>;
> +			width =3D <480>;
> +			height =3D <272>;
> +			stride =3D <960>;
> +			format =3D "r5g6b5";
> +			status =3D "disabled";
> +		};
> +	};
> +};

[Severity: High]
Will reserving the framebuffer with /memreserve/ cause simplefb_probe() to
fail on 32-bit arm?

/memreserve/ only calls memblock_reserve() without setting MEMBLOCK_NOMAP,
so map_lowmem() still maps 0xc0100000 into the kernel linear mapping when
memory@c0000000 covers that range.  When simplefb_probe() then calls
ioremap_wc(), __arm_ioremap_pfn_caller() hits a WARN_ON() and returns NULL
to reject the mismatched memory attribute alias, failing probe with
-ENOMEM:

arch/arm/mm/ioremap.c:__arm_ioremap_pfn_caller() {
    ...
	if (WARN_ON(memblock_is_map_memory(PFN_PHYS(pfn)) &&
		    mtype !=3D MT_MEMORY_RW))
		return NULL;
    ...
}

Reserving the region via a /reserved-memory child node with the no-map
property excludes it from the linear mapping so ioremap_wc() succeeds.

[ ... ]

> diff --git a/arch/arm/configs/at550_defconfig b/arch/arm/configs/at550_de=
fconfig
> new file mode 100644
> index 0000000000000..698b2f67574d0
> --- /dev/null
> +++ b/arch/arm/configs/at550_defconfig
> @@ -0,0 +1,34 @@
> +# CONFIG_LOCALVERSION_AUTO is not set
> +CONFIG_SYSVIPC=3Dy
> +CONFIG_NO_HZ_IDLE=3Dy
> +CONFIG_HIGH_RES_TIMERS=3Dy
> +CONFIG_BLK_DEV_INITRD=3Dy
> +CONFIG_ARCH_MULTI_V6=3Dy
> +CONFIG_ARCH_AT550=3Dy

[Severity: Low]
Should at550_defconfig explicitly disable CONFIG_ARCH_MULTI_V7?

ARCH_MULTI_V7 defaults to y in arch/arm/Kconfig.platforms, so omitting
"# CONFIG_ARCH_MULTI_V7 is not set" leaves CPU_V7, HAVE_SMP, multi-CPU/TLB
dispatch, and a 64-byte L1 cache line shift enabled for this single-core
ARM1136 target.

[ ... ]

> diff --git a/arch/arm/mach-at550/Kconfig b/arch/arm/mach-at550/Kconfig
> new file mode 100644
> index 0000000000000..c6380e529641d
> --- /dev/null
> +++ b/arch/arm/mach-at550/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config ARCH_AT550
> +	bool "SiRF AT550 platforms"
> +	depends on ARCH_MULTI_V6
> +	select ARM_ERRATA_411920
> +	select AT550_IRQ
> +	select CLKSRC_AT550
> +	select CPU_V6

[Severity: High]
Does selecting CPU_V6 without a !SMP dependency break multiplatform SMP
builds?

In arch/arm/mm/Kconfig, CPU_V6 depends on !SMP.  Enabling CONFIG_ARCH_AT550
in a configuration with CONFIG_SMP=3Dy (such as allmodconfig or a combined
v6/v7 multiplatform kernel) triggers an unmet direct dependency warning for
CPU_V6 and compiles out 1-byte and 2-byte __arch_xchg() and 2-byte
__cmpxchg() in arch/arm/include/asm/cmpxchg.h, causing link failures with
undefined references to __bad_xchg and __bad_cmpxchg (and smp_on_up when
CONFIG_SMP_ON_UP=3Dn).

Other ARM1136 platforms either select CPU_ARM1136R1 (which selects CPU_V6K)
or depend on !SMP when selecting CPU_ARM1136R0 / CPU_V6.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-at550-rfc-=
v1-v1-0-5879573cb825@gmail.com?part=3D6

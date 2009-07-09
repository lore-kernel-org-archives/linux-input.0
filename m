From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v2] input:Add clk api support for w90p910 touchscreen
Date: Thu, 09 Jul 2009 17:23:18 +0800
Message-ID: <4A55B706.60801@gmail.com>
References: <4A555B9E.8060508@gmail.com>
	<20090709051143.GA14516@dtor-d630.eng.vmware.com>
	<4A557CBC.3000507@gmail.com>
	<20090709062929.GD14516@dtor-d630.eng.vmware.com>
	<20090709073703.GA1785@jasper.tkos.co.il>
	<20090709085436.GE14516@dtor-d630.eng.vmware.com>
	<4A55B1B7.3090802@gmail.com>
	<20090709090606.GA30597@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090709090606.GA30597@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Baruch Siach <baruch@tkos.co.il>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input@vger.kernel.org, Trilok Soni <soni.trilok@gmail.com>
List-Id: linux-input@vger.kernel.org

Dear Russell,


>>>>> Umm, one more thing - we need to add "depends on" to Kconfig since
>>>>> clk API is not implemented on every platform. Any ideas what is the
>>>>> most wide dependency is?
>>>> The most wide dependency for the clk API is HAVE_CLK.
>>>>
>>> Cool, thanks.
>>>
>> Sure, but why to add it to touchscreen's kconfig?
>> it seems it should be put arch/arm/kconfig.
>>
>> In addition,I never use this HAVE_CLK in ARCH_W90X900, 
>> only using COMMON_CLKDEV to support clk API. 
> 
> HAVE_CLK is the configuration symbol which tells the rest of the kernel
> configuration system that the clk API is available.  Drivers using the
> clk API should depend on HAVE_CLK.
> 
> COMMON_CLKDEV is just one implementation of a subset of the clk API, and
> nothing should ever depend on this symbol.
> 
 Maybe I should add this "select HAVE_CLK" to arch/arm/Kconfig too, as following:

config ARCH_W90X900
	bool "Nuvoton W90X900 CPU"
	select CPU_ARM926T
	select ARCH_REQUIRE_GPIOLIB
	select GENERIC_GPIO
	select COMMON_CLKDEV
	select HAVE_CLK

Is it right?

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php

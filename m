From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH v2 2/5] x86: add enum for hypervisors to replace x86_hyper
Date: Fri, 10 Nov 2017 20:39:14 +0000
Message-ID: <DM5PR21MB047609826D9C166EC6359E98A0540@DM5PR21MB0476.namprd21.prod.outlook.com>
References: <20171109132739.23465-1-jgross@suse.com>
 <20171109132739.23465-3-jgross@suse.com>
 <20171110182611.maikfgykek7y6xww@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20171110182611.maikfgykek7y6xww@dtor-ws>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Juergen Gross <jgross@suse.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "akataria@vmware.com" <akataria@vmware.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Stephen Hemminger <sthemmin@microsoft.com>, "x86@kernel.org" <x86@kernel.org>, "moltmann@vmware.com" <moltmann@vmware.com>, "mingo@redhat.com" <mingo@redhat.com>, "linux-graphics-maintainer@vmware.com" <linux-graphics-maintainer@vmware.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "arnd@arndb.de" <arnd@arndb.de>, "xdeguillard@vmware.com" <xdeguillard@vmware.com>, Haiyang Zhang <haiyangz@microsoft.com>, "pbonzini@redhat.com" <pbonzini@redhat.>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Friday, November 10, 2017 10:26 AM
> To: Juergen Gross <jgross@suse.com>
> Cc: linux-kernel@vger.kernel.org; tglx@linutronix.de; mingo@redhat.com;
> hpa@zytor.com; x86@kernel.org; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; akataria@vmware.com;
> pbonzini@redhat.com; rkrcmar@redhat.com; boris.ostrovsky@oracle.com;
> devel@linuxdriverproject.org; virtualization@lists.linux-foundation.org;
> kvm@vger.kernel.org; xen-devel@lists.xenproject.org; linux-graphics-
> maintainer@vmware.com; pv-drivers@vmware.com;
> xdeguillard@vmware.com; moltmann@vmware.com; arnd@arndb.de;
> gregkh@linuxfoundation.org; linux-input@vger.kernel.org
> Subject: Re: [PATCH v2 2/5] x86: add enum for hypervisors to replace
> x86_hyper
> 
> On Thu, Nov 09, 2017 at 02:27:36PM +0100, Juergen Gross wrote:
> > The x86_hyper pointer is only used for checking whether a virtual
> > device is supporting the hypervisor the system is running on.
> >
> > Use an enum for that purpose instead and drop the x86_hyper pointer.
> >
> > Cc: kys@microsoft.com
> > Cc: haiyangz@microsoft.com
> > Cc: sthemmin@microsoft.com
> > Cc: akataria@vmware.com
> > Cc: pbonzini@redhat.com
> > Cc: rkrcmar@redhat.com
> > Cc: boris.ostrovsky@oracle.com
> > Cc: devel@linuxdriverproject.org
> > Cc: virtualization@lists.linux-foundation.org
> > Cc: kvm@vger.kernel.org
> > Cc: xen-devel@lists.xenproject.org
> > Cc: linux-graphics-maintainer@vmware.com
> > Cc: pv-drivers@vmware.com
> > Cc: dmitry.torokhov@gmail.com
> > Cc: xdeguillard@vmware.com
> > Cc: moltmann@vmware.com
> > Cc: arnd@arndb.de
> > Cc: gregkh@linuxfoundation.org
> > Cc: linux-input@vger.kernel.org
> >
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > ---
> >  arch/x86/hyperv/hv_init.c         |  2 +-
> >  arch/x86/include/asm/hypervisor.h | 23 ++++++++++++++---------
> >  arch/x86/kernel/cpu/hypervisor.c  | 12 +++++++++---
> >  arch/x86/kernel/cpu/mshyperv.c    |  4 ++--
> >  arch/x86/kernel/cpu/vmware.c      |  4 ++--
> >  arch/x86/kernel/kvm.c             |  4 ++--
> >  arch/x86/xen/enlighten_hvm.c      |  4 ++--
> >  arch/x86/xen/enlighten_pv.c       |  4 ++--
> >  drivers/hv/vmbus_drv.c            |  2 +-
> >  drivers/input/mouse/vmmouse.c     | 10 ++++------
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>

> 
> >  drivers/misc/vmw_balloon.c        |  2 +-
> >  11 files changed, 40 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index a5db63f728a2..a0b86cf486e0 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -113,7 +113,7 @@ void hyperv_init(void)
> >  	u64 guest_id;
> >  	union hv_x64_msr_hypercall_contents hypercall_msr;
> >
> > -	if (x86_hyper != &x86_hyper_ms_hyperv)
> > +	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
> >  		return;
> >
> >  	/* Allocate percpu VP index */
> > diff --git a/arch/x86/include/asm/hypervisor.h
> b/arch/x86/include/asm/hypervisor.h
> > index 0eca7239a7aa..1b0a5abcd8ae 100644
> > --- a/arch/x86/include/asm/hypervisor.h
> > +++ b/arch/x86/include/asm/hypervisor.h
> > @@ -29,6 +29,16 @@
> >  /*
> >   * x86 hypervisor information
> >   */
> > +
> > +enum x86_hypervisor_type {
> > +	X86_HYPER_NATIVE = 0,
> > +	X86_HYPER_VMWARE,
> > +	X86_HYPER_MS_HYPERV,
> > +	X86_HYPER_XEN_PV,
> > +	X86_HYPER_XEN_HVM,
> > +	X86_HYPER_KVM,
> > +};
> > +
> >  struct hypervisor_x86 {
> >  	/* Hypervisor name */
> >  	const char	*name;
> > @@ -36,6 +46,9 @@ struct hypervisor_x86 {
> >  	/* Detection routine */
> >  	uint32_t	(*detect)(void);
> >
> > +	/* Hypervisor type */
> > +	enum x86_hypervisor_type type;
> > +
> >  	/* init time callbacks */
> >  	struct x86_hyper_init init;
> >
> > @@ -43,15 +56,7 @@ struct hypervisor_x86 {
> >  	struct x86_hyper_runtime runtime;
> >  };
> >
> > -extern const struct hypervisor_x86 *x86_hyper;
> > -
> > -/* Recognized hypervisors */
> > -extern const struct hypervisor_x86 x86_hyper_vmware;
> > -extern const struct hypervisor_x86 x86_hyper_ms_hyperv;
> > -extern const struct hypervisor_x86 x86_hyper_xen_pv;
> > -extern const struct hypervisor_x86 x86_hyper_xen_hvm;
> > -extern const struct hypervisor_x86 x86_hyper_kvm;
> > -
> > +extern enum x86_hypervisor_type x86_hyper_type;
> >  extern void init_hypervisor_platform(void);
> >  #else
> >  static inline void init_hypervisor_platform(void) { }
> > diff --git a/arch/x86/kernel/cpu/hypervisor.c
> b/arch/x86/kernel/cpu/hypervisor.c
> > index 22226c1bf092..bea8d3e24f50 100644
> > --- a/arch/x86/kernel/cpu/hypervisor.c
> > +++ b/arch/x86/kernel/cpu/hypervisor.c
> > @@ -26,6 +26,12 @@
> >  #include <asm/processor.h>
> >  #include <asm/hypervisor.h>
> >
> > +extern const struct hypervisor_x86 x86_hyper_vmware;
> > +extern const struct hypervisor_x86 x86_hyper_ms_hyperv;
> > +extern const struct hypervisor_x86 x86_hyper_xen_pv;
> > +extern const struct hypervisor_x86 x86_hyper_xen_hvm;
> > +extern const struct hypervisor_x86 x86_hyper_kvm;
> > +
> >  static const __initconst struct hypervisor_x86 * const hypervisors[] =
> >  {
> >  #ifdef CONFIG_XEN_PV
> > @@ -41,8 +47,8 @@ static const __initconst struct hypervisor_x86 * const
> hypervisors[] =
> >  #endif
> >  };
> >
> > -const struct hypervisor_x86 *x86_hyper;
> > -EXPORT_SYMBOL(x86_hyper);
> > +enum x86_hypervisor_type x86_hyper_type;
> > +EXPORT_SYMBOL(x86_hyper_type);
> >
> >  static inline const struct hypervisor_x86 * __init
> >  detect_hypervisor_vendor(void)
> > @@ -87,6 +93,6 @@ void __init init_hypervisor_platform(void)
> >  	copy_array(&h->init, &x86_init.hyper, sizeof(h->init));
> >  	copy_array(&h->runtime, &x86_platform.hyper, sizeof(h-
> >runtime));
> >
> > -	x86_hyper = h;
> > +	x86_hyper_type = h->type;
> >  	x86_init.hyper.init_platform();
> >  }
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c
> b/arch/x86/kernel/cpu/mshyperv.c
> > index 6bb84d655e4b..85eb5fc180c8 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -254,9 +254,9 @@ static void __init ms_hyperv_init_platform(void)
> >  #endif
> >  }
> >
> > -const __refconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
> > +const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
> >  	.name			= "Microsoft Hyper-V",
> >  	.detect			= ms_hyperv_platform,
> > +	.type			= X86_HYPER_MS_HYPERV,
> >  	.init.init_platform	= ms_hyperv_init_platform,
> >  };
> > -EXPORT_SYMBOL(x86_hyper_ms_hyperv);
> > diff --git a/arch/x86/kernel/cpu/vmware.c
> b/arch/x86/kernel/cpu/vmware.c
> > index 4804c1d063c8..8e005329648b 100644
> > --- a/arch/x86/kernel/cpu/vmware.c
> > +++ b/arch/x86/kernel/cpu/vmware.c
> > @@ -205,10 +205,10 @@ static bool __init
> vmware_legacy_x2apic_available(void)
> >  	       (eax & (1 << VMWARE_PORT_CMD_LEGACY_X2APIC)) != 0;
> >  }
> >
> > -const __refconst struct hypervisor_x86 x86_hyper_vmware = {
> > +const __initconst struct hypervisor_x86 x86_hyper_vmware = {
> >  	.name			= "VMware",
> >  	.detect			= vmware_platform,
> > +	.type			= X86_HYPER_VMWARE,
> >  	.init.init_platform	= vmware_platform_setup,
> >  	.init.x2apic_available	= vmware_legacy_x2apic_available,
> >  };
> > -EXPORT_SYMBOL(x86_hyper_vmware);
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 9dca8437c795..a94de09edbed 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -544,12 +544,12 @@ static uint32_t __init kvm_detect(void)
> >  	return kvm_cpuid_base();
> >  }
> >
> > -const struct hypervisor_x86 x86_hyper_kvm __refconst = {
> > +const __initconst struct hypervisor_x86 x86_hyper_kvm = {
> >  	.name			= "KVM",
> >  	.detect			= kvm_detect,
> > +	.type			= X86_HYPER_KVM,
> >  	.init.x2apic_available	= kvm_para_available,
> >  };
> > -EXPORT_SYMBOL_GPL(x86_hyper_kvm);
> >
> >  static __init int activate_jump_labels(void)
> >  {
> > diff --git a/arch/x86/xen/enlighten_hvm.c
> b/arch/x86/xen/enlighten_hvm.c
> > index 7b1622089f96..754d5391d9fa 100644
> > --- a/arch/x86/xen/enlighten_hvm.c
> > +++ b/arch/x86/xen/enlighten_hvm.c
> > @@ -226,12 +226,12 @@ static uint32_t __init xen_platform_hvm(void)
> >  	return xen_cpuid_base();
> >  }
> >
> > -const struct hypervisor_x86 x86_hyper_xen_hvm = {
> > +const __initconst struct hypervisor_x86 x86_hyper_xen_hvm = {
> >  	.name                   = "Xen HVM",
> >  	.detect                 = xen_platform_hvm,
> > +	.type			= X86_HYPER_XEN_HVM,
> >  	.init.init_platform     = xen_hvm_guest_init,
> >  	.init.x2apic_available  = xen_x2apic_para_available,
> >  	.init.init_mem_mapping	= xen_hvm_init_mem_mapping,
> >  	.runtime.pin_vcpu       = xen_pin_vcpu,
> >  };
> > -EXPORT_SYMBOL(x86_hyper_xen_hvm);
> > diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> > index 69d1a7054ddb..168efb2534c0 100644
> > --- a/arch/x86/xen/enlighten_pv.c
> > +++ b/arch/x86/xen/enlighten_pv.c
> > @@ -1460,9 +1460,9 @@ static uint32_t __init xen_platform_pv(void)
> >  	return 0;
> >  }
> >
> > -const struct hypervisor_x86 x86_hyper_xen_pv = {
> > +const __initconst struct hypervisor_x86 x86_hyper_xen_pv = {
> >  	.name                   = "Xen PV",
> >  	.detect                 = xen_platform_pv,
> > +	.type			= X86_HYPER_XEN_PV,
> >  	.runtime.pin_vcpu       = xen_pin_vcpu,
> >  };
> > -EXPORT_SYMBOL(x86_hyper_xen_pv);
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 937801ac2fe0..2cd134dd94d2 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1534,7 +1534,7 @@ static int __init hv_acpi_init(void)
> >  {
> >  	int ret, t;
> >
> > -	if (x86_hyper != &x86_hyper_ms_hyperv)
> > +	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
> >  		return -ENODEV;
> >
> >  	init_completion(&probe_event);
> > diff --git a/drivers/input/mouse/vmmouse.c
> b/drivers/input/mouse/vmmouse.c
> > index 0f586780ceb4..1ae5c1ef3f5b 100644
> > --- a/drivers/input/mouse/vmmouse.c
> > +++ b/drivers/input/mouse/vmmouse.c
> > @@ -316,11 +316,9 @@ static int vmmouse_enable(struct psmouse
> *psmouse)
> >  /*
> >   * Array of supported hypervisors.
> >   */
> > -static const struct hypervisor_x86 *vmmouse_supported_hypervisors[] =
> {
> > -	&x86_hyper_vmware,
> > -#ifdef CONFIG_KVM_GUEST
> > -	&x86_hyper_kvm,
> > -#endif
> > +static enum x86_hypervisor_type vmmouse_supported_hypervisors[] = {
> > +	X86_HYPER_VMWARE,
> > +	X86_HYPER_KVM,
> >  };
> >
> >  /**
> > @@ -331,7 +329,7 @@ static bool vmmouse_check_hypervisor(void)
> >  	int i;
> >
> >  	for (i = 0; i < ARRAY_SIZE(vmmouse_supported_hypervisors); i++)
> > -		if (vmmouse_supported_hypervisors[i] == x86_hyper)
> > +		if (vmmouse_supported_hypervisors[i] == x86_hyper_type)
> >  			return true;
> >
> >  	return false;
> > diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> > index 1e688bfec567..9047c0a529b2 100644
> > --- a/drivers/misc/vmw_balloon.c
> > +++ b/drivers/misc/vmw_balloon.c
> > @@ -1271,7 +1271,7 @@ static int __init vmballoon_init(void)
> >  	 * Check if we are running on VMware's hypervisor and bail out
> >  	 * if we are not.
> >  	 */
> > -	if (x86_hyper != &x86_hyper_vmware)
> > +	if (x86_hyper_type != X86_HYPER_VMWARE)
> >  		return -ENODEV;
> >
> >  	for (is_2m_pages = 0; is_2m_pages <
> VMW_BALLOON_NUM_PAGE_SIZES;
> > --
> > 2.12.3
> >
> 
> --
> Dmitry

From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 0/5] x86/xen: support booting PVH guest via standard boot
	path
Date: Thu,  9 Nov 2017 14:27:34 +0100
Message-ID: <20171109132739.23465-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, pv-drivers@vmware.com, akataria@vmware.com, virtualization@lists.linux-foundation.org, pavel@ucw.cz, hpa@zytor.com, tglx@linutronix.de, sthemmin@microsoft.com, x86@kernel.org, moltmann@vmware.com, mingo@redhat.com, linux-graphics-maintainer@vmware.com, linux-input@vger.kernel.org, xen-devel@lists.xenproject.org, len.brown@intel.com, arnd@arndb.de, linux-pm@vger.kernel.org, xdeguillard@vmware.com, haiyangz@microsoft.com, rusty@rustcorp.com.au, pbonzini@redhat.com, boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, rjw@rjwysocki.net, devel@linuxdriverproject.org
List-Id: linux-input@vger.kernel.org

Booting a Xen PVH guest requires a special boot entry as it is
mandatory to setup some Xen-specific interfaces rather early. When grub
or OVMF are used as boot loaders, however, those will fill the boot
parameters in zeropage and there is no longer a need to do something
PVH specific in the early boot path.

This patch series adds support for that scenario by identifying PVH
environment and doing the required init steps via Xen hooks instead of
using a dedicated boot entry.

The dedicated entry is still mandatory for support of Dom0 running in
PVH mode as in this case there is no grub or OVMF involved for filling
in the boot parameters.

Changes in V2:
- added new patches 1 and 2

Cc: kys@microsoft.com
Cc: haiyangz@microsoft.com
Cc: sthemmin@microsoft.com
Cc: akataria@vmware.com
Cc: pbonzini@redhat.com
Cc: rkrcmar@redhat.com
Cc: boris.ostrovsky@oracle.com
Cc: rusty@rustcorp.com.au
Cc: devel@linuxdriverproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: linux-graphics-maintainer@vmware.com
Cc: pv-drivers@vmware.com
Cc: dmitry.torokhov@gmail.com
Cc: xdeguillard@vmware.com
Cc: moltmann@vmware.com
Cc: arnd@arndb.de
Cc: gregkh@linuxfoundation.org
Cc: linux-input@vger.kernel.org
Cc: rjw@rjwysocki.net
Cc: len.brown@intel.com
Cc: pavel@ucw.cz
Cc: linux-pm@vger.kernel.org

Juergen Gross (5):
  x86: merge x86_hyper into x86_platform and x86_init
  x86: add enum for hypervisors to replace x86_hyper
  x86/acpi: add test for ACPI_FADT_NO_VGA
  x86: add guest_late_init hook to hypervisor_x86 structure
  x86/xen: use guest_late_init to detect Xen PVH guest

 arch/x86/hyperv/hv_init.c         |  2 +-
 arch/x86/include/asm/hypervisor.h | 46 +++++++++++-----------------
 arch/x86/include/asm/kvm_para.h   |  2 --
 arch/x86/include/asm/x86_init.h   | 27 +++++++++++++++++
 arch/x86/kernel/acpi/boot.c       |  5 +++
 arch/x86/kernel/apic/apic.c       |  2 +-
 arch/x86/kernel/cpu/hypervisor.c  | 64 +++++++++++++++++++++------------------
 arch/x86/kernel/cpu/mshyperv.c    |  6 ++--
 arch/x86/kernel/cpu/vmware.c      |  8 ++---
 arch/x86/kernel/kvm.c             |  9 +++---
 arch/x86/kernel/setup.c           |  2 +-
 arch/x86/kernel/x86_init.c        | 10 ++++++
 arch/x86/mm/init.c                |  2 +-
 arch/x86/xen/enlighten_hvm.c      | 36 +++++++++++++++++-----
 arch/x86/xen/enlighten_pv.c       |  6 ++--
 arch/x86/xen/enlighten_pvh.c      |  9 ------
 drivers/hv/vmbus_drv.c            |  2 +-
 drivers/input/mouse/vmmouse.c     | 10 +++---
 drivers/misc/vmw_balloon.c        |  2 +-
 include/linux/hypervisor.h        |  8 +++--
 20 files changed, 153 insertions(+), 105 deletions(-)

-- 
2.12.3

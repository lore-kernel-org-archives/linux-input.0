From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: intel-ish-hid: Prevent loading of driver on
 Mehlow
Date: Thu, 2 Aug 2018 13:27:33 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1808021327240.25787@cbobk.fhfr.pm>
References: <20180718193200.17944-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718193200.17944-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 18 Jul 2018, Srinivas Pandruvada wrote:

> On Mehlow Xeon-E workstation, ISH PCI device is enabled but without ISH
> firmware. Here the ISH device PCI device id was reused for some non Linux
> storage drivers. So this was not done for enabling ISH. But this has a
> undesirable side effect for Linux.
> 
> Here the ISH driver will be loaded via PCI enumeration and will try to do
> reset sequence. But reset sequence will wait till timeout as there is no
> real ISH firmware is present to take action. This delay will add to boot
> time of Linux (This platform will still continue to boot after this
> timeout).
> 
> To avoid this boot delay we need to prevent loading of ISH drivers on
> this platform. So we need to have hack to avoid treating this device as
> ISH on this platform. To identify this workstation, we need some runtime
> method. Luckily there are special PCI id on this workstation to
> distinguish from the client version of this platform. On client version,
> the ISH is supported using same PCI device id. So this change look for
> the presence of PCI device IDs A309 and A30A and exit.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2
>  Replaced pci_get_device with pci_dev_present to check in a loop as
> suggested by Benjamin.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

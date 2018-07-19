From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: intel-ish-hid: Prevent loading of driver on Mehlow
Date: Thu, 19 Jul 2018 11:39:51 +0200
Message-ID: <CAO-hwJJ=hsdu7AapAaWbB-JQUk9+24Lcx6i31bF5xaVwXdNQpQ@mail.gmail.com>
References: <20180718193200.17944-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718193200.17944-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jul 18, 2018 at 9:32 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
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

That's even better than what I suggested :)

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index a2c53ea3b5ed..4a55eab39b88 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -95,6 +95,13 @@ static int ish_init(struct ishtp_device *dev)
>         return 0;
>  }
>
> +static const struct pci_device_id ish_invalid_pci_ids[] = {
> +       /* Mehlow platform special pci ids */
> +       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xA309)},
> +       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xA30A)},
> +       {}
> +};
> +
>  /**
>   * ish_probe() - PCI driver probe callback
>   * @pdev:      pci device
> @@ -110,6 +117,10 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>         struct ish_hw *hw;
>         int     ret;
>
> +       /* Check for invalid platforms for ISH support */
> +       if (pci_dev_present(ish_invalid_pci_ids))
> +               return -ENODEV;
> +
>         /* enable pci dev */
>         ret = pci_enable_device(pdev);
>         if (ret) {
> --
> 2.17.1
>

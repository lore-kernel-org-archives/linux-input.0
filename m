From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: Prevent loading of driver on Mehlow
Date: Wed, 18 Jul 2018 07:21:11 -0700
Message-ID: <4bb491b5b31eeefbe82b5d21c1c2b3c19d7cc0d4.camel@linux.intel.com>
References: <20180717200557.39925-1-srinivas.pandruvada@linux.intel.com>
         <CAO-hwJ+b6aSSC7UGDtdivfh69+ZZaV5uwJH_ramLM0FeAZwRDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJ+b6aSSC7UGDtdivfh69+ZZaV5uwJH_ramLM0FeAZwRDQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, 2018-07-18 at 09:53 +0200, Benjamin Tissoires wrote:
> On Tue, Jul 17, 2018 at 10:06 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Mehlow Xeon-E workstation, ISH PCI device is enabled but without
> > ISH
> > firmware. Here the ISH device PCI device id was reused for some non
> > Linux
> > storage drivers. So this was not done for enabling ISH. But this
> > has a
> > undesirable side effect for Linux.
> > 
> > Here the ISH driver will be loaded via PCI enumeration and will try
> > to do
> > reset sequence. But reset sequence will wait till timeout as there
> > is no
> > real ISH firmware is present to take action. This delay will add to
> > boot
> > time of Linux (This platform will still continue to boot after this
> > timeout).
> > 
> > To avoid this boot delay we need to prevent loading of ISH drivers
> > on
> > this platform. So we need to have hack to avoid treating this
> > device as
> > ISH on this platform. To identify this workstation, we need some
> > runtime
> > method. Luckily there are special PCI id on this workstation to
> > distinguish from the client version of this platform. On client
> > version,
> > the ISH is supported using same PCI device id. So this change look
> > for
> > the presence of PCI device IDs A309 and A30A and exit.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > ---
> > This is not a change for 4.18-rc.
> > 
> >  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 23
> > +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > index a2c53ea3b5ed..d6e7156c36d9 100644
> > --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > @@ -95,6 +95,26 @@ static int ish_init(struct ishtp_device *dev)
> >         return 0;
> >  }
> > 
> > +
> > +static bool ish_invalid_firmware(void)
> > +{
> > +       struct pci_dev *pdev;
> > +
> > +       pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0xA309, NULL);
> > +       if (pdev) {
> > +               pci_dev_put(pdev);
> > +               return true;
> > +       }
> > +
> > +       pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0xA30A, NULL);
> > +       if (pdev) {
> > +               pci_dev_put(pdev);
> > +               return true;
> > +       }
> 
> I think this duplicated code should be merged in a for loop on an
> array of blacklisted items :)
Good idea.

Thanks,
Srinivas

> 
> Cheers,
> Benjamin
> 
> > +
> > +       return false;
> > +}
> > +
> >  /**
> >   * ish_probe() - PCI driver probe callback
> >   * @pdev:      pci device
> > @@ -110,6 +130,9 @@ static int ish_probe(struct pci_dev *pdev,
> > const struct pci_device_id *ent)
> >         struct ish_hw *hw;
> >         int     ret;
> > 
> > +       if (ish_invalid_firmware())
> > +               return -ENODEV;
> > +
> >         /* enable pci dev */
> >         ret = pci_enable_device(pdev);
> >         if (ret) {
> > --
> > 2.17.1
> > 

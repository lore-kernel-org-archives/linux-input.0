From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix regression in pci_restore_state()
Date: Mon, 23 Apr 2012 11:03:35 -0600
Message-ID: <CAErSpo4St6zBBz7131Ne3BEHNO8Xcq8sCy3T5HV1F0B1B1u1cg@mail.gmail.com>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com>
 <201204152047.51019.rjw@sisk.pl> <CA+55aFyShMvUjkyGv4DgSGByuoU18o8=MnGJqbz5aSwDVyOyOA@mail.gmail.com>
 <201204152140.40747.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201204152140.40747.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mikko Vinni <mmvinni@yahoo.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Kay <allen.m.kay@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Apr 15, 2012 at 1:40 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Sunday, April 15, 2012, Linus Torvalds wrote:
>> On Sun, Apr 15, 2012 at 11:47 AM, Rafael J. Wysocki <rjw@sisk.pl> wr=
ote:
>> >
>> > mdelay(10) doesn't really look good either to me in this case, tho=
ugh.
>>
>> Oh, I agree. What kind of ass-backwards device actually needs that
>> kind of crazy delays? It is almost certainly buggy.
>>
>> With retries, 10ms delays are totally unacceptable. There's somethin=
g wrong.
>>
>> A single ms *may* be ok.
>>
>> Anyway, can you also split the actual "write _one_ register with
>> retry" into a function of its own? The code looks like crap with tho=
se
>> multiple levels of looping, with conditionals inside them etc. With =
a
>> simple helper function, you could change the break into return, and =
it
>> would look much better, I bet.
>
> Sure. =A0It appears cleaner this way.
>
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PCI: Fix regression in pci_restore_state(), v3
>
> Commit 26f41062f28de65e11d3cf353e52d0be73442be1
>
> =A0 =A0PCI: check for pci bar restore completion and retry
>
> attempted to address problems with PCI BAR restoration on systems
> where FLR had not been completed before pci_restore_state() was
> called, but it did that in an utterly wrong way.
>
> First off, instead of retrying the writes for the BAR registers
> only, it did that for all of the PCI config space of the device,
> including the status register (whose value after the write quite
> obviously need not be the same as the written one). =A0Second, it
> added arbitrary delay to pci_restore_state() even for systems
> where the PCI config space restoration was successful at first
> attempt. =A0Finally, the mdelay(10) it added to every iteration of th=
e
> writing loop was way too much of a delay for any reasonable device.
>
> All of this actually caused resume failures for some devices on
> the Mikko's system.
>
> To fix the regression, make pci_restore_state() only retry the
> writes for BAR registers and only wait if the first read from
> the register doesn't return the written value. =A0Additionaly, make
> it wait for 1 ms, instead of 10 ms, after every failing attempt
> to write into config space.
>
> Reported-by: Mikko Vinni <mmvinni@yahoo.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> =A0drivers/pci/pci.c | =A0 57 ++++++++++++++++++++++++++++++++++++---=
---------------
> =A01 file changed, 39 insertions(+), 18 deletions(-)
>
> Index: linux/drivers/pci/pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/pci/pci.c
> +++ linux/drivers/pci/pci.c
> @@ -967,16 +967,47 @@ pci_save_state(struct pci_dev *dev)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static void pci_restore_config_dword(struct pci_dev *pdev, int offse=
t,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0u32 saved_val, int retry)
> +{
> + =A0 =A0 =A0 u32 val;
> +
> + =A0 =A0 =A0 pci_read_config_dword(pdev, offset, &val);
> + =A0 =A0 =A0 if (val =3D=3D saved_val)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 for (;;) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "restoring config s=
pace at offset "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%#x (was %#x, writing =
%#x)\n", offset, val, saved_val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_write_config_dword(pdev, offset, sa=
ved_val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retry-- <=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_read_config_dword(pdev, offset, &va=
l);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val =3D=3D saved_val)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
> + =A0 =A0 =A0 }
> +}
> +
> +static void pci_restore_config_space(struct pci_dev *pdev, int start=
, int end,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0int retry)
> +{
> + =A0 =A0 =A0 int index;
> +
> + =A0 =A0 =A0 for (index =3D end; index >=3D start; index--)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_restore_config_dword(pdev, 4 * inde=
x,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0pdev->saved_config_space[index],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0retry);
> +}
> +
> =A0/**
> =A0* pci_restore_state - Restore the saved state of a PCI device
> =A0* @dev: - PCI device that we're dealing with
> =A0*/
> =A0void pci_restore_state(struct pci_dev *dev)
> =A0{
> - =A0 =A0 =A0 int i;
> - =A0 =A0 =A0 u32 val;
> - =A0 =A0 =A0 int tries;
> -
> =A0 =A0 =A0 =A0if (!dev->state_saved)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> @@ -984,24 +1015,14 @@ void pci_restore_state(struct pci_dev *d
> =A0 =A0 =A0 =A0pci_restore_pcie_state(dev);
> =A0 =A0 =A0 =A0pci_restore_ats_state(dev);
>
> + =A0 =A0 =A0 pci_restore_config_space(dev, 10, 15, 0);
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * The Base Address register should be programmed befo=
re the command
> =A0 =A0 =A0 =A0 * register(s)
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 for (i =3D 15; i >=3D 0; i--) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_read_config_dword(dev, i * 4, &val)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tries =3D 10;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (tries && val !=3D dev->saved_con=
fig_space[i]) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&dev->dev, "res=
toring config "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "space =
at offset %#x (was %#x, writing %#x)\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i, val,=
 (int)dev->saved_config_space[i]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_write_config_dword(=
dev,i * 4,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->sa=
ved_config_space[i]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_read_config_dword(d=
ev, i * 4, &val);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(10);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tries--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 pci_restore_config_space(dev, 4, 9, 10);
> + =A0 =A0 =A0 pci_restore_config_space(dev, 0, 3, 0);
> +
> =A0 =A0 =A0 =A0pci_restore_pcix_state(dev);
> =A0 =A0 =A0 =A0pci_restore_msi_state(dev);
> =A0 =A0 =A0 =A0pci_restore_iov_state(dev);

I'd feel better about this if there were a way to delay in the FLR
path instead.  If we delay in the restore path, we're only fixing one
of the many ways config space can be written.  Other paths that write
config space will just silently fail.

The PCIe spec (r3.0, sec 6.6.2) mentions waiting for the "pre-FLR
value for Completion Timeout," but I don't see anything that looks
like that in pcie_flr() or pci_af_flr().  Are there any other direct
ways we can detect when the FLR is complete?

Bjorn

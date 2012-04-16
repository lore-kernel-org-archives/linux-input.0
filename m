From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [linux-pm] "i8042: Can't reactivate AUX port" after s2ram on 3.4-rc2
Date: Mon, 16 Apr 2012 11:57:45 -0700 (PDT)
Message-ID: <1334602665.33371.YahooMailNeo@web161806.mail.bf1.yahoo.com>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com> <201204152256.03198.rjw@sisk.pl> <1334560992.32851.YahooMailNeo@web161806.mail.bf1.yahoo.com> <201204161817.21800.rjw@sisk.pl>
Reply-To: Mikko Vinni <mmvinni@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201204161817.21800.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Kay <allen.m.kay@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

=46rom: Rafael J. Wysocki:

>>  Ok, I tested v4 and also v3, which is in 3.4-rc3. On this laptop bo=
th=20
> versions
>>  work equally: touchpad works after resume (no help for the card rea=
der
>>  problem, though).
>=20
> [...]
>=20
>>  Difference from v3:
>>  --- /tmp/v3-uniq=A0 =A0 =A0 =A0 2012-04-16 09:57:42.880521878 +0300
>>  +++ /tmp/v4-uniq=A0 =A0 =A0 =A0 2012-04-16 09:58:03.880545386 +0300
>>  @@ -1019,11 +1018,11 @@
>> =A0 =A0 =A0 =A0 1 Booting Node 0 Processor 1 APIC 0x1
>> =A0 =A0 =A0 =A0 1 CPU1 is up
>> =A0 =A0 =A0 =A0 1 ACPI: Waking up from system sleep state S3
>>  -=A0 =A0  11 pcieport 0000:00:02.0: restoring config space at offse=
t 0x1c (was=20
> 0x20005151, writing 0x5151)
>>  +=A0 =A0 =A0 1 pcieport 0000:00:02.0: restoring config space at off=
set 0x1c (was=20
> 0x20005151, writing 0x5151)
>=20
> OK, so clearly we need to prevent the writes into the secondary statu=
s register
> of the PCIe port from being repreated pointlessly.
>=20
> Can you please test the appended patch from completness on top of 3.4=
-rc3?

I think that's what I did already :)

git pull to 3.4-rc3
(test, result as v3 output/diff in the previous email)
Revert "PCI: Fix regression in pci_restore_state(), v3"
apply v4 of the patch
(test, result as v4 output in the previous email)
git diff v3.4-rc3 -- drivers/pci/pci.c --> matches the patch below


Mikko


>=20
> Rafael
>=20
>=20
> ---
> drivers/pci/pci.c |=A0  18 +++++++++++-------
> 1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> Index: linux/drivers/pci/pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/pci/pci.c
> +++ linux/drivers/pci/pci.c
> @@ -1015,13 +1015,17 @@ void pci_restore_state(struct pci_dev *d
> =A0=A0=A0 pci_restore_pcie_state(dev);
> =A0=A0=A0 pci_restore_ats_state(dev);
>=20
> -=A0=A0=A0 pci_restore_config_space(dev, 10, 15, 0);
> -=A0=A0=A0 /*
> -=A0=A0=A0  * The Base Address register should be programmed before t=
he command
> -=A0=A0=A0  * register(s)
> -=A0=A0=A0  */
> -=A0=A0=A0 pci_restore_config_space(dev, 4, 9, 10);
> -=A0=A0=A0 pci_restore_config_space(dev, 0, 3, 0);
> +=A0=A0=A0 if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL) {
> +=A0=A0=A0 =A0=A0=A0 pci_restore_config_space(dev, 10, 15, 0);
> +=A0=A0=A0 =A0=A0=A0 /*
> +=A0=A0=A0 =A0=A0=A0  * The Base Address register should be programme=
d before the
> +=A0=A0=A0 =A0=A0=A0  * command register(s)
> +=A0=A0=A0 =A0=A0=A0  */
> +=A0=A0=A0 =A0=A0=A0 pci_restore_config_space(dev, 4, 9, 10);
> +=A0=A0=A0 =A0=A0=A0 pci_restore_config_space(dev, 0, 3, 0);
> +=A0=A0=A0 } else {
> +=A0=A0=A0 =A0=A0=A0 pci_restore_config_space(dev, 0, 15, 0);
> +=A0=A0=A0 }
>=20
> =A0=A0=A0 pci_restore_pcix_state(dev);
> =A0=A0=A0 pci_restore_msi_state(dev);
>=20

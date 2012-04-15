From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [linux-pm] "i8042: Can't reactivate AUX port" after s2ram on 3.4-rc2
Date: Sun, 15 Apr 2012 03:39:45 -0700 (PDT)
Message-ID: <1334486385.82898.YahooMailNeo@web161803.mail.bf1.yahoo.com>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com> <201204132219.23106.rjw@sisk.pl> <1334350068.79333.YahooMailNeo@web161804.mail.bf1.yahoo.com> <201204150011.53556.rjw@sisk.pl>
Reply-To: Mikko Vinni <mmvinni@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm23-vm0.bullet.mail.bf1.yahoo.com ([98.139.212.191]:32536 "HELO
	nm23-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752366Ab2DOKjr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Apr 2012 06:39:47 -0400
In-Reply-To: <201204150011.53556.rjw@sisk.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Kay <allen.m.kay@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>

=46rom: Rafael J. Wysocki:

>>  > Please change that dev_dbg() in pci_restore_state() into dev_info=
()
>>  > and see how many times it gets printed with the commit applied (n=
ot=20
> reverted).
>>=20
>>=20
>>  I ran the dmesg through "uniq -c" and it looks like this:
>>=20
>> =A0 =A0 =A0  1 ACPI: Low-level resume complete
>> =A0 =A0 =A0  1 PM: Restoring platform NVS memory
>> =A0 =A0 =A0  1 Enabling non-boot CPUs ...
>> =A0 =A0 =A0  1 Booting Node 0 Processor 1 APIC 0x1
>> =A0 =A0 =A0  1 CPU1 is up
>> =A0 =A0 =A0  1 ACPI: Waking up from system sleep state S3
>> =A0 =A0 =A0 10 pcieport 0000:00:02.0: restoring config space at offs=
et 0x7 (was=20
> 0x20005151, writing 0x5151)
>=20
> Well, yeah.=A0 So the commit you bisected it to is total and utter cr=
ap.
> Most importantly, it retries the writes for all of the dwords in the=20
> device's
> config space _including_ the status register (which by definition nee=
d not be
> the same as the written value).
>=20
> I wonder if the appended patch helps?

It does. It seems there is a change only in the devices that refuse to =
wake up;
somehow writing too many times to them affects the rest of the machine.
So, for this machine your patch fixes the problem of the touchpad not w=
orking.

The write is now attempted (at most) 11 times, as shown below. Probably=
 not
a huge deal.

=A0=A0=A0=A0=A0 1 ACPI: Waking up from system sleep state S3
=A0=A0=A0=A0 11 pcieport 0000:00:02.0: restoring config space at offset=
 0x1c (was 0x20005151, writing 0x5151)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:02.0: restoring config space at offs=
et 0x4 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:04.0: restoring config space at offs=
et 0x4 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:05.0: restoring config space at offs=
et 0x4 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0 11 pcieport 0000:00:06.0: restoring config space at offset=
 0x1c (was 0x20002121, writing 0x2121)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:06.0: restoring config space at offs=
et 0x4 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:0a.0: restoring config space at offs=
et 0x4 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 ahci 0000:00:11.0: restoring config space at offset 0=
x4 (was 0x2300003, writing 0x2300007)
=A0=A0=A0=A0=A0 1 ohci_hcd 0000:00:12.0: restoring config space at offs=
et 0x4 (was 0x2a00002, writing 0x2a00013)
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:12.2: BAR 0: set to [mem 0xd2408500-=
0xd24085ff] (PCI address [0xd2408500-0xd24085ff])
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:12.2: restoring config space at offs=
et 0x4 (was 0x2b00000, writing 0x2b00013)
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:12.2: PME# disabled
=A0=A0=A0=A0=A0 1 ohci_hcd 0000:00:13.0: restoring config space at offs=
et 0x4 (was 0x2a00002, writing 0x2a00013)
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:13.2: BAR 0: set to [mem 0xd2408400-=
0xd24084ff] (PCI address [0xd2408400-0xd24084ff])
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:13.2: restoring config space at offs=
et 0x4 (was 0x2b00000, writing 0x2b00013)
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:13.2: PME# disabled
=A0=A0=A0=A0=A0 1 pata_atiixp 0000:00:14.1: restoring config space at o=
ffset 0x4 (was 0x2300011, writing 0x2300015)
=A0=A0=A0=A0=A0 1 radeon 0000:01:00.0: restoring config space at offset=
 0x4 (was 0x100003, writing 0x20100407)
=A0=A0=A0=A0=A0 1 pci 0000:09:00.0: restoring config space at offset 0x=
4 (was 0x100007, writing 0x100003)
=A0=A0=A0=A0=A0 1 firewire_ohci 0000:0a:00.0: Refused to change power s=
tate, currently in D3
=A0=A0=A0=A0=A0 1 firewire_ohci 0000:0a:00.0: restoring config space at=
 offset 0x3c (was 0xffffffff, writing 0x10a)
=A0=A0=A0=A0=A0 1 firewire_ohci 0000:0a:00.0: restoring config space at=
 offset 0x38 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0=A0 1 firewire_ohci 0000:0a:00.0: restoring config space at=
 offset 0x34 (was 0xffffffff, writing 0x44)
=A0=A0=A0=A0=A0 1 firewire_ohci 0000:0a:00.0: restoring config space at=
 offset 0x30 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0=A0 1 firewire_ohci 0000:0a:00.0: restoring config space at=
 offset 0x2c (was 0xffffffff, writing 0x3600103c)
=A0=A0=A0=A0=A0 1 firewire_ohci 0000:0a:00.0: restoring config space at=
 offset 0x28 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x24 (was 0xffffffff, writing 0xd1100c00)
=A0=A0=A0=A0 11 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x20 (was 0xffffffff, writing 0xd1100c80)
=A0=A0=A0=A0 11 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x1c (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x18 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x14 (was 0xffffffff, writing 0xd1100d00)
=A0=A0=A0=A0 11 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x10 (was 0xffffffff, writing 0xd1100000)
=A0=A0=A0=A0=A0 1 firewire_ohci 0000:0a:00.0: restoring config space at=
 offset 0xc (was 0xffffffff, writing 0x800000)
=A0=A0=A0=A0=A0 1 firewire_ohci 0000:0a:00.0: restoring config space at=
 offset 0x8 (was 0xffffffff, writing 0xc001000)
=A0=A0=A0=A0=A0 1 firewire_ohci 0000:0a:00.0: restoring config space at=
 offset 0x4 (was 0xffffffff, writing 0x100007)
=A0=A0=A0=A0=A0 1 firewire_ohci 0000:0a:00.0: restoring config space at=
 offset 0x0 (was 0xffffffff, writing 0x2380197b)
=A0=A0=A0=A0=A0 1 sdhci-pci 0000:0a:00.1: Refused to change power state=
, currently in D3
=A0=A0=A0=A0=A0 1 sdhci-pci 0000:0a:00.1: restoring config space at off=
set 0x3c (was 0xffffffff, writing 0x10a)
=A0=A0=A0=A0=A0 1 sdhci-pci 0000:0a:00.1: restoring config space at off=
set 0x38 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0=A0 1 sdhci-pci 0000:0a:00.1: restoring config space at off=
set 0x34 (was 0xffffffff, writing 0xa4)
=A0=A0=A0=A0=A0 1 sdhci-pci 0000:0a:00.1: restoring config space at off=
set 0x30 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0=A0 1 sdhci-pci 0000:0a:00.1: restoring config space at off=
set 0x2c (was 0xffffffff, writing 0x3600103c)
=A0=A0=A0=A0=A0 1 sdhci-pci 0000:0a:00.1: restoring config space at off=
set 0x28 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x24 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x20 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x1c (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x18 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x14 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x10 (was 0xffffffff, writing 0xd1100b00)
=A0=A0=A0=A0=A0 1 sdhci-pci 0000:0a:00.1: restoring config space at off=
set 0xc (was 0xffffffff, writing 0x800000)
=A0=A0=A0=A0=A0 1 sdhci-pci 0000:0a:00.1: restoring config space at off=
set 0x8 (was 0xffffffff, writing 0x8800000)
=A0=A0=A0=A0=A0 1 sdhci-pci 0000:0a:00.1: restoring config space at off=
set 0x4 (was 0xffffffff, writing 0x100007)
=A0=A0=A0=A0=A0 1 sdhci-pci 0000:0a:00.1: restoring config space at off=
set 0x0 (was 0xffffffff, writing 0x2382197b)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.2: Refused to change power state, curr=
ently in D3
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.2: restoring config space at offset 0x=
3c (was 0xffffffff, writing 0x10a)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.2: restoring config space at offset 0x=
38 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.2: restoring config space at offset 0x=
34 (was 0xffffffff, writing 0xa4)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.2: restoring config space at offset 0x=
30 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.2: restoring config space at offset 0x=
2c (was 0xffffffff, writing 0x3600103c)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.2: restoring config space at offset 0x=
28 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 pci 0000:0a:00.2: restoring config space at offset 0x24=
 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 pci 0000:0a:00.2: restoring config space at offset 0x20=
 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 pci 0000:0a:00.2: restoring config space at offset 0x1c=
 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 pci 0000:0a:00.2: restoring config space at offset 0x18=
 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 pci 0000:0a:00.2: restoring config space at offset 0x14=
 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 pci 0000:0a:00.2: restoring config space at offset 0x10=
 (was 0xffffffff, writing 0xd1100a00)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.2: restoring config space at offset 0x=
c (was 0xffffffff, writing 0x800000)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.2: restoring config space at offset 0x=
8 (was 0xffffffff, writing 0x8050100)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.2: restoring config space at offset 0x=
4 (was 0xffffffff, writing 0x100003)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.2: restoring config space at offset 0x=
0 (was 0xffffffff, writing 0x2381197b)
=A0=A0=A0=A0=A0 1 jmb38x_ms 0000:0a:00.3: Refused to change power state=
, currently in D3
=A0=A0=A0=A0=A0 1 jmb38x_ms 0000:0a:00.3: restoring config space at off=
set 0x3c (was 0xffffffff, writing 0x10a)
=A0=A0=A0=A0=A0 1 jmb38x_ms 0000:0a:00.3: restoring config space at off=
set 0x38 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0=A0 1 jmb38x_ms 0000:0a:00.3: restoring config space at off=
set 0x34 (was 0xffffffff, writing 0xa4)
=A0=A0=A0=A0=A0 1 jmb38x_ms 0000:0a:00.3: restoring config space at off=
set 0x30 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0=A0 1 jmb38x_ms 0000:0a:00.3: restoring config space at off=
set 0x2c (was 0xffffffff, writing 0x3600103c)
=A0=A0=A0=A0=A0 1 jmb38x_ms 0000:0a:00.3: restoring config space at off=
set 0x28 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x24 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x20 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x1c (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x18 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x14 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x10 (was 0xffffffff, writing 0xd1100900)
=A0=A0=A0=A0=A0 1 jmb38x_ms 0000:0a:00.3: restoring config space at off=
set 0xc (was 0xffffffff, writing 0x800000)
=A0=A0=A0=A0=A0 1 jmb38x_ms 0000:0a:00.3: restoring config space at off=
set 0x8 (was 0xffffffff, writing 0x8800000)
=A0=A0=A0=A0=A0 1 jmb38x_ms 0000:0a:00.3: restoring config space at off=
set 0x4 (was 0xffffffff, writing 0x100007)
=A0=A0=A0=A0=A0 1 jmb38x_ms 0000:0a:00.3: restoring config space at off=
set 0x0 (was 0xffffffff, writing 0x2383197b)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: Refused to change power state, curr=
ently in D3
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: restoring config space at offset 0x=
3c (was 0xffffffff, writing 0x10a)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: restoring config space at offset 0x=
38 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: restoring config space at offset 0x=
34 (was 0xffffffff, writing 0xa4)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: restoring config space at offset 0x=
30 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: restoring config space at offset 0x=
2c (was 0xffffffff, writing 0x3600103c)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: restoring config space at offset 0x=
28 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 pci 0000:0a:00.4: restoring config space at offset 0x24=
 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 pci 0000:0a:00.4: restoring config space at offset 0x20=
 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 pci 0000:0a:00.4: restoring config space at offset 0x1c=
 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 pci 0000:0a:00.4: restoring config space at offset 0x18=
 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 pci 0000:0a:00.4: restoring config space at offset 0x14=
 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 11 pci 0000:0a:00.4: restoring config space at offset 0x10=
 (was 0xffffffff, writing 0xd1100800)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: restoring config space at offset 0x=
c (was 0xffffffff, writing 0x800000)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: restoring config space at offset 0x=
8 (was 0xffffffff, writing 0x8800000)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: restoring config space at offset 0x=
4 (was 0xffffffff, writing 0x100007)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: restoring config space at offset 0x=
0 (was 0xffffffff, writing 0x2384197b)
=A0=A0=A0=A0=A0 1 PM: noirq resume of devices complete after 6539.864 m=
secs
=A0=A0=A0=A0=A0 1 PM: early resume of devices complete after 0.159 msec=
s
=A0=A0=A0=A0=A0 1 ohci_hcd 0000:00:12.0: enabling bus mastering
=2E..


Thanks,

Mikko


>=20
> Rafael
>=20
>=20
> ---
> drivers/pci/pci.c |=A0  50 ++++++++++++++++++++++++++++++++----------=
--------
> 1 file changed, 32 insertions(+), 18 deletions(-)
>=20
> Index: linux/drivers/pci/pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/pci/pci.c
> +++ linux/drivers/pci/pci.c
> @@ -967,16 +967,40 @@ pci_save_state(struct pci_dev *dev)
> =A0=A0=A0 return 0;
> }
>=20
> +static void pci_restore_config_space(struct pci_dev *pdev, int start=
, int end,
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0  int retry)
> +{
> +=A0=A0=A0 int index;
> +
> +=A0=A0=A0 for (index =3D end; index >=3D start; index--) {
> +=A0=A0=A0 =A0=A0=A0 u32 val, saved;
> +=A0=A0=A0 =A0=A0=A0 int offset =3D 4 * index;
> +=A0=A0=A0 =A0=A0=A0 int count =3D retry;
> +
> +=A0=A0=A0 =A0=A0=A0 saved =3D pdev->saved_config_space[index];
> +=A0=A0=A0 =A0=A0=A0 pci_read_config_dword(pdev, offset, &val);
> +=A0=A0=A0 =A0=A0=A0 while (saved !=3D val) {
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dev_dbg(&pdev->dev, "restoring config =
space at offset=20
> "
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "%#x (was %#x, writing %#x)\=
n",
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 offset, val, saved);
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 pci_write_config_dword(pdev, offset, s=
aved);
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (count-- > 0) {
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 pci_read_config_dword(pdev, =
offset, &val);
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (saved !=3D val)
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 msleep(10);
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 } else {
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 break;
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 }
> +=A0=A0=A0 =A0=A0=A0 }
> +=A0=A0=A0 }
> +}
> +
> /**=20
> =A0 * pci_restore_state - Restore the saved state of a PCI device
> =A0 * @dev: - PCI device that we're dealing with
> =A0 */
> void pci_restore_state(struct pci_dev *dev)
> {
> -=A0=A0=A0 int i;
> -=A0=A0=A0 u32 val;
> -=A0=A0=A0 int tries;
> -
> =A0=A0=A0 if (!dev->state_saved)
> =A0=A0=A0 =A0=A0=A0 return;
>=20
> @@ -984,24 +1008,14 @@ void pci_restore_state(struct pci_dev *d
> =A0=A0=A0 pci_restore_pcie_state(dev);
> =A0=A0=A0 pci_restore_ats_state(dev);
>=20
> +=A0=A0=A0 pci_restore_config_space(dev, 10, 15, 0);
> =A0=A0=A0 /*
> =A0=A0=A0  * The Base Address register should be programmed before th=
e command
> =A0=A0=A0  * register(s)
> =A0=A0=A0  */
> -=A0=A0=A0 for (i =3D 15; i >=3D 0; i--) {
> -=A0=A0=A0 =A0=A0=A0 pci_read_config_dword(dev, i * 4, &val);
> -=A0=A0=A0 =A0=A0=A0 tries =3D 10;=A0=A0=A0 =A0=A0=A0=20
> -=A0=A0=A0 =A0=A0=A0 while (tries && val !=3D dev->saved_config_space=
[i]) {
> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dev_dbg(&dev->dev, "restoring config "
> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "space at offset %#x (was %#=
x, writing %#x)\n",
> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 i, val, (int)dev->saved_conf=
ig_space[i]);
> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 pci_write_config_dword(dev,i * 4,
> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dev->saved_config_space[i]);
> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 pci_read_config_dword(dev, i * 4, &val=
);
> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 mdelay(10);
> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 tries--;
> -=A0=A0=A0 =A0=A0=A0 }
> -=A0=A0=A0 }
> +=A0=A0=A0 pci_restore_config_space(dev, 4, 9, 10);
> +=A0=A0=A0 pci_restore_config_space(dev, 0, 3, 0);
> +
> =A0=A0=A0 pci_restore_pcix_state(dev);
> =A0=A0=A0 pci_restore_msi_state(dev);
> =A0=A0=A0 pci_restore_iov_state(dev);
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

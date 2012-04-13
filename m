From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [linux-pm] "i8042: Can't reactivate AUX port" after s2ram on 3.4-rc2
Date: Fri, 13 Apr 2012 13:47:48 -0700 (PDT)
Message-ID: <1334350068.79333.YahooMailNeo@web161804.mail.bf1.yahoo.com>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com> <201204132118.22074.rjw@sisk.pl> <1334346546.93033.YahooMailNeo@web161806.mail.bf1.yahoo.com> <201204132219.23106.rjw@sisk.pl>
Reply-To: Mikko Vinni <mmvinni@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201204132219.23106.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Kay <allen.m.kay@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

=46rom: Rafael J. Wysocki:

> On Friday, April 13, 2012, Mikko Vinni wrote:
>>  From: Rafael J. Wysocki:
>>=20
>>  > On Friday, April 13, 2012, Mikko Vinni wrote:
>>  >>=A0 Bug report:
>>  >>=A0 =A0 https://bugzilla.kernel.org/show_bug.cgi?id=3D43099
>>  >>=20

^^^ some of the home-work is already there, including dmesg with and wi=
thout the patch
with PCI debug on, which hopefully does the same as dev_info

>=20
> Please change that dev_dbg() in pci_restore_state() into dev_info()
> and see how many times it gets printed with the commit applied (not r=
everted).


I ran the dmesg through "uniq -c" and it looks like this:

=A0=A0=A0=A0=A0 1 ACPI: Low-level resume complete
=A0=A0=A0=A0=A0 1 PM: Restoring platform NVS memory
=A0=A0=A0=A0=A0 1 Enabling non-boot CPUs ...
=A0=A0=A0=A0=A0 1 Booting Node 0 Processor 1 APIC 0x1
=A0=A0=A0=A0=A0 1 CPU1 is up
=A0=A0=A0=A0=A0 1 ACPI: Waking up from system sleep state S3
=A0=A0=A0=A0 10 pcieport 0000:00:02.0: restoring config space at offset=
 0x7 (was 0x20005151, writing 0x5151)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:02.0: restoring config space at offs=
et 0x1 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:04.0: restoring config space at offs=
et 0x1 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:05.0: restoring config space at offs=
et 0x1 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0 10 pcieport 0000:00:06.0: restoring config space at offset=
 0x7 (was 0x20002121, writing 0x2121)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:06.0: restoring config space at offs=
et 0x1 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:0a.0: restoring config space at offs=
et 0x1 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 ahci 0000:00:11.0: restoring config space at offset 0=
x1 (was 0x2300003, writing 0x2300007)
=A0=A0=A0=A0=A0 1 ohci_hcd 0000:00:12.0: restoring config space at offs=
et 0x1 (was 0x2a00002, writing 0x2a00013)
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:12.2: BAR 0: set to [mem 0xd2408500-=
0xd24085ff] (PCI address [0xd2408500-0xd24085ff])
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:12.2: restoring config space at offs=
et 0x1 (was 0x2b00000, writing 0x2b00013)
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:12.2: PME# disabled
=A0=A0=A0=A0=A0 1 ohci_hcd 0000:00:13.0: restoring config space at offs=
et 0x1 (was 0x2a00002, writing 0x2a00013)
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:13.2: BAR 0: set to [mem 0xd2408400-=
0xd24084ff] (PCI address [0xd2408400-0xd24084ff])
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:13.2: restoring config space at offs=
et 0x1 (was 0x2b00000, writing 0x2b00013)
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:13.2: PME# disabled
=A0=A0=A0=A0=A0 1 pata_atiixp 0000:00:14.1: restoring config space at o=
ffset 0x1 (was 0x2300011, writing 0x2300015)
=A0=A0=A0=A0=A0 1 radeon 0000:01:00.0: restoring config space at offset=
 0x1 (was 0x100003, writing 0x100407)
=A0=A0=A0=A0=A0 1 r8169 0000:09:00.0: restoring config space at offset =
0x1 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 firewire_ohci 0000:0a:00.0: Refused to change power s=
tate, currently in D3
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0xf (was 0xffffffff, writing 0x10a)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0xe (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0xd (was 0xffffffff, writing 0x44)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0xc (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0xb (was 0xffffffff, writing 0x3600103c)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0xa (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x9 (was 0xffffffff, writing 0xd1100c00)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x8 (was 0xffffffff, writing 0xd1100c80)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x7 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x6 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x5 (was 0xffffffff, writing 0xd1100d00)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x4 (was 0xffffffff, writing 0xd1100000)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x3 (was 0xffffffff, writing 0x800000)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x2 (was 0xffffffff, writing 0xc001000)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x1 (was 0xffffffff, writing 0x100007)
=A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space at o=
ffset 0x0 (was 0xffffffff, writing 0x2380197b)
=A0=A0=A0=A0=A0 1 sdhci-pci 0000:0a:00.1: Refused to change power state=
, currently in D3
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0xf (was 0xffffffff, writing 0x10a)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0xe (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0xd (was 0xffffffff, writing 0xa4)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0xc (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0xb (was 0xffffffff, writing 0x3600103c)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0xa (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x9 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x8 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x7 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x6 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x5 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x4 (was 0xffffffff, writing 0xd1100b00)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x3 (was 0xffffffff, writing 0x800000)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x2 (was 0xffffffff, writing 0x8800000)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x1 (was 0xffffffff, writing 0x100007)
=A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at offse=
t 0x0 (was 0xffffffff, writing 0x2382197b)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.2: Refused to change power state, curr=
ently in D3
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0xf =
(was 0xffffffff, writing 0x10a)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0xe =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0xd =
(was 0xffffffff, writing 0xa4)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0xc =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0xb =
(was 0xffffffff, writing 0x3600103c)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0xa =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0x9 =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0x8 =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0x7 =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0x6 =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0x5 =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0x4 =
(was 0xffffffff, writing 0xd1100a00)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0x3 =
(was 0xffffffff, writing 0x800000)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0x2 =
(was 0xffffffff, writing 0x8050100)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0x1 =
(was 0xffffffff, writing 0x100003)
=A0=A0=A0=A0 10 pci 0000:0a:00.2: restoring config space at offset 0x0 =
(was 0xffffffff, writing 0x2381197b)
=A0=A0=A0=A0=A0 1 jmb38x_ms 0000:0a:00.3: Refused to change power state=
, currently in D3
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0xf (was 0xffffffff, writing 0x10a)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0xe (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0xd (was 0xffffffff, writing 0xa4)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0xc (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0xb (was 0xffffffff, writing 0x3600103c)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0xa (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x9 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x8 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x7 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x6 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x5 (was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x4 (was 0xffffffff, writing 0xd1100900)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x3 (was 0xffffffff, writing 0x800000)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x2 (was 0xffffffff, writing 0x8800000)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x1 (was 0xffffffff, writing 0x100007)
=A0=A0=A0=A0 10 jmb38x_ms 0000:0a:00.3: restoring config space at offse=
t 0x0 (was 0xffffffff, writing 0x2383197b)
=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: Refused to change power state, curr=
ently in D3
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0xf =
(was 0xffffffff, writing 0x10a)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0xe =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0xd =
(was 0xffffffff, writing 0xa4)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0xc =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0xb =
(was 0xffffffff, writing 0x3600103c)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0xa =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0x9 =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0x8 =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0x7 =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0x6 =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0x5 =
(was 0xffffffff, writing 0x0)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0x4 =
(was 0xffffffff, writing 0xd1100800)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0x3 =
(was 0xffffffff, writing 0x800000)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0x2 =
(was 0xffffffff, writing 0x8800000)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0x1 =
(was 0xffffffff, writing 0x100007)
=A0=A0=A0=A0 10 pci 0000:0a:00.4: restoring config space at offset 0x0 =
(was 0xffffffff, writing 0x2384197b)
=A0=A0=A0=A0=A0 1 PM: noirq resume of devices complete after 8474.806 m=
secs
=A0=A0=A0=A0=A0 1 PM: early resume of devices complete after 0.194 msec=
s
=A0=A0=A0=A0=A0 1 ohci_hcd 0000:00:12.0: enabling bus mastering


Interestingly, this only seems to happen after the first s2ram.
https://bugzilla.kernel.org/attachment.cgi?id=3D72904 contains the dmes=
g from
three s2ram's, and after the second and third one write seems to be eno=
ugh.
Even the failing firewire/card reader (another bug) is more quiet.

=2E.. (after the second s2ram, touchpad works after this)
=A0=A0=A0=A0=A0 1 CPU1 is up
=A0=A0=A0=A0=A0 1 ACPI: Waking up from system sleep state S3
=A0=A0=A0=A0=A0 1 pcieport 0000:00:02.0: restoring config space at offs=
et 0x1 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:04.0: restoring config space at offs=
et 0x1 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:05.0: restoring config space at offs=
et 0x1 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:06.0: restoring config space at offs=
et 0x1 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:0a.0: restoring config space at offs=
et 0x1 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 ahci 0000:00:11.0: restoring config space at offset 0=
x1 (was 0x2300003, writing 0x2300007)
=A0=A0=A0=A0=A0 1 ohci_hcd 0000:00:12.0: restoring config space at offs=
et 0x1 (was 0x2a00002, writing 0x2a00013)
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:12.2: BAR 0: set to [mem 0xd2408500-=
0xd24085ff] (PCI address [0xd2408500-0xd24085ff])
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:12.2: restoring config space at offs=
et 0x1 (was 0x2b00000, writing 0x2b00013)
=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:12.2: PME# disabled
=2E..=20


Mikko


>=20
> [Margin note: I think it would make more sense to read the value from
> the register _after_ and not before the waiting and I'm not exactly s=
ure why
> msleep() is not used.]
>=20
> Thanks,
> Rafael
>=20

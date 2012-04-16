From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [linux-pm] "i8042: Can't reactivate AUX port" after s2ram on 3.4-rc2
Date: Mon, 16 Apr 2012 00:23:12 -0700 (PDT)
Message-ID: <1334560992.32851.YahooMailNeo@web161806.mail.bf1.yahoo.com>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com> <201204152030.23148.rjw@sisk.pl> <201204152152.56048.rjw@sisk.pl> <201204152256.03198.rjw@sisk.pl>
Reply-To: Mikko Vinni <mmvinni@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201204152256.03198.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Kay <allen.m.kay@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

=46rom: Rafael J. Wysocki

>>  OK, I know.=A0 There simply are fewer BARs for bridges (and PCIe po=
rts)
>>  and here we're attempting to overwrite the secondary status registe=
r.=A0=20
> Sigh.
>>=20
>>  Well, I guess we should only retry the writes to BARs for Type 0 he=
aders.
>=20
> Which is done by the appended updated patch.=A0 Can you please give i=
t a try?


Ok, I tested v4 and also v3, which is in 3.4-rc3. On this laptop both v=
ersions
work equally: touchpad works after resume (no help for the card reader
problem, though).

Here is part of the resume log with version 4:

=A0=A0=A0=A0=A0 1 ACPI: Waking up from system sleep state S3
=A0=A0=A0=A0=A0 1 pcieport 0000:00:02.0: restoring config space at offs=
et 0x1c (was 0x20005151, writing 0x5151)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:02.0: restoring config space at offs=
et 0x4 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:04.0: restoring config space at offs=
et 0x4 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:05.0: restoring config space at offs=
et 0x4 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0 1 pcieport 0000:00:06.0: restoring config space at offs=
et 0x1c (was 0x20002121, writing 0x2121)
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
 0x4 (was 0x100003, writing 0x100407)
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
=A0=A0=A0=A0=A0 1 PM: noirq resume of devices complete after 440.260 ms=
ecs
=A0=A0=A0=A0=A0 1 PM: early resume of devices complete after 0.152 msec=
s
=A0=A0=A0=A0=A0 1 ohci_hcd 0000:00:12.0: enabling bus mastering
=A0=A0=A0=A0=A0 1 ohci_hcd 0000:00:12.1: enabling bus mastering


Difference from v3:
--- /tmp/v3-uniq=A0=A0=A0=A0=A0=A0=A0 2012-04-16 09:57:42.880521878 +03=
00
+++ /tmp/v4-uniq=A0=A0=A0=A0=A0=A0=A0 2012-04-16 09:58:03.880545386 +03=
00
@@ -1019,11 +1018,11 @@
=A0=A0=A0=A0=A0=A0 1 Booting Node 0 Processor 1 APIC 0x1
=A0=A0=A0=A0=A0=A0 1 CPU1 is up
=A0=A0=A0=A0=A0=A0 1 ACPI: Waking up from system sleep state S3
-=A0=A0=A0=A0 11 pcieport 0000:00:02.0: restoring config space at offse=
t 0x1c (was 0x20005151, writing 0x5151)
+=A0=A0=A0=A0=A0 1 pcieport 0000:00:02.0: restoring config space at off=
set 0x1c (was 0x20005151, writing 0x5151)
=A0=A0=A0=A0=A0=A0 1 pcieport 0000:00:02.0: restoring config space at o=
ffset 0x4 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0=A0 1 pcieport 0000:00:04.0: restoring config space at o=
ffset 0x4 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0=A0 1 pcieport 0000:00:05.0: restoring config space at o=
ffset 0x4 (was 0x100007, writing 0x100407)
-=A0=A0=A0=A0 11 pcieport 0000:00:06.0: restoring config space at offse=
t 0x1c (was 0x20002121, writing 0x2121)
+=A0=A0=A0=A0=A0 1 pcieport 0000:00:06.0: restoring config space at off=
set 0x1c (was 0x20002121, writing 0x2121)
=A0=A0=A0=A0=A0=A0 1 pcieport 0000:00:06.0: restoring config space at o=
ffset 0x4 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0=A0 1 pcieport 0000:00:0a.0: restoring config space at o=
ffset 0x4 (was 0x100007, writing 0x100407)
=A0=A0=A0=A0=A0=A0 1 ahci 0000:00:11.0: restoring config space at offse=
t 0x4 (was 0x2300003, writing 0x2300007)
@@ -1123,8 +1122,8 @@
=A0=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: restoring config space at offset=
 0x8 (was 0xffffffff, writing 0x8800000)
=A0=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: restoring config space at offset=
 0x4 (was 0xffffffff, writing 0x100007)
=A0=A0=A0=A0=A0=A0 1 pci 0000:0a:00.4: restoring config space at offset=
 0x0 (was 0xffffffff, writing 0x2384197b)
-=A0=A0=A0=A0=A0 1 PM: noirq resume of devices complete after 460.315 m=
secs
-=A0=A0=A0=A0=A0 1 PM: early resume of devices complete after 0.168 mse=
cs
+=A0=A0=A0=A0=A0 1 PM: noirq resume of devices complete after 440.260 m=
secs
+=A0=A0=A0=A0=A0 1 PM: early resume of devices complete after 0.152 mse=
cs
=A0=A0=A0=A0=A0=A0 1 ohci_hcd 0000:00:12.0: enabling bus mastering
=A0=A0=A0=A0=A0=A0 1 ohci_hcd 0000:00:12.1: enabling bus mastering
=A0=A0=A0=A0=A0=A0 1 ehci_hcd 0000:00:12.2: enabling bus mastering


(...if only radeon didn't add 10 seconds to resume time, that improveme=
nt of 20 msecs
would be very nice; that is another issue, of course, and not a new pro=
blem for this
kernel version:

[drm:atom_op_jump] *ERROR* atombios stuck in loop for more than 5secs a=
borting
[drm:atom_execute_table_locked] *ERROR* atombios stuck executing F8B6 (=
len 485, WS 0, PS 4) @ 0xF8F7
[drm:atom_op_jump] *ERROR* atombios stuck in loop for more than 5secs a=
borting
[drm:atom_execute_table_locked] *ERROR* atombios stuck executing F8B6 (=
len 485, WS 0, PS 4) @ 0xF8F7
PM: resume of devices complete after 12741.575 msecs
)


Thanks,

Mikko


>=20
> Rafael
>=20
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PCI: Fix regression in pci_restore_state(), v4
>=20
> Commit 26f41062f28de65e11d3cf353e52d0be73442be1
>=20
> =A0 =A0 PCI: check for pci bar restore completion and retry
>=20
> attempted to address problems with PCI BAR restoration on systems
> where FLR had not been completed before pci_restore_state() was
> called, but it did that in an utterly wrong way.
>=20
> First off, instead of retrying the writes for the BAR registers
> only, it did that for all of the PCI config space of the device,
> including the status registers (whose values after the write quite
> obviously need not be the same as the written ones).=A0 Second, it
> added arbitrary delay to pci_restore_state() even for systems
> where the PCI config space restoration was successful at first
> attempt.=A0 Finally, the mdelay(10) it added to every iteration of th=
e
> writing loop was way too much of a delay for any reasonable device.
>=20
> All of this actually caused resume failures for some devices on
> the Mikko's system.
>=20
> To fix the regression, make pci_restore_state() only retry the
> writes to BAR registers and only for devices with Type 0 headers.
> Moreover, make it wait only if the next first read from the given
> register doesn't return the value written to it.=A0 Finally, make it
> wait for 1 ms, instead of 10 ms, after every failing attempt to write
> into the device's config space.
>=20
> Reported-by: Mikko Vinni <mmvinni@yahoo.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> drivers/pci/pci.c |=A0  67 +++++++++++++++++++++++++++++++++++++-----=
------------
> 1 file changed, 46 insertions(+), 21 deletions(-)
>=20
> Index: linux/drivers/pci/pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/pci/pci.c
> +++ linux/drivers/pci/pci.c
> @@ -967,16 +967,47 @@ pci_save_state(struct pci_dev *dev)
> =A0=A0=A0 return 0;
> }
>=20
> +static void pci_restore_config_dword(struct pci_dev *pdev, int offse=
t,
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0  u32 saved_val, int =
retry)
> +{
> +=A0=A0=A0 u32 val;
> +
> +=A0=A0=A0 pci_read_config_dword(pdev, offset, &val);
> +=A0=A0=A0 if (val =3D=3D saved_val)
> +=A0=A0=A0 =A0=A0=A0 return;
> +
> +=A0=A0=A0 for (;;) {
> +=A0=A0=A0 =A0=A0=A0 dev_dbg(&pdev->dev, "restoring config space at o=
ffset=20
> "
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "%#x (was %#x, writing %#x)\n", offset=
, val,=20
> saved_val);
> +=A0=A0=A0 =A0=A0=A0 pci_write_config_dword(pdev, offset, saved_val);
> +=A0=A0=A0 =A0=A0=A0 if (retry-- <=3D 0)
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return;
> +
> +=A0=A0=A0 =A0=A0=A0 pci_read_config_dword(pdev, offset, &val);
> +=A0=A0=A0 =A0=A0=A0 if (val =3D=3D saved_val)
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return;
> +
> +=A0=A0=A0 =A0=A0=A0 mdelay(1);
> +=A0=A0=A0 }
> +}
> +
> +static void pci_restore_config_space(struct pci_dev *pdev, int start=
, int end,
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0  int retry)
> +{
> +=A0=A0=A0 int index;
> +
> +=A0=A0=A0 for (index =3D end; index >=3D start; index--)
> +=A0=A0=A0 =A0=A0=A0 pci_restore_config_dword(pdev, 4 * index,
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0  pdev->saved_confi=
g_space[index],
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0  retry);
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
> @@ -984,24 +1015,18 @@ void pci_restore_state(struct pci_dev *d
> =A0=A0=A0 pci_restore_pcie_state(dev);
> =A0=A0=A0 pci_restore_ats_state(dev);
>=20
> -=A0=A0=A0 /*
> -=A0=A0=A0  * The Base Address register should be programmed before t=
he command
> -=A0=A0=A0  * register(s)
> -=A0=A0=A0  */
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
> =A0=A0=A0 }
> +
> =A0=A0=A0 pci_restore_pcix_state(dev);
> =A0=A0=A0 pci_restore_msi_state(dev);
> =A0=A0=A0 pci_restore_iov_state(dev);
>=20

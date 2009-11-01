From: Dave Young <hidave.darkstar@gmail.com>
Subject: Re: [PATCH][RFC] input: remove bios I8042_CTR_XLATE check to make
	keyboard usable
Date: Sun, 1 Nov 2009 16:33:05 +0800
Message-ID: <a8e1da0911010133u57bd85cfj6cdcb789edc4d522@mail.gmail.com>
References: <20091027053404.GA2241@darkstar.vlan7>
	 <20091028054309.GA2368@core.coreip.homeip.net>
	 <20091028100318.GA4861@suse.cz> <20091028104211.GA2207@darkstar.vlan7>
	 <20091029003325.GA2739@darkstar.vlan7>
	 <20091029032633.GA7959@core.coreip.homeip.net>
	 <20091029071544.GA2220@darkstar.vlan7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751707AbZKAIdK@vger.kernel.org>
In-Reply-To: <20091029071544.GA2220@darkstar.vlan7>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 29, 2009 at 3:15 PM, Dave Young <hidave.darkstar@gmail.com>=
 wrote:
> On Wed, Oct 28, 2009 at 08:26:33PM -0700, Dmitry Torokhov wrote:
>> On Thu, Oct 29, 2009 at 08:33:26AM +0800, Dave Young wrote:
>> > On Wed, Oct 28, 2009 at 06:42:12PM +0800, Dave Young wrote:
>> > > On Wed, Oct 28, 2009 at 11:03:18AM +0100, Vojtech Pavlik wrote:
>> > > > On Tue, Oct 27, 2009 at 10:43:10PM -0700, Dmitry Torokhov wrot=
e:
>> > > > > Hi Dave,
>> > > > >
>> > > > > On Tue, Oct 27, 2009 at 01:34:04PM +0800, Dave Young wrote:
>> > > > > >
>> > > > > > Pressing somekey at early booting phase cause keyboard to =
be not usable
>> > > > > > (The hardware is DELL latitude e5400):
>> > > >
>> > > > Does early booting mean while the BIOS is coming up? Does the =
keyboard
>> > > > work in GRUB then? Or is it during the early init of the Linux=
 kernel?
>> > >
>> > > Keyboard work under lilo.
>> > > For the early booting I means the early init of the linux kernel
>> > >
>> > > >
>> > > > > > atkbd.c: Unknown key pressed (raw set 2, code 0xd3 on isa0=
060/serio0).
>> > > > > > atkbd.c: Use 'setkeycodes e053 <keycode>' to make it known=
=2E
>> > > > > > atkbd.c: Unknown key pressed (raw set 2, code 0x1d3 on isa=
0060/serio0).
>> > > > > > atkbd.c: Use 'setkeycodes e053 <keycode>' to make it known=
=2E
>> > > > > >
>> > > > > > i8042.c set i8042_direct to true when the controller init.=
 But the result
>> > > > > > is keyboard not usable, The only option is press the power=
 button to shutdown.
>> > > > > >
>> > > > > > So here remove the bios check to fix it.
>> > > >
>> > > > My question would be: Why this happens? Could it be that the p=
robe is
>> > > > confused by the keypress and reads the CTR incorrectly? Or is =
it just
>> > > > that the keyboard controller is in fact in translating mode, y=
et the CTR
>> > > > indicates otherwise?
>> > > >
>> > > > A i8042.debug=3D1 log of the bad init would be good.
>> > >
>> > > Here it is (retrieve from syslog):
>> >
>> > Syslog redirect the debug info to another log file, sorry, post ag=
ain:
>> >
>>
>> Any chance of reconfiguring syslog so debug is captured in the same
>> file? It is easier to see what is happening with the rest of context
>> present...
>
> Sure, here it is:
>
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A01.769328] fb: conflic=
ting fb hw usage inteldrmfb vs VESA VGA - removing generic driver
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A01.775105] Console: sw=
itching to colour dummy device 80x25
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A01.836980] [drm] LVDS-=
8: set mode 1280x800 c
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.067531] async/0 use=
d greatest stack depth: 6184 bytes left
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.228157] Console: sw=
itching to colour frame buffer device 160x50
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.260999] fb0: inteld=
rmfb frame buffer device
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.261001] registered =
panic notifier
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.309878] acpi device=
:3b: registered as cooling_device2
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.311325] input: Vide=
o Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/LNXVIDEO:01/input/=
input3
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.311794] ACPI: Video=
 Device [VID1] (multi-head: yes =C2=A0rom: no =C2=A0post: no)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.312212] ACPI Warnin=
g for \_SB_.PCI0.VID2._DOD: Return Package has no elements (empty) (200=
90903/nspredef-433)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.312910] input: Vide=
o Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/LNXVIDEO:02/input/=
input4
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.313337] ACPI: Video=
 Device [VID2] (multi-head: yes =C2=A0rom: no =C2=A0post: no)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.313768] [drm] Initi=
alized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.314252] Serial: 825=
0/16550 driver, 4 ports, IRQ sharing enabled
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.321153] brd: module=
 loaded
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.323814] loop: modul=
e loaded
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.324372] Loading iSC=
SI transport class v2.0-870.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.325679] ata_piix 00=
00:00:1f.2: version 2.13
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.325706] ata_piix 00=
00:00:1f.2: PCI INT D -> GSI 19 (level, low) -> IRQ 19
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.326042] ata_piix 00=
00:00:1f.2: MAP [ P0 -- P1 -- ]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.326420] ata_piix 00=
00:00:1f.2: setting latency timer to 64
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.326548] scsi0 : ata=
_piix
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.327157] scsi1 : ata=
_piix
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.329192] ata1: SATA =
max UDMA/133 cmd 0x6e70 ctl 0x6e78 bmdma 0x6ea0 irq 19
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.329525] ata2: SATA =
max UDMA/133 cmd 0x6e80 ctl 0x6e88 bmdma 0x6ea8 irq 19
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.329918] ata_piix 00=
00:00:1f.5: PCI INT D -> GSI 19 (level, low) -> IRQ 19
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.330280] ata_piix 00=
00:00:1f.5: MAP [ P0 -- P1 -- ]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.483399] ata_piix 00=
00:00:1f.5: setting latency timer to 64
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.483472] scsi2 : ata=
_piix
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.483889] scsi3 : ata=
_piix
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.494799] ata3: SATA =
max UDMA/133 cmd 0x6eb0 ctl 0x6eb8 bmdma 0x6ee0 irq 19
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.505374] ata4: SATA =
max UDMA/133 cmd 0x6ec0 ctl 0x6ec8 bmdma 0x6ee8 irq 19
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.517131] tg3.c:v3.10=
2 (September 1, 2009)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.527407] tg3 0000:09=
:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.537850] tg3 0000:09=
:00.0: setting latency timer to 64
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.556144] eth0: Tigon=
3 [partno(BCM95756m) rev a200] (PCI Express) MAC address 00:21:9b:f5:60=
:0f
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.566888] eth0: attac=
hed PHY is 5722/5756 (10/100/1000Base-T Ethernet) (WireSpeed[1])
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.577614] eth0: RXcsu=
ms[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.588351] eth0: dma_r=
wctrl[76180000] dma_mask[64-bit]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.599287] sky2 driver=
 version 1.25
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.610019] PPP generic=
 driver version 2.4.2
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.620820] PPP Deflate=
 Compression module registered
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.631273] PPP BSD Com=
pression module registered
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.642068] PPP MPPE Co=
mpression module registered
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.652346] NET: Regist=
ered protocol family 24
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.662740] PPPoL2TP ke=
rnel driver, V1.0
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.673215] SLIP: versi=
on 0.8.4-NET3.019-NEWTTY (dynamic channels, max=3D256) (6 bit encapsula=
tion enabled).
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.684287] CSLIP: code=
 copyright 1989 Regents of the University of California.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.695418] SLIP linefi=
ll/keepalive option.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.706655] console [ne=
tcon0] enabled
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.717759] netconsole:=
 network logging started
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.729216] ehci_hcd: U=
SB 2.0 'Enhanced' Host Controller (EHCI) Driver
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.740669] ehci_hcd 00=
00:00:1a.7: PCI INT C -> GSI 22 (level, low) -> IRQ 22
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.752135] ehci_hcd 00=
00:00:1a.7: setting latency timer to 64
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.752141] ehci_hcd 00=
00:00:1a.7: EHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.763541] ehci_hcd 00=
00:00:1a.7: new USB bus registered, assigned bus number 1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.774930] ehci_hcd 00=
00:00:1a.7: debug port 1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.789956] ehci_hcd 00=
00:00:1a.7: cache line size of 32 is not supported
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.789984] ehci_hcd 00=
00:00:1a.7: irq 22, io mem 0xfed1c400
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.803419] ata2: SATA =
link up 1.5 Gbps (SStatus 113 SControl 300)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.805095] ata1: SATA =
link up 3.0 Gbps (SStatus 123 SControl 300)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.838801] ata4: SATA =
link down (SStatus 4 SControl 300)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.850203] ata3: SATA =
link down (SStatus 0 SControl 300)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.850605] ehci_hcd 00=
00:00:1a.7: USB 2.0 started, EHCI 1.00
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.850787] usb usb1: N=
ew USB device found, idVendor=3D1d6b, idProduct=3D0002
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.850790] usb usb1: N=
ew USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.850793] usb usb1: P=
roduct: EHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.850795] usb usb1: M=
anufacturer: Linux 2.6.32-rc5-00081-g964fe08 ehci_hcd
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.850797] usb usb1: S=
erialNumber: 0000:00:1a.7
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.851349] usb usb1: c=
onfiguration #1 chosen from 1 choice
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.851747] hub 1-0:1.0=
: USB hub found
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.851792] hub 1-0:1.0=
: 6 ports detected
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.852198] ehci_hcd 00=
00:00:1d.7: PCI INT A -> GSI 20 (level, low) -> IRQ 20
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.852216] ehci_hcd 00=
00:00:1d.7: setting latency timer to 64
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.852220] ehci_hcd 00=
00:00:1d.7: EHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.852233] ehci_hcd 00=
00:00:1d.7: new USB bus registered, assigned bus number 2
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.852275] ehci_hcd 00=
00:00:1d.7: debug port 1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.856179] ehci_hcd 00=
00:00:1d.7: cache line size of 32 is not supported
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A02.856205] ehci_hcd 00=
00:00:1d.7: irq 20, io mem 0xfed1c000
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.000521] ata1.00: AT=
A-8: ST9160310AS, DE04, max UDMA/133
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.000905] ata2.00: AT=
API: TSSTcorp DVD+/-RW TS-L633A, D500, max UDMA/100
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.000919] ata2.00: ap=
plying bridge limits
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.030396] ata2.00: co=
nfigured for UDMA/100
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.040423] ehci_hcd 00=
00:00:1d.7: USB 2.0 started, EHCI 1.00
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.040485] ata1.00: 31=
2581808 sectors, multi 8: LBA48 NCQ (depth 0/32)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.060761] usb usb2: N=
ew USB device found, idVendor=3D1d6b, idProduct=3D0002
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.071186] usb usb2: N=
ew USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.071212] ata1.00: co=
nfigured for UDMA/133
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.071835] scsi 0:0:0:=
0: Direct-Access =C2=A0 =C2=A0 ATA =C2=A0 =C2=A0 =C2=A0ST9160310AS =C2=A0=
 =C2=A0 =C2=A0DE04 PQ: 0 ANSI: 5
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.073532] sd 0:0:0:0:=
 Attached scsi generic sg0 type 0
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.074208] sd 0:0:0:0:=
 [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.074331] sd 0:0:0:0:=
 [sda] Write Protect is off
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.074334] sd 0:0:0:0:=
 [sda] Mode Sense: 00 3a 00 00
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.074397] sd 0:0:0:0:=
 [sda] Write cache: enabled, read cache: enabled, doesn't support DPO o=
r FUA
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.142477] usb usb2: P=
roduct: EHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.152723] usb usb2: M=
anufacturer: Linux 2.6.32-rc5-00081-g964fe08 ehci_hcd
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.163136] usb usb2: S=
erialNumber: 0000:00:1d.7
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.173957] usb usb2: c=
onfiguration #1 chosen from 1 choice
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.184694] hub 2-0:1.0=
: USB hub found
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.186168] scsi 1:0:0:=
0: CD-ROM =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TSSTcorp DVD+-RW TS-=
L633A D500 PQ: 0 ANSI: 5
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.205673] =C2=A0sda:
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.205887] hub 2-0:1.0=
: 6 ports detected
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.226536] uhci_hcd: U=
SB Universal Host Controller Interface driver
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.236805] uhci_hcd 00=
00:00:1a.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.247146] uhci_hcd 00=
00:00:1a.0: setting latency timer to 64
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.247152] uhci_hcd 00=
00:00:1a.0: UHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.257722] uhci_hcd 00=
00:00:1a.0: new USB bus registered, assigned bus number 3
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.268019] uhci_hcd 00=
00:00:1a.0: irq 20, io base 0x00006f60
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.271348] sr0: scsi3-=
mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.271352] Uniform CD-=
ROM driver Revision: 3.20
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.271935] sr 1:0:0:0:=
 Attached scsi CD-ROM sr0
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.272214] sr 1:0:0:0:=
 Attached scsi generic sg1 type 5
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.309009] usb usb3: N=
ew USB device found, idVendor=3D1d6b, idProduct=3D0001
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.319485] usb usb3: N=
ew USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.329938] usb usb3: P=
roduct: UHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.340494] usb usb3: M=
anufacturer: Linux 2.6.32-rc5-00081-g964fe08 uhci_hcd
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.351173] usb usb3: S=
erialNumber: 0000:00:1a.0
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.362274] usb usb3: c=
onfiguration #1 chosen from 1 choice
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.373209] hub 3-0:1.0=
: USB hub found
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.383878] hub 3-0:1.0=
: 2 ports detected
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.394578] uhci_hcd 00=
00:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.405325] uhci_hcd 00=
00:00:1a.1: setting latency timer to 64
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.405330] uhci_hcd 00=
00:00:1a.1: UHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.415917] uhci_hcd 00=
00:00:1a.1: new USB bus registered, assigned bus number 4
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.426596] uhci_hcd 00=
00:00:1a.1: irq 21, io base 0x00006f80
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.437249] usb usb4: N=
ew USB device found, idVendor=3D1d6b, idProduct=3D0001
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.447963] usb usb4: N=
ew USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.458896] usb usb4: P=
roduct: UHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.469684] usb usb4: M=
anufacturer: Linux 2.6.32-rc5-00081-g964fe08 uhci_hcd
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.480609] usb usb4: S=
erialNumber: 0000:00:1a.1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.491487] =C2=A0sda1 =
sda2 sda3 sda4 <
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.491970] usb usb4: c=
onfiguration #1 chosen from 1 choice
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.513750] hub 4-0:1.0=
: USB hub found
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.524608] hub 4-0:1.0=
: 2 ports detected
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.535457] uhci_hcd 00=
00:00:1a.2: PCI INT C -> GSI 22 (level, low) -> IRQ 22
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.546368] uhci_hcd 00=
00:00:1a.2: setting latency timer to 64
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.546373] uhci_hcd 00=
00:00:1a.2: UHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.557269] uhci_hcd 00=
00:00:1a.2: new USB bus registered, assigned bus number 5
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.568246] uhci_hcd 00=
00:00:1a.2: irq 22, io base 0x00006fa0
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.579151] usb usb5: N=
ew USB device found, idVendor=3D1d6b, idProduct=3D0001
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.590038] usb usb5: N=
ew USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.601062] usb usb5: P=
roduct: UHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.611827] usb usb5: M=
anufacturer: Linux 2.6.32-rc5-00081-g964fe08 uhci_hcd
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.622664] usb usb5: S=
erialNumber: 0000:00:1a.2
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.633580] usb usb5: c=
onfiguration #1 chosen from 1 choice
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.644466] hub 5-0:1.0=
: USB hub found
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.655057] hub 5-0:1.0=
: 2 ports detected
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.665643] uhci_hcd 00=
00:00:1d.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.676188] uhci_hcd 00=
00:00:1d.0: setting latency timer to 64
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.676193] uhci_hcd 00=
00:00:1d.0: UHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.686592] uhci_hcd 00=
00:00:1d.0: new USB bus registered, assigned bus number 6
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.697039] uhci_hcd 00=
00:00:1d.0: irq 20, io base 0x00006f00
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.707478] usb usb6: N=
ew USB device found, idVendor=3D1d6b, idProduct=3D0001
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.717980] usb usb6: N=
ew USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.728432] usb usb6: P=
roduct: UHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.738725] usb usb6: M=
anufacturer: Linux 2.6.32-rc5-00081-g964fe08 uhci_hcd
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.749227] usb usb6: S=
erialNumber: 0000:00:1d.0
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.759744] =C2=A0sda5
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.759936] usb usb6: c=
onfiguration #1 chosen from 1 choice
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.780577] hub 6-0:1.0=
: USB hub found
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.790864] hub 6-0:1.0=
: 2 ports detected
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.801175] uhci_hcd 00=
00:00:1d.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.811517] uhci_hcd 00=
00:00:1d.1: setting latency timer to 64
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.811523] uhci_hcd 00=
00:00:1d.1: UHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.821680] uhci_hcd 00=
00:00:1d.1: new USB bus registered, assigned bus number 7
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.831928] uhci_hcd 00=
00:00:1d.1: irq 21, io base 0x00006f20
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.842070] usb usb7: N=
ew USB device found, idVendor=3D1d6b, idProduct=3D0001
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.852336] usb usb7: N=
ew USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.862506] usb usb7: P=
roduct: UHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.872556] usb usb7: M=
anufacturer: Linux 2.6.32-rc5-00081-g964fe08 uhci_hcd
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.882704] usb usb7: S=
erialNumber: 0000:00:1d.1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.893017] usb usb7: c=
onfiguration #1 chosen from 1 choice
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.903360] hub 7-0:1.0=
: USB hub found
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.913514] hub 7-0:1.0=
: 2 ports detected
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.923668] uhci_hcd 00=
00:00:1d.2: PCI INT C -> GSI 22 (level, low) -> IRQ 22
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.933900] uhci_hcd 00=
00:00:1d.2: setting latency timer to 64
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.933906] uhci_hcd 00=
00:00:1d.2: UHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.944027] uhci_hcd 00=
00:00:1d.2: new USB bus registered, assigned bus number 8
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.954264] uhci_hcd 00=
00:00:1d.2: irq 22, io base 0x00006f40
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.964387] usb usb8: N=
ew USB device found, idVendor=3D1d6b, idProduct=3D0001
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.974574] usb usb8: N=
ew USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.984724] usb usb8: P=
roduct: UHCI Host Controller
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A03.994775] usb usb8: M=
anufacturer: Linux 2.6.32-rc5-00081-g964fe08 uhci_hcd
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.004946] usb usb8: S=
erialNumber: 0000:00:1d.2
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.015031] =C2=A0sda6
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.015363] usb usb8: c=
onfiguration #1 chosen from 1 choice
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.035532] hub 8-0:1.0=
: USB hub found
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.045674] hub 8-0:1.0=
: 2 ports detected
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.055871] Initializin=
g USB Mass Storage driver...
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.065990] usbcore: re=
gistered new interface driver usb-storage
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.076095] USB Mass St=
orage support registered.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.086460] usbcore: re=
gistered new interface driver libusual
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.096753] PNP: PS/2 C=
ontroller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.107118] drivers/inp=
ut/serio/i8042.c: 25 <- i8042 (flush, kbd) [3]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.107251] drivers/inp=
ut/serio/i8042.c: 20 -> i8042 (command) [3]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.107260] drivers/inp=
ut/serio/i8042.c: 1f <- i8042 (return) [3]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.107265] i8042.c: Wa=
rning: Keylock active.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.117378] drivers/inp=
ut/serio/i8042.c: 60 -> i8042 (command) [6]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.117437] drivers/inp=
ut/serio/i8042.c: 1e -> i8042 (parameter) [6]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.117497] drivers/inp=
ut/serio/i8042.c: 65 <- i8042 (flush, kbd) [6]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.117557] drivers/inp=
ut/serio/i8042.c: d3 -> i8042 (command) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.117668] drivers/inp=
ut/serio/i8042.c: 5a -> i8042 (parameter) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.117992] drivers/inp=
ut/serio/i8042.c: 5a <- i8042 (return) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.118003] drivers/inp=
ut/serio/i8042.c: a7 -> i8042 (command) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.118061] drivers/inp=
ut/serio/i8042.c: 20 -> i8042 (command) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.118383] drivers/inp=
ut/serio/i8042.c: 3e <- i8042 (return) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.118388] drivers/inp=
ut/serio/i8042.c: a8 -> i8042 (command) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.118445] drivers/inp=
ut/serio/i8042.c: 20 -> i8042 (command) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.118768] drivers/inp=
ut/serio/i8042.c: 1e <- i8042 (return) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.118773] drivers/inp=
ut/serio/i8042.c: 60 -> i8042 (command) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.118832] drivers/inp=
ut/serio/i8042.c: 3c -> i8042 (parameter) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.118998] drivers/inp=
ut/serio/i8042.c: d3 -> i8042 (command) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.119110] drivers/inp=
ut/serio/i8042.c: f0 -> i8042 (parameter) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.119434] drivers/inp=
ut/serio/i8042.c: f0 <- i8042 (return) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.119439] drivers/inp=
ut/serio/i8042.c: d3 -> i8042 (command) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.119498] drivers/inp=
ut/serio/i8042.c: 56 -> i8042 (parameter) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.119770] drivers/inp=
ut/serio/i8042.c: 56 <- i8042 (return) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.119775] drivers/inp=
ut/serio/i8042.c: d3 -> i8042 (command) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.119834] drivers/inp=
ut/serio/i8042.c: a4 -> i8042 (parameter) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.120159] drivers/inp=
ut/serio/i8042.c: a4 <- i8042 (return) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.120194] drivers/inp=
ut/serio/i8042.c: 60 -> i8042 (command) [7]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.122915] drivers/inp=
ut/serio/i8042.c: 1e -> i8042 (parameter) [8]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.123043] drivers/inp=
ut/serio/i8042.c: 60 -> i8042 (command) [8]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.123154] drivers/inp=
ut/serio/i8042.c: 0f -> i8042 (parameter) [8]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.123160] serio: i804=
2 KBD port at 0x60,0x64 irq 1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.123464] drivers/inp=
ut/serio/i8042.c: 20 <- i8042 (interrupt, 0, 1) [8]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.133281] drivers/inp=
ut/serio/i8042.c: a0 <- i8042 (interrupt, 0, 1) [11]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.133325] serio: i804=
2 AUX port at 0x60,0x64 irq 12
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.133411] drivers/inp=
ut/serio/i8042.c: 1e <- i8042 (interrupt, 0, 1) [11]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.143256] drivers/inp=
ut/serio/i8042.c: a5 <- i8042 (interrupt, 0, 1) [14]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.143385] drivers/inp=
ut/serio/i8042.c: 26 <- i8042 (interrupt, 0, 1) [14]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.143527] drivers/inp=
ut/serio/i8042.c: 25 <- i8042 (interrupt, 0, 1) [14]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.143662] drivers/inp=
ut/serio/i8042.c: 9f <- i8042 (interrupt, 0, 1) [14]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.143670] mice: PS/2 =
mouse device common for all mice
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.153624] drivers/inp=
ut/serio/i8042.c: a6 <- i8042 (interrupt, 0, 1) [17]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.153754] drivers/inp=
ut/serio/i8042.c: 21 <- i8042 (interrupt, 0, 1) [17]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.153937] drivers/inp=
ut/serio/i8042.c: 24 <- i8042 (interrupt, 0, 1) [17]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.154696] drivers/inp=
ut/serio/i8042.c: f2 -> i8042 (kbd-data) [18]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.154826] Driver 'rtc=
_cmos' needs updating - please use bus_type methods
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.154947] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [18]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.164935] drivers/inp=
ut/serio/i8042.c: ab <- i8042 (interrupt, 0, 1) [21]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.165054] rtc_cmos 00=
:03: RTC can wake from S4
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.165068] drivers/inp=
ut/serio/i8042.c: 41 <- i8042 (interrupt, 0, 1) [21]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.165086] drivers/inp=
ut/serio/i8042.c: ed -> i8042 (kbd-data) [21]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.175208] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [24]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.175226] drivers/inp=
ut/serio/i8042.c: 00 -> i8042 (kbd-data) [24]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.175345] drivers/inp=
ut/serio/i8042.c: a5 <- i8042 (interrupt, 0, 1) [24]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.175471] rtc_cmos 00=
:03: rtc core: registered rtc_cmos as rtc0
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.185639] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [27]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.185661] drivers/inp=
ut/serio/i8042.c: f3 -> i8042 (kbd-data) [27]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.185698] rtc0: alarm=
s up to one month, y3k, 114 bytes nvram, hpet irqs
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.185957] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [27]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.185972] drivers/inp=
ut/serio/i8042.c: 00 -> i8042 (kbd-data) [27]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.195933] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [30]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.195955] drivers/inp=
ut/serio/i8042.c: f4 -> i8042 (kbd-data) [30]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.196035] i2c /dev en=
tries driver
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.197044] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [30]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.197497] input: AT R=
aw Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.197766] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [31]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.197825] drivers/inp=
ut/serio/i8042.c: f2 -> i8042 (parameter) [31]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.216640] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [36]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.216785] drivers/inp=
ut/serio/i8042.c: 00 <- i8042 (interrupt, 1, 12) [36]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.216818] drivers/inp=
ut/serio/i8042.c: 60 -> i8042 (command) [36]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.216878] drivers/inp=
ut/serio/i8042.c: 0d -> i8042 (parameter) [36]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.216988] drivers/inp=
ut/serio/i8042.c: 60 -> i8042 (command) [36]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.217099] drivers/inp=
ut/serio/i8042.c: 0f -> i8042 (parameter) [36]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.217241] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [36]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.217353] drivers/inp=
ut/serio/i8042.c: f2 -> i8042 (parameter) [36]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.218739] i801_smbus =
0000:00:1f.3: PCI INT B -> GSI 19 (level, low) -> IRQ 19
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.220373] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [37]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.229267] drivers/inp=
ut/serio/i8042.c: 00 <- i8042 (interrupt, 1, 12) [40]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.229290] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [40]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.229455] drivers/inp=
ut/serio/i8042.c: f6 -> i8042 (parameter) [40]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.229467] drivers/inp=
ut/serio/i8042.c: 20 <- i8042 (interrupt, 0, 1) [40]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.229570] atkbd.c: Un=
known key pressed (raw set 2, code 0x20 on isa0060/serio0).
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.232057] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [40]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.232608] atkbd.c: Us=
e 'setkeycodes 20 <keycode>' to make it known.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.250787] drivers/inp=
ut/serio/i8042.c: 1f <- i8042 (interrupt, 0, 1) [47]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.250794] atkbd.c: Un=
known key pressed (raw set 2, code 0x1f on isa0060/serio0).
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.254107] atkbd.c: Us=
e 'setkeycodes 1f <keycode>' to make it known.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.272408] =C2=A0sda7
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.272598] i6300ESB ti=
mer: Intel 6300ESB WatchDog Timer Driver v0.04
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.272602] async/1 use=
d greatest stack depth: 6128 bytes left
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.272704] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [53]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.272763] drivers/inp=
ut/serio/i8042.c: f3 -> i8042 (parameter) [53]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.273045] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [53]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.273062] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [53]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.273121] drivers/inp=
ut/serio/i8042.c: 0a -> i8042 (parameter) [53]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.304310] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [63]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.304334] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [63]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.304393] drivers/inp=
ut/serio/i8042.c: e8 -> i8042 (parameter) [63]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.304575] iTCO_wdt: I=
ntel TCO WatchDog Timer Driver v1.05
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.304733] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [63]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.304749] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [63]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.304807] drivers/inp=
ut/serio/i8042.c: 00 -> i8042 (parameter) [63]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.315406] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [66]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.315429] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [66]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.315540] drivers/inp=
ut/serio/i8042.c: f3 -> i8042 (parameter) [66]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.315726] iTCO_wdt: F=
ound a ICH9M TCO device (Version=3D2, TCOBASE=3D0x1060)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.315835] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [66]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.315850] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [66]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.315909] drivers/inp=
ut/serio/i8042.c: 14 -> i8042 (parameter) [66]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.326568] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [69]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.326591] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [69]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.326755] drivers/inp=
ut/serio/i8042.c: f3 -> i8042 (parameter) [69]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.326767] drivers/inp=
ut/serio/i8042.c: 25 <- i8042 (interrupt, 0, 1) [69]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.326783] iTCO_wdt: i=
nitialized. heartbeat=3D30 sec (nowayout=3D0)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.337663] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [73]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.337682] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [73]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.337692] iTCO_vendor=
_support: vendor-support=3D0
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.337846] drivers/inp=
ut/serio/i8042.c: 3c -> i8042 (parameter) [73]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.337858] drivers/inp=
ut/serio/i8042.c: a4 <- i8042 (interrupt, 0, 1) [73]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.337871] atkbd.c: Un=
known key pressed (raw set 2, code 0x124 on isa0060/serio0).
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.337874] atkbd.c: Us=
e 'setkeycodes 24 <keycode>' to make it known.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.370530] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [82]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.370552] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [82]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.370717] drivers/inp=
ut/serio/i8042.c: f3 -> i8042 (parameter) [82]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.370729] drivers/inp=
ut/serio/i8042.c: a1 <- i8042 (interrupt, 0, 1) [82]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.370743] atkbd.c: Un=
known key pressed (raw set 2, code 0x121 on isa0060/serio0).
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.371011] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [82]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.371197] device-mapp=
er: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.371429] device-mapp=
er: dm-log-userspace: version 1.0.0 loaded
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.372402] cpuidle: us=
ing governor ladder
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.373871] atkbd.c: Us=
e 'setkeycodes 21 <keycode>' to make it known.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.426476] drivers/inp=
ut/serio/i8042.c: 26 <- i8042 (interrupt, 0, 1) [99]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.426518] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [99]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.428191] cpuidle: us=
ing governor menu
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.429084] drivers/inp=
ut/serio/i8042.c: 28 -> i8042 (parameter) [99]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.434432] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [100]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.434478] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [102]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.434641] drivers/inp=
ut/serio/i8042.c: f3 -> i8042 (parameter) [102]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.439332] drivers/inp=
ut/serio/i8042.c: a6 <- i8042 (interrupt, 0, 1) [102]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.439347] atkbd.c: Un=
known key pressed (raw set 2, code 0x126 on isa0060/serio0).
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.439349] atkbd.c: Us=
e 'setkeycodes 26 <keycode>' to make it known.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.439654] sdhci: Secu=
re Digital Host Controller Interface driver
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.439656] sdhci: Copy=
right(c) Pierre Ossman
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.439707] sdhci-pci 0=
000:02:01.2: SDHCI controller found [1180:0822] (rev 21)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.439735] sdhci-pci 0=
000:02:01.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.442116] Registered =
led device: mmc0::
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.443389] mmc0: SDHCI=
 controller on PCI [0000:02:01.2] using DMA
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.443641] wbsd: Winbo=
nd W83L51xD SD/MMC card interface driver
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.443644] wbsd: Copyr=
ight(c) Pierre Ossman
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.444232] dcdbas dcdb=
as: Dell Systems Management Base Driver (version 5.6.0-3.2)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.447550] usbcore: re=
gistered new interface driver hiddev
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.447680] usbcore: re=
gistered new interface driver usbhid
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.447685] usbhid: v2.=
6:USB HID core driver
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.447900] Advanced Li=
nux Sound Architecture Driver Version 1.0.21.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.447902] ALSA device=
 list:
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.447904] =C2=A0 No s=
oundcards found.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.447907] Netfilter m=
essages via NETLINK v0.30.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.447987] nf_conntrac=
k version 0.5.0 (15347 buckets, 61388 max)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.448841] ctnetlink v=
0.93: registering with nfnetlink.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.450911] ip_tables: =
(C) 2000-2006 Netfilter Core Team
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.450992] TCP cubic r=
egistered
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.450997] NET: Regist=
ered protocol family 17
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.451028] lib80211: c=
ommon routines for IEEE802.11 drivers
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.451041] lib80211_cr=
ypt: registered algorithm 'NULL'
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.463024] Using IPI N=
o-Shortcut mode
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.463687] PM: Checkin=
g image partition /dev/sda8
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.463733] PM: Resume =
from partition 8:8
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.463735] PM: Checkin=
g hibernation image.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.473031] drivers/inp=
ut/serio/i8042.c: a0 <- i8042 (interrupt, 0, 1) [110]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.473047] atkbd.c: Un=
known key pressed (raw set 2, code 0x120 on isa0060/serio0).
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.473049] atkbd.c: Us=
e 'setkeycodes 20 <keycode>' to make it known.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.511209] =C2=A0sda8 =
>
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.715234] drivers/inp=
ut/serio/i8042.c: a5 <- i8042 (interrupt, 0, 1) [186]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.715242] atkbd.c: Un=
known key pressed (raw set 2, code 0x125 on isa0060/serio0).
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.715244] atkbd.c: Us=
e 'setkeycodes 25 <keycode>' to make it known.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.716589] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [186]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.716649] drivers/inp=
ut/serio/i8042.c: f3 -> i8042 (parameter) [186]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.783675] drivers/inp=
ut/serio/i8042.c: 9f <- i8042 (interrupt, 0, 1) [207]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.783683] atkbd.c: Un=
known key pressed (raw set 2, code 0x11f on isa0060/serio0).
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.783685] atkbd.c: Us=
e 'setkeycodes 1f <keycode>' to make it known.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.913583] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [246]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.956571] PM: Resume =
from disk failed.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.956677] registered =
taskstats version 1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A04.979979] sd 0:0:0:0:=
 [sda] Attached SCSI disk
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.004842] =C2=A0 Magi=
c number: 13:858:134
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.027235] acpi device=
:09: hash matches
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.049367] BIOS EDD fa=
cility v0.16 2004-Jun-25, 1 devices found
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.072385] drivers/inp=
ut/serio/i8042.c: f3 -> i8042 (parameter) [258]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.319685] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [367]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.319755] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [367]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.322450] drivers/inp=
ut/serio/i8042.c: 3c -> i8042 (parameter) [367]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.330489] drivers/inp=
ut/serio/i8042.c: 9e <- i8042 (interrupt, 0, 1) [370]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.330576] atkbd.c: Un=
known key pressed (raw set 2, code 0x11e on isa0060/serio0).
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.333797] atkbd.c: Us=
e 'setkeycodes 1e <keycode>' to make it known.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.520261] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [428]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.523457] drivers/inp=
ut/serio/i8042.c: f3 -> i8042 (parameter) [486]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.839759] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [523]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.839792] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [523]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.842149] drivers/inp=
ut/serio/i8042.c: 28 -> i8042 (parameter) [524]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.847357] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [526]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.847398] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [526]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.847514] drivers/inp=
ut/serio/i8042.c: f3 -> i8042 (parameter) [526]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.847894] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [526]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.847929] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [526]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.847991] drivers/inp=
ut/serio/i8042.c: 14 -> i8042 (parameter) [526]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.853332] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [527]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.853374] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [528]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.853435] drivers/inp=
ut/serio/i8042.c: f3 -> i8042 (parameter) [528]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.853865] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [528]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.853899] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [528]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.853960] drivers/inp=
ut/serio/i8042.c: 14 -> i8042 (parameter) [528]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.859306] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [529]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.859347] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [529]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.859408] drivers/inp=
ut/serio/i8042.c: f2 -> i8042 (parameter) [529]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.862548] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [530]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.863755] drivers/inp=
ut/serio/i8042.c: 00 <- i8042 (interrupt, 1, 12) [531]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.863796] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [531]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.863857] drivers/inp=
ut/serio/i8042.c: e8 -> i8042 (parameter) [531]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.864236] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [531]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.864269] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [531]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.864331] drivers/inp=
ut/serio/i8042.c: 00 -> i8042 (parameter) [531]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.869766] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [532]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.869806] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [532]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.869867] drivers/inp=
ut/serio/i8042.c: e8 -> i8042 (parameter) [532]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.870251] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [533]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.870284] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [533]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.870346] drivers/inp=
ut/serio/i8042.c: 00 -> i8042 (parameter) [533]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.875813] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [534]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.875853] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [534]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.875914] drivers/inp=
ut/serio/i8042.c: e8 -> i8042 (parameter) [534]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.876297] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [534]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.876330] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [534]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.876391] drivers/inp=
ut/serio/i8042.c: 00 -> i8042 (parameter) [534]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.881873] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [536]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.881913] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [536]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.881975] drivers/inp=
ut/serio/i8042.c: e8 -> i8042 (parameter) [536]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.882340] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [536]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.882374] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [536]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.882435] drivers/inp=
ut/serio/i8042.c: 00 -> i8042 (parameter) [536]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.887905] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [538]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.887945] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [538]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.888007] drivers/inp=
ut/serio/i8042.c: e9 -> i8042 (parameter) [538]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.891177] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [539]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.894188] drivers/inp=
ut/serio/i8042.c: 00 <- i8042 (interrupt, 1, 12) [540]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.894315] drivers/inp=
ut/serio/i8042.c: 00 <- i8042 (interrupt, 1, 12) [540]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.894538] drivers/inp=
ut/serio/i8042.c: 14 <- i8042 (interrupt, 1, 12) [540]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.894577] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [540]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.894638] drivers/inp=
ut/serio/i8042.c: f6 -> i8042 (parameter) [540]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.897753] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [541]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.897793] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [541]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.897855] drivers/inp=
ut/serio/i8042.c: e8 -> i8042 (parameter) [541]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.898230] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [541]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.898264] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [541]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.898326] drivers/inp=
ut/serio/i8042.c: 00 -> i8042 (parameter) [541]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.903804] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [543]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.903844] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [543]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.903905] drivers/inp=
ut/serio/i8042.c: e6 -> i8042 (parameter) [543]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.907069] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [544]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.907109] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [544]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.907170] drivers/inp=
ut/serio/i8042.c: e6 -> i8042 (parameter) [544]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.909865] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [544]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.909905] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [544]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.909966] drivers/inp=
ut/serio/i8042.c: e6 -> i8042 (parameter) [544]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.913103] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [545]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.913143] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [545]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.913204] drivers/inp=
ut/serio/i8042.c: e9 -> i8042 (parameter) [545]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.916550] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [546]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.919557] drivers/inp=
ut/serio/i8042.c: 00 <- i8042 (interrupt, 1, 12) [547]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.919719] drivers/inp=
ut/serio/i8042.c: 00 <- i8042 (interrupt, 1, 12) [547]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.919932] drivers/inp=
ut/serio/i8042.c: 64 <- i8042 (interrupt, 1, 12) [547]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.919971] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [547]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.920032] drivers/inp=
ut/serio/i8042.c: e8 -> i8042 (parameter) [547]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.920396] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [548]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.920430] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [548]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.920491] drivers/inp=
ut/serio/i8042.c: 00 -> i8042 (parameter) [548]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.925916] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [549]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.925956] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [549]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.926018] drivers/inp=
ut/serio/i8042.c: e7 -> i8042 (parameter) [549]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.929179] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [550]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.929219] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [550]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.929281] drivers/inp=
ut/serio/i8042.c: e7 -> i8042 (parameter) [550]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.932607] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [551]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.932647] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [551]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.932708] drivers/inp=
ut/serio/i8042.c: e7 -> i8042 (parameter) [551]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.936036] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [552]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.936076] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [552]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.936137] drivers/inp=
ut/serio/i8042.c: e9 -> i8042 (parameter) [552]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.939444] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [553]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.942512] drivers/inp=
ut/serio/i8042.c: 73 <- i8042 (interrupt, 1, 12) [554]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.942673] drivers/inp=
ut/serio/i8042.c: 02 <- i8042 (interrupt, 1, 12) [554]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.942886] drivers/inp=
ut/serio/i8042.c: 50 <- i8042 (interrupt, 1, 12) [554]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.942933] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [554]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.942995] drivers/inp=
ut/serio/i8042.c: e8 -> i8042 (parameter) [554]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.943347] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [555]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.943381] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [555]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.943442] drivers/inp=
ut/serio/i8042.c: 00 -> i8042 (parameter) [555]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.948979] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [556]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.949020] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [556]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.949081] drivers/inp=
ut/serio/i8042.c: e6 -> i8042 (parameter) [556]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.952244] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [557]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.952284] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [557]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.952345] drivers/inp=
ut/serio/i8042.c: e6 -> i8042 (parameter) [557]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.954432] async/0 use=
d greatest stack depth: 6036 bytes left
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.955629] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [558]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.955687] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [558]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.955750] drivers/inp=
ut/serio/i8042.c: e6 -> i8042 (parameter) [558]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.959057] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [558]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.959168] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [558]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.959231] drivers/inp=
ut/serio/i8042.c: e9 -> i8042 (parameter) [558]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.976954] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [565]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.977073] drivers/inp=
ut/serio/i8042.c: 00 <- i8042 (interrupt, 1, 12) [565]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.977191] drivers/inp=
ut/serio/i8042.c: 00 <- i8042 (interrupt, 1, 12) [565]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.977336] drivers/inp=
ut/serio/i8042.c: 64 <- i8042 (interrupt, 1, 12) [565]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.977370] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [565]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.977431] drivers/inp=
ut/serio/i8042.c: e8 -> i8042 (parameter) [565]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.977798] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [565]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.977826] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [565]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.977888] drivers/inp=
ut/serio/i8042.c: 00 -> i8042 (parameter) [565]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.983314] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [566]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.983369] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [566]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.983430] drivers/inp=
ut/serio/i8042.c: e7 -> i8042 (parameter) [566]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.986598] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [567]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.986633] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [567]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.986694] drivers/inp=
ut/serio/i8042.c: e7 -> i8042 (parameter) [567]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.990039] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [568]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.990150] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [568]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.990214] drivers/inp=
ut/serio/i8042.c: e7 -> i8042 (parameter) [568]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.993986] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [569]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.994064] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [569]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.994128] drivers/inp=
ut/serio/i8042.c: e9 -> i8042 (parameter) [569]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A05.997399] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [570]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.000394] drivers/inp=
ut/serio/i8042.c: 73 <- i8042 (interrupt, 1, 12) [571]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.000638] drivers/inp=
ut/serio/i8042.c: 02 <- i8042 (interrupt, 1, 12) [571]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.000855] drivers/inp=
ut/serio/i8042.c: 50 <- i8042 (interrupt, 1, 12) [571]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.000975] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [572]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.001040] drivers/inp=
ut/serio/i8042.c: e9 -> i8042 (parameter) [572]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.004211] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [572]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.007249] drivers/inp=
ut/serio/i8042.c: 10 <- i8042 (interrupt, 1, 12) [574]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.007387] drivers/inp=
ut/serio/i8042.c: 00 <- i8042 (interrupt, 1, 12) [574]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.007641] drivers/inp=
ut/serio/i8042.c: 64 <- i8042 (interrupt, 1, 12) [574]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.007729] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [574]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.007793] drivers/inp=
ut/serio/i8042.c: f5 -> i8042 (parameter) [574]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.010910] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [575]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.010995] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [575]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.011059] drivers/inp=
ut/serio/i8042.c: f5 -> i8042 (parameter) [575]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.014288] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [576]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.014374] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [576]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.014439] drivers/inp=
ut/serio/i8042.c: f3 -> i8042 (parameter) [576]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.014840] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [576]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.014914] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [576]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.014979] drivers/inp=
ut/serio/i8042.c: 0a -> i8042 (parameter) [576]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.020364] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [578]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.020451] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [578]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.020516] drivers/inp=
ut/serio/i8042.c: f5 -> i8042 (parameter) [578]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.023620] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [579]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.023705] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [579]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.023770] drivers/inp=
ut/serio/i8042.c: f5 -> i8042 (parameter) [579]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.026976] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [580]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.027063] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [580]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.027601] drivers/inp=
ut/serio/i8042.c: f5 -> i8042 (parameter) [580]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.030817] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [581]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.030875] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [581]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.030939] drivers/inp=
ut/serio/i8042.c: e9 -> i8042 (parameter) [581]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.034248] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [582]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.037294] drivers/inp=
ut/serio/i8042.c: 15 <- i8042 (interrupt, 1, 12) [583]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.037432] drivers/inp=
ut/serio/i8042.c: 01 <- i8042 (interrupt, 1, 12) [583]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.037673] drivers/inp=
ut/serio/i8042.c: 0a <- i8042 (interrupt, 1, 12) [583]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.037760] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [583]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.037824] drivers/inp=
ut/serio/i8042.c: f5 -> i8042 (parameter) [583]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.040942] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [584]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.041029] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [584]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.041094] drivers/inp=
ut/serio/i8042.c: f5 -> i8042 (parameter) [584]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.044325] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [585]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.044411] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [585]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.044475] drivers/inp=
ut/serio/i8042.c: f5 -> i8042 (parameter) [585]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.047695] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [586]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.047781] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [586]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.047846] drivers/inp=
ut/serio/i8042.c: f5 -> i8042 (parameter) [586]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.051075] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [587]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.051161] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [587]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.051225] drivers/inp=
ut/serio/i8042.c: f4 -> i8042 (parameter) [587]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.054427] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [588]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.054516] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [588]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.054580] drivers/inp=
ut/serio/i8042.c: f0 -> i8042 (parameter) [588]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.057823] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [589]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.057908] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [589]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.057973] drivers/inp=
ut/serio/i8042.c: ea -> i8042 (parameter) [589]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.061698] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [590]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.062978] input: PS/2=
 Mouse as /devices/platform/i8042/serio1/input/input6
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.086920] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [598]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.086986] drivers/inp=
ut/serio/i8042.c: f3 -> i8042 (parameter) [598]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.087282] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [598]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.087325] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [598]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.087390] drivers/inp=
ut/serio/i8042.c: 64 -> i8042 (parameter) [598]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.092777] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [599]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.092861] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [599]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.092925] drivers/inp=
ut/serio/i8042.c: e8 -> i8042 (parameter) [599]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.093316] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [599]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.093426] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [600]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.093491] drivers/inp=
ut/serio/i8042.c: 03 -> i8042 (parameter) [600]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.098930] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [601]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.099009] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [601]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.099074] drivers/inp=
ut/serio/i8042.c: e6 -> i8042 (parameter) [601]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.102264] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [602]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.102920] input: Alps=
PS/2 ALPS GlidePoint as /devices/platform/i8042/serio1/input/input7
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.126546] drivers/inp=
ut/serio/i8042.c: d4 -> i8042 (command) [609]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.126612] drivers/inp=
ut/serio/i8042.c: f4 -> i8042 (parameter) [609]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.129705] drivers/inp=
ut/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [610]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.129990] md: Waiting=
 for all devices to be available before autodetect
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.152892] md: If you =
don't use raid, use raid=3Dnoautodetect
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.178277] md: Autodet=
ecting RAID arrays.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.189302] md: Scanned=
 0 and added 0 devices.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.200230] md: autorun=
 ...
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.211012] md: ... aut=
orun DONE.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.501012] kjournald s=
tarting. =C2=A0Commit interval 5 seconds
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.501731] EXT3-fs: mo=
unted filesystem with writeback data mode.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.501973] VFS: Mounte=
d root (ext3 filesystem) readonly on device 8:2.
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.566188] Freeing unu=
sed kernel memory: 384k freed
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.588717] Write prote=
cting the kernel text: 3404k
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A06.599694] Write prote=
cting the kernel read-only data: 1932k
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A08.993092] cdrom_id us=
ed greatest stack depth: 5856 bytes left
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.012525] cfg80211: U=
sing static regulatory domain info
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.023380] cfg80211: R=
egulatory domain: US
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.033906] ^I(start_fr=
eq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.044924] ^I(2402000 =
KHz - 2472000 KHz @ 40000 KHz), (600 mBi, 2700 mBm)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.055982] ^I(5170000 =
KHz - 5190000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.066742] ^I(5190000 =
KHz - 5210000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.069530] ACPI: WMI: =
Mapper loaded
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.088499] ^I(5210000 =
KHz - 5230000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.099789] ^I(5230000 =
KHz - 5330000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.110511] ^I(5735000 =
KHz - 5835000 KHz @ 40000 KHz), (600 mBi, 3000 mBm)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.215994] cfg80211: C=
alling CRDA for country: US
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.576264] b43-phy0: B=
roadcom 4312 WLAN found (core revision 15)
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.621094] b43-phy0 de=
bug: Found PHY: Analog 6, Type 5, Revision 1
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.621119] b43-phy0 de=
bug: Found Radio: Manuf 0x17F, Version 0x2062, Revision 2
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.643418] phy0: Selec=
ted rate control algorithm 'minstrel'
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.647010] Registered =
led device: b43-phy0::tx
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.668083] Registered =
led device: b43-phy0::rx
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.688675] Registered =
led device: b43-phy0::radio
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 =C2=A09.698934] Broadcom 43=
xx driver loaded [ Features: PLS, Firmware-ID: FW13 ]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 10.006303] ohci1394 0000:02=
:01.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 10.083112] ohci1394: fw-hos=
t0: OHCI-1394 1.1 (PCI): IRQ=3D[17] =C2=A0MMIO=3D[f67ff800-f67fffff] =C2=
=A0Max Packet=3D[2048] =C2=A0IR/IT contexts=3D[4/4]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 10.189891] HDA Intel 0000:0=
0:1b.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 10.211309] HDA Intel 0000:0=
0:1b.0: setting latency timer to 64
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 10.659098] Adding 2008084k =
swap on /dev/sda8. =C2=A0Priority:-1 extents:1 across:2008084k
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 11.373895] ieee1394: Host a=
dded: ID:BUS[0-00:1023] =C2=A0GUID[464fc0001679c05c]
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 12.833903] EXT3 FS on sda2,=
 internal journal
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 17.492595] kjournald starti=
ng. =C2=A0Commit interval 5 seconds
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 17.493282] EXT3 FS on sda3,=
 internal journal
> Oct 29 15:08:32 darkstar kernel: [ =C2=A0 17.493315] EXT3-fs: mounted=
 filesystem with writeback data mode.
>
>>
>> --
>> Dmitry
>

Ping. Any further idea?

--=20
Regards
dave

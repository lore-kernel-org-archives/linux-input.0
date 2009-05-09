From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: atkbd.c: Unknown key pressed/released
Date: Sat, 09 May 2009 08:35:50 +0200
Message-ID: <4A052446.6080906@freemail.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030800070404060901090606"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail01d.mail.t-online.hu ([84.2.42.6]:57669 "EHLO
	mail01d.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbZEIGoQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 May 2009 02:44:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------030800070404060901090606
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit

Hi,

I have a Clevo D410J laptop (see dmidecode output attached). When I press the
"Application Launch" special key I get the following message in dmesg:

[   60.865561] atkbd.c: Unknown key pressed (translated set 2, code 0x81 on isa0060/serio0).
[   60.865574] atkbd.c: Use 'setkeycodes e001 <keycode>' to make it known.
[   60.967948] atkbd.c: Unknown key released (translated set 2, code 0x81 on isa0060/serio0).
[   60.967962] atkbd.c: Use 'setkeycodes e001 <keycode>' to make it known.

Is it possible to add support for the "Application Launch" key directly
in the kernel? I am currently running Linux kernel 2.6.30-rc5.

Regards,

	Márton Németh

--------------030800070404060901090606
Content-Type: text/plain;
 name="dmidecode-Clevo-D410J.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode-Clevo-D410J.txt"

# dmidecode 2.9
SMBIOS 2.34 present.
39 structures occupying 956 bytes.
Table at 0x000D8010.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
	Vendor: Phoenix
	Version: 4.06CJ15   
	Release Date: 12/08/2004
	Address: 0xE4540
	Runtime Size: 113344 bytes
	ROM Size: 512 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		APM is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		USB legacy is supported
		Smart battery is supported
		BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
	Manufacturer: VIA
	Product Name: K8N800
	Version: VT8204B 
	Serial Number: 000001
	UUID: 0090F53E-5ACA-0000-0000-000000000000
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: VIA
	Product Name: K8N800
	Version: None
	Serial Number: None

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: No Enclosure
	Type: Other
	Lock: Not Present
	Version: N/A
	Serial Number: None
	Asset Tag: No Asset Tag
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: Socket 754
	Type: Central Processor
	Family: Sempron
	Manufacturer: AuthenticAMD
	ID: C0 0F 01 00 FF FB 8B 07
	Signature: Family 15, Model 28, Stepping 0
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
	Version: Mobile Sempron    
	Voltage: 3.3 V
	External Clock: Unknown
	Max Speed: 2500 MHz
	Current Speed: 1600 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 16 KB
	Maximum Size: 16 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Through
	Location: External
	Installed Size: 128 KB
	Maximum Size: 512 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Primary IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Secondary IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: FLOPPY
	Internal Connector Type: On Board Floppy
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: COM1
	External Connector Type: DB-9 male
	Port Type: Serial Port XT/AT Compatible

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: COM2
	External Connector Type: DB-9 male
	Port Type: Serial Port XT/AT Compatible

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: Printer
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: KBD
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: Mouse
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CD_IN
	Internal Connector Type: On Board Sound Input From CD-ROM
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: Game Port
	External Connector Type: DB-15 female
	Port Type: Joystick Port

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: MIC_IN
	External Connector Type: RJ-11
	Port Type: MIDI Port

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: LINE_IN
	External Connector Type: RJ-11
	Port Type: MIDI Port

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: LINE_OUT
	External Connector Type: RJ-11
	Port Type: MIDI Port

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: FC
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: MIDI Port

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB1
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: USB

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB2
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: USB

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB3
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: USB

Handle 0x0018, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot 1
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Long
	ID: 1
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x0019, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot 2
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 2
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x001A, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot 3
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 3
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x001B, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot 4
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 3
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x001C, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: VIA 8235 Sound

Handle 0x001D, DMI type 11, 5 bytes
OEM Strings
	String 1: VIA
	String 2: www.via.com.tw
	String 3: w3.via.com.tw

Handle 0x001E, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x001F, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x001E
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: 1
	Locator: S1
	Bank Locator: Bank 1
	Type: DRAM
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0020, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x001E
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: 2
	Locator: S2
	Bank Locator: Bank 2
	Type: DRAM
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0021, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x001E
	Partition Width: 0

Handle 0x0022, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x001F
	Memory Array Mapped Address Handle: 0x0001
	Partition Row Position: 1

Handle 0x0023, DMI type 23, 13 bytes
System Reset
	Status: Enabled
	Watchdog Timer: Present
	Boot Option: Do Not Reboot
	Boot Option On Limit: Do Not Reboot
	Reset Count: Unknown
	Reset Limit: Unknown
	Timer Interval: Unknown
	Timeout: Unknown

Handle 0x0024, DMI type 24, 5 bytes
Hardware Security
	Power-On Password Status: Disabled
	Keyboard Password Status: Unknown
	Administrator Password Status: Enabled
	Front Panel Reset Status: Unknown

Handle 0x0025, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0026, DMI type 127, 4 bytes
End Of Table


--------------030800070404060901090606--

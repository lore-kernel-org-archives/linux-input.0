From: Kim Phillips <kim@kimphillips.com>
Subject: Re: [PATCH] Input: synaptics - add PNP IDs for Dell XPS models to
 forcepad
Date: Sat, 12 Jan 2019 16:04:36 -0600
Message-ID: <22e2d619-0622-1816-2057-c9005288b46b@kimphillips.com>
References: <20190111205430.15371-1-kim@kimphillips.com>
 <20190112014004.GA122403@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190112014004.GA122403@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 1/11/19 7:40 PM, Dmitry Torokhov wrote:
> Hi Kim,

Hi Dmitry,

> On Fri, Jan 11, 2019 at 02:54:30PM -0600, Kim Phillips wrote:
>> This patch is the result of seeing this message:
>>
>> psmouse serio1: synaptics: Your touchpad (PNP: DLL087c PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
>>
>> If I set psmouse.synaptics_intertouch=1, or add the PNP ID to
>> smbus_pnp_ids, the touchpad continues to work, and the above message
>> goes away, but we now get:
>>
>> psmouse serio1: synaptics: Trying to set up SMBus access
>> psmouse serio1: synaptics: SMbus companion is not ready yet
>>
>> With this patch applied, i.e., the PNP IDs are added to the forcepad
>> array, the touchpad continues to work and all of the above messages
>> disappear.
> 
> Are you sure the touchpad in XPSes is a forcepad (i.e. it does not have
> physical button underneath it)? As far as I know there were only couple
> of HP laptops with forcepads and when switching to RMI mode forcepads
> need F21 handler that we do not currently have in the kernel.

I see, no, I'm not sure, but assuming you're right, the IDs 
should be added to the smbus array instead, after fixing 
the SMbus "companion not ready" problem?  Pointers for that and 
the below interrupts when touchpad idle after resume, welcome.

Also, the link to get the RMI4 spec in
Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
is broken.  Any pointers for that also appreciated.

>> ---
>> With or without this patch, I'm seeing a problem where when the XPS 15
>> comes out of a resume, and without even touching the touchpad, I notice
>> about 600 interrupts per second firing on the "IR-IO-APIC   51-fasteoi
>> SYNA2393:00" line in /proc/interrupts.  If I start using the touchpad,
>> then leave it alone, I check if there are still interrupts firing, and
>> they have indeed stopped.  This adversely affects my battery life when
>> using an external mouse.  Any ideas on how to debug the situation?
>> Could it be related to the 'vdd not found' messages?:
>>
>> $ dmesg | grep -C 1 -i syna
>> probe of 1-12 returned 1 after 2343 usecs
>> psmouse serio1: synaptics: queried max coordinates: x [..5664], y [..4646]
>> psmouse serio1: synaptics: queried min coordinates: x [1278..], y [1206..]
>> psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf00123/0x840300/0x12e800/0x0, board id: 3125, fw id: 2378871
>> input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input6
>> probe of serio1 returned 1 after 939332 usecs
>> --
>> probe of idma64.1 returned 1 after 72 usecs
>> i2c_hid i2c-SYNA2393:00: i2c-SYNA2393:00 supply vdd not found, using dummy regulator
>> i2c_hid i2c-SYNA2393:00: Linked as a consumer to regulator.0
>> i2c_hid i2c-SYNA2393:00: i2c-SYNA2393:00 supply vddl not found, using dummy regulator
>> ath10k_pci 0000:3b:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
>> --
>> ath10k_pci 0000:3b:00.0: firmware ver WLAN.RM.4.4.1-00079-QCARMSWPZ-1 api 6 features wowlan,ignore-otp crc32 fd869beb
>> probe of i2c-SYNA2393:00 returned 1 after 23978 usecs
>> ath10k_pci 0000:3b:00.0: board_file api 2 bmi_id N/A crc32 20d869c3
>> --
>> probe of 0018:056A:488F.0001 returned 1 after 1366 usecs
>> input: SYNA2393:00 06CB:7A13 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-10/i2c-SYNA2393:00/0018:06CB:7A13.0002/input/input23
>> input: SYNA2393:00 06CB:7A13 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-10/i2c-SYNA2393:00/0018:06CB:7A13.0002/input/input24
>> hid-generic 0018:06CB:7A13.0002: input,hidraw1: I2C HID v1.00 Mouse [SYNA2393:00 06CB:7A13] on i2c-SYNA2393:00
>> probe of 0018:06CB:7A13.0002 returned 1 after 320 usecs
>> --
>> probe of 0018:06CB:7A13.0002 returned 0 after 5 usecs
>> input: SYNA2393:00 06CB:7A13 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-10/i2c-SYNA2393:00/0018:06CB:7A13.0002/input/input27
>> hid-multitouch 0018:06CB:7A13.0002: input,hidraw1: I2C HID v1.00 Mouse [SYNA2393:00 06CB:7A13] on i2c-SYNA2393:00
>> probe of 0018:06CB:7A13.0002 returned 1 after 25104 usecs

Thanks,

Kim

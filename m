From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 0/7] usbhid: add load-time and run-time USB HID quirks
 configuration
Date: Sun, 18 Mar 2007 22:21:41 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0703182032400.21893@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org


The USB HID quirk list ('hid_blacklist') is a compile-time fixed array
in the current kernel.  Any modifications require editing the module
source and recompiling.  Some distributions compile the usbhid code
into the kernel, thus requiring that the entire kernel be rebuilt.

For most HID devices, this is not a major problem, since quirks are
unlikely to change often.  Some devices, however, have multiple
drivers available, requiring different HID quirks.  For example, the
LabJack U12 data acquisition device requires HID_QUIRK_IGNORE for one
driver and HID_QUIRK_HIDDEV for another.  With a static hid_blacklist
array, switching between the two is quite difficult.

This series of patches fixes this problem by adding a new module
parameter 'hid_quirks' which allows quirks to be modified at boot or
module load-time.  These quirks can also be reviewed and configured at
runtime via a procfs file, /proc/usbhid/device_quirks.  (This latter
ability is controlled by the Kconfig option CONFIG_USBHID_PROC_FS.)  The 
patches also add a new field 'idProductMask' to the hid_blacklist, so some 
of the multiple-device vendor quirks can be converted into list entries 
efficiently.

Against 2.6.21-rc4.  Comments welcome,


- Paul

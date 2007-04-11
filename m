From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 0/7] usbhid: quirks cleanup, add dynamic quirks, ConfigFS
 interface
Date: Wed, 11 Apr 2007 00:49:50 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0704110003460.28726@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: jikos@jikos.cz
List-Id: linux-input@vger.kernel.org


Hello,

As requested, I respun the runtime USB HID quirks patches that I posted a 
few weeks ago.  My application for this code is to switch quirks at 
runtime for a data acquisition device.  This device has at least two 
drivers written for it: one kernel module driver requiring 
HID_QUIRK_IGNORE; one userspace driver based on hiddev requiring 
HID_QUIRK_HIDDEV.  Maybe others will find this code useful.

Patches 1-3 are cleanup and reorganization.  The primary changes move USB 
HID quirk handling into its own files, hid-quirks.[ch].  There should be 
no behavioral changes after 1-3 are applied.  These patches touch the 
Bluetooth HID code lightly, since it references HID quirk #defines.

Patches 4-6 implement dynamic quirk handling ("equirks" for extra quirks) 
and support changing these quirks with a module parameter, 'quirks'. 
Jiri, this uses a separate list as we discussed.  Documentation is in 
kernel-parameters.txt.

Patch 7 implements a ConfigFS-based interface to add/modify/remove dynamic 
quirks while the usbhid module is loaded.  We'd discussed using sysfs for 
this, but upon further consideration, blacklists don't seem to fit into 
the sysfs model very well.  ConfigFS seemed like a better approach.  Not 
that I'm entirely happy with it - it requires a lot of code/data.  oh 
well.  Documentation is included as part of the Kconfig option.

Much of this code could probably be shared with the Bluetooth HID 
subsystem.  I guess there's been some discussion about this recently.  If 
this code seems more appropriate to drivers/hid/, I'd be happy to
reshuffle it.

Jiri, I think I've cleaned up most of the other coding style issues that 
you mentioned.  Please let me know if there's more that needs to be done.

Patches against 2.6.21-rc6.


- Paul

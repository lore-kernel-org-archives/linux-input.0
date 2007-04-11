From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 0/6] usbhid: quirks cleanup, add dynamic quirks, ConfigFS
 interface
Date: Wed, 11 Apr 2007 12:54:53 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0704111248110.28726@utopia.booyaka.com>
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


Changes from the patchset I sent last night are:

- rebased against current mm branch of hid.git
- fixed whitespace
- renamed 'equirks' to 'dquirks'
- renamed struct hid_quirk_name to hid_quirk_type

----

My application for this code is to switch quirks at runtime for a data 
acquisition device.  This device has at least two drivers written for it: 
one kernel module driver requiring HID_QUIRK_IGNORE; one userspace driver 
based on hiddev requiring HID_QUIRK_HIDDEV.  Maybe others will find this 
code useful.

Patches 1-2 are cleanup and reorganization.  The primary changes move USB 
HID quirk handling into its own files, hid-quirks.[ch].  There should be 
no behavioral changes after 1-2 are applied.  These patches touch the 
Bluetooth HID code lightly, since it references HID quirk #defines.

Patches 3-5 implement dynamic quirk handling ("dquirks" for dynamic 
quirks) and support changing these quirks with a module parameter, 
'quirks'. Jiri, this uses a separate list as we discussed.  Documentation 
is in kernel-parameters.txt.

Patch 6 implements a ConfigFS-based interface to add/modify/remove dynamic 
quirks while the usbhid module is loaded.  We'd discussed using sysfs for 
this, but upon further consideration, blacklists don't seem to fit into 
the sysfs model very well.  ConfigFS seemed like a better approach.  Not 
that I'm entirely happy with it - it requires a lot of code/data.  oh 
well.  Documentation is included as part of the Kconfig option.

Patches against current mm branch of hid.git.


- Paul

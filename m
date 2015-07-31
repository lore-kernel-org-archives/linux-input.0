From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v4 8/8] DO NOT APPLY! goodix configuration update helper
Date: Fri, 31 Jul 2015 20:42:12 +0300
Message-ID: <1438364532-27150-9-git-send-email-irina.tirdea@intel.com>
References: <1438364532-27150-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438364532-27150-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-input@vger.kernel.org

This patch is not meant to be applied. It can be used to test
updates to the goodix touchscreen configuration.

It provides a bash script to help generate a new configuration
starting from the one read from the device.

Below are instructions on how to test that the config is correctly
updated for goodix 911 touchscreens. For other models you need to
replace 911 with your model ID.

On the target:
- dump current configuration of the device:
$ cat /sys/class/input/input4/device/dump_config > goodix_911_cfg

On the host:
 - modify some fields from goodix_911_cfg (e.g. change resolution of
x/y axes, maximum reported touch points, switch X,Y axes). For more
details check datasheet for format of Configuration Registers.
 - run tools/touch-goodix-generate-fw.sh on the modified script to
obtain a valid config (it needs to recompute the checksum, set
Config_Fresh to 1 and generate the binary config firmware image):
$ ./tools/touch-goodix-generate-fw.sh goodix_911_cfg
 - copy goodix_911_cfg.bin on the target in /lib/firmware
 - when the goodix driver is initialized it will read the new config
firmware from /lib/firmware/goodix_911_cfg.bin and write it to the
device
 - check that the new firmware was actually written to the device by
reading the config again on the target from
/sys/class/input/input4/device/dump_config. Also check that Config_Fresh
has been reset to 0. You can also check if the functionality changed
in the config has actually changed (reported resolution for x/y has
changed, x,y axis are switched, etc.)

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 tools/touch-goodix-generate-fw.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100755 tools/touch-goodix-generate-fw.sh

diff --git a/tools/touch-goodix-generate-fw.sh b/tools/touch-goodix-generate-fw.sh
new file mode 100755
index 0000000..0efe2e1
--- /dev/null
+++ b/tools/touch-goodix-generate-fw.sh
@@ -0,0 +1,39 @@
+#!/bin/bash
+
+if [[ $# -lt 1 ]]; then
+    echo "$0 fw_filename"
+    exit 1
+fi
+
+file_in="$1"
+file_out_bin=${file_in}.bin
+
+print_val ()
+{
+    val="$1"
+    printf "0x%.2x" "$val" | xxd -r -p >> ${file_out_bin}
+}
+
+rm -f ${file_out_bin}
+
+size=`cat ${file_in} | wc -w`
+
+checksum=0
+i=1
+for val in `cat ${file_in}`; do
+    val="0x$val"
+    if [[ $i == $size ]]; then
+	# Config_Fresh
+	print_val 0x01
+    elif [[ $i == $((size-1)) ]]; then
+	# Config_Chksum
+	checksum=$(( (~ checksum + 1) & 0xFF))
+	print_val $checksum
+    else
+	checksum=$((checksum + val))
+	print_val $val
+    fi
+    i=$((i+1))
+done
+
+echo "Wrote ${file_out_bin}"
-- 
1.9.1

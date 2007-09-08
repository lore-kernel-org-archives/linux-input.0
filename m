From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: sysfs change of input/event devices in 2.6.23rc breaks udev
Date: Sat, 08 Sep 2007 20:08:34 +0300
Message-ID: <46E2D712.1010402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi!

There seem to be changes in sysfs input structure between 2.6.22 and 
2.6.23-rc5 which cause some breakage.

With 2.6.22:

> # LC_ALL=C ls -l /sys/class/input/input4
> total 0
> drwxr-xr-x 2 root root    0 Sep  8 12:51 capabilities/
> lrwxrwxrwx 1 root root    0 Sep  8 19:48 device -> ../../../devices/platform/pcspkr/
> drwxr-xr-x 2 root root    0 Sep  8 12:51 event4/
> drwxr-xr-x 2 root root    0 Sep  8 12:51 id/
> -r--r--r-- 1 root root 4096 Sep  8 19:48 modalias
> -r--r--r-- 1 root root 4096 Sep  8 19:48 name
> -r--r--r-- 1 root root 4096 Sep  8 19:48 phys
> lrwxrwxrwx 1 root root    0 Sep  8 19:48 subsystem -> ../../../class/input/
> --w------- 1 root root 4096 Sep  8 19:48 uevent
> -r--r--r-- 1 root root 4096 Sep  8 19:48 uniq

> # ls -l /sys/class/input/event4
> lrwxrwxrwx 1 root root 0 Sep  8 19:48 /sys/class/input/event4 -> ../../class/input/input4/event4/
> # ls -l /sys/class/input/event4/
> total 0
> -r--r--r-- 1 root root 4096 Sep  8 19:58 dev
> lrwxrwxrwx 1 root root    0 Sep  8 19:58 device -> ../../../../devices/platform/pcspkr/
> lrwxrwxrwx 1 root root    0 Sep  8 19:58 subsystem -> ../../../../class/input/
> --w------- 1 root root 4096 Sep  8 19:58 uevent

With 2.6.23-rc5:

> # ls -l /sys/class/input/input5
> total 0
> drwxr-xr-x 2 root root    0 Sep  8 19:47 capabilities/
> lrwxrwxrwx 1 root root    0 Sep  8 19:03 device -> ../../../devices/platform/pcspkr/
> drwxr-xr-x 2 root root    0 Sep  8 19:47 id/
> lrwxrwxrwx 1 root root    0 Sep  8 19:47 input:event5 -> ../../../class/input/event5/
> -r--r--r-- 1 root root 4096 Sep  8 19:03 modalias
> -r--r--r-- 1 root root 4096 Sep  8 19:03 name
> -r--r--r-- 1 root root 4096 Sep  8 19:47 phys
> drwxr-xr-x 2 root root    0 Sep  8 19:47 power/
> lrwxrwxrwx 1 root root    0 Sep  8 19:03 subsystem -> ../../../class/input/
> -rw-r--r-- 1 root root 4096 Sep  8 19:03 uevent
> -r--r--r-- 1 root root 4096 Sep  8 19:47 uniq

> # ls -l /sys/class/input/event5
> total 0
> -r--r--r-- 1 root root 4096 Sep  8 19:03 dev
> lrwxrwxrwx 1 root root    0 Sep  8 19:03 device -> ../../../class/input/input5/
> drwxr-xr-x 2 root root    0 Sep  8 19:48 power/
> lrwxrwxrwx 1 root root    0 Sep  8 19:03 subsystem -> ../../../class/input/
> -rw-r--r-- 1 root root 4096 Sep  8 19:03 uevent

There are a few changes.

There is no longer:
/sys/class/input/eventX => /sys/class/input/inputX/eventX
instead there is:
/sys/class/inputX/input:eventX => /sys/class/input/eventX
Notice the added "input:". I don't know if any software depends on this, 
though.

However, the change that broke id_path of udev is that 
/sys/class/input/event5/device is now a symlink to the inputX directory 
instead of being the same as the device symlink in inputX directory, 
i.e. to ../../../devices/platform/pcspkr in this case.

Udev id_path uses that directory to construct the ID_PATH variable. 
Should the sysfs structure be reverted or should udev be adapted to 
handle traversing /device symlink twice? I think the former, as there 
should be considerably more time to adapt udev for coming changes in sysfs.

-- 
Anssi Hannula

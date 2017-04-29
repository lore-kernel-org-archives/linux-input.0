From: Roy Wellington <deathanatos@gmail.com>
Subject: Kernel bug/driver crash? while changing settings of Trackpoint mouse
 on Thinkpad T460p
Date: Sat, 29 Apr 2017 13:10:56 -0700
Message-ID: <CAF5E6=panu0+FpSWbmRh4UzYmq_uzNGKbiocBvpXSiGSzXfbPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35719 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755963AbdD2UK5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 29 Apr 2017 16:10:57 -0400
Received: by mail-oi0-f46.google.com with SMTP id l18so54926oig.2
        for <linux-input@vger.kernel.org>; Sat, 29 Apr 2017 13:10:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,

I own a T460p Lenovo ThinkPad laptop, which includes a TrackPoint
mouse. (A small red eraserhead-like object in the middle of the
keyboard that can be pushed on to move the mouse.)

On boot, it starts with a speed & sensitivity of 97 and 200,
respectively, which I find much too low. There are some files exposed
in /sys that appear to be for the purpose of modifying these values:

# pwd
/sys/devices/platform/i8042/serio1/serio2
# ls -l
total 0
-rw-r--r-- 1 root root 4096 Mar  8 19:20 bind_mode
-r--r--r-- 1 root root 4096 Mar  8 19:20 description
-rw-r--r-- 1 root root 4096 Apr 29 12:27 draghys
-rw-r--r-- 1 root root 4096 Apr 29 12:27 drift_time
lrwxrwxrwx 1 root root    0 Apr 29 12:26 driver ->
../../../../../bus/serio/drivers/psmouse
--w------- 1 root root 4096 Mar  8 19:20 drvctl
-rw-r--r-- 1 root root 4096 Apr 29 12:27 ext_dev
-r--r--r-- 1 root root 4096 Mar  8 19:20 firmware_id
drwxr-xr-x 2 root root    0 Mar  8 15:39 id
-rw-r--r-- 1 root root 4096 Apr 29 12:27 inertia
drwxr-xr-x 3 root root    0 Apr 29 12:26 input
-rw-r--r-- 1 root root 4096 Apr 29 12:27 jenks
-rw-r--r-- 1 root root 4096 Apr 29 12:27 mindrag
-r--r--r-- 1 root root 4096 Mar  8 19:20 modalias
drwxr-xr-x 2 root root    0 Mar  8 19:13 power
-rw-r--r-- 1 root root 4096 Apr 29 12:27 press_to_select
-rw-r--r-- 1 root root 4096 Apr 29 12:27 protocol
-rw-r--r-- 1 root root 4096 Apr 29 12:27 rate
-rw-r--r-- 1 root root 4096 Apr 29 12:27 reach
-rw-r--r-- 1 root root 4096 Apr 29 12:27 resetafter
-rw-r--r-- 1 root root 4096 Apr 29 12:27 resolution
-rw-r--r-- 1 root root 4096 Apr 29 12:27 resync_time
-rw-r--r-- 1 root root 4096 Apr 29 12:27 sensitivity
-rw-r--r-- 1 root root 4096 Apr 29 12:27 skipback
-rw-r--r-- 1 root root 4096 Apr 29 12:27 speed
lrwxrwxrwx 1 root root    0 Mar  8 15:38 subsystem -> ../../../../../bus/se=
rio
-rw-r--r-- 1 root root 4096 Apr 29 12:27 thresh
-rw-r--r-- 1 root root 4096 Mar  8 19:20 uevent
-rw-r--r-- 1 root root 4096 Apr 29 12:27 upthresh
-rw-r--r-- 1 root root 4096 Apr 29 12:27 ztime


Sometimes, writing to "speed" and "sensitivity" seems to work as I
expect (cat'ing the file shows the written value, and the mouse's
behavior changes). However, quite often when I attempt to write to
these files, the write will have no effect:

# printf '200' > speed
# cat speed
97


Sometimes, the writing process gets I/O errors, other times, the write
hands entirely. Typically, when a write "fails" in any manner (hangs,
errors, or has no effect), it appears that the device gets reset,
because the values that cat shows reset to the defaults. (i.e., if I
successfully set speed, but writing to sensitivity fails, then speed
gets reset, making the whole process very frustrating.)

Additionally, sometimes while setting these values the mouse will
"hang", in that it starts ignoring input for a good few seconds.
(again, it seems to get reset)


I get odd entries in dmesg too, that lead me to think I'm looking at a
bug. I get lots of these:

[4210625.035118] psmouse serio2: Failed to deactivate mouse on
synaptics-pt/serio0
[4210625.498402] psmouse serio2: Failed to enable mouse on synaptics-pt/ser=
io0
[4210626.299358] psmouse serio2: trackpoint: IBM TrackPoint firmware:
0x0e, buttons: 3/3
[4210626.495468] input: TPPS/2 IBM TrackPoint as
/devices/platform/i8042/serio1/serio2/input/input47
[4210628.805004] psmouse serio2: Failed to deactivate mouse on
synaptics-pt/serio0
[4210629.265010] psmouse serio2: Failed to enable mouse on synaptics-pt/ser=
io0
[4210630.055310] psmouse serio2: trackpoint: IBM TrackPoint firmware:
0x0e, buttons: 3/3
[4210630.247025] input: TPPS/2 IBM TrackPoint as
/devices/platform/i8042/serio1/serio2/input/input48


(more of the same)

and occasionally stuff like this:
[4210650.914935] psmouse serio2: Failed to deactivate mouse on
synaptics-pt/serio0
[4210651.378276] psmouse serio2: Failed to enable mouse on synaptics-pt/ser=
io0
[4210652.317323] psmouse serio2: trackpoint: IBM TrackPoint firmware:
0x0e, buttons: 3/3
[4210652.512726] input: TPPS/2 IBM TrackPoint as
/devices/platform/i8042/serio1/serio2/input/input52
[4210780.931315] INFO: task kworker/0:1:17657 blocked for more than 120 sec=
onds.
[4210780.931323]    Not tainted 4.9.11-1-ARCH #1
[4210780.931324] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[4210780.931325] kworker/0:1    D  0 17657    2 0x00000000
[4210780.931339] Workqueue: events_long serio_handle_event [serio]
[4210780.931342]  ffff88081a891400 0000000000000000 ffff88081cd5bb00
ffff8808414180c0
[4210780.931344]  ffffffff81a0e500 ffffc9000b2bbc10 ffffffff8160606f
ffffffff810c3ee6
[4210780.931346]  00ff880819754610 ffff8808414180c0 ffff880819754640
ffff88081cd5bb00
[4210780.931348] Call Trace:
[4210780.931356]  [<ffffffff8160606f>] ? __schedule+0x22f/0x6e0
[4210780.931360]  [<ffffffff810c3ee6>] ? finish_wait+0x56/0x70
[4210780.931361]  [<ffffffff8160655d>] schedule+0x3d/0x90
[4210780.931364]  [<ffffffff81291868>] __kernfs_remove+0x1a8/0x240
[4210780.931365]  [<ffffffff810c4250>] ? wake_atomic_t_function+0x60/0x60
[4210780.931368]  [<ffffffff81292563>] kernfs_remove_by_name_ns+0x43/0xa0
[4210780.931371]  [<ffffffff81294d55>] remove_files.isra.0+0x35/0x70
[4210780.931373]  [<ffffffff81295104>] sysfs_remove_group+0x44/0x90
[4210780.931376]  [<ffffffffa099aa14>] trackpoint_disconnect+0x24/0x40 [psm=
ouse]
[4210780.931378]  [<ffffffffa098c3c6>] psmouse_disconnect+0x96/0x150 [psmou=
se]
[4210780.931379]  [<ffffffffa0000200>] serio_disconnect_driver+0x30/0x40 [s=
erio]
[4210780.931381]  [<ffffffffa0000225>] serio_driver_remove+0x15/0x20 [serio=
]
[4210780.931386]  [<ffffffff81451fe1>] __device_release_driver+0xa1/0x160
[4210780.931387]  [<ffffffff814520c3>] device_release_driver+0x23/0x30
[4210780.931389]  [<ffffffffa00005b7>] serio_disconnect_port+0x97/0xa0 [ser=
io]
[4210780.931390]  [<ffffffffa0001216>] serio_handle_event+0x166/0x220 [seri=
o]
[4210780.931395]  [<ffffffff81098ad5>] process_one_work+0x1e5/0x470
[4210780.931397]  [<ffffffff81098da8>] worker_thread+0x48/0x4e0
[4210780.931398]  [<ffffffff81098d60>] ? process_one_work+0x470/0x470
[4210780.931400]  [<ffffffff81098d60>] ? process_one_work+0x470/0x470
[4210780.931401]  [<ffffffff8109e939>] kthread+0xd9/0xf0
[4210780.931402]  [<ffffffff8102d752>] ? __switch_to+0x2d2/0x630
[4210780.931403]  [<ffffffff8109e860>] ? kthread_park+0x60/0x60
[4210780.931405]  [<ffffffff8160ad55>] ret_from_fork+0x25/0x30
[4210833.480972] psmouse serio2: trackpoint: IBM TrackPoint firmware:
0x0e, buttons: 3/3
[4210833.672221] input: TPPS/2 IBM TrackPoint as
/devices/platform/i8042/serio1/serio2/input/input53


When it says "blocked for more than 120 seconds", my mouse was
completely unresponsive for about the same amount of time.
The source for this seems to be drivers/input/mouse/trackpoint.c,
which I gave a read but couldn't really make much of. I'm not really
sure where to go with this, so I'm reporting it here. Any help would
be appreciated, and if there's anything I could do to provide more
info, let me know.

Thanks,
=E2=80=94Roy Wellington

From: Alexander Babayants <babayants.alexander@gmail.com>
Subject: Re: PROBLEM: atkbd: Incorrect (?) handling of BAT from laptop PS/2 keyboard
Date: Tue, 4 Jul 2017 14:31:57 +0300
Message-ID: <CAB92dJaSnsTW8ig337=v6SgbqPRivy9Mip71fktezbW0Cka4sQ@mail.gmail.com>
References: <CAB92dJZtxT2+CqKyNjW5NuE8wWvXVmKknt5muHZdbucXXRMT5A@mail.gmail.com>
 <20170702202535.GA3935@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38681 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbdGDLb7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Jul 2017 07:31:59 -0400
Received: by mail-wm0-f41.google.com with SMTP id f67so81605762wmh.1
        for <linux-input@vger.kernel.org>; Tue, 04 Jul 2017 04:31:58 -0700 (PDT)
In-Reply-To: <20170702202535.GA3935@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

2017-07-02 23:25 GMT+03:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> I would be interesting to see the command stream there. Can you try
> booting with i8042.debug and reproducing the issue?

I think this is the part where the keyboard initialization happens:
[    0.000000] Command line: initrd=\initramfs-linux.img
root=/dev/sda6 rw i8042.debug=1
[    0.000000] Kernel command line: initrd=\initramfs-linux.img
root=/dev/sda6 rw i8042.debug=1
[    6.001554] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]
at 0x60,0x64 irq 1,12
[    6.001574] i8042: [0] d1 -> i8042 (command)
[    6.002098] i8042: [0] df -> i8042 (parameter)
[    6.002157] i8042: [0] ff -> i8042 (command)
[    6.002214] i8042: [0] aa <- i8042 (flush, kbd)
[    6.003510] i8042: [0] 20 -> i8042 (command)
[    6.003518] i8042: [0] 9d <- i8042 (return)
[    6.003571] i8042: [0] 20 -> i8042 (command)
[    6.003576] i8042: [0] 65 <- i8042 (return)
[    6.003629] i8042: [0] 20 -> i8042 (command)
[    6.003635] i8042: [0] 65 <- i8042 (return)
[    6.003639] i8042: [0] 60 -> i8042 (command)
[    6.003799] i8042: [0] 74 -> i8042 (parameter)
[    6.003856] i8042: [0] 65 <- i8042 (flush, kbd)
[    6.003914] i8042: [0] d3 -> i8042 (command)
[    6.004851] i8042: [1] 5a -> i8042 (parameter)
[    6.004962] i8042: [1] 5a <- i8042 (return)
[    6.004982] i8042: [1] a7 -> i8042 (command)
[    6.005192] i8042: [1] 20 -> i8042 (command)
[    6.005198] i8042: [1] 74 <- i8042 (return)
[    6.005200] i8042: [1] a8 -> i8042 (command)
[    6.005358] i8042: [1] 20 -> i8042 (command)
[    6.005364] i8042: [1] 54 <- i8042 (return)
[    6.005367] i8042: [1] 60 -> i8042 (command)
[    6.005526] i8042: [1] 74 -> i8042 (parameter)
[    6.005688] i8042: [1] d3 -> i8042 (command)
[    6.006468] i8042: [1] f0 -> i8042 (parameter)
[    6.006579] i8042: [1] f0 <- i8042 (return)
[    6.006582] i8042: [1] d3 -> i8042 (command)
[    6.007465] i8042: [2] 56 -> i8042 (parameter)
[    6.007576] i8042: [2] 56 <- i8042 (return)
[    6.007588] i8042: [2] d3 -> i8042 (command)
[    6.008628] i8042: [2] a4 -> i8042 (parameter)
[    6.008739] i8042: [2] a4 <- i8042 (return)
[    6.008764] i8042: [2] 60 -> i8042 (command)
[    6.008924] i8042: [2] 56 -> i8042 (parameter)
[    6.008940] i8042: [2] Interrupt 1, without any data
[    6.009102] i8042: [2] 60 -> i8042 (command)
[    6.009261] i8042: [2] 47 -> i8042 (parameter)
[    6.009264] serio: i8042 KBD port at 0x60,0x64 irq 1
[    6.009350] serio: i8042 AUX port at 0x60,0x64 irq 12
[    6.010010] i8042: [2] b8 <- i8042 (interrupt, 0, 1)
[    6.011180] i8042: [3] e0 <- i8042 (interrupt, 0, 1)
[    6.013453] i8042: [3] 9d <- i8042 (interrupt, 0, 1)
[    6.015734] i8042: [4] b6 <- i8042 (interrupt, 0, 1)
[    6.016704] i8042: [4] e0 <- i8042 (interrupt, 0, 1)
[    6.018599] i8042: [5] b8 <- i8042 (interrupt, 0, 1)
[    6.044183] i8042: [13] f2 -> i8042 (kbd-data)
[    6.045444] i8042: [13] fa <- i8042 (interrupt, 0, 1)
[    6.046079] i8042: [13] ab <- i8042 (interrupt, 0, 1)
[    6.046731] i8042: [13] 41 <- i8042 (interrupt, 0, 1)
[    6.046745] i8042: [13] f5 -> i8042 (kbd-data)
[    6.048040] i8042: [14] fa <- i8042 (interrupt, 0, 1)
[    6.048056] i8042: [14] ed -> i8042 (kbd-data)
[    6.049348] i8042: [14] fa <- i8042 (interrupt, 0, 1)
[    6.049363] i8042: [14] 00 -> i8042 (kbd-data)
[    6.050642] i8042: [14] fa <- i8042 (interrupt, 0, 1)
[    6.050653] i8042: [14] f3 -> i8042 (kbd-data)
[    6.051939] i8042: [15] fa <- i8042 (interrupt, 0, 1)
[    6.051951] i8042: [15] 00 -> i8042 (kbd-data)
[    6.053242] i8042: [15] fa <- i8042 (interrupt, 0, 1)
[    6.053275] i8042: [15] f4 -> i8042 (kbd-data)
[    6.054542] i8042: [16] fa <- i8042 (interrupt, 0, 1)
[    6.054650] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
[    6.054694] i8042: [16] d4 -> i8042 (command)
[    6.054905] i8042: [16] f2 -> i8042 (parameter)
[    6.057267] i8042: [16] fa <- i8042 (interrupt, 1, 12)
[    6.058355] i8042: [17] 00 <- i8042 (interrupt, 1, 12)
[    6.058370] i8042: [17] 60 -> i8042 (command)
[    6.058530] i8042: [17] 45 -> i8042 (parameter)
[    6.058688] i8042: [17] 60 -> i8042 (command)
[    6.058848] i8042: [17] 47 -> i8042 (parameter)

And this is being spammed to dmesg approx. every second since keyboard
initialization:
[   89.574138] i8042: [25070] ** <- i8042 (interrupt, 0, 1)
[   89.574188] i8042: [25070] f2 -> i8042 (kbd-data)
[   89.575455] i8042: [25070] ** <- i8042 (interrupt, 0, 1)
[   89.576127] i8042: [25070] ** <- i8042 (interrupt, 0, 1)
[   89.576756] i8042: [25071] ** <- i8042 (interrupt, 0, 1)
[   89.577699] i8042: [25071] f5 -> i8042 (kbd-data)
[   89.579023] i8042: [25071] ** <- i8042 (interrupt, 0, 1)
[   89.579089] i8042: [25071] ed -> i8042 (kbd-data)
[   89.580399] i8042: [25072] ** <- i8042 (interrupt, 0, 1)
[   89.580542] i8042: [25072] 02 -> i8042 (kbd-data)
[   89.581825] i8042: [25072] ** <- i8042 (interrupt, 0, 1)
[   89.581886] i8042: [25072] f3 -> i8042 (kbd-data)
[   89.583249] i8042: [25072] ** <- i8042 (interrupt, 0, 1)
[   89.583309] i8042: [25072] 00 -> i8042 (kbd-data)
[   89.584614] i8042: [25073] ** <- i8042 (interrupt, 0, 1)
[   89.584655] i8042: [25073] f4 -> i8042 (kbd-data)
[   89.585983] i8042: [25073] ** <- i8042 (interrupt, 0, 1)
[   89.586685] i8042: [25073] ** <- i8042 (interrupt, 0, 1)
[   89.588451] i8042: [25074] ** <- i8042 (interrupt, 0, 1)
[   89.589608] i8042: [25074] ** <- i8042 (interrupt, 0, 1)
[   89.591506] i8042: [25075] ** <- i8042 (interrupt, 0, 1)
[   89.593479] i8042: [25076] ** <- i8042 (interrupt, 0, 1)
[   89.595672] i8042: [25076] ** <- i8042 (interrupt, 0, 1)
[   89.597691] i8042: [25077] ** <- i8042 (interrupt, 0, 1)
[   91.141599] i8042: [25540] ** <- i8042 (interrupt, 0, 1)
[   91.141630] i8042: [25540] f2 -> i8042 (kbd-data)
[   91.142958] i8042: [25540] ** <- i8042 (interrupt, 0, 1)
[   91.143580] i8042: [25541] ** <- i8042 (interrupt, 0, 1)
[   91.144230] i8042: [25541] ** <- i8042 (interrupt, 0, 1)
[   91.144251] i8042: [25541] f5 -> i8042 (kbd-data)
[   91.145539] i8042: [25541] ** <- i8042 (interrupt, 0, 1)
[   91.145555] i8042: [25541] ed -> i8042 (kbd-data)
[   91.146850] i8042: [25542] ** <- i8042 (interrupt, 0, 1)
[   91.146886] i8042: [25542] 02 -> i8042 (kbd-data)
[   91.148144] i8042: [25542] ** <- i8042 (interrupt, 0, 1)
[   91.148184] i8042: [25542] f3 -> i8042 (kbd-data)
[   91.149460] i8042: [25542] ** <- i8042 (interrupt, 0, 1)
[   91.149479] i8042: [25542] 00 -> i8042 (kbd-data)
[   91.150805] i8042: [25543] ** <- i8042 (interrupt, 0, 1)
[   91.150985] i8042: [25543] f4 -> i8042 (kbd-data)
[   91.152234] i8042: [25543] ** <- i8042 (interrupt, 0, 1)
[   91.153661] i8042: [25544] ** <- i8042 (interrupt, 0, 1)
[   91.155557] i8042: [25544] ** <- i8042 (interrupt, 0, 1)
[   91.157172] i8042: [25545] ** <- i8042 (interrupt, 0, 1)
[   91.158928] i8042: [25545] ** <- i8042 (interrupt, 0, 1)
[   91.160903] i8042: [25546] ** <- i8042 (interrupt, 0, 1)
[   91.162180] i8042: [25546] ** <- i8042 (interrupt, 0, 1)
[   91.163938] i8042: [25547] ** <- i8042 (interrupt, 0, 1)

If necessary, I could provide the full dmesg log, but it's quite large
(~300kb for 256 seconds since boot) and apparently it's not allowed to
attach files on the mailing list. Will it be convenient for you if I
upload it on Google Drive/Dropbox/smth.?

Regards,
Alexander Babayants.

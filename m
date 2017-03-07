From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: PS/2 keyboard non-functional after resume with i8042.nopnp
Date: Tue, 7 Mar 2017 12:36:44 +0100
Message-ID: <a531d989-5aa7-5e10-8755-c686acfe854c@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11]:33203 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754350AbdCGMNR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Mar 2017 07:13:17 -0500
Received: from keineahnung.molgen.mpg.de (keineahnung.molgen.mpg.de [141.14.17.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C75F52012BA04D
        for <linux-input@vger.kernel.org>; Tue,  7 Mar 2017 12:36:44 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Dear Linux folks,


On an ASRock E350M1 and a PS/2 keyboard connected, starting it with 
`i8042.nopnp`, the PS/2 is detected and works fine. In this case I am 
using Linux 4.10.

```
kernel: i8042: Probing ports directly.
kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
kernel: mousedev: PS/2 mouse device common for all mice
```

Suspending and resuming the system, the PS/2 keyboard then doesn’t work 
anymore. As a workaround a keyboard connected can be used.

Using PNP, that means ACPI, the keyboard also works after resume.

Is that by design? As I don’t see any i8042 messages in the log after 
resume, I wonder, if the devices on the PS/2 controller should also be 
probed during resume by the Linux kernel.


Kind regards,

Paul

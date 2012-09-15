From: Chris Rankin <rankincj@yahoo.com>
Subject: [BUG][3.5.4] No keyboard without i8042_nokbd=1 parameter
Date: Sat, 15 Sep 2012 07:48:44 -0700 (PDT)
Message-ID: <1347720524.66204.YahooMailNeo@web120302.mail.ne1.yahoo.com>
Reply-To: Chris Rankin <rankincj@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

I have recently upgraded my oldest PC from 3.4.8 to 3.5.4, but was puzzled to discover that the keyboard no longer worked unless I also added the i8042_nokbd=1 boot parameter. It turns out that 3.4.8 didn't use the i8042 keyboard device anyway:

>From 3.4.8:
...

i8042 aux: probe of 00:07 failed with error -16
i8042: PNP: PS/2 Controller [PNP0303] at 0x60,0x64 irq 1
i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
mousedev: PS/2 mouse device common for all mice
TCP: cubic registered
Registering the dns_resolver key type
Using IPI Shortcut mode
Freeing unused kernel memory: 268k freed
Write protecting the kernel text: 1628k
Write protecting the kernel read-only data: 580k
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
...

Hence adding the i8042_nokbd=1 parameter merely forces the kernel to do again what it used to do automatically.Does anyone have any theories as to why the 3.5.x kernel now needs help to set the keyboard up correctly, please?

Thanks,
Chris

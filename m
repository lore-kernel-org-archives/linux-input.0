From: Nicola Alessi <nialessi@gmx.com>
Subject: Elantech touchpad detected as Logitech PS2 Wheel Mouse
Date: Sun, 20 May 2012 20:36:37 +0200
Message-ID: <4FB939B5.4000309@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-eu.gmx.com ([213.165.64.42]:45121 "HELO
	mailout-eu.gmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756711Ab2ETSgl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 May 2012 14:36:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jj_ding@emc.com.tw, 673588@bugs.debian.org

Hi,

I'm running debian wheezy with latest kernel (uname -a gives me: Linux
ehehehpc 3.2.0-2-686-pae #1 SMP Sun May 13 07:51:23 UTC 2012 i686
GNU/Linux).
While I'm expecting the kernel to correctly detect my touchpad, it's
detected as a mouse. No scrolling, no multitouch.
Below there's a snippet of my /proc/bus/input/devices:

[...]
I: Bus=0011 Vendor=0002 Product=0001 Version=0063
N: Name="PS/2 Logitech Wheel Mouse"
P: Phys=isa0060/serio4/input0
S: Sysfs=/devices/platform/i8042/serio4/input/input7
U: Uniq=
H: Handlers=mouse0 event7
B: PROP=0
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=103
[...]

The notebook I'm using is a Fujitsu Siemens Amilo pi2515.
I also tried kernel version 3.3.6 with same results.
In both cases grep ELANTECH .config gives me:

CONFIG_MOUSE_PS2_ELANTECH=y

so I suppose it shouldn't be a kernel configuration problem.
I opened a bug on http://bugs.debian.org/673588
You can find more information and preliminary testing there.
Thank you very much for your attention.
Regards.


Nicola

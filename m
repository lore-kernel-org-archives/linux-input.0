From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [git pull] Input updates for v4.15-rc8
Date: Thu, 8 Feb 2018 11:04:22 +0100
Message-ID: <b41e15f7-845a-6873-ddd1-0829b39319a4@suse.cz>
References: <20180119174205.iq76oggc2h7neymf@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180119174205.iq76oggc2h7neymf@dtor-ws>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 01/19/2018, 06:42 PM, Dmitry Torokhov wrote:
> Please pull from:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> 
> to receive updates for the input subsystem. You will get:
> 
...
> - touchpad on Lenovo T640p is switched over to SMbus/RMI
...

> 王振杰 (1):
>       Input: synaptics - Lenovo Thinkpad T460p devices should use RMI

Hi,

one of openSUSE users with T460p reports that the touchpad is defunct
after resume in 4.15. psmouse.synaptics_intertouch=0 works around the
problem.

The problem is:
 kernel: rmi4_smbus 8-002c: failed to get SMBus version number!
 kernel: rmi4_physical rmi4-00: rmi_driver_reset_handler: Failed to read
current IRQ mask.
 kernel: rmi4_f01 rmi4-00.fn01: Failed to restore normal operation: -16.
 kernel: rmi4_f01 rmi4-00.fn01: Resume failed with code -16.
 kernel: rmi4_physical rmi4-00: Failed to suspend functions: -16
 kernel: rmi4_smbus 8-002c: Failed to resume device: -16
 kernel: rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03
TX register (-16).

The downstream bug is at:
https://bugzilla.suse.com/show_bug.cgi?id=1079862

Any ideas?

thanks,
-- 
js
suse labs

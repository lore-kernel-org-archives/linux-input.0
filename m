From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: 2.6.23-rc4: oops in evdev_disconnect
Date: Thu, 11 Oct 2007 12:04:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710111201130.25413@twin.jikos.cz>
References: <470E1272.2030300@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <470E1272.2030300@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: vojtech@suse.cz, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, 11 Oct 2007, Jiri Slaby wrote:

> after unplugging usb logitech mouse I got:
> input: Logitech Logitech USB Optical Mouse as
> /devices/pci0000:00/0000:00:1d.3/usb5/5-2/5-2:1.0/input/input10
> input: USB HID v1.11 Mouse [Logitech Logitech USB Optical Mouse] on
> usb-0000:00:1d.3-2
> usb 5-2: USB disconnect, address 6
> Unable to handle kernel paging request at 0000000000100100 RIP:
>  [<ffffffff803b6ac4>] evdev_disconnect+0xb4/0xf0

Could you by any chance try to reproduce this when Dmitry's patches 
implementing proper locking in the input subsystem are applied? Andrew's 
tree has them pulled through git-input.patch for example.

Thanks,

-- 
Jiri Kosina

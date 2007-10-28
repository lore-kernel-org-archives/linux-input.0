From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
Subject: Re: [RFC: 2.6 patch] remove the USB_STORAGE_ONETOUCH driver
Date: Sun, 28 Oct 2007 19:48:03 +0200
Message-ID: <64bb37e0710281048x589ab063o8a32294e30488979@mail.gmail.com>
References: <20071028155212.GC7227@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071028155212.GC7227@stusta.de>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Adrian Bunk <bunk@kernel.org>
Cc: Nick Sillik <n.sillik@temple.edu>, David Brownell <david-b@pacbell.net>, Greg Kroah-Hartman <gregkh@suse.de>, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

On 10/28/07, Adrian Bunk <bunk@kernel.org> wrote:
> Nearly two years ago, USB_STORAGE_ONETOUCH got a dependency on !PM.
> Considering that this also implies that the driver is not available
> e.g. when ACPI is enabled in the kernel that's not far from a dependency
> on BROKEN.
>
> This patch therefore removes this driver.

Hmm...

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c9d00fc148b210aa8cf388d6e1eac187a0e855a6
-> Adds !PM because suspend was broken (17.11.2005)

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=7931e1c6f8007d5fef8a0bb2dc71bd97315eeae9
-> Adds suspend support, but fails to remove the !PM (5.12.2005)

So it looks like that !PM is false.

I have the following device:
Bus 001 Device 005: ID 1058:0400 Western Digital Technologies, Inc.
Bus 001 Device 004: ID 1058:0600 Western Digital Technologies, Inc.
Bus 001 Device 003: ID 1058:0500 Western Digital Technologies, Inc.
aka Western Digital Media Center
This firewire+usb hdd enclosure also has three buttons.
But it looks like that uses another driver:
hiddev0hidraw1: USB HID v1.10 Device [Western Digital External HDD] on
usb-0000:00:02.1-5.2

Otherwise I would be willing to try to test this, if someone would
tell me how to check that the second commit did fix the suspend
problem.

Torsten

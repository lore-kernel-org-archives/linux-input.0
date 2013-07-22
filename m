From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2] Revert "Revert "HID: Fix logitech-dj: missing Unifying
 device issue""
Date: Mon, 22 Jul 2013 11:27:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1307221126190.1495-100000@iolanthe.rowland.org>
References: <51ED3BC3.40300@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51ED3BC3.40300@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Joseph Salisbury <joseph.salisbury@canonical.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, benjamin.tissoires@gmail.com, adlr@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 22 Jul 2013, Peter Hurley wrote:

> On 07/22/2013 07:44 AM, Jiri Kosina wrote:
...
> > Seems like this might be a part of the picture, but not a complete one.
> > Linus claims to have similar problem, but his receiver is not connected
> > through xHCI (I got this as an off-list report, so can't really provide a
> > pointer to ML archives).
> 
> Ah, ok. I wasn't aware of that. I'll assume then that the necessary
> people have the complete picture.

It might help to get a usbmon trace and dmesg log from Linus, if he
still has this problem.

Alan Stern

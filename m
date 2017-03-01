From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] hid: usbhid: usbkbd: fix checkpatch.pl issues
Date: Wed, 1 Mar 2017 17:05:06 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1703011702570.1988-100000@iolanthe.rowland.org>
References: <3c67c4db-9b59-82f1-9406-3dfdb2ac0a48@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3c67c4db-9b59-82f1-9406-3dfdb2ac0a48@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avraham Shukron <avraham.shukron@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org, benjamin.tissoires@redhat.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 1 Mar 2017, Avraham Shukron wrote:

> I thought fixing a driver that I actually use daily will be more satisfying.

Unless there are special reasons, you should not be using the usbkbd
driver.  It is legacy code; everyone should now use usbhid instead.

Alan Stern

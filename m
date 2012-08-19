From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Date: Sat, 18 Aug 2012 20:11:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1208182001320.25537-100000@netrider.rowland.org>
References: <20120818154828.0e992bfe@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120818154828.0e992bfe@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 18 Aug 2012, Bruno Pr=C3=A9mont wrote:

> One thing I just though about, how does usbhid handle the calls to
> usbhid_submit_report() when hid_hw_stop()/hid_hw_close() have already
> been called?

Looks like they aren't synchronized at all.  That's a bug. =20
usbhid_submit_report() should check the HID_DISCONNECTED flag.

> I will attempt to see if it makes a difference to shortcut my
> usbhid_submit_report() calls from the point on I have called hid_hw_c=
lose()...

I don't know bout hid_hw_close().  Certainly no more reports should be=20
submitted following usbhid_stop().

Alan Stern

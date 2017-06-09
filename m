From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/3] USB: add API for interface driver to vote for
 autosuspend
Date: Fri, 9 Jun 2017 10:48:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1706091046270.2100-100000@iolanthe.rowland.org>
References: <20170608215828.130455-1-yueyao.zhu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170608215828.130455-1-yueyao.zhu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yueyao Zhu <yueyao.zhu@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>, Badhri Jagan Sridharan <badhri@google.com>, Dmitry Torokhov <dtor@google.com>, Yueyao Zhu <yueyao@google.com>
List-Id: linux-input@vger.kernel.org

On Thu, 8 Jun 2017, Yueyao Zhu wrote:

> From: Yueyao Zhu <yueyao@google.com>
> 
> Currently, if a USB driver would like to enable autosuspend on the USB
> device, usb_enable_autosuspend() seems to be the only option. However,
> this acts on the device level, and other interfaces might not desire
> to autosuspend the USB device.
> 
> For example, for the usb digital audio driver to enable autosuspend on
> a device, calling usb_enable_autosuspend() from the interface driver
> might not be a good idea as the USB device might have a keyboard HID
> interface which generally doesn't handle autosupend very well.
> 
> This patch series introduces an API for interface driver to vote
> for autosuspend on the interface, and when all interfaces agree to
> it, autosuspend can then be enabled on the usb device.

The whole idea of this seems questionable.  USB interface drivers are
generally not supposed to enable or disable autosuspend -- that is a
policy decision left up to userspace.  There are a few exceptions for 
things like hubs, but this is generally true.

Why should the USB digital audio driver want to enable autosuspend?

Alan Stern

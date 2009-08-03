From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: Add support for filtering input events
Date: Mon, 3 Aug 2009 10:04:51 -0700
Message-ID: <20090803170453.F0DF9526EA5@mailhub.coreip.homeip.net>
References: <1249007207-27392-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1249007207-27392-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Matthew,

On Fri, Jul 31, 2009 at 03:26:46AM +0100, Matthew Garrett wrote:
> Devices occasionally use the keyboard controller to send hardware
> notifications that should be handled by the kernel rather than userspace.
> These can be handled in kernel by registering an input handler, but the
> event will still bubble up to userspace where it may cause confusion. This
> patch adds support for the kernel to register filters, allowing it to
> indicate that the event should be consumed by the hardware-specific driver
> rather than passed to other input handlers. The assumption is that, as this
> is hardware specific, there should be no need to have more than one filter -
> similarly, if an input device is grabbed, we assume that people know what
> they're doing and don't pass it to the filter.
> 

I don't think this is the proper layer to do the filtering, the filter
should be done in i8042, not input core. The way you done it would kill
any possibility of user assigning KEY_WLAN to a spare key on his or her
keyboard and using it to control wireless cards that are not hardwired.

I would accept the patch that would add a filter in the form

	bool (*i8042_fillter)(unsigned char data, unsigned int flags,
			struct serio *port);

I don't think we'd need to chain them into a list or something, one hook
should be enough since I don't expect we'll have several platform
drivers loaded on one box.

-- 
Dmitry

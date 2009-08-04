From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] input: Add support for filtering input events
Date: Tue, 4 Aug 2009 11:01:58 +0100
Message-ID: <20090804100158.GA14530@srcf.ucam.org>
References: <1249007207-27392-1-git-send-email-mjg@redhat.com> <20090803170453.F0DF9526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090803170453.F0DF9526EA5@mailhub.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 03, 2009 at 10:04:51AM -0700, Dmitry Torokhov wrote:

> I don't think this is the proper layer to do the filtering, the filter
> should be done in i8042, not input core. The way you done it would kill
> any possibility of user assigning KEY_WLAN to a spare key on his or her
> keyboard and using it to control wireless cards that are not hardwired.

Ok, that seems fine.

> I would accept the patch that would add a filter in the form
> 
> 	bool (*i8042_fillter)(unsigned char data, unsigned int flags,
> 			struct serio *port);
> 
> I don't think we'd need to chain them into a list or something, one hook
> should be enough since I don't expect we'll have several platform
> drivers loaded on one box.

So filter on the raw i8042 data rather than after any processing? 
Wouldn't this require some level of state machine in the driver using 
this functionality?

-- 
Matthew Garrett | mjg59@srcf.ucam.org

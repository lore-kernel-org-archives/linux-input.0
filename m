From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Date: Sat, 15 Oct 2011 15:07:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110151504510.15129-100000@netrider.rowland.org>
References: <201110151143.27061.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201110151143.27061.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Benson Leung <bleung@chromium.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 15 Oct 2011, Oliver Neukum wrote:

> Am Freitag, 14. Oktober 2011, 17:09:32 schrieb Alan Stern:
> > > Anyway, I'll solve this problem on my system by writing to wakeup
> > > property on device attach. Consider my change abandoned.
> > 
> > That seems like the best approach.
> 
> Do you think this could be added to the USB configuration tool I wrote
> last week?

I don't see why not.  It's exactly the sort of thing that should be 
handled on a per-user basis.

> In the longer run, we might consider that this properties may also need
> to be changed based on AC vs. DC or the battery's charge level.

Is that really true?  I'm not sure -- in general people want their 
computers to be consistent.  In particular, they want to conserve power 
regardless of the power source.

However, you could add such a mechanism to the program in case some 
people do want to use it.

Alan Stern

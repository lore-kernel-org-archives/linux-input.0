From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Thu, 13 Nov 2014 17:11:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411131710200.4266-100000@iolanthe.rowland.org>
References: <CANLzEktsBvmX7Nbn=+JBq6A=cowqnFVPJ1ymQjbv4dgrDvSLFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANLzEktsBvmX7Nbn=+JBq6A=cowqnFVPJ1ymQjbv4dgrDvSLFA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: johan@kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>
List-Id: linux-input@vger.kernel.org

On Thu, 13 Nov 2014, Benson Leung wrote:

> On Thu, Nov 13, 2014 at 1:18 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > If you interchange the two lines then the flag _will_ be cleared before
> > usb_kill_urb() and autosuspend_check() can run.  This means your patch
> > description is bogus.
> 
> Gotcha. v2 posted. Thanks for the direction.

Wait a minute -- in your previous email you said this approach didn't 
work.  So does it work or doesn't it?

Alan Stern

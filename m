From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Date: Fri, 14 Oct 2011 11:09:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110141106270.2036-100000@iolanthe.rowland.org>
References: <CANLzEksars=PfOdx6Uxu-FbmxuXK0DMZoGW0HWbpogQ11YAA1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANLzEksars=PfOdx6Uxu-FbmxuXK0DMZoGW0HWbpogQ11YAA1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Oliver Neukum <oneukum@suse.de>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 14 Oct 2011, Benson Leung wrote:

> Thanks for the prompt response.
> 
> My initial reasoning was to set as default the wakeup behavior so a
> mouse button press would wake the system. I am well aware that most if
> not all mice don't support wake on move, but at least wake on button
> press would have been more desirable than doing nothing.

I'm sorry, I misunderstood the purpose of the original patch.  Probably 
read it too quickly -- I thought you were enabling autosuspend rather 
than wakeup.

Enabling wakeup by default has its own problems.  Some mice do send
wakeup requests when they are moved.  You wouldn't want a stray motion
or unintentional touch to wake up a sleeping system.  Or at least, a
lot of people wouldn't want that.

> Anyway, I'll solve this problem on my system by writing to wakeup
> property on device attach. Consider my change abandoned.

That seems like the best approach.

Alan Stern

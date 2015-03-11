From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH v2] HID: multitouch: Add support for button type usage
Date: Wed, 11 Mar 2015 12:25:25 -0500
Message-ID: <20150311172525.GB136254@ubuntu-hedt>
References: <1425070801-73595-1-git-send-email-seth.forshee@canonical.com>
 <1425180871-5232-1-git-send-email-seth.forshee@canonical.com>
 <alpine.LNX.2.00.1503111216190.24876@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1503111216190.24876@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Wed, Mar 11, 2015 at 12:19:13PM -0400, Jiri Kosina wrote:
> On Sat, 28 Feb 2015, Seth Forshee wrote:
> 
> > According to [1], Windows Precision Touchpad devices must supply
> > a button type usage in the device capabilities feature report. A
> > value of 0 indicates that the device contains a depressible
> > button (i.e. it's a click-pad) whereas a value of 1 indicates
> > a non-depressible button. Add support for this usage and set
> > INPUT_PROP_BUTTONPAD on the touchpad input device whenever a
> > depressible button is present.
> > 
> > v2: Add string for button type usage in debugfs.
> > 
> > [1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn467314(v=vs.85).aspx
> > 
> > Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> 
> I'd like to have Benjamin's Ack on this. Adding him to CC. Please also see 
> 015fdaa9f8ed ("HID: multitouch: add support of clickpads").

That commit does also gets INPUT_PROP_BUTTONPAD set for my touchpad.
I'll leave it up to the two of you to decide whether or not there's
benefit in also using the usage to set the property bit. I'll also
follow up with a v3 patch which resolves the conflicts with Benjamin's
patch.

Also, I should probably mention that I don't have any non-depressible
touchpads which set the button type usage that I can test with. If
anyone has such hardware it would be great to get this tested against
it.

Thanks,
Seth

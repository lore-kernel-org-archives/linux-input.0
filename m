From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Should we create a raw input interface for IR's ?
Date: Thu, 26 Nov 2009 15:28:09 -0800
Message-ID: <20091126232809.GE6936@core.coreip.homeip.net>
References: <BDZb9P9ZjFB@christoph> <m3skc25wpx.fsf@intrepid.localdomain> <E6F196CB-8F9E-4618-9283-F8F67D1D3EAF@wilsonet.com> <829197380911251020y6f330f15mba32920ac63e97d3@mail.gmail.com> <E88E119C-BB86-4F01-8C2C-E514AC6BA5E2@wilsonet.com> <m3skc249ev.fsf@intrepid.localdomain> <20091126055302.GI23244@core.coreip.homeip.net> <m37htduo3i.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753450AbZKZX2O@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m37htduo3i.fsf@intrepid.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Jarod Wilson <jarod@wilsonet.com>, Devin Heitmueller <dheitmueller@kernellabs.com>, Christoph Bartelmus <lirc@bartelmus.de>, awalls@radix.net, j@jannau.net, jarod@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@redhat.com, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

On Thu, Nov 26, 2009 at 07:40:01PM +0100, Krzysztof Halasa wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> 
> > Why would sysfs write be slower than ioctl?
> 
> Sysfs is generally one-value, one-file. open, read/write, close.
> ioctl() OTOH does everything (e.g. a whole key table) in one syscall.

There are binary sysfs attributes. For ioctl you also need to open and
close the device. Plus, how often do you expect to perform this
operation? Don't you think you are trying to optimize something that
does not have any real performavnce impact here?
 
-- 
Dmitry

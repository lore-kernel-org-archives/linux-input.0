From: Andy Walls <awalls@radix.net>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel
 IR  system?
Date: Tue, 01 Dec 2009 06:38:00 -0500
Message-ID: <1259667480.3100.10.camel@palomino.walls.org>
References: <BE3edeNXqgB@lirc>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753532AbZLALj5@vger.kernel.org>
In-Reply-To: <BE3edeNXqgB@lirc>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Bartelmus <lirc@bartelmus.de>
Cc: jonsmirl@gmail.com, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, khc@pm.waw.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, lirc-list@lists.sourceforge.net, mchehab@redhat.com, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

On Tue, 2009-12-01 at 08:45 +0100, Christoph Bartelmus wrote:
> Hi Jon,
> 
> on 30 Nov 09 at 16:35, Jon Smirl wrote:


> Currently I would tend to an approach like this:
> - raw interface to userspace using LIRC
> - fixed set of in-kernel decoders that can handle bundled remotes
> 
> That would allow zero configuration for simple use cases and full  
> flexibility for more advanced use cases.
> 
> Christoph

I'd also prefer that approach.

That probably comes as no surprise, but I may not be able to keep
following/kibitzing in this thread. Christoph's statement sums up my
preference.

Regards,
Andy

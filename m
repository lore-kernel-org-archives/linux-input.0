From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was:
	Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: Thu, 26 Nov 2009 15:10:43 -0800
Message-ID: <20091126231043.GB6936@core.coreip.homeip.net>
References: <4B0A765F.7010204@redhat.com> <4B0A81BF.4090203@redhat.com> <m36391tjj3.fsf@intrepid.localdomain> <4B0AC65C.806@redhat.com> <m3zl6dq8ig.fsf@intrepid.localdomain> <4B0E765C.2080806@redhat.com> <m3iqcxuotd.fsf@intrepid.localdomain> <4B0ED238.6060306@redhat.com> <m3pr75rpqa.fsf@intrepid.localdomain> <4B0EED7D.90204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B0EED7D.90204@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Jarod Wilson <jarod@redhat.com>, linux-kernel@vger.kernel.org, Mario Limonciello <superm1@ubuntu.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org, Janne Grunau <j@jannau.net>, Christoph Bartelmus <lirc@bartelmus.de>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 26, 2009 at 07:05:01PM -0200, Mauro Carvalho Chehab wrote:
> 
> For example, the two ioctls to replace a scancode x key code are defined as:
> 
> #define EVIOCGKEYCODE           _IOR('E', 0x04, int[2])                 /* get keycode */
> #define EVIOCSKEYCODE           _IOW('E', 0x04, int[2])                 /* set keycode */
> 
> We need to better analyze the API to see how this can be extended to
> allow bigger widths.
> 
> (what's worse is that it is defined as "int" instead of "u32" - so the number
> of bits is different on 32 and on 64 systems)
> 

Not really, int is 32 bits on both, longs the ones that differ.

-- 
Dmitry

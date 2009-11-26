From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was:
 Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: Thu, 26 Nov 2009 16:55:23 -0200
Message-ID: <4B0ECF1B.1090103@redhat.com>
References: <BDcbizrJjFB@christoph> <4B0EABF8.9000902@redhat.com> <m3r5rlupcb.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <m3r5rlupcb.fsf@intrepid.localdomain>
Sender: linux-media-owner@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Christoph Bartelmus <lirc@bartelmus.de>, jarod@wilsonet.com, awalls@radix.net, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

Krzysztof Halasa wrote:
> Mauro Carvalho Chehab <mchehab@redhat.com> writes:
> 
>> 1) the developer that adds the hardware also adds the IR code. He has
>> the hardware and the IR for testing, so it means a faster development
>> cycle than waiting for someone else with the same hardware and IR to
>> recode it on some other place. You should remember that not all
>> developers use lirc;
> 
> It's fine, but please - no keymaps in the kernel (except for fixed
> receivers, i.e. the ones which can only work with their own dedicated
> remote, and which don't pass RC5/etc. code).
> 
> The existing keymaps (those which can be used with lirc) have to be
> moved to userspace as well.

The removal of the existing keymaps from kernel depends on having an application
to be called from udev to load the proper keymaps when a device is probed.

After having it for a while, we should deprecate the in-kernel keymaps
and move them to userspace.

I also think that it is important to remove the 7 bits limitation from all drivers
and re-generate the keymaps, since they'll change after it.

cheers,
Mauro.

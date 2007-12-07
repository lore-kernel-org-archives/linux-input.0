From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.24: false double-clicks from USB mouse
Date: Fri, 7 Dec 2007 13:32:10 -0500
Message-ID: <d120d5000712071032r35f7c837paa513e20a9029ab4@mail.gmail.com>
References: <4752DB8C.50608@rtr.ca>
	<Pine.LNX.4.64.0712021918500.13260@jikos.suse.cz>
	<4752FE11.2050200@rtr.ca> <4752FEFE.3000600@rtr.ca>
	<Pine.LNX.4.64.0712022007360.13260@jikos.suse.cz>
	<47530680.6020206@rtr.ca>
	<Pine.LNX.4.64.0712022025250.13260@jikos.suse.cz>
	<47530B32.7080502@rtr.ca>
	<Pine.LNX.4.64.0712022300490.13260@jikos.suse.cz>
	<2c0942db0712070959v400901ax59f7b445ec701c27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <2c0942db0712070959v400901ax59f7b445ec701c27@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Ray Lee <ray-lk@madrabbit.org>
Cc: linux-usb-devel@lists.sourceforge.net, Jeff Garzik <jeff@garzik.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel <linux-kernel@vger.kernel.org>, rubini@vision.unipv.it, linux-input@vger.kernel.org, Mark Lord <lkml@rtr.ca>
List-Id: linux-input@vger.kernel.org

Hi,

On Dec 7, 2007 12:59 PM, Ray Lee <ray-lk@madrabbit.org> wrote:
> On Dec 2, 2007 2:07 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> > Thanks. To sum up this longish thread:
> >
> > - Mark seems to be able to reproduce the problem quite easily; I was not
> >   successful reproducing this no matter how hard I tried, and I also
> >   didn't receive any similar bugreports from anyone else
> > - we are currently waiting for Mark to provide HID_DEBUG (and preferably
> >   also usbmon) output from the situation where multiple clicks are
> >   being generated incorrectly
>
> Okay, I'm having a problem with 2.6.24-rc4 that I didn't with 2.6.23-rc6.
>
> When the problem hits, my mouse (synaptics touchpad) is randomly
> moving about and clicking things whenever I have my finger on the
> trackpad. This behavior will persists for five to ten minutes (is
> happening now), and seems to be triggered by load (watching online
> videos in flash player, for example -- this matches Mark's experience
> with a make -j4).
>
> I *think* the touchpad is connected via ps2, which looks like it'd
> clear usb of any blame. It's /dev/input/event6 at any rate.
>
> This has been happening about once a day, and seems to start because
> of high CPU usage. ONce the CPU is idle, it still happens though, so
> I'm not sure why it clears up.
>
> Any clues for where I should hunt from here?
>

Can you try replacing drivers/input/ and include/linux/input.h from
2.6.23-rc6 and see if it works or not? That should give us idea if
input locking changes are to blame.

Thanks.

-- 
Dmitry

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

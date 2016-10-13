From: Nick Dyer <nick@shmanahar.org>
Subject: Re: [PATCH v3 2/2] Input: synaptics-rmi4 - add support for F34
 device reflash
Date: Thu, 13 Oct 2016 21:35:20 +0100
Message-ID: <20161013203520.GA6525@lava.h.shmanahar.org>
References: <1474404162-29357-1-git-send-email-nick@shmanahar.org>
 <1474404162-29357-3-git-send-email-nick@shmanahar.org>
 <20161010134807.GJ30411@mail.corp.redhat.com>
 <20161012185705.GA20820@lava.h.shmanahar.org>
 <20161013135245.GM15950@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161013135245.GM15950@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 13, 2016 at 03:52:45PM +0200, Benjamin Tissoires wrote:
> > > You could basically export rmi_fn_reset() which would call
> > > rmi_free_function_list(), rmi_scan_pdt (if initial reset),
> > > rmi_probe_interrupts() and rmi_init_functions, and this would allow you
> > > to have all this in f34.
> > 
> > I see what you mean, and I do agree that it would be neater to have all
> > of this in the f34 code.
> > 
> > However, the problem is that when you call rmi_free_function_list(), the
> > f34 driver and all the context information attached to it (struct
> > rmi_function, struct f34_data, and any sysfs attributes in the f34
> > directory) gets torn down, so you're kind of left without the branch you
> > were sitting on.
> > 
> > To get around that, I'd have to make f34 a special case anyway. Taking
> > that into account, the current solution seemed neater to me. I could
> > possibly cram a little more of it into rmi_f34.c, but I think the
> > context has to be "struct rmi_driver_data".
> 
> If I understand correctly, rmi_firmware_update() is only called through
> the sysfs. So how about you export the required functions from core you
> are using and export 2 functions from rmi_f34 that will be a special
> case: rmi_f34_create_sysfs() and rmi_f34_remove_sysfs() (or any better
> names). You could just put your code in rmi_f34, provide noops
> declarations if RMI_F34 is not set, and core will have only 2 calls to
> rmi_f34.

OK: I will have a go at achieving this over the next few days. I also
have some changes almost ready to add F34 bootloader V7 support.

> BTW, I am thinking at carrying in my next RMI4 series your 1/2 patch. I
> also want to take Bjorn and Andrew left patches so that we have a common
> tree at some point. Any objections? 
> Of course, if you resubmit before me, feel free to carry over 1/2.

Sounds like a good idea, it will reduce merging difficulty later.

N

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] hid: usbhid: usbkbd: fix checkpatch.pl issues
Date: Wed, 1 Mar 2017 12:43:38 -0800
Message-ID: <20170301204338.GF30349@dtor-ws>
References: <48d55583-6f2d-cfda-c6dd-0e789f4bf6f1@gmail.com>
 <20170301181628.GD30349@dtor-ws>
 <3c67c4db-9b59-82f1-9406-3dfdb2ac0a48@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3c67c4db-9b59-82f1-9406-3dfdb2ac0a48@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avraham Shukron <avraham.shukron@gmail.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 01, 2017 at 09:59:31PM +0200, Avraham Shukron wrote:
> > 
> > This kind of change is definitely not helpful. The original table was
> > Nx16, you converted it to Nx14. Why do you think original table used 16
> > columns?
> > 
> > Regardless, it's a very old driver, just let it be.
> > 
> > Thanks.
> > 
> 
> I can make it Nx8 :)

Or you can leave it as is.

> 
> Seriously now - I don't understand what is so wrong with checkpatch fixes?

Checkpatch is a tool to make sure new code follows standard conversions,
not reshuffling old working code.

> I'm a new to kernel development, and the natural place to start is to do some
> coding style fixes.
> I thought fixing a driver that I actually use daily will be more satisfying.

You are not using this driver daily, pretty much nobody does. What you
are using is usbhid + hid-input + probably some hardware-specific hid
driver that twiddles the behavior of your keyboard.

> Why driver being old is a good reason to ignore the coding style conventions?

Since there is no active development nor use it is easy to introduce
bugs that won't be caught until much later. Checkpatch fixes are usually
welcome when there are additional fixes to the same driver.

Thanks.

-- 
Dmitry

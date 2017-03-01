From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] hid: usbhid: usbkbd: fix checkpatch.pl issues
Date: Wed, 1 Mar 2017 21:56:47 +0100
Message-ID: <20170301205647.GA21651@kroah.com>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org, benjamin.tissoires@redhat.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
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
> 
> Seriously now - I don't understand what is so wrong with checkpatch fixes?
> I'm a new to kernel development, and the natural place to start is to do some
> coding style fixes.

Start doing this in the drivers/staging/ portion of the kernel.  Other
places usually do not want these types of changes for the reasons people
have given you already.

That is what drivers/staging/ is for, to learn the process.  Please
stick to it there.

thanks,

greg k-h

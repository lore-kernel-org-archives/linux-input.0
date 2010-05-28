From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH] Quickstart Button ACPI driver to serve PNP0C32 ACPI
 devices
Date: Fri, 28 May 2010 11:01:03 -0700
Message-ID: <20100528180103.GA2905@core.coreip.homeip.net>
References: <201005281940.09925.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201005281940.09925.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Angelo Arrifano <miknix@gmail.com>
List-Id: linux-input@vger.kernel.org

On Fri, May 28, 2010 at 07:40:09PM +0200, Thomas Renninger wrote:
> Hi,
> 
> if you have a recent Microsoft Office format reader you find some
> documentation here:
> http://www.microsoft.com/whdc/system/platform/firmware/DirAppLaunch.mspx	
> 
> I finally got it converted and these should be readable in OpenOffice as well:
> ftp.suse.com/pub/people/trenn/hotstart_quickstart_docu
> 
> The idea of these buttons is that they are undefined from BIOS/kernel
> point of view. Userspace has to map a functionality to them.
> Therefore the idea to modify the input event keycode via sysfs file.

What s wrong with using EVIOCSKEYCODE to adjust the mapping. Note that
the issue of handlers not re-binding after keymap change should be
solved regardless.

> There should be 2 situations that perfectly are triggered via userspace:
>    - DMI match (or similar) and assign the correct buttons on the known
>      machine. I know that hal could do this rather well and had dmi
>      tables pre-defined. AFAIK hal is already obsolete? What userspace
>      tools/lists would be best to ask?

udev/hal remap keys on laptop keyboards, they should have facilities to
do that here as well.

> 
>    - If the button is undefined, a higher level userspace X application
>      could ask the user to set it to something useful. For this to
>      happen the usage id has to be passed somehow through the input
>      layer. Not sure how realistic such an implementation is and what
>      is still needed in X to make this happen.

Yes, KEY_UNKNOWN is expected to cause such behavior.

-- 
Dmitry

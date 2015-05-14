From: "Dennis O'Brien" <dennis.obrien@eqware.net>
Subject: Re: [PATCH 1/1] usb: Remove Vernier devices from lsusb and hid_ignore_list
Date: Thu, 14 May 2015 07:56:21 -0700
Message-ID: <1A36F65D54584E70BED29E4478AE5DC6@EQwarePC>
References: <20150506150028.5w93ixo5k4o8kkw0@hostingmail.earthlink.net> <5550BAAA.9030209@eqware.net> <alpine.LNX.2.00.1505121400210.8186@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1505121400210.8186@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: gregkh@linuxfoundation.org, jminor@vernier.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Dennis O'Brien <dennis.obrien@eqware.net>
List-Id: linux-input@vger.kernel.org

Jiri,

Hope I'm not being too dense...

All the Vernier devices are hid class and are supported via the hid driver 
sub-system and the hidraw device interface.

Vernier has a library called GoIO 
http://www.vernier.com/downloads/software-development-kits/go-sdk/, which 
supports (or will support) the devices through the hidraw interface.  One 
such device is http://www.vernier.com/products/interfaces/go-link/.

Did you want me to reference the GoIO SDK?

Dennis




-----Original Message----- 
From: Jiri Kosina
Sent: Tuesday, May 12, 2015 5:00 AM
To: Dennis O'Brien
Cc: gregkh@linuxfoundation.org ; jminor@vernier.com ; 
linux-input@vger.kernel.org ; linux-kernel@vger.kernel.org ; 
linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: Remove Vernier devices from lsusb and 
hid_ignore_list

On Mon, 11 May 2015, Dennis O'Brien wrote:

> From: Dennis O'Brien <dennis.obrien@eqware.net>
>
> Removes Vernier Software & Technology devices from the ldusb
> driver and the hid_ignore_list table of the usbhid driver in the
> Linux tree.  These devices will now be supported via the hidraw
> driver.
>
> Signed-off-by: Dennis O'Brien <dennis.obrien@eqware.net>

Could you please also include in the changelog name / pointer to the
userspace driver?

Thanks,

-- 
Jiri Kosina
SUSE Labs 

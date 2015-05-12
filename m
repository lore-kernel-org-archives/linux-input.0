From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] usb: Remove Vernier devices from lsusb and
 hid_ignore_list
Date: Tue, 12 May 2015 14:00:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505121400210.8186@pobox.suse.cz>
References: <20150506150028.5w93ixo5k4o8kkw0@hostingmail.earthlink.net> <5550BAAA.9030209@eqware.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5550BAAA.9030209@eqware.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dennis O'Brien <dennis.obrien@eqware.net>
Cc: gregkh@linuxfoundation.org, jminor@vernier.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

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

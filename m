From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: synaptics-rmi4 - export nosleep of f01 via
 sysfs
Date: Sun, 9 Jun 2019 09:53:19 -0700
Message-ID: <20190609165319.GA90002@dtor-ws>
References: <20190220164200.31044-1-aaron.ma@canonical.com>
 <20190220164200.31044-2-aaron.ma@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220164200.31044-2-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cheiny@synaptics.com, aduggan@synaptics.com, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

Hi Aaron,

On Wed, Feb 20, 2019 at 05:42:00PM +0100, Aaron Ma wrote:
> Some of ThinkPad X1C6 touchpads didn't wakeup after resume.
> Forcing enable nosleep make touchpad back.
> Add nosleep via sysfs, so user can control it to workaround issue.
> 
> /sys/devices/rmi4-00/nosleep can be written non-zero will enable
> nosleep mode.

I do not think that noseleep attribute is a good solution as users will
have very hard time finding and activating it. If nosleep is absolutely
required, it has to be activated automatically.

However from the discussion on the 1st patch it is my understanding that
this patch was not really required, so I will not be applying it.

Thanks.

-- 
Dmitry

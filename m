From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH 0/2] Add Apple SPI keyboard and trackpad driver
Date: Mon, 4 Feb 2019 21:47:55 +0100
Message-ID: <cdca5121-4f2b-2f74-8a1c-63fda385ee6f@bitmath.org>
References: <20190204081947.25152-1-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204081947.25152-1-ronald@innovation.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Ronald_Tschal=c3=a4r?= <ronald@innovation.ch>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Ronald,

> This changeset adds a driver for the SPI keyboard and trackpad on recent
> MacBook's and MacBook Pro's. The driver has seen a fair amount of use
> over the last 2 years (basically anybody running linux on these
> machines), with only relatively small changes in the last year or so.
> For those interested, the driver development has been hosted at
> https://github.com/cb22/macbook12-spi-driver/  (as well as my clone at
> https://github.com/roadrunner2/macbook12-spi-driver/).
>
> The first patch is just a placeholder for now and is provided in case
> somebody wants to compile the driver while it's being reviewed here; the
> real patch has been submitted to dri-devel and is being discussed there,
> with the intent/hope that I can get an Ack and permission to merge it
> through the input subsystem tree here as part of this patch series.

Great to see this upstream. The patch obviously has a lot in common with 
the previous keyboard and touchpad drivers; foremost this is a change of 
transport protocol and not functionality. That said, the code is compact 
and clear enough to make it hard to motivate any major effort to share 
more of existing code, at least initially. Barring detailed comments 
that are likely to produce new revisions, this looks like really good work.

Thanks,

Henrik

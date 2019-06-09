From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - clear irqs before set irqs
Date: Sun, 9 Jun 2019 09:55:51 -0700
Message-ID: <20190609165551.GB90002@dtor-ws>
References: <20190220164200.31044-1-aaron.ma@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220164200.31044-1-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cheiny@synaptics.com, aduggan@synaptics.com, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

Hi Aaron,

On Wed, Feb 20, 2019 at 05:41:59PM +0100, Aaron Ma wrote:
> rmi4 got spam data after S3 resume on some ThinkPads.
> Then TrackPoint lost when be detected by psmouse.
> Clear irqs status before set irqs will make TrackPoint back.

Could you please give me an idea as to what this spam data is?

In F03 probe we clear all pending data before enabling the function,
maybe the same needs to be done on resume, instead of changing the way
we handle IRQ bits?

Thanks,

-- 
Dmitry

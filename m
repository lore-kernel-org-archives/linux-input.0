From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] HID: sensor-hub: Add quirk for Lenovo Yoga 900 with ITE
 Chips
Date: Sat, 19 Dec 2015 09:26:48 -0800
Message-ID: <1450546008.4225.13.camel@linux.intel.com>
References: <1450463680-10400-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CAOhV88P35k37uP1=qhsThgrA4Y7iOn6fARps-N6DxaSpzKkztA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40149 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933345AbbLSR2j (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Dec 2015 12:28:39 -0500
In-Reply-To: <CAOhV88P35k37uP1=qhsThgrA4Y7iOn6fARps-N6DxaSpzKkztA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org

On Fri, 2015-12-18 at 22:31 -0800, Nish Aravamudan wrote:
> On Fri, Dec 18, 2015 at 10:34 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > This needs same quirk as applied to other YOGA sensor hubs.
> > Refer to
> > 47eeca8a48 (" HID: sensor-hub: Add in quirk for Lenovo Yogas with
> > ITE")
> > 
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > Tested-by: Nishanth Aravamudan <nish.aravamudan@gmail.com>
> 
> Ok, maybe I spoke too soon! It did work once, at least. But since
> then
> it seems to have stopped working again? 

This patch is still relevant like other YOGAs. Can you try different
motions like quick movements with jerk?

> That is, the *raw* files are
> still working, but iio-sensor-proxy is again not seeing any updates
> via the chardev(s). Any notion of what might be going on?
> 
> Note that dmesg does contain (it always has):
> 
> i2c_hid i2c-ITE8396:00: error in i2c_hid_init_report size:19 /
> ret_size:18

We have to enable debug in the i2c-hid driver and see if this device
getting powered off. You can google i2c-hid specification from
Microsoft to get details about the protocol.

Thanks,
Srinivas

> but I have no idea if that's relevant to the IIO sensors? I was told
> in another thread that it shouldn't have any negative consequence.
> -Nish

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1] Input: synaptics-rmi4 - allow number of PDT pages to
 be specified
Date: Mon, 24 Oct 2016 17:09:13 -0700
Message-ID: <20161025000913.GD15034@dtor-ws>
References: <1477349722-26635-1-git-send-email-nick@shmanahar.org>
 <20161024233941.GB9026@dtor-ws>
 <67e70b31-292d-b0ff-0598-7b71e1dcff35@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <67e70b31-292d-b0ff-0598-7b71e1dcff35@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Nick Dyer <nick@shmanahar.org>, Christopher Heiny <cheiny@synaptics.com>, Guenter Roeck <linux@roeck-us.net>, Chris Healy <cphealy@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 24, 2016 at 05:03:30PM -0700, Andrew Duggan wrote:
> On 10/24/2016 04:39 PM, Dmitry Torokhov wrote:
> >On Mon, Oct 24, 2016 at 11:55:22PM +0100, Nick Dyer wrote:
> >>We have encountered some RMI4 firmwares where there are blank pages in between
> >>PDT pages which contain functions. Add a device tree property which can be set
> >>to force reading the first N pages.
> >Cann we get updated firmware instead? This seems like violation of RMI
> >protocol. Or, if it is allowed by the protocol, can we avoid DT
> >parameter and keep scanning until the end?
> 
> It is a violation of the RMI4 spec and we found at least one other
> device with misconfigured firmware, so this problem extends beyond
> just a single device. We are adding steps to our verification
> process to make sure we catch these misconfigurations in the future.
> But, I'm not sure we can guarantee that a device with this issue
> didn't go into production.
> 
> I like Guenter's suggestion of requiring two empty pages to stop
> scanning. If we did that for all devices it would add one extra read
> to the PDT scan, but we would avoid us having to maintain a list of
> devices or set additional parameters.

OK, if that fixes broken firmware then that's what I would prefer.

Thanks.

-- 
Dmitry

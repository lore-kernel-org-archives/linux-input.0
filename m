From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [PATCH 12/19] iio & mfd & input: ti_tscadc: Match mfd sub devices to regmap interface
Date: Tue, 4 Jun 2013 14:10:20 +0300
Message-ID: <FBB90884-C774-4981-A5BA-26B498B19D76@antoniou-consulting.com>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de> <1369681926-22185-13-git-send-email-bigeasy@linutronix.de> <51AB84F5.2030405@kernel.org> <20130604102318.GC1151@linutronix.de> <F58DCC19-20B7-4385-B323-C1A2E5F22641@antoniou-consulting.com> <20130604105210.GI1151@linutronix.de> <4AA621AD-5273-444C-875C-05486CC810A8@antoniou-consulting.com> <20130604110532.GJ1151@linutronix.de>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130604110532.GJ1151-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org


On Jun 4, 2013, at 2:05 PM, Sebastian Andrzej Siewior wrote:

> * Pantelis Antoniou | 2013-06-04 13:54:48 [+0300]:
> 
>> What make you think I am the original author?
> Nothing, you just made _this_ patch.
> 

I'm the author of that patch that fixes it, I'm not the author of the original driver.

>> I just fixed whatever I had to fix to get it working.
> Fair enough.
> 
>> Namely that the multi function device was using regmap in one place and
>> not in another, which had the nice effect of the regmap cache getting out of sync.
> 
> Yeah, that is a pain. Currently I think why we do need regmap at all
> here and I think about getting rid of it. Most of the values read here
> need no caching at all.
> 

You need to talk to the original driver author then.

>> Regards
>> 
>> -- Pantelis
> 
> Sebastian

Regards

-- Pantelis

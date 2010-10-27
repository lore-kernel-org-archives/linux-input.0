From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 06/10] drivers/input/serio/i8042: Use pr_<level>, pr_fmt. Fix dbg and __FILE__ use
Date: Tue, 26 Oct 2010 18:00:44 -0700
Message-ID: <BFA186FD-32F7-4E1A-9193-CA1575248B73@gmail.com>
References: <cover.1288059486.git.joe@perches.com> <20101026155028.GA13097@core.coreip.homeip.net> <1288135531.4145.59.camel@Joe-Laptop> <201010261740.13566.dmitry.torokhov@gmail.com> <1288140416.4145.76.camel@Joe-Laptop>
Mime-Version: 1.0 (iPhone Mail 8B117)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1288140416.4145.76.camel@Joe-Laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Jiri Kosina <trivial@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Oct 26, 2010, at 5:46 PM, Joe Perches <joe@perches.com> wrote:

> On Tue, 2010-10-26 at 17:40 -0700, Dmitry Torokhov wrote:
>>> Mind if I move the time to the front like this?
>>> +#define dbg(format, arg...)                                            \
>>> +do {                                    \
>>> +    if (i8042_debug)                        \
>>> +        printk(KERN_DEBUG KBUILD_MODNAME ": [%d]" format),    \
>>> +                      (int)(jiffies - i8042_start_time), ##arg);    \
>>> +} while (0)
>> Another option would be to leave '\n' in dbg() and leave most of the
>> callers as is.
> 
> That's really error prone though.
> 

In what way?

-- 
Dmitry

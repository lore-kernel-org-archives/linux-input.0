From: Yann Cantin <yann.cantin@laposte.net>
Subject: Re: [RFC ebeam PATCH 3/3] input: misc: New USB eBeam input driver.
Date: Sat, 28 Jul 2012 11:02:13 +0200
Message-ID: <5013AA95.7090006@laposte.net>
References: <1343433754-3887-1-git-send-email-yann.cantin@laposte.net> <1343433754-3887-4-git-send-email-yann.cantin@laposte.net> <20120728014252.GB19817@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120728014252.GB19817@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

>> +config INPUT_EBEAM_USB_CLASSIC
>> +	bool "eBeam Classic Projection support"
>> +	depends on INPUT_EBEAM_USB
>> +	default y
> 
> Will there be support for other eBean devices (are there any)? If there
> will how soon? How different are they? If not the we probably do not
> need this INPUT_EBEAM_USB_CLASSIC selector.

I know at least one re-branded same hardware by 3M, i will be able to borrow
one in a month or so. According to the wikipedia article, there's probably more.

There's also newer models and embeded ones in some video projector setup, also
re-branded, based on the same technology and that might use the same type of
protocol, but i can't be sure until someone can inspect them.
These pieces of hardware are quite expensive, and mostly used in educational
or corporate, they are not easy to grab.

The code structure (device selector + functions indirection) also seems overkill
to me for now, but permit to anticipate device's variations. If it appears that they
all works in the same way, it'll be easy (and more comfortable to me) to step down,
the opposite seems more difficult.

>> +#define DEBUG
> I do not think leaving DEBUG on is good idea for production code.
Cinder, cleaned.
 
>> +/* until KConfig */
>> +#define CONFIG_INPUT_EBEAM_USB_CLASSIC
> 
> Huh?

I test the module against my running kernel, building out of tree,
and don't know how to define that in the makefile.
This will be cleaned in final step.

>> +	bool irq_always;
> 
> Does you device need this?

Part of "overkill" foresight.
 
>> +	/* optional, model-specific */
>> +	int  (*alloc)	(struct ebeam_device *ebeam);
>> +	int  (*init)	(struct ebeam_device *ebeam);
>> +	void (*exit)	(struct ebeam_device *ebeam);
> 
> Again, do you expect to see multitude of sufficiently different
> devices or are they going to follow roughly the same protocol?
ditto.

-- 
Yann Cantin
A4FEB47F
--

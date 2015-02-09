From: "Holmberg, Hans" <hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 0/2] GPIO joystick driver
Date: Mon, 9 Feb 2015 10:19:07 +0000
Message-ID: <4B6D6D87A8FB62428BE0A3E38461A1AB18D6B24F@irsmsx105.ger.corp.intel.com>
References: <1423215122-19947-1-git-send-email-hans.holmberg@intel.com>
 <1AA6C46C-36D9-4243-9DC5-254A7202D339@gmail.com>
 <4B6D6D87A8FB62428BE0A3E38461A1AB18D6AF04@irsmsx105.ger.corp.intel.com>
 <20150207204658.GA29015@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150207204658.GA29015@dtor-ws>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org


> > As far as I can tell, there is no way to specify values for ABS-"keys"
> > in the device tree binding.
> 
> It may not be present in device tree binding, but the driver does support it,
> so I would rather extend the binding than have a brand new driver.

All right, I find it a bit like whacking a round peg down a square hole, but I'll head down that path and see where it leads.

> > While both the device tree binding and the gpio-keys driver could
> > possibly be adapted to support this, it makes sense to me to describe
> > joysticks in a separate binding and keep the driver implementations apart.
> 
> Why? From the input core perspective there is no difference. It is just a
> device that emits set of events.
> 

>From a hardware-description/devicee-tree binding perspective its confusing (at least to me) to describe joysticks as keyboards.

> > In addition to this,  auto-repeat and the sys fs disable interface for
> > individual keys does not make sense for joysticks.
> 
> You do not need to use it when you describe the device (BTW autorepeat for
> trigger might be a good thing).

Ah, yes. autofire. 

Thanks!
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

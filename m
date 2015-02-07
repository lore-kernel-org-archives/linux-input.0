From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] GPIO joystick driver
Date: Sat, 7 Feb 2015 12:46:58 -0800
Message-ID: <20150207204658.GA29015@dtor-ws>
References: <1423215122-19947-1-git-send-email-hans.holmberg@intel.com>
 <1AA6C46C-36D9-4243-9DC5-254A7202D339@gmail.com>
 <4B6D6D87A8FB62428BE0A3E38461A1AB18D6AF04@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B6D6D87A8FB62428BE0A3E38461A1AB18D6AF04-pww93C2UFcwu0RiL9chJVbfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Holmberg, Hans" <hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Hans,

On Sat, Feb 07, 2015 at 07:35:46AM +0000, Holmberg, Hans wrote:
> Hi Dmitry,
> 
> > Why do we need this new driver when we have gpio-keys driver that can be
> > configured to emit ABS_* events?
> > 
> 
> As far as I can tell, there is no way to specify values for ABS-"keys" in the
> device tree binding. 

It may mot be present in device tree binding, but the driver does
support it, so I would rather extend the binding than have a brand new
driver.

> 
> While both the device tree binding and the gpio-keys driver could possibly be adapted to 
> support this, it makes sense to me to describe joysticks in a separate binding and keep
> the driver implementations apart.

Why? From the input core perspective there is no difference. It is just
a device that emits set of events.

> 
> In addition to this,  auto-repeat and the sys fs disable interface for individual keys 
> does not make sense for joysticks.

You do not need to use it when you describe the device (BTW autorepeat
for trigger might be a good thing).

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

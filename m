From: Christian Lamparter <chunkeey-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH 1/2] input: Add KEY_RFKILL
Date: Wed, 17 Feb 2010 20:42:45 +0100
Message-ID: <22ee4e771002171142q1496842ap4079026a5c0be8c6@mail.gmail.com>
References: <1266356185-10324-1-git-send-email-mjg@redhat.com>
	 <20100217052247.GD7160@core.coreip.homeip.net>
	 <20100217180342.GA22522@srcf.ucam.org>
	 <22ee4e771002171043u2aaf97vd73c1090c2fce901@mail.gmail.com>
	 <20100217191708.GA15554@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100217191708.GA15554-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Feb 17, 2010 at 8:17 PM, Dmitry Torokhov
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Feb 17, 2010 at 07:43:56PM +0100, Christian Lamparter wrote:
>> The reason: Some new devices come with a WPS "Push Button".
>> And there's no code for them yet.
>>
> Yes, we can add a new key definition if you provide clear description of
> what the intended use is and if we can't map such use to any existing
> key definitions.

I found one http://en.wikipedia.org/wiki/Wi-Fi_Protected_Setup (if you
don't mind):

There's the relevant part: (PBC stands for Push Button Control/Configuration?)

"PBC Method, in which the user simply has to push a button, either an actual
or virtual one, on both the AP (or a Registrar of the Network) and the new
wireless client device (STA)
.
Support of this model is mandatory for APs and optional for STAs."

And there are already a few potential users:
OpenWRT routers as well as some rt30xx, ar9170 and ar9271 devices.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

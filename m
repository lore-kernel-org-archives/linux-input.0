From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] input: Add KEY_RFKILL_ALL
Date: Sat, 01 Aug 2009 14:48:47 -0700
Message-ID: <1249163327.3491.24.camel@localhost.localdomain>
References: <1249152859-14769-1-git-send-email-mjg@redhat.com>
	 <1249159133.3491.13.camel@localhost.localdomain>
	 <20090801204534.GA23642@srcf.ucam.org>
	 <1249159942.3491.21.camel@localhost.localdomain>
	 <20090801205445.GA23751@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090801205445.GA23751-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Matthew,

> > actually if the key is clearly hardwired to WLAN, then it should not
> > even show up as input event at all. This is one of the mis-concepts of
> > the old RFKILL subsystem. No need to send an input event if the platform
> > driver is going to rfkill that device anyway.
> 
> There's still a policy decision. Does it kill internal devices, or does 
> it kill all attached wlan devices?
> 
> > Remember that in the end it is just a key and whatever the user does
> > with it is users policy. So in summary it is up to the platform driver
> > to emit the proper key. For some it might be still KEY_WLAN, for other
> > it might be KEY_RFKILL. Sounds fair?
> 
> I agree on the technical side, but not the naming. KEY_WLAN is an 
> rfkill-related key, so introducing KEY_RFKILL is potentially confusing. 
> KEY_RFKILL_ALL isn't.

why is it confusing? I don't understanding your argument here. I think
the KEY_RFKILL_ALL is confusing is the user policy then only kills WiFi
devices or toggles between various on/off combinations.

Regards

Marcel


--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

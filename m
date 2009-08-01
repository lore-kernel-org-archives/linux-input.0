From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [PATCH 1/2] input: Add KEY_RFKILL_ALL
Date: Sat, 1 Aug 2009 23:25:37 +0100
Message-ID: <20090801222537.GA24262@srcf.ucam.org>
References: <1249152859-14769-1-git-send-email-mjg@redhat.com> <1249159133.3491.13.camel@localhost.localdomain> <20090801204534.GA23642@srcf.ucam.org> <1249159942.3491.21.camel@localhost.localdomain> <20090801205445.GA23751@srcf.ucam.org> <1249163327.3491.24.camel@localhost.localdomain> <20090801215130.GA24201@srcf.ucam.org> <1249164685.3491.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1249164685.3491.28.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, Aug 01, 2009 at 03:11:25PM -0700, Marcel Holtmann wrote:

> and that is what it should NOT imply. The policy if it applies to all
> internal devices, all devices in general or just WiFi or Bluetooth for
> example is up to the user.
> 
> We are NOT going to have any kind of RFKILL policy in the kernel in the
> future. We will remove rfkill-input once we have a proper userspace
> solution (aka rfkilld or similar).

We seem to be talking at cross purposes here. My objection to the name 
KEY_RFKILL is that it gives no indication what it's meant to be or why 
it's different to KEY_WLAN. KEY_RFKILL implies that it's the only input 
component that an rfkill policy agent needs to listen to, which isn't 
the case.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

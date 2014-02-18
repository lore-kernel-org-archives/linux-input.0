From: Peter Stuge <peter-Y+HMSxxDrH8@public.gmane.org>
Subject: Re: USB keyboard occasional key stuck
Date: Tue, 18 Feb 2014 03:21:05 +0100
Message-ID: <20140218022105.14422.qmail@stuge.se>
References: <CAMVG2ss9nA4zcOT3c47EwEMrR7Z_gAQU-HTYGjdWcdYzihSnbg@mail.gmail.com> <5302C0B2.9010506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5302C0B2.9010506-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clinton Sprain <clintonsprain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel J Blueman <daniel-JCXMqzvhRcvYtjvyW6yDsg@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Clinton Sprain wrote:
> I noticed your examples are both fn combos. I'm seeing something like
> this and it seems specifically related to the fn key. Reproducible on a
> Macbook (3,1) and a Lenovo Yoga 13. Sequence is simple:
> 
> Press key
> Press fn
> Release key
> Release fn
> 
> The key will be 'stuck' until you press another key. It seems to only
> apply to keys that are part of a fn combo

Fn is handled by the embedded controller (H8 as per Intel reference
design in case of Macbook or Thinkpad) which has its own closed
firmware which is rarely perfectly bug-free.


//Peter
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

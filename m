From: simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org
Subject: Re: [PATCH] HID: logitech - lg2ff: Add IDs for Formula Vibration
 Feedback Wheel
Date: Mon, 7 Oct 2013 13:48:08 -0400
Message-ID: <cec1e0ca61cf17ceb6e52faa4f2baad9.squirrel@mungewell.org>
References: <1381164492-27145-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1381164492-27145-1-git-send-email-anssi.hannula-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anssi Hannula <anssi.hannula-X3B1VOXEql0@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Elias Vanderstuyft <elias.vds-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster-A1zFtI14ZBulVyrhU4qvOw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

> From: Elias Vanderstuyft <Elias.vds-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Add USB IDs for Logitech Formula Vibration Feedback Wheel (046d:ca04).
>
> The lg2ff force feedback subdriver is used for vibration and
> HID_GD_MULTIAXIS is set to avoid deadzone like other Logitech wheels.
>
> Kconfig description etc are also updated accordingly.
>
> Signed-off-by: Elias Vanderstuyft <Elias.vds-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> [anssi.hannula-X3B1VOXEql0@public.gmane.org: added description and CCs]
> Signed-off-by: Anssi Hannula <anssi.hannula-X3B1VOXEql0@public.gmane.org>
> Cc: Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> ---
>
> Simon, does this look OK to you, or do you think it should be an lg4ff
> device? Though I guess lg2ff is better than nothing even in that case.
>
> Jiri, lets see if we get a comment from Simon before applying.
>

I've cc'ed Michal as he contributed a lot to lg4ff and is looking at
improving ff-memless.

I am unfamiliar with this wheel (180' rotation, bungee cord for autocenter
and rumble motors - or so google tells me...), it's not listed on
Wikipedia (hint, hint):
http://en.wikipedia.org/wiki/Racing_wheel

At present lg4ff does not support RUMBLE effects (only CONSTANT and
AUTOCENTER), so lg2ff seems a sensible place. The only minor concern I
would have is any confusion from the descriptions in Kconfig.

I didn't build, but think that the patch looks OK to commit.

For the other wheels we have re-written the HID descriptors to split
brake/accel into seperate axis. Do you know whether this is possible for
this wheel too?

Thanks for your patch,
Simon.

Signed-off-by: Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

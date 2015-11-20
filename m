From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/7] Various touchscreens: Support axis
 inversion / swapping / extra gpios
Date: Fri, 20 Nov 2015 12:33:20 +0100
Message-ID: <564F0500.6020606@redhat.com>
References: <1448018233-27824-1-git-send-email-hdegoede@redhat.com>
 <20151120112245.GC8644@n2100.arm.linux.org.uk>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORBCEKXSZAKGQEHID5OGI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20151120112245.GC8644-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Sander Vermin <sander-wENMetUwf8VmR6Xm/wNWPw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On 20-11-15 12:22, Russell King - ARM Linux wrote:
> On Fri, Nov 20, 2015 at 12:17:06PM +0100, Hans de Goede wrote:
>> This patch-set extends the of_touchscreen.c helpers to (optionally) also
>> deal with axis inversion / swapping, and patches a bunch of drivers to use
>> this new functionality.
>
> What's wrong with using tslib?  tslib supports axis transformations in
> userspace via a set of filters.

Doing this in the kernel when we know that the touchscreen is always
mounted upside down (or rotated 90 degress) on a certain tablet makes things
just work, where as tslib requires manual configuration by the user.

Also most distributions are not even shipping tslib, some of this can be
done with the xf86-input-evdev driver (which is the upstream xorg default
driver for touchscreens) too, but again requires manual configuration and
the same goes for the new libinput stack to which xorg is moving and which
is the default for wayland.

Also note that this patch-set is not adding new functionality. We already
have devicetree-bindings to indicate to the driver that axis inversion /
swapping should be done in the driver, and these are already used in
various drivers. This patch-set just makes it easier to add support for
these already existing (and documented) devicetree properties.

Regards,

Hans

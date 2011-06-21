From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local GPIO chips.
Date: Tue, 21 Jun 2011 01:04:06 -0600
Message-ID: <BANLkTimWXtEyTbFic-n8EmCF9Y9T=g_=Nw@mail.gmail.com>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
 <1308042491-20203-4-git-send-email-david@protonic.nl> <20110616192732.GJ3795@ponder.secretlab.ca>
 <20110618101706.GB2401@core.coreip.homeip.net> <BANLkTiky39X3g3g9oy7fAdFhPn4hHOij9w@mail.gmail.com>
 <ADE657CA350FB648AAC2C43247A983F001F38227BCFE@AUSP01VMBX24.collaborationhost.net>
 <BANLkTin1aZEm5EKHFi7kB4zK4mija9P=pw@mail.gmail.com> <20110621085557.78509a8f@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34142 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab1FUHE0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2011 03:04:26 -0400
Received: by ywe9 with SMTP id 9so2387601ywe.19
        for <linux-input@vger.kernel.org>; Tue, 21 Jun 2011 00:04:26 -0700 (PDT)
In-Reply-To: <20110621085557.78509a8f@archvile>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Jander <david.jander@protonic.nl>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Jander <david@protonic.nl>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Jun 21, 2011 at 12:55 AM, David Jander <david.jander@protonic.n=
l> wrote:
> On Mon, 20 Jun 2011 12:20:30 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> On Mon, Jun 20, 2011 at 11:03 AM, H Hartley Sweeten
>> <hartleys@visionengravers.com> wrote:
>> > On Saturday, June 18, 2011 6:18 AM, Grant Likely wrote:
>> >> On Sat, Jun 18, 2011 at 4:17 AM, Dmitry Torokhov wrote:
>> >>> On Thu, Jun 16, 2011 at 01:27:32PM -0600, Grant Likely wrote:
>> >>>> On Tue, Jun 14, 2011 at 11:08:11AM +0200, David Jander wrote:
>> >>>>> Use a threaded interrupt handler in order to permit the handle=
r to use
>> >>>>> a GPIO driver that causes things like I2C transactions being d=
one
>> >>>>> inside the handler context.
>> >>>>> Also, gpio_keys_init needs to be declared as a late_initcall, =
to make
>> >>>>> sure all needed GPIO drivers have been loaded if the drivers a=
re built
>> >>>>> into the kernel.
>> >>>>
>> >>>> ...which is a horrid hack, but until device dependencies can be
>> >>>> described, it isn't one that can be solved easily.
>> >>>>
>> >>>
>> >>> I really do not want to apply this... Currently the order of
>> >>> initialization does not matter since nothing actually happens un=
til
>> >>> corresponding device appears on the bus. Does the OF code create=
s
>> >>> devices before all resources are ready?
>> >>
>> >> It's not an OF problem. =A0The problem is that all the platform_d=
evices
>> >> typically get registered all at once at machine_init time (on arm=
),
>> >> and if the gpio expander isn't a platform_device, (like an i2c gp=
io
>> >> expander which would end up being a child of a platform_device), =
then
>> >> it won't be ready. =A0The real problem is that we have no mechani=
sm for
>> >> holding off or deferring a driver probe if it depends on an
>> >> asynchronous resource.
>> >
>> > To avoid the registration order issue, isn't the proper fix to use=
 a
>> > "setup" method in the gpio expander driver? =A0The gpio-pca953x.c =
driver has
>> > this and I use it to hook the gpio_keys driver to those gpios. =A0=
The
>> > registration order ends up being:
>> >
>> > i2c-gpio as a platform_device in the machine init code
>> > pca9539 as part of the i2c_board_info for the i2c-gpio device
>> > gpio-keys as a platform_device via the .setup callback of pca9539
>>
>> Blech! =A0That approach fell out of the ugly tree and hit every bran=
ch
>> on the way down! =A0Points for creativity though. =A0:-) =A0Essentia=
lly that
>> ends up being a driver-specific notifier implementation.
>>
>> Yes, that works, but to me it just highlights a deficiency in the
>> Linux device model.
>
> Especially, how would I specify this setup handler in a device-tree?

You wouldn't.  Notifiers (and the above poor-man's notifier) only
works for specific cases in traditional board support code.  There
isn't a good pattern for using it with DT data.  You'd have to make
of_platform_populate() parse every node for any properties containing
a phandle it recognizes (assuming you can know whether the resource is
actually needed for the device to operate) and keep track of which
devices should not be registered because other devices haven't been
bound to drivers yet.  Then you need to have a notifier that looks for
those resources showing up, and registers the deferred device.

> The DT
> compiler still has no support for something like embedded DT-script ;=
-)

We're not going there.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

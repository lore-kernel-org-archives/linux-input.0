From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local GPIO chips.
Date: Mon, 20 Jun 2011 12:13:37 -0600
Message-ID: <BANLkTi=15FgU6t03VBnDD3_YEx56n_ZFDA@mail.gmail.com>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
 <1308042491-20203-4-git-send-email-david@protonic.nl> <20110616192732.GJ3795@ponder.secretlab.ca>
 <20110618101706.GB2401@core.coreip.homeip.net> <BANLkTiky39X3g3g9oy7fAdFhPn4hHOij9w@mail.gmail.com>
 <20110618145154.GA18190@core.coreip.homeip.net> <20110618151645.GG8195@ponder.secretlab.ca>
 <20110620094815.341d1cff@archvile> <20110620084511.GB23113@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41935 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755475Ab1FTSN6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2011 14:13:58 -0400
Received: by yxi11 with SMTP id 11so2187645yxi.19
        for <linux-input@vger.kernel.org>; Mon, 20 Jun 2011 11:13:58 -0700 (PDT)
In-Reply-To: <20110620084511.GB23113@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Jander <david.jander@protonic.nl>, David Jander <david@protonic.nl>, linux-input@vger.kernel.org

On Mon, Jun 20, 2011 at 2:45 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Jun 20, 2011 at 09:48:15AM +0200, David Jander wrote:
>> On Sat, 18 Jun 2011 09:16:45 -0600
>> Grant Likely <grant.likely@secretlab.ca> wrote:
>>
>> > On Sat, Jun 18, 2011 at 07:51:54AM -0700, Dmitry Torokhov wrote:
>> > > On Sat, Jun 18, 2011 at 07:18:28AM -0600, Grant Likely wrote:
>> > > > On Sat, Jun 18, 2011 at 4:17 AM, Dmitry Torokhov
>> > > > <dmitry.torokhov@gmail.com> wrote:
>> > > > > On Thu, Jun 16, 2011 at 01:27:32PM -0600, Grant Likely wrote=
:
>> > > > >> On Tue, Jun 14, 2011 at 11:08:11AM +0200, David Jander wrot=
e:
>> > > > >> > Use a threaded interrupt handler in order to permit the h=
andler to
>> > > > >> > use a GPIO driver that causes things like I2C transaction=
s being
>> > > > >> > done inside the handler context.
>> > > > >> > Also, gpio_keys_init needs to be declared as a late_initc=
all, to
>> > > > >> > make sure all needed GPIO drivers have been loaded if the=
 drivers
>> > > > >> > are built into the kernel.
>> > > > >>
>> > > > >> ...which is a horrid hack, but until device dependencies ca=
n be
>> > > > >> described, it isn't one that can be solved easily.
>> > > > >>
>> > > > >
>> > > > > I really do not want to apply this... Currently the order of
>> > > > > initialization does not matter since nothing actually happen=
s until
>> > > > > corresponding device appears on the bus. Does the OF code cr=
eates
>> > > > > devices before all resources are ready?
>> > > >
>> > > > It's not an OF problem. =A0The problem is that all the platfor=
m_devices
>> > > > typically get registered all at once at machine_init time (on =
arm),
>> > > > and if the gpio expander isn't a platform_device, (like an i2c=
 gpio
>> > > > expander which would end up being a child of a platform_device=
), then
>> > > > it won't be ready.
>> > >
>> > > Ah, I see. But that can be handled in board code that should ens=
ure that
>> > > it registers devices in correct order.
>> >
>> > Unfortunately, handling it in board code doesn't really work eithe=
r.
>> > It just shuffles the complexity to the board code to implement som=
e
>> > kind of deferred mechanism for registering devices, and it has to =
take
>> > into account that it may be a long time before the device actually
>> > appears, such as when the driver is configured as a module.
>>
>> Besides... we don't want anymore board-code, do we? I mean, if a boa=
rd can use
>> a generic board configuration and specify all it needs in the device=
-tree, why
>> should something as trivial as connecting a gpio_keys device to a I2=
C GPIO
>> expander force us to do special board setup all of a sudden?
>> IMHO specifying I2C-gpios to be used for gpio_keys should "just work=
", even if
>> declared in a device-tree.
>
> This is a laudable goal, but then device-tree needs to be able to
> express device dependencies better. Until then board-specific code is
> needed to register devices in proper order.

Do:
$ git grep _initcall drivers/gpio
and
$ git grep module_init drivers/gpio

I curse and hold my nose every time I have to apply one of those
initcall patches, but I have to anyway since there isn't even a good
way in board-specific code to control the device registration order.
Everything gets registered at machine_init time, and the /order/ that
things get registered has barely any effect.  It all ends up hanging
on the initcall order.  The only way for board code to have a
meaningful impact on initialization order is to wait for a driver to
get probed on a prerequisite device, probably by using a notifier, and
then register the device at that point.

As far as I can tell, no board code does that.  As ugly as fiddling
with initcall levels is, it has been sufficient up to this point for
existing (non-DT) board ports.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

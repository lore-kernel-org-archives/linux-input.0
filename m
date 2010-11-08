From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: ir-core and default IR maps
Date: Mon, 8 Nov 2010 10:07:25 -0500
Message-ID: <AANLkTinOE7MVWkQNm0Guoc6p2qQ+RmyJZZt7zh8ss8Yr@mail.gmail.com>
References: <AANLkTikfeu4DnV8E7rKahUdu2k_d08BOFZjLzBMRA2o+@mail.gmail.com>
	<20101107060147.GC3823@core.coreip.homeip.net>
	<AANLkTinbTw26wTvbUVJU+sEGyH0DCt4WvmfO2_nvcLjR@mail.gmail.com>
	<4CD7F6A7.8040206@redhat.com>
	<AANLkTinc_SuTrP6E8aoyXxGKEQwu=QRieRPt3z4b6Xn_@mail.gmail.com>
	<4CD80518.3060401@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58673 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab0KHPH1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 10:07:27 -0500
Received: by ewy7 with SMTP id 7so2826480ewy.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 07:07:26 -0800 (PST)
In-Reply-To: <4CD80518.3060401@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Jarod Wilson <jarod@redhat.com>

On Mon, Nov 8, 2010 at 9:11 AM, Mauro Carvalho Chehab
<mchehab@redhat.com> wrote:
> Em 08-11-2010 11:34, jonsmirl@gmail.com escreveu:
>> On Mon, Nov 8, 2010 at 8:09 AM, Mauro Carvalho Chehab
>
>> I only want the keymaps for remotes that are bundled with the hardware
>> to be included in their kernel driver. All other maps would ship in
>> the user space package. The maps for the bundled remotes would also be
>> duplicated in the user space package.
>
> All current RC maps in kernel are for the bundled hardware. There are, currently,
> 86 keymaps there. To be consistent, we should break the dibcom tables (there are 2
> "big" tables there, that supports lots of different remotes that came from dib0700 driver.
> There are also several dvb-usb drivers that still use their own RC keycodes bundled
> inside the driver's source code. So, we have 100+ keycode tables in kernel.
>
> This seems too much to keep synced between kernel and the userspace application.

You could write a script to do this. Use the user space versions as
master and then generate .h files that get included by the various
receivers. Regenerate on each release and send a single delta to
Linus.

>> To achieve plug and play at least one of four choices has to happen:
>> 1) maps for bundled remotes in the kernel drivers
>> 2) the distros always install the IR remotes map package
>> 3) every app that could possibly use IR adds the map package as a
>> dependency (may not work for IR keyboards)
>
> We don't have any IR keyboards right now at RC core. Do you know about any?

They exist, here are a few. I've only used them in hotel rooms so I'm
not sure how they work.
Some of these are probably IRDA.

http://www.goldmine-elec-products.com/prodinfo.asp?number=G15326&variation=
http://www.markertek.com/Structured-Premise-Wiring/Infrared-Extenders-Receivers/Amino/IR-KEYBOARD.xhtml
http://www.abesofmaine.com/itemB.do?item=SKIRKEYBOARD&id=SKIRKEYBOARD&l=FROOGLE
http://pcmonde.com/index.php?page=shop.product_details&flypage=flypage.tpl&option=com_virtuemart&Itemid=5&product_id=841


>
>> 4) We figure out some way of implementing the Windows search for
>> drivers dialog. This could be possible with a udev 'catch all' script.
>
>
> I like (3). I also think that (4) is a good long-term solution. Some distros
> like Fedora and Knoppix are adding some auto-search stuff (like printers,
> codec drivers, unknown commands, etc).
>
> I doubt I would have any time to work on (4), but, it shouldn't be hard to write
> generic auto-catch udev application that can open a dialog window at the windows
> manager, pointing that a newly plugged device requires some additional userspace
> package to be installed, in order to work. Of course, it will need to have a way
> to specify the command line to install a package (as it will be distro-specific).
> I think that it would be possible to have a config file that could explain the
> hardware/package dependencies, and the command lines needed to install an
> application.

The difficulty of getting all of the distros to build this is why I
thought it was easier to leave the bundled maps in the drivers until
the distros are ready.

>
>> All four of these will work, but we need to be sure at least one of
>> them gets implement. If not we end up with the user plugging in the
>> hardware and Googling to find out why it doesn't work.
>
> Yes. I think we should try to make everything working fine for .38 with some distros,
> making the in-kernel keytables as deprecated, but giving some time for all distros
> to adopt it, before actually removing them.
>
> Cheers,
> Mauro
>



-- 
Jon Smirl
jonsmirl@gmail.com

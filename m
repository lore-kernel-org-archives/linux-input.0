From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: RFC: making the aiptek.c tablet driver xf86-input-wacom compatible
Date: Wed, 26 Jun 2013 10:17:30 +0200
Message-ID: <CAN+gG=FxW40WxY1eSi=UzCKnmPipZ3HZw8sjNPbAgfi0P+D1bw@mail.gmail.com>
References: <1448859.K0oxtlBRpL@pebbles>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:43103 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab3FZIRb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Jun 2013 04:17:31 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so13215743lab.9
        for <linux-input@vger.kernel.org>; Wed, 26 Jun 2013 01:17:30 -0700 (PDT)
In-Reply-To: <1448859.K0oxtlBRpL@pebbles>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Stefan_Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Cc: linux-input <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>

Hi Stephan,

On Wed, Jun 26, 2013 at 12:02 AM, Stefan Br=C3=BCns
<stefan.bruens@rwth-aachen.de> wrote:
> Hi everyone,
>
> I have started to modify the aiptek tablet driver to be compatible wi=
th the
> xf86-input-wacom driver.
>
> Motivation:
> First, as wacom dominates the market, most configuration frontends ar=
e for
> wacom, desktop integration only exists for wacom, and most applicatio=
n
> developers only test with wacom tablets.
> Second, the xf86-input-aiptek driver seems to be unmaintained, at lea=
st
> opensuse has dropped it from distribution, and xf86-input-evdev is no
> sufficient replacement.

Yes the fact is that xf86-input-aiptek is unmaintained due to lack of
testers with the device. xf86-input-evdev is not a sufficient
replacement because it aims at forwarding the raw events from the
kernel without any processing. For tablets, the de facto natural way
is to use the wacom driver, which should be called now "tablet" but is
still called "wacom" for historical reasons.

>
> So for me there are two possibilities, either replicating all the wor=
k done
> for the wacom driver in the xorg stack and above, or just making the =
the
> aiptek driver mimic the output of the wacom kernel driver - I have ta=
ken the
> second option.

thanks for choosing the second solution :) I think Peter will join me
on this thank you.
I just gave a quick look at the xf86-input-aiptek sources, and there
is nothing which prevents you to port this device to the wacom driver.

>
> Currently, I am cleaning up my changes, and I am investigating some b=
ugs in
> the original driver parsing the reports from the device.

The device seems to be a HID declared one. I'd be curious to have a
look at the report descriptors to know if the parsing is really
necessary. The reports descriptor can be retrieved by calling "lsusb
-v" when the device is not bound to its usb driver.

>
> I have tested my Aiptek 6000U with the xf86-input-wacom driver, and i=
t is
> working fine in Krita, Inkscape and The Gimp, configuring the tablet =
via
> kcm_wacomtablet (KDE configuration module).

great!

>
> If anyone is interested, I will send my patches to this list after th=
e
> cleanup.

I think we are. And I think you will also get some advantages in
pushing those patches upstream so you will not have to manually
maintain your own branch :)

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: simon@mungewell.org
Subject: Re: Saitek PS1000 gamepad - HID descriptor wonky
Date: Mon, 12 Dec 2011 13:49:59 -0500
Message-ID: <98f3f0015149c06f45aa0af8e5851777.squirrel@host171.canaca.com>
References: <20111122102832.GA22152@v36691.1blu.de>
    <95ab6669b51867deb14cdd81c79dead1.squirrel@host171.canaca.com>
    <20111123084340.GA18805@tapura>
    <3b70c0a60fd5821240583b7b5c1412b0.squirrel@host171.canaca.com>
    <20111124081205.GA22623@tapura>
    <30cc35606560d634477e2a288bdf6db3.squirrel@host171.canaca.com>
    <20111208123424.GA1298@tapura>
    <a8799dfc5b69fd158ec54b099d231961.squirrel@host171.canaca.com>
    <20111210131702.GA5620@tapura>
    <d13c53ac7f835eaff26cfc2aae0fac6c.squirrel@mungewell.org>
    <20111211214010.GA14046@tapura>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:52752 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab1LLSuC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Dec 2011 13:50:02 -0500
In-Reply-To: <20111211214010.GA14046@tapura>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=22Andreas_H=FCbner=22?= <andreas@k4n.de>
Cc: linux-input@vger.kernel.org

>> You have to check the rsize, otherwise you might have problems writing
>> outside the size of the original descriptor.
>
> That's exactly what I've been doing, or did I miss something?

> In fact, I wanted to be absolutely sure and only mess with the descriptor
> when the sizes match.  (*rsize == 137)

Err.. must have been sleepy when I looked over your code. Don't know
whether '>=' is better than '==', all other modules do this and I wonder
whether the kernel can get a larger descriptor block by some mechanism.


> Should already be on the list. And I was able to identify the culprit so
> no need to bother you.
>
> The problem is the following code in hidinput_configure_usage
> (drivers/hid/hid-input.c):
>
> 	if (field->flags & HID_MAIN_ITEM_CONSTANT)
> 		goto ignore;
>
> The buttons and the hat are defined with the constant flag enabled.
> Now I might be reading the spec wrong, but I'm not so sure that we can
> simply skip constant values.

Quite obviously if the buttons change value in the HID stream then they
are not 'CONSTANT', personally I would patch this part of the HID
descriptor so they are just defined as 'input variable'.

> Well, I need to patch the descriptor nevertheless because it defines a
> non-existing sixth axis. Might as well remove the constant flag on the
> buttons and hat. However, other devices might be affected as well, so
> I'd like to get some input on how to deal with the situation.

Not sure why you would think other devices might be affected. Patching the
HID descriptor should be limited to this USBID pair, and even only active
if the device provided matches the template you use to trigger patching.

Some drivers provide a complete/new descriptor where patching is
complicated, although you gain extra hacker-points if you can achieve the
same with a minimal patch :-)

Simon.



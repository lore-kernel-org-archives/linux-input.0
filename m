From: Andreas =?iso-8859-1?Q?H=FCbner?= <andreas@k4n.de>
Subject: Re: Saitek PS1000 gamepad - HID descriptor wonky
Date: Tue, 13 Dec 2011 20:09:31 +0100
Message-ID: <20111213190931.GA32329@v36691.1blu.de>
References: <20111123084340.GA18805@tapura>
 <3b70c0a60fd5821240583b7b5c1412b0.squirrel@host171.canaca.com>
 <20111124081205.GA22623@tapura>
 <30cc35606560d634477e2a288bdf6db3.squirrel@host171.canaca.com>
 <20111208123424.GA1298@tapura>
 <a8799dfc5b69fd158ec54b099d231961.squirrel@host171.canaca.com>
 <20111210131702.GA5620@tapura>
 <d13c53ac7f835eaff26cfc2aae0fac6c.squirrel@mungewell.org>
 <20111211214010.GA14046@tapura>
 <98f3f0015149c06f45aa0af8e5851777.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v36691.1blu.de ([89.202.1.191]:56549 "EHLO v36691.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984Ab1LMTJm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Dec 2011 14:09:42 -0500
Content-Disposition: inline
In-Reply-To: <98f3f0015149c06f45aa0af8e5851777.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

On Mon, Dec 12, 2011 at 01:49:59PM -0500, simon@mungewell.org wrote:
> Err.. must have been sleepy when I looked over your code. Don't know
> whether '>=' is better than '==', all other modules do this and I wonder
> whether the kernel can get a larger descriptor block by some mechanism.

Well, this would be kind of strange, wouldn't it?
But I can change it to '>=' if it makes you happy. :)


> Quite obviously if the buttons change value in the HID stream then they
> are not 'CONSTANT', personally I would patch this part of the HID
> descriptor so they are just defined as 'input variable'.

While I personally agree with that interpretation, the spec only states
that constant fields can not be written by the host. (I know, this
doesn't make any sense for an input report.)

Somewhere I read that a constant field with no usage assigned to it
should be treated as padding. But in this case, there is a usage
assigned to.
And this is what I'd actually do in hidinput_configure_usage: only goto
ignore if there is no usage associated with the field.

On the other hand, the gamepad example in the HID Usage Tables doesn't
use the constant flag for buttons.


> Not sure why you would think other devices might be affected. Patching the
> HID descriptor should be limited to this USBID pair, and even only active
> if the device provided matches the template you use to trigger patching.

I was worrying that other devices might declare some non-padding input
fields as constants. So if you fix this problem in the generic part
(i. e. hid-input.c) those devices will also start working correctly.


Andreas

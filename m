From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Support for Alps SS5 touchpad
Date: Sat, 28 May 2016 14:37:20 +0200
Message-ID: <bf7c7b92-0b17-3867-aa8e-a4cda193dc4a@redhat.com>
References: <1464436862-2649-1-git-send-email-ben@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45134 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbcE1Mh1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 28 May 2016 08:37:27 -0400
In-Reply-To: <1464436862-2649-1-git-send-email-ben@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org
Cc: Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>

Hi,

On 28-05-16 14:00, Ben Gamari wrote:
> Here is a patchset adding support for the Alps SS5 touchpad hardware shipped
> with the Dell Latitude E7470. The protocol is similar to that used by the SS4
> v2 devices, but with additional support for a touchstick.
>
> The touchpad exhibits slightly inconsistent behavior when single-finger
> contacts are released while a button is being held. This leads to extremely
> unpleasant jumps in pointer position, especially during drag-and-drop
> operations. This is resolved by patch 2/4.
>
> One minor outstanding issue is the high speed of the touchstick. Previous
> touchstick drivers have taken the extremely unfortunate approach of scaling the
> input device space to work-around this (often sacrificing device resolution in
> the process). I've started another thread on linux-input (see "Should
> touchsticks really be relative input devices?") to discuss options for
> resolving this.

The problem with touchstick's is that they have a wildly varying sensitivity,
unfortunately this seems to be laptop model specific, e.g. one generation
of alps tracksticks can be slow on some models and fast on others.

We've entries in udev's hwdb for known troublesome models, see:
/lib/udev/hwdb.d/70-pointingstick.hwdb

On a modern Linux distro. If you add an entry for your laptop there, with a
slow-down factor and are using xf86-input-libinput as driver for the
touchstick, then things should work.

Note after updating the file you must run "sudo udevadm hwdb --update" and
then reboot (or trigger the relevant device).

Regards,

Hans

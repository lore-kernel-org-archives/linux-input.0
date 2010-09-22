From: Mat <jackdachef@gmail.com>
Subject: Re: [BUG, Regression, bisected] USB mouse causes bug on 1st insert,
 ignored on 2nd insert, lsusb stuck at usbdev_open
Date: Wed, 22 Sep 2010 11:47:09 +0200
Message-ID: <AANLkTinQVNy4yOSW=aEbuYh6b_F8nKBLxsjxBDk8zq8O@mail.gmail.com>
References: <Pine.LNX.4.44L0.1009211013460.1644-100000@iolanthe.rowland.org>
	<4C98C70B.3080407@turmel.org>
	<4C98D892.7030605@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45298 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab0IVJrK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Sep 2010 05:47:10 -0400
In-Reply-To: <4C98D892.7030605@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriel C <nix.or.die@googlemail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jiri Kosina <jkosina@suse.cz>, Guillaume Chazarain <guichaz@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Oliver Neukum <oliver@neukum.org>, Alan Ott <alan@signal11.us>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Andreas Bombe <aeb@debian.org>, Alex Riesen <raa.lkml@gmail.com>

On Tue, Sep 21, 2010 at 6:08 PM, Gabriel C <nix.or.die@googlemail.com> =
wrote:
> On 21.09.2010 16:54, Phil Turmel wrote:
>
>> On 09/21/2010 10:30 AM, Alan Stern wrote:
>>> On Tue, 21 Sep 2010, Jiri Kosina wrote:
>>>
>>>> I have just found out that it's actually CONFIG_USB_DYNAMIC_MINORS=
 which
>>>> makes the difference. When unset, the problem doesn't trigger, and
>>>> usb_find_interface() always returns the proper interface. When
>>>> CONFIG_USB_DYNAMIC_MINORS is being used, the oops happen.
>>>>
>>>> I'll look into that.
>>>
>>> Apparently the problem is that intf->minors doesn't get initialized
>>> properly. =A0This patch should fix it. =A0Everybody, please try it =
out.
>>
>> Yes, this works for me. =A0(as did Jiri's version.)
>
>
> Both versions of the patch are working fine for me too also.
>
>>
>> Thank you both for the support.
>>
>> Feel free to add my:
>>
>> Tested-by: Philip J. Turmel <philip@turmel.org>
>
>
> And mine if you wish.
> Tested-by: Gabriel Craciunescu =A0<nix.or.die@googlemail.com>
>
>

confirmed !

I also tested both and it works fine so far :)

I don't know if it's too late already:
Tested-by: Matthias Bayer <jackdachef@gmail.com>

Thanks !

Matt
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

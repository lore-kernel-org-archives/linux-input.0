From: przemo@firszt.eu
Subject: Re: [PATCH] HID: wacom: Fix invalid power_supply_powers calls
Date: Mon, 6 Feb 2012 17:44:17 -0000
Message-ID: <b24d411c05c013317690ef4cec330c71.squirrel@webmail.firszt.eu>
References: <1328481324-7241-1-git-send-email-przemo@firszt.eu>
    <alpine.LNX.2.00.1202061326150.24127@pobox.suse.cz>
    <d2139519eb66f9b7bfd8f56d3b4e2d96.squirrel@webmail.firszt.eu>
    <alpine.LNX.2.00.1202061342090.24127@pobox.suse.cz>
    <4F300F2C.9030308@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:44857 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751016Ab2BFRok (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Feb 2012 12:44:40 -0500
In-Reply-To: <4F300F2C.9030308@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Przemo Firszt <przemo@firszt.eu>, chris@cnpbagwell.com, pinglinux@gmail.com, linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> On 02/06/2012 04:42 AM, Jiri Kosina wrote:
>> On Mon, 6 Feb 2012, przemo@firszt.eu wrote:
>>
>>>> Hmm, seems valid. How did you notice? Have you seen crashes because of
>>>> wild pointers?
>>> Hi Jiri,
>>> Yes, the driver was unusable - 100% crashes during connection.
>> Okay, I thought that'd be the case.
>
> Very sorry about that.  I don't have a device to test with, so I should
> have reviewed the code extra carefully.
>
> Does the same bug apply to the Wii changes, which were of the same form?
>
Hi Jeremy,
The wii code looks the same, so probably it's affected as well. Can you
make a patch?

power_supply_powers call in wiimote driver:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/hid/hid-wiimote-core.c#l1229

regards,
Przemo Firszt


From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/1] HID: multitouch: enable palm rejection if device
 implements confidence usage
Date: Mon, 4 Jan 2016 09:35:46 +0100
Message-ID: <CAN+gG=EzUADfseJQ_bY9KXQ_+YNrpS8B6B9eRK_gcyD6aZpg9w@mail.gmail.com>
References: <1448014866-25348-1-git-send-email-allen_hung@dell.com>
	<alpine.LNX.2.00.1511261521350.20111@pobox.suse.cz>
	<CAN+gG=Ga92-UPbbcjiL0p2b4gO0iQE_-U6wXiq_x3=39z+edSg@mail.gmail.com>
	<5677CA23.9050008@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34676 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbcADIfr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jan 2016 03:35:47 -0500
In-Reply-To: <5677CA23.9050008@dell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Allen Hung <allen_hung@dell.com>
Cc: Jiri Kosina <jikos@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

Hi Allen,

On Mon, Dec 21, 2015 at 10:45 AM, Allen Hung <allen_hung@dell.com> wrote:
> On 12/18/2015 05:52 AM, Benjamin Tissoires wrote:
>> On Thu, Nov 26, 2015 at 3:21 PM, Jiri Kosina <jikos@kernel.org> wrote:
>>> On Fri, 20 Nov 2015, Allen Hung wrote:
>>>
>>>> The usage Confidence is mandary to Windows Precision Touchpad devices. The
>>>> appearance of this usage is checked in hidinput_connect but the quirk
>>>> MT_QUIRK_VALID_IS_CONFIDENCE is not applied to device accordingly.
>>>> Apply this quirk and also remove quirk MT_QUIRK_ALWAYS_VALID to enable palm
>>>> rejection for the WIN 8 touchpad devices which have implemented usage
>>>> Confidence in its input reports.
>>>>
>>>> Tested on Dell XPS 13 laptop.
>>>>
>>>> Signed-off-by: Allen Hung <allen_hung@dell.com>
>>> Applied to for-4.5/multitouch. Thanks,
>>>
>> Allen, looks like the Dell XPS13 2015 (or was it the 2014?) has
>> problems with your patch:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1292583 (we backported
>> this change in the Fedora kernel 4.2.7).
>>
>> Would you mind checking that this patch does not create regressions on
>> older series of laptops?
>>
>> Thanks in advance.
>>
>> Cheers,
>> Benjamin
> Hi Benjamin,
>
> It looks like a XPS13 2014 but I can confirm this with my colleagues who are in charge of this product line. I don't mind checking this patch with more older series of laptops. I will do it and let you know the status. Should I also test the machines with Fedora 23, or just go with Ubuntu OS? The XPS machines are shipped with Ubuntu.
> Btw, the issue reporter said she/he cannot reproduce the issue (posted on Dec. 18).
>

[Sorry for the late answer, but you guessed the holiday season did not help :)]

I think I'll just ask the reporter to confirm he can not reproduce and
then close the downstream bug.
Unless other people complains, I think we can just keep the current
state and wait :)

Cheers,
Benjamin

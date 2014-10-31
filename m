From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] i8042: Add noloop quirk for Asus X750LN
Date: Fri, 31 Oct 2014 09:23:14 +0100
Message-ID: <545346F2.5040002@redhat.com>
References: <1413032946-19748-1-git-send-email-hdegoede@redhat.com> <20141011183523.GA20881@dtor-ws> <20141030183410.GG36444@dtor-ws> <545346A1.3070708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43182 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbaJaIXS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 04:23:18 -0400
In-Reply-To: <545346A1.3070708@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

On 10/31/2014 09:21 AM, Hans de Goede wrote:
> Hi,
> 
> On 10/30/2014 07:34 PM, Dmitry Torokhov wrote:
>> On Sat, Oct 11, 2014 at 11:35:23AM -0700, Dmitry Torokhov wrote:
>>> On Sat, Oct 11, 2014 at 03:09:06PM +0200, Hans de Goede wrote:
>>>> Without this the aux port does not get detected, and consequently the touchpad
>>>> will not work.
>>>>
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1110011
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> Applied, thank you.
>>
>> Hans,
>>
>> Do you still have dmidecode for this laptop around?
> 
> No I took the necessary identification strings from the dmesg, which is here:
> 
> https://bugzilla.redhat.com/attachment.cgi?id=944389
> 
> I'll drop you a private mail with the users email address, then you
> can get into contact with him directly, I expect him to be willing to
> help debug this further.
> 
>> Can I see it? I am
>> just wondering what part of AUX_LOOP was causing issues. Was it aux
>> delivery test or loop test itself?
> 
> I was wondering myself, which is why the above dmesg is with:
> 
> "dyndbg=file drivers/input/serio/* +p"
> 
> But that does not seem to print anything extra ..., is the i8042 code
> properly using one of the foo_dbg macro's ?

Ah, wait I just realized that even though the user was asking for help
in Red Hat bugzilla he is actually a ubuntu user, I guess their kernels
just don't have dyndbg turned on.

Regards,

Hans

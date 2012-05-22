From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [PATCH] input: Force Sentelic reconnect when mode setting has
 failed
Date: Tue, 22 May 2012 11:42:28 +0800 (CST)
Message-ID: <12052211372417.9614@cnaqrzbavhz.fragryvp.pbz>
References: <1337468192-16337-1-git-send-email-mjg@redhat.com>
 <12052123215711.9614@cnaqrzbavhz.fragryvp.pbz> <20120521152851.GA3552@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809760-1554920753-1337658148=:9614"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:15981 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759456Ab2EVDnT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 May 2012 23:43:19 -0400
In-Reply-To: <20120521152851.GA3552@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: os@ohmu.fi, dtor@mail.ru, linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809760-1554920753-1337658148=:9614
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Mon, 21 May 2012, Matthew Garrett wrote:
> On Mon, May 21, 2012 at 11:22:07PM +0800, Tai-hwa Liang wrote:
>> On Sat, 19 May 2012, Matthew Garrett wrote:
>>> The Sentelic touchpad in an Asus UX-21 failed to work since the native
>>> driver was merged. Examination showed that the FSP_REG_SWC1 register had
>>> reverted back to 0x80 and so the pad was sending normal packets despite
>>> the driver expecting absolute ones.
>>
>>    Sounds to me that the hardware was reset, which usually happens if
>> there's intermittent power failure events.  Is there any particular step
>> to reproduce this unexpected resetting?
>
> None that I've identified. It only seems to do it once, and afterwards
> it's fine. I agree that this seems to be covering up some more insidious
> bug, but I spent most of Friday and Saturday failing to find one.

Hi Matthew,

   Would you please run the attached script and post the result next time
when you run into the abnormal scenario(FSP sends normal instead of abs.
packets)?

   You probably need to do this experiment without the reconnecting patch
applied.

Thank you,

Tai-hwa Liang
---1463809760-1554920753-1337658148=:9614
Content-Type: APPLICATION/x-sh; name=get_state.sh
Content-Transfer-Encoding: BASE64
Content-ID: <12052211422817.9614@cnaqrzbavhz.fragryvp.pbz>
Content-Description: 
Content-Disposition: attachment; filename=get_state.sh

IyEvYmluL3NoCmZvciBpIGluIC9zeXMvYnVzL3NlcmlvL2RyaXZlcnMvcHNt
b3VzZS9zZXJpbyo7IGRvCglpZiBbIC1lICR7aX0vZ2V0cmVnIF07IHRoZW4K
CQlQQUdFPWBjYXQgJHtpfS9wYWdlYAoJCWVjaG8gLW4gMHgwMCA+ICR7aX0v
cGFnZQoJCWVjaG8gLW4gMHgwNyA+ICR7aX0vZ2V0cmVnCgkJVE1QPWBjYXQg
JHtpfS9nZXRyZWdgCgkJZWNobyAtbiAweDBiID4gJHtpfS9wYWdlCgkJZWNo
byAtbiAweDQwID4gJHtpfS9nZXRyZWcKCQlTTjA9YGNhdCAke2l9L2dldHJl
Z2AKCQllY2hvIC1uIDB4NDEgPiAke2l9L2dldHJlZwoJCVNOMT1gY2F0ICR7
aX0vZ2V0cmVnYAoJCWVjaG8gLW4gMHg0MiA+ICR7aX0vZ2V0cmVnCgkJU04y
PWBjYXQgJHtpfS9nZXRyZWdgCgkJZWNobyAtbiAke1BBR0V9ID4gJHtpfS9w
YWdlCgkJZWNobyAiJFRNUCwgJFNOMCwgJFNOMSwgJFNOMiIKCWZpCmRvbmUK

---1463809760-1554920753-1337658148=:9614--

From: Michal Suchanek <hramrach@centrum.cz>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Fri, 12 Nov 2010 00:21:09 +0100
Message-ID: <AANLkTikg9=EvXX2NFAJQSNv8-1XWdoWmwBNo10_nFcww@mail.gmail.com>
References: <AANLkTi=rxkJcmp8WLKCRnxqNd_1QBT4W_2YJNJBcsHzF@mail.gmail.com>
 <AANLkTimPUYXe=Pno8O2k_U7u9N+ob6EQMD_DCDtLDTS5@mail.gmail.com>
 <20101110050219.GB29110@barra.bne.redhat.com> <4CDA6D25.4070501@euromail.se>
 <20101110235355.GB4473@barra.bne.redhat.com> <4CDB3D6C.2000507@euromail.se>
 <20101111012251.GC2121@core.coreip.homeip.net> <AANLkTinYE40qN7n98Vb-Pyh5npst6JN+1LzxZaU50X_H@mail.gmail.com>
 <20101111082653.GC24415@core.coreip.homeip.net> <AANLkTikVZBdTTR=jb=jpW+u5sHr4zazypwOnJSoR-RXv@mail.gmail.com>
 <20101111192434.GA13163@core.coreip.homeip.net> <4CDC46E5.8040703@euromail.se>
 <AANLkTi=TVm1xUeM8nfnGFhyrjW9+3NL0AO9iCvVFTriZ@mail.gmail.com>
 <4CDC626D.9050205@euromail.se> <AANLkTikjbqo3RdJjDzm4N+cDy+q4dC2h_9oMR7zVJTPn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44801 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab0KKXVb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 18:21:31 -0500
Received: by wyb28 with SMTP id 28so1262445wyb.19
        for <linux-input@vger.kernel.org>; Thu, 11 Nov 2010 15:21:30 -0800 (PST)
In-Reply-To: <AANLkTikjbqo3RdJjDzm4N+cDy+q4dC2h_9oMR7zVJTPn@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Chris Bagwell <chris@cnpbagwell.com>, linux-input <linux-input@vger.kernel.org>

On 11 November 2010 23:10, Ping Cheng <pinglinux@gmail.com> wrote:
> On Thu, Nov 11, 2010 at 1:38 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
>>>
>>> Are we going to do the tocuh and pen aribtration in input-mt.c? I need
>>> to understand this to make my patches.
>>
>> If the pen is implemented as just another contact, it will also be treated as
>> such, and arbitration becomes the same thing as single-pointer emulation.
>
> As we discussed earlier, pen is on a separate logical port for USB
> devices. But that should not be an issue in the kernel driver, i.e.,
> input-mt.c.
>
> I'd love to wait for the implementation of input-mt.c. Do you have a
> rough timeline for it?
>
> If we want to merge pen, and other tool types in the future, into the
> same MT slot, a way to tell the userland of the different size and
> resolution of the tool is a must. Or maybe you have other suggestions
> on "pen is implemented as just another contact"?
>

I would suggest to report the data in the resolution and scale they
are obtained.

Most attempts to 'cook' data in the kernel eventually result in issues.

In no use I know of the scale really matters. Either the data is used
for relative motion and then different tools need different
acceleration formulas depending on their properties like fuzz or it is
used as absolute pointer and then it is scaled to the desktop or widow
size regardless of the original range. When used for gestures again
fuzz is more relevant than range of possible values received.

Thanks

Michal

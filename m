From: Robert Munteanu <rombert@apache.org>
Subject: Re: [RFC v2 PATCH] Fix modifier keys for Redragon Asura Keyboard
Date: Mon, 19 Jun 2017 10:33:17 +0300
Message-ID: <1497857597.5395.2.camel@apache.org>
References: <1497565458.8428.1.camel@apache.org>
         <CAAZ5spAeoQ0sycktP7zpoTRMb42EGS2=8ZODzmNi3=80MB-CzA@mail.gmail.com>
         <CAAZ5spAV3tKc-52W4snYq3XRsw9uZ-ikDvAss3dSEk9hnFTitQ@mail.gmail.com>
         <CAAZ5spBy_wzOYgZ42nuet-vp_FR1UHxyzz1fj8qdMqd0-DYuig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermes.apache.org ([140.211.11.3]:59661 "HELO mail.apache.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751089AbdFSHdY (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 03:33:24 -0400
In-Reply-To: <CAAZ5spBy_wzOYgZ42nuet-vp_FR1UHxyzz1fj8qdMqd0-DYuig@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michel Hermier <michel.hermier@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Michel,

On Fri, 2017-06-16 at 08:30 +0200, Michel Hermier wrote:
> Are you sure it is the correct way to do it? I mean I looked a little
> to
> the hid descriptor and it seemed to be correct, at least the part
> that
> describe key modifiers. So it smell more like a hid parser bug,
> forgetting
> to consume/declare one byte before the modifiers bits.
> 

I am not sure about the correctness of the approach, thus the RFC :-)

It was also quite easy for me to discover the behaviour when using a
new module, but with the existing code base I find it harder to
navigate.

Can you point me to where the hid codes are parsed? Is it
hidinput_setkeycode in hid-input.c?

Thanks,

Robert

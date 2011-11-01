From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: Sony DualShock3 - Detected but no events
Date: Tue, 1 Nov 2011 12:24:03 +0200
Message-ID: <CAOazyz0pBZE_qE3NYbz6n54kCA30dU2Z3PaT3_ufZv2egpj=cg@mail.gmail.com>
References: <CAOazyz0GNJKFWNsaFiwheMjhBVJrcP-p8QBcsSvS3V97iuZFtQ@mail.gmail.com>
	<20111101011854.5e0e87b561f6b18dcc09a988@studenti.unina.it>
	<CAOazyz1EfHdg4gExfeVaQ_8mMV=1Tu-aYBTEo_j4MjLnNC4kHA@mail.gmail.com>
	<20111101090645.0d3abeac5909f87dae8bec58@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47527 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab1KAKYE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Nov 2011 06:24:04 -0400
Received: by qabj40 with SMTP id j40so5608821qab.19
        for <linux-input@vger.kernel.org>; Tue, 01 Nov 2011 03:24:04 -0700 (PDT)
In-Reply-To: <20111101090645.0d3abeac5909f87dae8bec58@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org

On Tue, Nov 1, 2011 at 10:06 AM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
>> In the mean while I would like first to see it work with plain USB,
>> which should be much simpler, no?
>> If you connect the device to the USB port, does it work? Do yo see
>> activity when you do cat /dev/input/js0?

Thank you again for your reply, I will patch bluez and report back.

But can you please reply to the plain USB setup (wired) question?
It should work without any patch, right? Vanilla kernel with proper
setup should do the trick,
no user mode component, just kernel support.
Does it work for you? or can you confirm that plain USB HID with
hid-sony is not working?

Thanks!
Alon.

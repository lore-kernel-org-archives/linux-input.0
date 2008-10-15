From: "Phil Endecott" <phil_dubhl_endecott@chezphil.org>
Subject: Re: Slow boot due perhaps to locks in mouse and platform system
Date: Wed, 15 Oct 2008 10:19:28 +0100
Message-ID: <1224062368151@dmwebmail.dmwebmail.chezphil.org>
References: <20081014222222.4260fa48@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; format="flowed"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from japan.chezphil.org ([77.240.5.4]:3568 "EHLO japan.chezphil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbYJOJTa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Oct 2008 05:19:30 -0400
Received: from localhost ([127.0.0.1] helo=chezphil.org)
	by japan.chezphil.org with esmtp (Exim 4.69)
	(envelope-from <phil_dubhl_endecott@chezphil.org>)
	id 1Kq2XQ-00014L-ST
	for linux-input@vger.kernel.org; Wed, 15 Oct 2008 10:19:28 +0100
In-Reply-To: <20081014222222.4260fa48@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-input <linux-input@vger.kernel.org>

Arjan van de Ven wrote:
> On Wed, 15 Oct 2008 00:17:29 +0100
> "Phil Endecott" <phil_dubhl_endecott@chezphil.org> wrote:
>
>> 
>> It looks to me as if uhci holds some lock that 8250 needs before it
>> can complete.  Now those are both PCI drivers in the same way that
>> the last two that seemed to contend were both input drivers (touchpad
>> and speaker) [hmm, except that as Dmitry pointed out there's a
>> distinction between the platform bus and the serio bus].  Anyway, my
>> ignorant suspicion is that there's some lock related to the bus or
>> subsystem that they both need.  Maybe something in sysfs?
>
> it does do this. And I know which lock... and I fixed it ;)
> Just the patch for this is in Gregkh's tree since it's a change to the
> device/sysfs layer and he wanted to carry it via that way.
>
> I can dig that patch out if you want

Yes please!


Phil.




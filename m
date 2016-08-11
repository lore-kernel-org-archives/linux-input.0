From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: Update last_slot_field during pre_report
 phase
Date: Thu, 11 Aug 2016 08:22:55 -0700
Message-ID: <539b414d-b9be-879b-6d3c-7737ea4e8883@gmail.com>
References: <f20b53ac-1bde-7005-2874-74bdd6d6aa96@gmail.com>
 <20160721161046.25608-1-killertofu@gmail.com>
 <20160725093830.GF19383@mail.corp.redhat.com>
 <ef5407df-f33f-1da1-7ade-385932711bcd@gmail.com>
 <alpine.LNX.2.00.1608111026340.22028@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:32984 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbcHKPXc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Aug 2016 11:23:32 -0400
Received: by mail-pa0-f65.google.com with SMTP id vy10so363830pac.0
        for <linux-input@vger.kernel.org>; Thu, 11 Aug 2016 08:22:58 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1608111026340.22028@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On 08/11/2016 01:27 AM, Jiri Kosina wrote:
> On Wed, 10 Aug 2016, Jason Gerecke wrote:
> 
>> Making sure this patch doesn't fall into the cracks...
> 
> Alright, I apparently wasn't CCed; please don't forget to do so on patches 
> you want me to apply, otherwise they might easily be missed.
> 
> My understanding is that this is rather 4.8 material still, do you agree?
> 
> Thanks,
> 

Yes, it should be fine to target for 4.8.

Thanks,
Jason
---
Now instead of four in the eights place /
you’ve got three, ‘Cause you added one /
(That is to say, eight) to the two, /
But you can’t take seven from three, /
So you look at the sixty-fours....

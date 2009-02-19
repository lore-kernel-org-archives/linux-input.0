From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Thu, 19 Feb 2009 09:56:14 +0300
Message-ID: <78f5d6bf0902182256r4ea8525dn94caa84b4b447574@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	 <78f5d6bf0902121006r460ba8d6m61126af161358c19@mail.gmail.com>
	 <49946D7A.408@gmail.com>
	 <78f5d6bf0902130033k7d0089cfo857bb48a19da1630@mail.gmail.com>
	 <4995CD44.5000808@gmail.com>
	 <78f5d6bf0902141125m1bf9ac00xb2b414e81d81b869@mail.gmail.com>
	 <49972478.3060207@gmail.com>
	 <78f5d6bf0902141433hca696fdo87140907cc358fbf@mail.gmail.com>
	 <78f5d6bf0902170416j39cced63i23a712c754fd4445@mail.gmail.com>
	 <499C2D22.8020005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:64323 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbZBSG4P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Feb 2009 01:56:15 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1076725fgg.17
        for <linux-input@vger.kernel.org>; Wed, 18 Feb 2009 22:56:14 -0800 (PST)
In-Reply-To: <499C2D22.8020005@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

2009/2/18 Anssi Hannula <anssi.hannula@gmail.com>:
>> Problem in fftest is simple: using uninitialized structures. That also
>> was causing slow path warning.
>> But running ffmvforce after fftest brings device to unconsistent
>> state, causing messages "usb 1-1: ctrl urb status -62 received".
>
> Does this happen also with fixed fftest?
Yes. That's the problem.
Exactly this sequence: run fftest, play all effects, then run
ffmvforce. ffmvforce itself is working well.

> Of course hid-pidff should also check the values provided, I'll fix this as
> well.
I think it'd be also good to look what could cause slow path warning.

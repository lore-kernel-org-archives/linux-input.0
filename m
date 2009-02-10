From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Fwd: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Tue, 10 Feb 2009 10:49:57 +0300
Message-ID: <78f5d6bf0902092349s7d4781bfwce0e9016f1babef@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	 <49871663.4060605@gmail.com>
	 <78f5d6bf0902021029g7e53f16ble27500b52f9498ba@mail.gmail.com>
	 <498D7E81.4060007@gmail.com>
	 <78f5d6bf0902092146x2abaf45an79e4546e75a80356@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:52449 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbZBJHt7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2009 02:49:59 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1235409fgg.17
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2009 23:49:57 -0800 (PST)
In-Reply-To: <78f5d6bf0902092146x2abaf45an79e4546e75a80356@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Thanks Anssi!

Your patch helped, device is passing pidff_find_reports().

Now stuck in pidff_find_fields(), with "unknown set_effect report layout".
Looks like, device doesn't implement PID specs completely, as there is
no gain and direction usages in set_effect report:
>The minimal Effect parameter block must contain (Effect) Parameter Block Index, Effect Type, Duration,
>Sample Period, Gain, Trigger Button, Trigger Repeat Interval, Axis Direction, and Type Specific Block
>Handle values.

But, looking into pidff_set_effect_report(), I think, it's possible to
add two if's to check if these fields present. And need to make check
for these fields optional somehow.
These two usages are not fully utilized anyway, gain is always set to
it's logical_maximum (actually it's used only in pidff_autocenter())
and direction is always set to 1.

There is also some problem with pidff_find_special_fields() ("effect
lists not found"), i'll add more debug messages and tell about that
later.

2009/2/7 Anssi Hannula <anssi.hannula@gmail.com>:
> Try the attached patch, which simply changes the collection type for
> such collections.

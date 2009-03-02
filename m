From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Mon, 2 Mar 2009 21:41:26 +0300
Message-ID: <78f5d6bf0903021041o24155b7dg89a5fb975e60c320@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	 <78f5d6bf0902141125m1bf9ac00xb2b414e81d81b869@mail.gmail.com>
	 <49972478.3060207@gmail.com>
	 <78f5d6bf0902141433hca696fdo87140907cc358fbf@mail.gmail.com>
	 <78f5d6bf0902170416j39cced63i23a712c754fd4445@mail.gmail.com>
	 <499C2D22.8020005@gmail.com>
	 <78f5d6bf0902182254v191cc485x62eb211baaddd36@mail.gmail.com>
	 <499D7C66.6090000@gmail.com>
	 <78f5d6bf0902261321m62b423c6hed04c693e03f569e@mail.gmail.com>
	 <49A813CB.3080805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:39400 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbZCBSl3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2009 13:41:29 -0500
Received: by fxm24 with SMTP id 24so2109497fxm.37
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2009 10:41:26 -0800 (PST)
In-Reply-To: <49A813CB.3080805@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org

2009/2/27 Anssi Hannula <anssi.hannula@gmail.com>:
> These seem strange:
> [ 5108.143241] usbhid:hid-pidff: create_new_effect sent, type: 4
> [ 5108.161645] usbhid:hid-pidff: create_new_effect sent, type: 1
> [ 5108.251905] usbhid:hid-pidff: create_new_effect sent, type: 4
> [ 5108.338133] usbhid:hid-pidff: create_new_effect sent, type: 4
>
> Type 4 means FF_SINE for your device. However, fftest does test only one
> FF_SINE effect. Have you altered fftest? If not, could you post the
> output of fftest?
No i didn't, fftest plays 4 different effect types, of which only 2
are supported,
Here is output: http://paste.org.ru/index.pl?jc3999
Here is source of this fftest: http://paste.org.ru/index.pl?jjkw01

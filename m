From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 3/9] HID: hid, make parsing event driven
Date: Wed, 14 May 2008 11:34:52 +0200
Message-ID: <482AB23C.2090809@gmail.com>
References: <1210536043-19812-1-git-send-email-jirislaby@gmail.com>	 <1210536043-19812-2-git-send-email-jirislaby@gmail.com>	 <1210536043-19812-3-git-send-email-jirislaby@gmail.com> <1210548050.16390.39.camel@violet.holtmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:5601 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876AbYENJez (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 May 2008 05:34:55 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2648981fkq.5
        for <linux-input@vger.kernel.org>; Wed, 14 May 2008 02:34:53 -0700 (PDT)
In-Reply-To: <1210548050.16390.39.camel@violet.holtmann.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com, akpm@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>

Marcel Holtmann napsal(a):
> Hi Jiri,
> 
>> Next step for complete hid bus, this patch includes:
>> - call parser either from probe or from hid-core if there is no probe.
>> - add ll_driver structure and centralize some stuff there (open, close...)
>> - split and merge usb_hid_configure and hid_probe into several functions
>>   to allow hooks/fixes between them
> 
> has the Bluetooth HIDP changes been tested. You move a lot of code
> around and this might have side effects.

Not really. I was only to test non-hid path (i.e. input) of hidp changes. 
This is why I want it in -mm/-next for some time. If you have some (real) 
bluetooth HID devices, I would be glad if you could test it.

Thanks.

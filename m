From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH] input synaptics-rmi4: rmi_driver.c storage fix
Date: Wed, 5 Mar 2014 11:40:52 -0800
Message-ID: <53177DC4.5030801@synaptics.com>
References: <1393988899-30076-1-git-send-email-cheiny@synaptics.com> <alpine.LNX.2.00.1403050951090.30402@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:52086 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089AbaCETkx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Mar 2014 14:40:53 -0500
In-Reply-To: <alpine.LNX.2.00.1403050951090.30402@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>

On 03/05/2014 12:51 AM, Jiri Kosina wrote:
> On Tue, 4 Mar 2014, Christopher Heiny wrote:
>
>> Do not use kfree() on storage allocated with devm_kfree(),
>
> I believe you meant devm_kmalloc() here.

I've been trying for an hour to come up with some witty excuse for that 
brain fart, but came up with nothing but "D'oh!  Thanks!"



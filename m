From: Ike Panhc <ike.pan@canonical.com>
Subject: Re: [PATCH] ideapad: let Fn+F5 also trigger KEY_BLUETOOTH
Date: Tue, 14 Jun 2011 16:29:53 +0800
Message-ID: <4DF71C01.6080504@canonical.com>
References: <1308040109-12038-1-git-send-email-ike.pan@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:59785 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab1FNIaA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 04:30:00 -0400
In-Reply-To: <1308040109-12038-1-git-send-email-ike.pan@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, Dmitry Torohov <dmitry.torokhov@gmail.com>

On 06/14/2011 04:28 PM, Ike Panhc wrote:
> The design for ideapad Fn-F5 key is not only for wifi but for all
> radio device including wifi, bluetooth and wwan. Idealy it shall
> acts like this:
> 
>     wifi on          wifi off         wifi on         wifi off
>      bt on   ----->   bt on   ----->   bt off  ----->  bt off
> 
> This patch will switch wifi mode every key-push and switch
> bluetooth mode every two key-push.

This maybe is disputed. 

The problem is that now Fn+F5 only turns on/off wifi and leave bluetooth alone.
According to the design this hotkey shall change the status of all radio
devices, including wifi, bluetooth and wwan.

On machine with wifi and bluetooth, it will turn on/off wifi and bluetooth in
order. On machine with wifi, it will switch wifi mode on every event.

I think it is better to solve this in driver not in user space application 
because on some other platforms, the KEY_WLAN and KEY_BLUETOOTH are separate.

I do not have a clear idea how to deal with wwan interface such as it shall be
exclusive or inclusive with wifi.

Please reply for any opinion.

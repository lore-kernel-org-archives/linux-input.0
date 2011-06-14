From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] ideapad: let Fn+F5 also trigger KEY_BLUETOOTH
Date: Tue, 14 Jun 2011 10:21:59 +0100
Message-ID: <1308043321.26522.4.camel@air.hadess.net>
References: <1308040109-12038-1-git-send-email-ike.pan@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57156 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab1FNJWE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 05:22:04 -0400
In-Reply-To: <1308040109-12038-1-git-send-email-ike.pan@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Dmitry Torohov <dmitry.torokhov@gmail.com>

On Tue, 2011-06-14 at 16:28 +0800, Ike Panhc wrote:
> The design for ideapad Fn-F5 key is not only for wifi but for all
> radio device including wifi, bluetooth and wwan. Idealy it shall
> acts like this:
> 
>     wifi on          wifi off         wifi on         wifi off
>      bt on   ----->   bt on   ----->   bt off  ----->  bt off
> 
> This patch will switch wifi mode every key-push and switch
> bluetooth mode every two key-push.

If that's what you want to achieve, then the key should be KEY_RFKILL.
That's what the key is there for.


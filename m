From: Frederic Jacob <frederic.jacob.78@gmail.com>
Subject: Re: [PATCH] hid: sony: Add power supply support for PS3 remote
Date: Wed, 9 Mar 2016 21:54:12 -0500
Message-ID: <56E0E1D4.1050302@gmail.com>
References: <1457487659-3970-1-git-send-email-frederic.jacob.78@gmail.com>
 <1457542738.2648.113.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35953 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbcCJCyP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2016 21:54:15 -0500
In-Reply-To: <1457542738.2648.113.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/09/2016 11:58 AM, Bastien Nocera wrote:
> Hey Frederic,
>
> On Tue, 2016-03-08 at 20:40 -0500, Frederic Jacob wrote:
>> Add power supply support for the PS3 remote controller
> Isn't something like "add battery state reporting for PS3 remotes"
> better?
>
> Also, as I don't think it's physically possible to have the PS3 remote
> both connected and charging at the same time, maybe the comment
> in sixaxis_parse_report() should be modified to make it clear that the
> PS3 remote doesn't have that problem.
>
> Cheers
I hesitated to use a message similar as to what you suggest
but changed it to use the technical term, but I prefer yours.

As for the comment in  sixaxis_parse_report() what do you think if I add
at the end of the comment?
" The PS3 remote cannot be charged so it is always set to discharging
    and unplugged."

Thanks




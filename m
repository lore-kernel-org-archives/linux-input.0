From: Clinton Sprain <clintonsprain@gmail.com>
Subject: Re: [PATCH v4 0/3] input: appletouch: fixes for jagged/uneven cursor
 movement
Date: Sun, 23 Mar 2014 08:34:47 -0500
Message-ID: <532EE2F7.8020107@gmail.com>
References: <52D9DE7A.7040509@gmail.com> <5320EA03.2040206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:32837 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbaCWNew (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Mar 2014 09:34:52 -0400
Received: by mail-ob0-f178.google.com with SMTP id wp18so4560693obc.23
        for <linux-input@vger.kernel.org>; Sun, 23 Mar 2014 06:34:51 -0700 (PDT)
In-Reply-To: <5320EA03.2040206@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

Ping?

On 03/12/2014 06:13 PM, Clinton Sprain wrote:
> input: appletouch: fixes for jagged/uneven cursor movement
> 
> The appletouch driver can make some touchpads feel insensitive, with movement that tends to jerk in steps. This is particularly evident when moving diagonally. There is also undesirable movement when additional fingers enter or leave the touchpad.
> 
> These patches address these issues by dialing back the fuzz setting, by implementing sensor data smoothing and by discarding movements that directly coincide with a change in the number of fingers detected on the touchpad.
> 
> Changes since v3:
> 
> 1: No change
> 2: Fix loop counter in atp_calculate_abs
> 3: No change
> 
> Clinton Sprain (3):
>   input: appletouch: dial back fuzz setting
>   input: appletouch: implement sensor data smoothing
>   input: appletouch: fix jumps when additional fingers are detected
> 
>  drivers/input/mouse/appletouch.c |  114 +++++++++++++++++++++++++++-----------
>  1 file changed, 83 insertions(+), 31 deletions(-)
> 

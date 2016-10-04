From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: [PATCH v2 0/4] Input: xpad - improve support for new Xbox One S
 pad
Date: Tue, 4 Oct 2016 12:29:41 -0700
Message-ID: <090e30e9-7cb8-45d5-6645-2da4b0bca56f@gmail.com>
References: <1471320616-13110-1-git-send-email-aicommander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33250 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754181AbcJDT3n (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Oct 2016 15:29:43 -0400
Received: by mail-pf0-f193.google.com with SMTP id i85so4055564pfa.0
        for <linux-input@vger.kernel.org>; Tue, 04 Oct 2016 12:29:43 -0700 (PDT)
In-Reply-To: <1471320616-13110-1-git-send-email-aicommander@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org

On 08/15/2016 09:10 PM, Cameron Gutman wrote:
> This pad generally works well enough on the current xpad, but there are
> a few usability issues that I'm fixing with this series.
> 
> The notable changes:
> 
> The protocol seems to have changed a bit with the new pad. For one, it
> needs an ack for the mode report now, otherwise it just retransmits it
> forever. This makes the mode button look stuck down to userspace after
> the first time it is pressed.
> 
> It also seems to overflow some internal buffer, hang, then eventually
> reset the pad if there is user input without the driver listening.
> This causes a spurious disconnection that may cause userspace programs
> to behave unexpectedly.
> 
> Changes in v2:
> Fixed multi-line comment style in patch 2 and 3 to be consistent with
> the existing code. I've also added a simple patch to address rumble
> issues on all Xbox One pads, including Xbox One S.
> 
> Cameron Gutman (4):
>   Input: xpad - add device ID for Xbox One S pad
>   Input: xpad - fix One S pad disconnecting when not opened
>   Input: xpad - fix stuck mode button on Xbox One S pad
>   Input: xpad - fix Xbox One rumble stopping after 2.5 secs
> 
>  drivers/input/joystick/xpad.c | 60 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 54 insertions(+), 6 deletions(-)
> 

Hi Dmitry,

I'm just following up on these patches. Do you want any changes or are they
fine as is?

Pavel has already applied the patches to his out-of-tree xpad driver [0].

[0] https://github.com/paroj/xpad

Thanks,
Cameron

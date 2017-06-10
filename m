From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: Dualshocks analog buttons
Date: Fri, 9 Jun 2017 20:59:31 -0700
Message-ID: <CANndSKm_t3U-x74S=Fx5dB4xZoxpcJVHicjDcebM3SQN7LuKEg@mail.gmail.com>
References: <wq9cWLrPuEa5SmtTckAklnC4hVQLc40OQlzgpMupfdIII2XRLb4i5LdYWScGS_4hCmpMx131156V2gk3D4bVyQ==@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36059 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdFJD7c (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Jun 2017 23:59:32 -0400
Received: by mail-oi0-f49.google.com with SMTP id k145so28673224oih.3
        for <linux-input@vger.kernel.org>; Fri, 09 Jun 2017 20:59:32 -0700 (PDT)
In-Reply-To: <wq9cWLrPuEa5SmtTckAklnC4hVQLc40OQlzgpMupfdIII2XRLb4i5LdYWScGS_4hCmpMx131156V2gk3D4bVyQ==@protonmail.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mirh <mirh@protonmail.ch>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

+dmitry,+linux-input

Hi Mirh,

Thanks for reaching out. Unfortunately during the hid-sony driver
cleanup we had to remove support for analog buttons for DualShock 3.
We don't mind supporting them in some way, but the Linux kernel has no
official way for reporting them. The old driver was actually quite
incorrect and used 'illegal' axes, which applications couldn't rely on
for these buttons e.g. some even used multitouch axes which are meant
for touch. For various applications this actually caused issues except
if they hardcoded the incorrect axis values.

On a sidenote someone from the community recently submitted a ps1/ps2
controller driver, which had similar issues and only digital buttons
could be supported to the Linux input framework.

The only way I see to support 'analog buttons' is to somehow extend
the Linux input framework, but this is not easy. Additional axes at
least can't be added due to technical limitations of the ioctls.

Thanks,
Roderick

On Fri, Jun 9, 2017 at 5:15 PM, Mirh <mirh@protonmail.ch> wrote:
> I'm not really used to mailing list discussions
> Would it be too much of a problem for you to join on bugzilla?
> https://bugzilla.kernel.org/show_bug.cgi?id=195643
>
> Regards.
>
>
>



-- 
Roderick Colenbrander
Senior Manager of Software Engineering
Gaikai, a Sony Interactive Entertainment Company
roderick@gaikai.com

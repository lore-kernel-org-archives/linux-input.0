From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: Input: synaptics - Lenovo X1 Carbon 5 devices should use SMBUS/RMI
Date: Fri, 6 Oct 2017 14:20:06 +0200
Message-ID: <CAEk1YH7jmi6xnEMxxh3pcKRyK1=eb_JkpDoW8eY_ZKBA5paWhQ@mail.gmail.com>
References: <20171005174315.2863-1-yiannis.marangos@gmail.com>
 <CAEk1YH4LpSFRJ_TCdq1xxm_auci7+a1TD0T=vdKDiajyQbYpLg@mail.gmail.com> <20171005183632.floyyyevey33vjbs@dystopia.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:46740 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdJFMUH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Oct 2017 08:20:07 -0400
Received: by mail-wm0-f44.google.com with SMTP id m72so7300116wmc.1
        for <linux-input@vger.kernel.org>; Fri, 06 Oct 2017 05:20:07 -0700 (PDT)
In-Reply-To: <20171005183632.floyyyevey33vjbs@dystopia.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yiannis Marangos <yiannis.marangos@gmail.com>
Cc: linux-input@vger.kernel.org

On 5 October 2017 at 20:36, Yiannis Marangos <yiannis.marangos@gmail.com> wrote:
> You will need the other part of the patch also.

sorry,
what other part?

the `if (smbus_version != 2 && smbus_version != 3) {` one?
I added that too, didn't change anything.

just FYI, these are the patches I have over 4.13.5 now:
https://github.com/gdamjan/linux/commits/linux-4.13.y-carbon5


-- 
damjan

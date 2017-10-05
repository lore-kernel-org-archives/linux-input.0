From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: Input: synaptics - Lenovo X1 Carbon 5 devices should use SMBUS/RMI
Date: Thu, 5 Oct 2017 20:28:17 +0200
Message-ID: <CAEk1YH4LpSFRJ_TCdq1xxm_auci7+a1TD0T=vdKDiajyQbYpLg@mail.gmail.com>
References: <20171005174315.2863-1-yiannis.marangos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53632 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbdJES2T (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 14:28:19 -0400
Received: by mail-wm0-f41.google.com with SMTP id q132so3865847wmd.2
        for <linux-input@vger.kernel.org>; Thu, 05 Oct 2017 11:28:18 -0700 (PDT)
In-Reply-To: <20171005174315.2863-1-yiannis.marangos@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yiannis Marangos <yiannis.marangos@gmail.com>
Cc: linux-input@vger.kernel.org

> Part of these patches were found at:
> https://gist.github.com/ursm/6d1007f44a1d6beeb670b3c3a6a78ea4
>
> They were tested in 4.12.8 for almost a month, in 4.13.2 for almost a month
> and in 4.14-rc3. No problems were found.


I've been carying the
+       "LEN0072", /* X1 Carbon 5 */
change for some time in my own builds

but that one makes the trackpoint device appear late, typically 400
seconds after boot, sometimes it even doesn't appear at all until I
remove 'psmouse' and load it again


-- 
damjan

From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: Input: synaptics - Lenovo X1 Carbon 5 devices should use SMBUS/RMI
Date: Wed, 11 Oct 2017 16:24:19 +0200
Message-ID: <CAEk1YH5wyh+_wwdhdVz4mJosNJ_fPAhKMdk=wA=fxrN813Tnpg@mail.gmail.com>
References: <20171005174315.2863-1-yiannis.marangos@gmail.com> <CAEk1YH4LpSFRJ_TCdq1xxm_auci7+a1TD0T=vdKDiajyQbYpLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:49131 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbdJKOYV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Oct 2017 10:24:21 -0400
Received: by mail-wm0-f41.google.com with SMTP id i124so5202140wmf.3
        for <linux-input@vger.kernel.org>; Wed, 11 Oct 2017 07:24:20 -0700 (PDT)
In-Reply-To: <CAEk1YH4LpSFRJ_TCdq1xxm_auci7+a1TD0T=vdKDiajyQbYpLg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yiannis Marangos <yiannis.marangos@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

>> Part of these patches were found at:
>> https://gist.github.com/ursm/6d1007f44a1d6beeb670b3c3a6a78ea4
>>
>> They were tested in 4.12.8 for almost a month, in 4.13.2 for almost a month
>> and in 4.14-rc3. No problems were found.
>
>
> I've been carying the
> +       "LEN0072", /* X1 Carbon 5 */
> change for some time in my own builds
>
> but that one makes the trackpoint device appear late, typically 400
> seconds after boot, sometimes it even doesn't appear at all until I
> remove 'psmouse' and load it again

I've found out now (2 out of 2 reboots) - that if I load the rmi_smbus
module before psmouse is loaded then the TrackPoint works fine as soon
as the psmouse module is loaded.

I load rmi_smbus statically from /etc/modules-load.d/mouse.conf.
psmouse is loaded automatically

Maybe a more global issue?


-- 
damjan

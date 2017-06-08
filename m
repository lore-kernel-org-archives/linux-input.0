From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] Input: psmouse - reset device during probe
Date: Thu, 8 Jun 2017 14:18:36 -0600
Message-ID: <CAD8Lp44uQJTro4xqmmSBfhmryZje_d90LNKExNQABak+Kp+FzA@mail.gmail.com>
References: <20170605202752.8061-1-drake@endlessm.com> <5939a665.4faa1c0a.ac8e9.69e4@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35775 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbdFHUSm (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Jun 2017 16:18:42 -0400
Received: by mail-oi0-f52.google.com with SMTP id p7so23139544oif.2
        for <linux-input@vger.kernel.org>; Thu, 08 Jun 2017 13:18:42 -0700 (PDT)
In-Reply-To: <5939a665.4faa1c0a.ac8e9.69e4@mx.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thu, Jun 8, 2017 at 1:32 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
> This patch will slow down enumeration and initalization of *all* PS/2 mou=
ses.

I know it's not ideal. but do you think anyone will be able to notice
the difference in initialization time?

Daniel

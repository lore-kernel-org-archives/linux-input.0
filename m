From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: Re: Input: synaptics - Lenovo X1 Carbon 5 devices should use
 SMBUS/RMI
Date: Fri, 6 Oct 2017 16:51:26 +0300
Message-ID: <20171006135126.crit5gg6nvrabgwr@dystopia.localdomain>
References: <20171005174315.2863-1-yiannis.marangos@gmail.com>
 <CAEk1YH4LpSFRJ_TCdq1xxm_auci7+a1TD0T=vdKDiajyQbYpLg@mail.gmail.com>
 <20171005183632.floyyyevey33vjbs@dystopia.localdomain>
 <CAEk1YH7jmi6xnEMxxh3pcKRyK1=eb_JkpDoW8eY_ZKBA5paWhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:48058 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdJFNu7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Oct 2017 09:50:59 -0400
Received: by mail-wr0-f177.google.com with SMTP id y44so7760401wrd.4
        for <linux-input@vger.kernel.org>; Fri, 06 Oct 2017 06:50:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAEk1YH7jmi6xnEMxxh3pcKRyK1=eb_JkpDoW8eY_ZKBA5paWhQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Damjan Georgievski <gdamjan@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Oct 06, 2017 at 12:20:06PM +0000, Damjan Georgievski wrote:
> sorry,
> what other part?
> 
> the `if (smbus_version != 2 && smbus_version != 3) {` one?
> I added that too, didn't change anything.

My bad. My X1 has LEN0073 and with this I don't have any problems. I will
resubmit my patches but only for LEN0073.

Thanks,
Yiannis.

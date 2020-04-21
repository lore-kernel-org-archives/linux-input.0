Return-Path: <SRS0=ZXj0=6F=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054ECC54FCC
	for <linux-input@archiver.kernel.org>; Tue, 21 Apr 2020 19:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B152074B
	for <linux-input@archiver.kernel.org>; Tue, 21 Apr 2020 19:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="mpSnJHUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgDUTJJ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:09:09 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:38176 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgDUTJJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Apr 2020 15:09:09 -0400
X-Greylist: delayed 940 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Apr 2020 15:09:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1b/gE5Wx8BbM9MjbWUVMc+EWAcqscOsveJTWROOiXcU=; b=mpSnJHUlfSqJPnjT8h6x4C7fE
        We3wKZiZLGFQ1xcnsq/C0IBE4WGisZhe88IY3giPRkkftch2C1+XmXc5nUk38XIlw3CMADOOxSbKP
        EN+svioBW8pNgNMM/+82Lu5NiU7rTAir/yfofa0Nk9GLhEd1BY5Z3XpxX2QE/wEwAW+84=;
Received: from cpe-107-184-2-226.socal.res.rr.com ([107.184.2.226] helo=[192.168.2.117])
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <bshanks@codeweavers.com>)
        id 1jQy1K-0003fV-A3; Tue, 21 Apr 2020 13:53:23 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: BUG: ff_effects lost after a fork
From:   Brendan Shanks <bshanks@codeweavers.com>
In-Reply-To: <20191127101008.GA327265@nuka.localdomain>
Date:   Tue, 21 Apr 2020 11:53:19 -0700
Cc:     dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        linux-kernel@vger.kernel.org,
        Mathieu Maret <mathieu.maret@gmail.com>,
        mmaret@pixium-vision.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5404D7D5-47EF-4399-B0D9-B3C68A3D5895@codeweavers.com>
References: <20191127101008.GA327265@nuka.localdomain>
To:     linux-input@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


> On Nov 27, 2019, at 2:10 AM, Mathieu Maret <mathieu.maret@gmail.com> =
wrote:
>=20
> Hi,
>=20
> I'm using evdev for vibrator interface.
> I can register ff_effect and play them.
> But, if I do any kind of fork, all the effects are flush and cannot be
> used.
>=20
> You can find, below, an example of such a program.
> =46rom some trace have put in the kernel, it's seems that at the end =
of
> the system() call, evdev_flush get called.
>=20
> evdev_flush() will call flush_effects() that will remove all the
> registered effects.
>=20
> I've only one device with vibrator and it's a imx6 4.1.15 kernel. But
> code looks the same that in linus master that why I'm posting it here. =
I
> hope that it will not waste people time
>=20

Hi everyone,

I=E2=80=99m also hitting this bug with games that use force-feedback =
steering wheels under Wine/Proton. It typically shows up as EVIOCSFF =
ioctls failing with EINVAL, since all the effects were unexpectedly =
flushed.

The problem is that input_ff_flush() is called whenever a file =
descriptor is closed, but there can be multiple descriptors open to the =
same file description (through fork(), dup(), etc). input_ff_flush() =
removes all effects added by that file description, which the users of =
the other descriptors certainly don't expect.

As for the fix, maybe fd_ops->flush() shouldn=E2=80=99t be implemented =
at all?
In the current design, effects =E2=80=9Cbelong=E2=80=9D to a file =
description (a struct file *), not a descriptor. This seems sensible to =
me: a process could open a device, upload an effect, then fork(), and it =
makes sense that the child would have full control of the effects =
created by the parent. It seems to me like nothing should be done when a =
descriptor is closed, and input_ff_flush() should be called only when =
the whole struct file is released.

I=E2=80=99ve attached a modified copy of Mathieu=E2=80=99s code, which =
reproduces the problem for me with a Logitech G25 steering wheel.

Brendan Shanks
CodeWeavers




#include <errno.h>
#include <fcntl.h>
#include <linux/input.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>

#define DEV_PATH "/dev/input/event10"

int main(int argc, char *argv[])
{
    int fd =3D open(DEV_PATH, O_RDWR);
    if (fd < 0) {
        printf("Cannot open " DEV_PATH);
    }
    // Register an effect
    struct ff_effect effects;
    memset(&effects, 0, sizeof(effects));
    effects.type                      =3D FF_CONSTANT;
    effects.id                        =3D -1;
    effects.replay.length             =3D 1000;
    effects.replay.delay              =3D 0;
    if (ioctl(fd, EVIOCSFF, &effects) < 0) {
        printf("Cannot upload effect %s\n", strerror(errno));
        return -1;
    }

    int fd2 =3D dup(fd);
    close(fd2);

    // ioctl fails with EINVAL
    if (ioctl(fd, EVIOCSFF, &effects) < 0) {
        printf("Cannot upload effect %s\n", strerror(errno));
        return -1;
    }

    close(fd);
    return 0;
}=

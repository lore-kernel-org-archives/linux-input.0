From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 14/22 v4] Input: atmel_mxt_ts - don't re-read matrix after
 applying pdata
Date: Mon, 18 Jun 2012 23:28:01 +0800
Message-ID: <CAGS+omB9kixY29f7awPDaRc-t9t0LJ+Lwz=gBzUoXro5f9jYXg@mail.gmail.com>
References: <1339992522-22073-1-git-send-email-djkurtz@chromium.org>
 <1339992522-22073-15-git-send-email-djkurtz@chromium.org> <4FDF4345.40508@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FDF4345.40508@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 18, 2012 at 11:03 PM, Nick Dyer <nick.dyer@itdev.co.uk> wro=
te:
>
> Daniel Kurtz wrote:
> > The matrix x/y size in the Info ID Block represents the number of x=
/y
> > trace lines on the device. =A0There is no need to re-read them afte=
r
> > applying pdata config, since pdata only configures the object table
> > etnries. =A0The matrix size read from the ID can only be updated by=
 a
> > firmware update.
>
> This isn't correct. For example, mXT224 can be configured as 16x14, 1=
7x13,
> 18x12, etc. This only takes effect when the chip is reset, which is w=
hy it
> is necessary to re-read them after applying the config.

Ah, so is that what T46.1 (Mode) does?  I hadn't played with that yet.
Ok, I'll move this patch into the next series which cleans up all of
the configuration stuff.

-Dan

>
>
> cheers
>
> --
> Nick Dyer
> Software Engineer, ITDev Ltd
> Hardware and Software Development Consultancy
> Website: http://www.itdev.co.uk

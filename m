From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 06/20] Input: atmel_mxt_ts - allow writing to object sysfs entry
Date: Mon, 19 Mar 2012 16:26:21 +0800
Message-ID: <CAGS+omBrdvwM5W31TShbBtqzdSnpQhvBA4fb6-fsy5ovYOXmNQ@mail.gmail.com>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
 <1331640263-18935-7-git-send-email-djkurtz@chromium.org> <20120319080402.GA15965@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120319080402.GA15965@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 19, 2012 at 4:04 PM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
>
> Hi Daniel,
>
> > Userspace can write a 24-bit value (encoded as a 6 character hex st=
ring)
> > to the 'object' sysfs entry to modify a single byte of the object t=
able.
> > The hex string encodes a 3 bytes, in the following format:
> > =A0TTFFVV
> >
> > Where:
> > =A0TT =3D object type
> > =A0FF =3D object offset
> > =A0VV =3D byte value
> >
> > The object table is modified in device ram, which means the change =
is
> > volatile, and will be overwritten on the next device reset. =A0To m=
ake
> > changes permanent, the new settings should be persisted in the devi=
ce's
> > Non-Voltatile Memory using the updatenv sysfs entry.
> >
> > Also, since the device driver initializes itself by reading some va=
lues
> > from the object table, the entire driver may need to be unloaded an=
d
> > reloaded after writing the values for the driver to stay in sync.
> > =A0Whether
> > this is required depends on exactly which values were updated.
> >
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > ---
>
> Perhaps you could give an example of why this is needed?
>
> Thanks,
> Henrik

The idea is to allow a a device to be calibrated via userspace.  The
atmel devices have many registers for tuning properties of their
firmware.
This would be used, for example, to program an initial calibration on
a factory floor, or, to tune a device at runtime.  Currently, the only
way devices are configured and calibrated is for a system integrator
to embed the entire calibration in the kernel via a binary blob in
platform_data.

Thanks,
-Daniel

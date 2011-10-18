From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 2/5] input/cma3000_d0x: Check silicon version
Date: Tue, 18 Oct 2011 14:07:11 +0200
Message-ID: <CAPybu_0hXDjKnmQF6OtoeC=mmqfNRK6pVSf4ZA+2Jn9BHFWV2Q@mail.gmail.com>
References: <1318926486-10330-1-git-send-email-ricardo.ribalda@gmail.com>
 <1318926486-10330-3-git-send-email-ricardo.ribalda@gmail.com> <4E9D3A0D.9070108@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E9D3A0D.9070108@cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Jonathan

>> + =A0 =A0 if (rev !=3D CMA3000_REV) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("CMA3000 Accelerometer: Unknown Rev=
ision %x\n", rev);
> warning perhaps rather than error?

IMHO it should be an error. If the revision is different, either you
are in front of a unknown chip or the chip is going to behave
differently and lead into an unstable system. Better be safe than
sorry.

> Patch could do with a statement of why anyone would care about this.
>> =A0 =A0 =A0 error =3D request_threaded_irq(irq, NULL, cma3000_thread=
_irq,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0pdata->irqflags | IRQF_ONESHOT,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0"cma3000_d0x", data);

You are right... not so useful information :). Maybe as part of a
sysfs file, but definately not as as a printk

>
>



--=20
Ricardo Ribalda

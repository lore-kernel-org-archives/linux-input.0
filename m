From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH][input] add Honeywell hmc5843 3-Axis Magnetometer
	(digital compass)  driver.
Date: Tue, 15 Dec 2009 16:23:03 +0200
Message-ID: <20091215142303.GC24799@bicker>
References: <200912102250.12853.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48790 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760360AbZLOOXA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2009 09:23:00 -0500
Content-Disposition: inline
In-Reply-To: <200912102250.12853.sfking@fdwdc.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steven King <sfking@fdwdc.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 10, 2009 at 10:50:12PM -0800, Steven King wrote:
> +static void hmc5843_poll(struct input_polled_dev *ipdev)
> +{
> +	struct hmc5843 *hmc5843 =3D ipdev->private;
> +	int x, y, z;
> +

  CC      drivers/input/misc/hmc5843.o
drivers/input/misc/hmc5843.c: In function =E2=80=98hmc5843_poll=E2=80=99=
:
drivers/input/misc/hmc5843.c:312: warning: =E2=80=98x=E2=80=99 may be u=
sed uninitialized in this function
drivers/input/misc/hmc5843.c:312: warning: =E2=80=98y=E2=80=99 may be u=
sed uninitialized in this function
drivers/input/misc/hmc5843.c:312: warning: =E2=80=98z=E2=80=99 may be u=
sed uninitialized in this function


> +	mutex_lock(&hmc5843->lock);
> +	if (!hmc5843_read_xyz(hmc5843, &x, &y, &z)) {
> +		input_report_abs(ipdev->input, ABS_X, x);
> +		input_report_abs(ipdev->input, ABS_Y, y);
> +		input_report_abs(ipdev->input, ABS_Z, z);
> +		input_sync(ipdev->input);
> +	}
> +	mutex_unlock(&hmc5843->lock);
> +}
> +

Some versions of gcc may not complain, but could you suppress
the warnings anyway?

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

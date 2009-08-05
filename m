From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] tsc2007: reduced number of I2C transfers
Date: Tue, 4 Aug 2009 22:04:43 -0700
Message-ID: <20090805050445.1C034526EA5@mailhub.coreip.homeip.net>
References: <4A69DDED.50402@mocean-labs.com> <20090724180022.GA6477@dtor-d630.eng.vmware.com> <4A6A0D77.6000600@mocean-labs.com> <20090726080212.GA24365@dtor-d630.eng.vmware.com> <4A7825B3.1010806@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933471AbZHEFEv@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A7825B3.1010806@mocean-labs.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard =?iso-8859-1?Q?R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, kwangwoo.lee@gmail.com, Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 04, 2009 at 02:12:35PM +0200, Richard R=F6jfors wrote:
> Dmitry Torokhov wrote:
>>
>> I modified the patch a bit before applying. In fact there were a few
>> changes to all the patces so it would be nice if you could take a lo=
ok
>> at the 'next' branch of my tree:
>>
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
>>
>> Also, I di dnot quite like the logic of the patch making
>> get_pendown_state callback optional; could you please try the patch
>> below and let me know of it works for you?
>
> I like your changes, there is just a small miss while checking the =20
> platform data. You forgot to remove the check for get_pen_down_state =
in =20
> the probe function, see the patch below (to be applied on top of your=
s):
>
> I also would like a check if the power down failed or not during prob=
e.
>
> --Richard
>
> Input: tsc2007 - Check if I2C communication works during probe
>
> Check the result when sending the power down command to the controlle=
r.
>
> Signed-off-by: Richard R=F6jfors <richard.rojfors.ext@mocean-labs.com=
>
> ---
> Index: linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c	(revision 10=
71)
> +++ linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c	(revision 10=
73)
> @@ -269,7 +269,7 @@
>  	struct input_dev *input_dev;
>  	int err;
>
> -	if (!pdata || !pdata->get_pendown_state) {
> +	if (!pdata) {
>  		dev_err(&client->dev, "platform data is required!\n");
>  		return -EINVAL;
>  	}


Ah, yes, thanks.

> @@ -326,10 +326,14 @@
>  	i2c_set_clientdata(client, ts);
>
>  	/* Prepare for touch readings - power down ADC and enable PENIRQ */
> -	tsc2007_xfer(ts, PWRDOWN);
> +	err =3D tsc2007_xfer(ts, PWRDOWN);
> +	if (err < 0)
> +		goto err_unreg_dev;
>
>  	return 0;
>
> + err_unreg_dev:
> +	input_unregister_device(ts->input);

This will case double free.. I will adjust locally.

>   err_free_irq:
>  	tsc2007_free_irq(ts);
>  	if (pdata->exit_platform_hw)

--=20
Dmitry

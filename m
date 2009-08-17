From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: Synaptics touchscreen for HTC Dream: check that smbus is
 available
Date: Mon, 17 Aug 2009 16:47:59 -0700
Message-ID: <20090817164759.43c39f2d.akpm@linux-foundation.org>
References: <20090714100634.GA4054@elf.ucw.cz>
	<5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com>
	<20090715133627.GA2538@elf.ucw.cz>
	<5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com>
	<20090721102153.GE4133@elf.ucw.cz>
	<5d5443650907210334k3f562cebsc665511a161c8639@mail.gmail.com>
	<20090808134049.GA13083@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090808134049.GA13083-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, 8 Aug 2009 15:40:50 +0200
Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:

> > >> Because this driver is using smbus i2c apis, it will be good to add
> > >> that check too.
> > >
> > > So I should do something like
> > >
> > > if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> > > __ __ __ __...
> > >
> > > in addition?
> > 
> > Yes.
> 
> Ok, here it is.
> 
> --- 
> 
> Check that SMBUS APIs are available in touchscreen driver.

Why?

> Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> 
> diff --git a/drivers/staging/dream/synaptics_i2c_rmi.c b/drivers/staging/dream/synaptics_i2c_rmi.c
> index dc1e3c7..6e23276 100644
> --- a/drivers/staging/dream/synaptics_i2c_rmi.c
> +++ b/drivers/staging/dream/synaptics_i2c_rmi.c
> @@ -373,6 +373,12 @@ static int __devinit synaptics_ts_probe(
>  		goto err_check_functionality_failed;
>  	}
>  
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
> +		pr_err("synaptics_ts_probe: need I2C_FUNC_SMBUS_WORD_DATA\n");
> +		ret = -ENODEV;
> +		goto err_check_functionality_failed;
> +	}
> +
>  	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
>  	if (ts == NULL) {
>  		ret = -ENOMEM;

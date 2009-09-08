From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2]add analog devices AD714X
	captouch input driver
Date: Tue, 8 Sep 2009 11:49:28 -0700
Message-ID: <200909081149.28942.david-b@pacbell.net>
References: <1252401564-5291-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1252401564-5291-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tuesday 08 September 2009, Barry Song wrote:
> +static int __init ad714x_init(void)
> +{
> +#if (defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE)) && \
> +=A0=A0=A0=A0=A0=A0=A0!(defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE))
> +=A0=A0=A0=A0=A0=A0=A0return spi_register_driver(&ad714x_spi_driver);
> +#endif
> +
> +#if (defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)) =A0&& \
> +=A0=A0=A0=A0=A0=A0=A0!(defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE))
> +=A0=A0=A0=A0=A0=A0=A0return i2c_add_driver(&ad714x_i2c_driver);
> +#endif
> +
> +#if (defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE)) && \
> +=A0=A0=A0=A0=A0=A0=A0(defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE))
> +=A0=A0=A0=A0=A0=A0=A0int ret =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0ret =3D spi_register_driver(&ad714x_spi_driver);
> +=A0=A0=A0=A0=A0=A0=A0if (ret)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto err;
> +=A0=A0=A0=A0=A0=A0=A0ret =3D i2c_add_driver(&ad714x_i2c_driver);
> +=A0=A0=A0=A0=A0=A0=A0if (ret)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spi_unregister_driver(&ad71=
4x_spi_driver);
> +err:
> +=A0=A0=A0=A0=A0=A0=A0return ret;
> +#endif
> +}

Ugly and error prone.
You should have only one block of code not four ...

Absolutely the cleanest solution adds inlined NOP stubs
for I2C and SPI driver register/unregister calls, and
gets rid of all that #ifdeffery; there are other solutions.

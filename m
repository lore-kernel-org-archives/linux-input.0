From: "Song, Barry" <Barry.Song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3] add analog devices
	AD714Xcaptouchinput driver
Date: Fri, 9 Oct 2009 18:34:07 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04D700BF@chinexm1.ad.analog.com>
References: <1252652006-5270-1-git-send-email-21cnbao@gmail.com>
	<8A42379416420646B9BFAC9682273B6D0DC3BD95@limkexm3.ad.analog.com>
	<8bd0f97a0910090156g2a8fba58r4085422f3a79c892@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <8bd0f97a0910090156g2a8fba58r4085422f3a79c892-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

 =


>-----Original Message-----
>From: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org =

>[mailto:uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org] On =

>Behalf Of Mike Frysinger
>Sent: Friday, October 09, 2009 4:56 PM
>To: Hennerich, Michael
>Cc: David Brownell; uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org; =

>dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: Re: [Uclinux-dist-devel] [PATCH v3] add analog =

>devices AD714Xcaptouchinput driver
>
>On Fri, Sep 11, 2009 at 09:19, Hennerich, Michael wrote:
>> On Friday 11 September 2009, Song, Barry wrote:
>> +static int __init ad714x_init(void)
>> +{
>> +
>> + =A0 =A0 =A0 int ret =3D 0;
>> + =A0 =A0 =A0 ret =3D ad714x_spi_register_driver(&ad714x_spi_driver);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 =A0 ret =3D ad714x_i2c_add_driver(&ad714x_i2c_driver);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x_spi_unregister_driver(&ad714x_spi_d=
river);
>> +err:
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static void __exit ad714x_exit(void)
>> +{
>> + =A0 =A0 =A0 ad714x_spi_unregister_driver(&ad714x_spi_driver);
>> + =A0 =A0 =A0 ad714x_i2c_del_driver(&ad714x_i2c_driver);
>> +}
>>
>> This doesn't make much sense!
>> Assuming we have two AD714x in a system. One connected by =

>SPI the other
>> by I2C.
>> Why would I remove the SPI one in case the other I2C fails, =

>or not even
>> try the SPI one if the I2C fails?
>
>is this a realistic problem ?  we arent talking about failure to probe
>the device, we're talking about failure to register the driver as
>available.  i.e. the only way the module_init step should fail is if
>i2c_add_driver() or spi_register_driver() fails.  and if either of
>those fail, it's most likely a pretty bad situation.

I agree with this. It is clear the failure of spi_register_driver or i2c_ad=
d_driver means a kernel issue not a device probe issue. That maybe means no=
 memory or other serious problems.
But anyway, I check in some codes to support the capacity that the other bu=
s can still continue to register even after the first one fails, maybe the =
new codes are ugly.
static int spi_sta =3D -1, i2c_sta =3D -1;

static __init int ad714x_init(void)
{
#if defined(CONFIG_AD714X_SCAN_SPI)
        spi_sta =3D spi_register_driver(&ad714x_spi_driver);
#endif

#if defined(CONFIG_AD714X_SCAN_I2C)
        i2c_sta =3D i2c_add_driver(&ad714x_i2c_driver);
#endif

        /* If anyone of spi and i2c init successfully, we permit it to work=
 */
        if ((spi_sta && i2c_sta) =3D=3D 0)
                return 0;
        else =

                return -ENODEV;
}

static __init void ad714x_exit(void)
{
#if defined(CONFIG_AD714X_SCAN_SPI)
        if (!spi_sta)
                spi_unregister_driver(&ad714x_spi_driver);
#endif

#if defined(CONFIG_AD714X_SCAN_I2C)
        if (!i2c_sta)
                i2c_del_driver(&ad714x_i2c_driver);
#endif
}

>
>failure to probe/detect/talk to the device are a different issue and a
>problem with one interface will not affect the other.
>
>> Who says that a driver can't have two module_init()?
>
>Mr. C Code says it wont work.  if ad714x is built as a module and both
>I2C and SPI support are enabled, we get:
>drivers/input/misc/ad714x.c:1621: error: redefinition of '__inittest'
>drivers/input/misc/ad714x.c:1492: error: previous definition of
>'__inittest' was here
>
>these lines correspond to the module_init() macro
>
>linux/init.h says:
>/* Each module must use one module_init(). */
>#define module_init(initfn)                 \
>    static inline initcall_t __inittest(void)       \
>    { return initfn; }                  \
>    int init_module(void) __attribute__((alias(#initfn)));
>
>and indeed, the error makes sense -- you cant have multiple functions
>named the same thing (in this case, we'd have two __inittest() and two
>init_module())
>-mike
>_______________________________________________
>Uclinux-dist-devel mailing list
>Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
>https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>

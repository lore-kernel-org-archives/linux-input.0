From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] add ad714x
	platform_datadefinition
Date: Tue, 1 Sep 2009 22:14:27 -0700
Message-ID: <200909012214.27637.david-b@pacbell.net>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com>
	<200909011857.37755.david-b@pacbell.net>
	<0F1B54C89D5F954D8535DB252AF412FA04A96A41@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA04A96A41-SGdA1W8gREmuVPpjEGsWsTcYPEmu4y7e@public.gmane.org>
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
To: "Song, Barry" <Barry.Song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tuesday 01 September 2009, Song, Barry wrote:
> >Doesn't belong under SPI since this is also used by the
> >I2C version of the chip. =A0Likely include/linux/input/*h
> >is best.
> =

> I really wanted to place it to include/linux/input, but the
> include/linux/input doesn't exist and current input header files are
> placed in the parent dir "include/linux".
> =


$ ls include/linux/input
matrix_keypad.h
$ =

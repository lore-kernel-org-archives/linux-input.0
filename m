From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH] Input: atmel_mxt_ts: Add of node type to the i2c table
Date: Thu, 11 Sep 2014 11:54:25 +0200
Message-ID: <54117151.3030601@collabora.co.uk>
References: <1410249158-18192-1-git-send-email-sjoerd.simons@collabora.co.uk>	 <540ED495.20609@collabora.co.uk> <20140910092832.GM30307@lee--X1> <1410422429.2857.16.camel@collabora.co.uk> <54115F6E.3010007@collabora.co.uk> <5411693A.3050300@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5411693A.3050300@itdev.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, "Bowens, Alan" <Alan.Bowens@atmel.com>
List-Id: linux-input@vger.kernel.org

Hello Nick,

On 09/11/2014 11:19 AM, Nick Dyer wrote:
> 
> Thanks for the clear explanation.
> 
> The i2c aliases are a bit confusing. The original device the driver was
> written for was called qt602240, which was renamed by Atmel to mXT224 when
> the chip series was called "maXTouch". The driver now actually supports
> many other chips which aren't listed (more than 20 devices that I've
> personally tested). I could add them all, but it would be an extremely long
> list. It may be preferable to use the generic name maXTouch.
> 
> So I think the sensible thing to do here would be to add "maxtouch" to the
> i2c list to fix the module autoload issue.
> 

While this will actually fix the module auto-load issue on the atmel driver,
I'm concerned that the I2C core is not reporting the correct module
'of:N*T*Catmel,maxtouch*' alias when probing using DT.

Since as Lee said on his cover letter for the mentioned series [0], an I2C ID
table shouldn't be mandatory for drivers that only support DT based platforms
(e.g: a driver that depends on OF) but in that case I2C module auto-loading
would not work AFAICT.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/6/20/199

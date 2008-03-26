From: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] Input/Joystick Driver: add support AD7142
	joystick driver
Date: Thu, 27 Mar 2008 00:15:07 +0800
Message-ID: <386072610803260915j7e4ca889ud193457367c712d3@mail.gmail.com>
References: <1206579622-21915-1-git-send-email-cooloney@kernel.org>
	<8bd0f97a0803260736v58c11f8g8a5f740c62891174@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <8bd0f97a0803260736v58c11f8g8a5f740c62891174-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 26, 2008 at 10:36 PM, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Mar 26, 2008 at 9:00 PM, Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>  >  +config JOYSTICK_AD7142
>  >  +       tristate "Analog Devices AD7142 Joystick support"
>  >  +       depends on BLACKFIN && I2C
>  >  +       ---help---
>  >  +         Say Y here if you want to support an AD7142 joystick
>
>  since you're going to send another patch anyways ;), this kconfig text
>  could use a line telling you the module name if built as a module.
>  -mike

No problem, I am waiting you guys to give some comments and update
this driver later.

Thanks
-Bryan

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

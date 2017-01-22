From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: max11801_ts - drop call to input_set_drvdata()
Date: Sun, 22 Jan 2017 14:31:55 -0800
Message-ID: <20170122223155.GF31009@dtor-ws>
References: <20170122073846.GA30131@dtor-ws>
 <dd170278-d556-2f73-cdbe-ee69f9a19423@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dd170278-d556-2f73-cdbe-ee69f9a19423@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, Zhang Jiejing <jiejing.zhang@freescale.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Jan 22, 2017 at 03:25:57AM -0800, Guenter Roeck wrote:
> On 01/21/2017 11:38 PM, Dmitry Torokhov wrote:
> >Nobody calls input_get_drvdata() so setting it is not required.
> >
> >Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Surprisingly, there is about a dozen of those. I'll send a series of
> coccinelle generated patches later.

Cool, thanks.

> 
> Guenter
> 
> >---
> > drivers/input/touchscreen/max11801_ts.c | 1 -
> > 1 file changed, 1 deletion(-)
> >
> >diff --git a/drivers/input/touchscreen/max11801_ts.c b/drivers/input/touchscreen/max11801_ts.c
> >index d87b89da114e..a595ae5284e3 100644
> >--- a/drivers/input/touchscreen/max11801_ts.c
> >+++ b/drivers/input/touchscreen/max11801_ts.c
> >@@ -199,7 +199,6 @@ static int max11801_ts_probe(struct i2c_client *client,
> > 	__set_bit(BTN_TOUCH, input_dev->keybit);
> > 	input_set_abs_params(input_dev, ABS_X, 0, MAX11801_MAX_X, 0, 0);
> > 	input_set_abs_params(input_dev, ABS_Y, 0, MAX11801_MAX_Y, 0, 0);
> >-	input_set_drvdata(input_dev, data);
> >
> > 	max11801_ts_phy_init(data);
> >
> >
> 

-- 
Dmitry

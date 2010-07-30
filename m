From: "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: Fwd: [RFC] [PATCH] Input: ADP5588 -
 Support gpio function on unused pin
Date: Fri, 30 Jul 2010 09:29:36 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712E7EC2301D@LIMKCMBX1.ad.analog.com>
References: <4c459b70.0aee8c0a.1c29.3e9e@mx.google.com>
	<4C4DADA7.9000201@gmail.com>	<20100726173844.GC14609@core.coreip.homeip.net>
	<AANLkTi=qHUknGZdoj75Nr9gCKe-TRPMf3cgtsHejSrOc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <AANLkTi=qHUknGZdoj75Nr9gCKe-TRPMf3cgtsHejSrOc-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Xiaolong Chen <xiaolong.chen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Xiaolong CHEN <a21785-3WKxDLwmzFNWk0Htik3J/w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, TAO HU <taohu-3WKxDLwmzFNWk0Htik3J/w@public.gmane.org>, "Yuan.Bo YE" <yuan-bo.ye-3WKxDLwmzFNWk0Htik3J/w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

I took a look at the driver in your next tree.

Two issues:
-Avoid NULL pointer dereference in adp5588_gpio_add(),
set clientdata before call to adp5588_gpio_add().
-Avoid NULL pointer dereference, exit if gpio_data doesn't exist

Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

drivers/input/keyboard/adp5588-keys.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index c39ec93..456bba7 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -201,6 +201,9 @@ static int __devinit adp5588_gpio_add(struct device *dev)

                if (kpad->gc.ngpio)
                        kpad->export_gpio = true;
+       } else {
+               kpad->export_gpio = false;
+               return 0;
        }

        if (!kpad->export_gpio) {
@@ -581,12 +584,13 @@ static int __devinit adp5588_probe(struct i2c_client *client,
        if (kpad->gpimapsize)
                adp5588_report_switch_state(kpad);

+       i2c_set_clientdata(client, kpad);
+
        error = adp5588_gpio_add(&client->dev);
        if (error)
                goto err_free_irq;

        device_init_wakeup(&client->dev, 1);
-       i2c_set_clientdata(client, kpad);

        dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->irq);
        return 0;

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif

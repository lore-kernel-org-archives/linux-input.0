From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH v3] add analog devices AD714X captouchinput driver
Date: Fri, 11 Sep 2009 14:19:12 +0100
Message-ID: <8A42379416420646B9BFAC9682273B6D0DC3BD95@limkexm3.ad.analog.com>
References: <1252652006-5270-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:22527 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbZIKNTR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Sep 2009 09:19:17 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1252652006-5270-1-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>, dmitry.torokhov@gmail.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-input@vger.kernel.org, David Brownell <david-b@pacbell.net>

On Friday 11 September 2009, Song, Barry wrote:
+static int __init ad714x_init(void)
+{
+
+	int ret = 0;
+	ret = ad714x_spi_register_driver(&ad714x_spi_driver);
+	if (ret)
+		goto err;
+	ret = ad714x_i2c_add_driver(&ad714x_i2c_driver);
+	if (ret)
+		ad714x_spi_unregister_driver(&ad714x_spi_driver);
+err:
+	return ret;
+}
+
+static void __exit ad714x_exit(void)
+{
+	ad714x_spi_unregister_driver(&ad714x_spi_driver);
+	ad714x_i2c_del_driver(&ad714x_i2c_driver);
+}

This doesn't make much sense!
Assuming we have two AD714x in a system. One connected by SPI the other
by I2C.
Why would I remove the SPI one in case the other I2C fails, or not even
try the SPI one if the I2C fails?

Who says that a driver can't have two module_init()?

Use two entry points and let them individually return its status.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

Index: drivers/input/misc/ad714x.c

===================================================================

--- drivers/input/misc/ad714x.c (revision 7296)

+++ drivers/input/misc/ad714x.c (working copy)

@@ -1479,19 +1479,18 @@

        .resume         = ad714x_spi_resume,

 };

 

-static inline int ad714x_spi_register_driver(struct spi_driver
*spi_drv)                              
+static inline int ad714x_spi_init(struct spi_driver *spi_drv)

 {

        return spi_register_driver(spi_drv);

 }

 

-static inline void ad714x_spi_unregister_driver(struct spi_driver
*spi_drv)                           
+static inline void ad714x_spi_exit(struct spi_driver *spi_drv)

 {

        spi_unregister_driver(spi_drv);

 }

 

-#else

-#define ad714x_spi_register_driver(p) 0

-#define ad714x_spi_unregister_driver(p)

+module_init(ad714x_spi_init);

+module_exit(ad714x_spi_exit);

 #endif

 

 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)

@@ -1609,44 +1608,20 @@

        .id_table = ad714x_id,

 };

 

-static inline int ad714x_i2c_add_driver(struct i2c_driver *i2c_drv)

+static __init int ad714x_i2c_init(struct i2c_driver *i2c_drv)

 {

        return i2c_add_driver(i2c_drv);
 }

-static inline void ad714x_i2c_del_driver(struct i2c_driver *i2c_drv)
+static __init void ad714x_i2c_exit(struct i2c_driver *i2c_drv)
 {
        i2c_del_driver(i2c_drv);
 }

-#else
-#define ad714x_i2c_add_driver(p) 0
-#define ad714x_i2c_del_driver(p)
+module_init(ad714x_i2c_init);
+module_exit(ad714x_i2c_exit);
 #endif

-static int __init ad714x_init(void)
-{
-
-       int ret = 0;
-       ret = ad714x_spi_register_driver(&ad714x_spi_driver);
-       if (ret)
-               goto err;
-       ret = ad714x_i2c_add_driver(&ad714x_i2c_driver);
-       if (ret)
-               ad714x_spi_unregister_driver(&ad714x_spi_driver);
-err:
-       return ret;
-}
-
-static void __exit ad714x_exit(void)
-{
-       ad714x_spi_unregister_driver(&ad714x_spi_driver);
-       ad714x_i2c_del_driver(&ad714x_i2c_driver);
-}
-
-module_init(ad714x_init);
-module_exit(ad714x_exit);
-
 MODULE_DESCRIPTION("Analog Devices AD714X Capacitance Touch Sensor
Driver");
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_LICENSE("GPL");
 


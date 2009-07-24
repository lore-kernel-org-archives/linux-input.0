From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext@mocean-labs.com>
Subject: Re: [PATCH 2/2] tsc2007: reduced number of I2C transfers
Date: Fri, 24 Jul 2009 21:37:27 +0200
Message-ID: <4A6A0D77.6000600@mocean-labs.com>
References: <4A69DDED.50402@mocean-labs.com> <20090724180022.GA6477@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from proxy1.bredband.net ([195.54.101.71]:64322 "EHLO
	proxy1.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbZGXTh3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jul 2009 15:37:29 -0400
In-Reply-To: <20090724180022.GA6477@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, kwangwoo.lee@gmail.com, Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>

On 7/24/09 8:00 PM, Dmitry Torokhov wrote:
> On Fri, Jul 24, 2009 at 06:14:37PM +0200, Richard R=F6jfors wrote:
>> Decreases the number of I2C transactions transferred by the driver.
>> During probe we don't need to ask for the coordinates from the contr=
oller.
>> When polling the controller we don't need to power down and enable I=
RQ
>> if we are going to poll again.
>>
>> Signed-off-by: Richard R=F6jfors<richard.rojfors.ext@mocean-labs.com=
>
>> ---
>> Index: linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c	(revision 1=
040)
>> +++ linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c	(revision 1=
053)
>> @@ -178,6 +178,12 @@
>>   		ts->penstate =3D PEN_STATE_UP;
>>   }
>>
>> +static void tsc2007_power_down(struct tsc2007 *tsc)
>> +{
>> +	/* power down */
>> +	tsc2007_xfer(tsc, PWRDOWN);
>> +}
>> +
>>   static int tsc2007_read_values(struct tsc2007 *tsc)
>>   {
>>   	/* y- still on; turn on only y+ (and ADC) */
>> @@ -188,11 +194,8 @@
>>
>>   	/* turn y+ off, x- on; we'll use formula #1 */
>>   	tsc->tc.z1 =3D tsc2007_xfer(tsc, READ_Z1);
>> -	tsc->tc.z2 =3D tsc2007_xfer(tsc, READ_Z2);
>> +	tsc->tc.z2 =3D tsc2007_xfer(tsc, READ_Z2 | TSC2007_POWER_OFF_IRQ_E=
N);
>
> I think this leaves the controller powered on and with with PENIRQ
> disabled.
>

You are right, I think we should leave the patch like below, just get=20
rid of the unnecessary read during startup.

--Richard

Input: tsc2007: Do not read coordinated when probing driver

=46rom: Richard R=F6jfors <richard.rojfors.ext@mocean-labs.com>

Don't read coordinates during probe of the driver, just powering down=20
the controller and wait for interrupts.


Signed-off-by: Richard R=F6jfors<richard.rojfors.ext@mocean-labs.com>
---
Index: linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c	(revision 1040=
)
+++ linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c	(revision 1056=
)
@@ -178,6 +178,12 @@
  		ts->penstate =3D PEN_STATE_UP;
  }

+static void tsc2007_power_down(struct tsc2007 *tsc)
+{
+	/* power down */
+	tsc2007_xfer(tsc, PWRDOWN);
+}
+
  static int tsc2007_read_values(struct tsc2007 *tsc)
  {
  	/* y- still on; turn on only y+ (and ADC) */
@@ -190,8 +196,7 @@
  	tsc->tc.z1 =3D tsc2007_xfer(tsc, READ_Z1);
  	tsc->tc.z2 =3D tsc2007_xfer(tsc, READ_Z2);

-	/* power down */
-	tsc2007_xfer(tsc, PWRDOWN);
+	tsc2007_power_down(tsc);

  	return 0;
  }
@@ -305,7 +310,7 @@
  	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
  	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT, 0, 0);

-	tsc2007_read_values(ts);
+	tsc2007_power_down(ts);

  	ts->irq =3D client->irq;

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

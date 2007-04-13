From: Paul Sokolovsky <pmiscml@gmail.com>
Subject: Re: [PATCH] gpio_keys ev_sw support
Date: Sat, 14 Apr 2007 00:13:05 +0300
Message-ID: <1417248704.20070414001305@gmail.com>
References: <461BC11C.7020401@gmail.com> <d120d5000704101120x4c292ae1w94b281b718a158d1@mail.gmail.com> <461C96F9.5000808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <461C96F9.5000808@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Roman Moravcik <roman.moravcik@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, kernel-discuss@handhelds.org
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

	I wonder if you're satisfied with Roman patch now. I guess it could just=
 fall to the bottom of your queue due to bad formatting. So, here's resen=
d, hopefully correct. One change is that we had to put "type" member to t=
he end of struct gpio_keys_button, the reason is backwards compatibility.=
 As you see, we'd like EV_KEY to be still default, and nay other type to =
be used only if explicitly specified. And as structure is already big, an=
d there're usually several keys to define, we use positional initializati=
on to save space:

	{ KEY_ENTER,	GPIO_NR_H4000_ACTION_BUTTON_N,	1, "Action button"	},

So, putting type after keycode will break this, and moreover compiler iss=
ues only warning, so that may go unnoticed.


Thanks,
Paul


-------------
This patch adds switch event support to gpio_keys driver.

Signed-off-by: Roman Moravcik <roman.moravcik@gmail.com>
Signed-off-by: Paul Sokolovsky <pmiscml@gmail.com>


Index: include/linux/gpio_keys.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/kernel26/include/linux/gpio_keys.h,v
retrieving revision 1.1
diff -u -p -r1.1 gpio_keys.h
--- include/linux/gpio_keys.h	25 Feb 2007 15:21:52 -0000	1.1
+++ include/linux/gpio_keys.h	13 Apr 2007 21:07:03 -0000
@@ -6,6 +6,7 @@ struct gpio_keys_button {
 	int gpio;
 	int active_low;
 	char *desc;
+	int type;
 };
=20
 struct gpio_keys_platform_data {
Index: drivers/input/keyboard/gpio_keys.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/kernel26/drivers/input/keyboard/gpio_keys.c,v
retrieving revision 1.15
diff -u -p -r1.15 gpio_keys.c
--- drivers/input/keyboard/gpio_keys.c	25 Feb 2007 15:26:10 -0000	1.15
+++ drivers/input/keyboard/gpio_keys.c	13 Apr 2007 21:07:03 -0000
@@ -39,7 +39,10 @@ static irqreturn_t gpio_keys_isr(int irq
 		if (irq =3D=3D gpio_to_irq(gpio)) {
 			int state =3D (gpio_get_value(gpio) ? 1 : 0) ^ (pdata->buttons[i].act=
ive_low);
=20
-			input_report_key(input, pdata->buttons[i].keycode, state);
+			if (pdata->buttons[i].type =3D=3D EV_SW)
+				input_report_switch(input, pdata->buttons[i].keycode, state);
+			else
+				input_report_key(input, pdata->buttons[i].keycode, state);
 			input_sync(input);
 		}
 	}
@@ -84,7 +87,12 @@ static int __devinit gpio_keys_probe(str
 				irq, error);
 			goto fail;
 		}
-		set_bit(code, input->keybit);
+		if (pdata->buttons[i].type =3D=3D EV_SW) {
+			input->evbit[0] |=3D BIT(EV_SW);
+			set_bit(code, input->swbit);
+		} else {
+			set_bit(code, input->keybit);
+		}
 	}
=20
 	error =3D input_register_device(input);





Wednesday, April 11, 2007, 11:06:17 AM, you wrote:

> Hi Dmitry,

> Dmitry Torokhov  wrote / nap=EDsal(a):

[]

--=20
Best regards,
 Paul                            mailto:pmiscml@gmail.com

From: Roman Moravcik <roman.moravcik@gmail.com>
Subject: Re: [PATCH] gpio_keys ev_sw support
Date: Wed, 11 Apr 2007 10:06:17 +0200
Message-ID: <461C96F9.5000808@gmail.com>
References: <461BC11C.7020401@gmail.com> <d120d5000704101120x4c292ae1w94b281b718a158d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000704101120x4c292ae1w94b281b718a158d1@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, kernel-discuss@handhelds.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Dmitry Torokhov  wrote / nap=EDsal(a):
>> This patch adds software event support to gpio_keys driver.
>>
>
> Just for the record EV_SW is not software event but switch event.
> Switch, as opposed to a key that returns to "off" state when released,
> keeps it's state until toggled again.

Ops, sorry. Yes, EV_SW is switch event not software event.
I don't why i wrote software.
>>
>> -    input->evbit[0] =3D BIT(EV_KEY);
>> +    input->evbit[0] =3D BIT(EV_KEY) | BIT(EV_SW);
>>
>
> You should not set these bits unconditionally but rather scan supplied
> keymap and set appropriately.
>
Ok, EV_SW bit is set conditionally now.

>> --- a/include/linux/gpio_keys.h    2007-02-25 16:21:52.000000000 +0100
>> +++ b/include/linux/gpio_keys.h    2007-04-05 20:23:31.000000000 +0200
>> @@ -6,6 +6,7 @@
>>     int gpio;
>>     int active_low;
>>     char *desc;
>> +    int type;
>
> Would not it make sense to keep type close to keycode element?
>
Moved behind the keycode.

Roman

This patch adds switch event support to gpio_keys driver.

Signed-off-by: Roman Moravcik <roman.moravcik@gmail.com>

diff -Naur a/drivers/input/keyboard/gpio_keys.c=20
b/drivers/input/keyboard/gpio_keys.c
--- a/drivers/input/keyboard/gpio_keys.c    2007-02-25=20
19:50:43.000000000 +0100
+++ b/drivers/input/keyboard/gpio_keys.c    2007-04-10=20
20:42:31.000000000 +0200
@@ -39,7 +39,10 @@
         if (irq =3D=3D gpio_to_irq(gpio)) {
             int state =3D (gpio_get_value(gpio) ? 1 : 0) ^=20
(pdata->buttons[i].active_low);
=20
-            input_report_key(input, pdata->buttons[i].keycode, state);
+            if (pdata->buttons[i].type =3D=3D EV_SW)
+                input_report_switch(input, pdata->buttons[i].keycode,=20
state);
+            else
+                input_report_key(input, pdata->buttons[i].keycode, state=
);
             input_sync(input);
         }
     }
@@ -84,7 +87,12 @@
                 irq, error);
             goto fail;
         }
-        set_bit(code, input->keybit);
+        if (pdata->buttons[i].type =3D=3D EV_SW) {
+            input->evbit[0] |=3D BIT(EV_SW);
+            set_bit(code, input->swbit);
+        } else {
+            set_bit(code, input->keybit);
+        }
     }
=20
     error =3D input_register_device(input);
diff -Naur a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
--- a/include/linux/gpio_keys.h    2007-02-25 16:21:52.000000000 +0100
+++ b/include/linux/gpio_keys.h    2007-04-10 20:31:25.000000000 +0200
@@ -3,6 +3,7 @@
 struct gpio_keys_button {
     /* Configuration parameters */
     int keycode;
+    int type;
     int gpio;
     int active_low;
     char *desc;

From: Alexey Slepov <sir-lexa@yandex.ru>
Subject: Re: Re: [PATCH V2 2/2] Input: rotaty-encoder - Add DT binding
 document
Date: Fri, 22 Mar 2019 02:04:59 +0100
Message-ID: <f780ef34-474b-3e23-b495-f2e80e87c18b@yandex.ru>
References: <20190107164249.2342-1-nazgul33@gmail.com>
 <20190107164249.2342-3-nazgul33@gmail.com> <20190115035221.GA151157@dtor-ws>
 <20190115202948.GA26482@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115202948.GA26482@bogus>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Donghoon Han <nazgul33@gmail.com>, linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello,

i used this rotary-encoder patch in my embedded project and found two 
errors:


First, in drivers/input/misc/rotary_encoder.c,
at @@ -237,6 +244,16 @@:
instead of

+        if (err)
+            dev_err(dev, "unable to get keycodes: %d\n", err);
+        return err;

it must be

+        if (err) {
+            dev_err(dev, "unable to get keycodes: %d\n", err);
+            return err;
+        }

otherwise successful creation of device is not possible.


Second, a typo in 
Documentation/devicetree/bindings/input/rotary-encoder.txt,
at @@ -48,3 +52,11 @@:
instead of

+            rotary-encoder,relative-keycode = <103>, <108>;

it should be

+            rotary-encoder,relative-keycodes = <103>, <108>;

otherwise keycodes are not found.


I am sorry, I know that E-Mail style is not good.
I have no time right now, but I'll be back in two weeks.
Someone, maybe Mr. Han, could submit a new version of the patch.
If not, I'll try to do it on my return. (it could take some time, since 
I am new to patchwork)

Best Regards and thanks
Alexey Slepov

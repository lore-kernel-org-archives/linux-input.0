From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v3 2/2] cap11xx: add LED support
Date: Mon, 15 Jun 2015 10:01:26 -0700
Message-ID: <CAKzfze9Hu6vSDqq7kYzHCbeKEBeP1BVczYiFpAN-dLbEGBzXgw@mail.gmail.com>
References: <1434169054-11035-1-git-send-email-mranostay@gmail.com>
	<1434169054-11035-3-git-send-email-mranostay@gmail.com>
	<557E8997.7070100@samsung.com>
	<CAKzfze8E-22XxzGuMUJWhcpmdoA=63XWR-v+bpf+Cdn70VoJqA@mail.gmail.com>
	<557E94CD.30705@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <557E94CD.30705@zonque.org>
Sender: linux-leds-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Daniel Mack <zonque@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-leds@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jun 15, 2015 at 2:03 AM, Daniel Mack <daniel@zonque.org> wrote:
> On 06/15/2015 10:56 AM, Matt Ranostay wrote:
>> On Mon, Jun 15, 2015 at 1:15 AM, Jacek Anaszewski
>> <j.anaszewski@samsung.com> wrote:
>
>>>> +               error = devm_led_classdev_register(dev, &led->cdev);
>>>> +               if (error < 0)
>>>> +                       return -EINVAL;
>>>> +               INIT_WORK(&led->work, cap11xx_led_work);
>>>> +               schedule_work(&led->work);
>>>
>>>
>>> Work queue should be initialized before registration of the LED class
>>> device.
>> What is the reason for this? Just curious
>
> It's a race condition. The LED device is accessible once
> devm_led_classdev_register() returns. So a user could be calling into
> cap11xx_led_set() before the work queue is initialized, which would
> hence access a NULL pointer.

Ah thanks for explaining. Will fix in v4.

>
>
> Daniel
>

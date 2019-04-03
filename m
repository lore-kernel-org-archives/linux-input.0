From: Ken Sloat <KSloat@aampglobal.com>
Subject: [BUG REPORT] linux-input: keyboard: gpio_keys: False Button Press
 Event on Wake
Date: Wed, 3 Apr 2019 17:50:09 +0000
Message-ID: <BL0PR07MB41151EC4B770F6A7396C152EAD570@BL0PR07MB4115.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "josephl@nvidia.com" <josephl@nvidia.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ken Sloat <KSloat@aampglobal.com>
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

I may have found a potential bug in the "gpio_keys" driver. FYI, I am runni=
ng the 4.14 LTS kernel on my system, but from my understanding of the issue=
, it seems that this would still occur in the latest version of the kernel.

The problem:
In the 4.14 LTS kernel, both key press and release events can generate a wa=
ke event. In the 5.x kernel, wake events are configurable for press only, r=
elease only or "both" (see "wakeup-event-action" binding). The issue can oc=
cur in the "both" case or release/deasserted case. Let's imagine that a sys=
tem is suspended when a gpio key button is pressed, and subsequently resume=
d when the button is released. If we look at the sequence of actions and ev=
ents reported by the input system, we can see the potential problem:

Button Pressed
Event Value 1
System Suspend
Button Released
System Wake & Resume
Event Value 0
Event Value 1
Event Value 0

As you can see the input system will report an extra button event/press. Th=
is appears to be caused in gpio_keys_gpio_isr by the following statement:

if (bdata->suspended  &&
    (button->type =3D=3D 0 || button->type =3D=3D EV_KEY)) {
        /*
         * Simulate wakeup key press in case the key has
         * already released by the time we got interrupt
         * handler to run.
         */
        input_report_key(bdata->input, button->code, 1);
}

This code does not seem to take into account that the wake event may have b=
een caused by a button release action, and just assumes we must have a butt=
on press.

This can obviously be problematic in the use case I mentioned, as the syste=
m would be put in a constant loop between waking and sleeping. While there =
are other ways to deal with or react to this issue in the userspace, it see=
ms that the driver should probably take this into account.

Thoughts?

Thanks,
Ken Sloat=20

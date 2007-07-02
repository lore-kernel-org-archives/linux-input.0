From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] fujtisu application panel driver
Date: Mon, 2 Jul 2007 15:16:30 -0400
Message-ID: <d120d5000707021216y1a3641b1rbc0c741e2d7d4e70@mail.gmail.com>
References: <20070702111724.43ee5b43@freepuppy.localdomain.hemminger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070702111724.43ee5b43@freepuppy.localdomain.hemminger.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Stephen,

On 7/2/07, Stephen Hemminger <shemminger@linux-foundation.org> wrote:
> This driver supports the application buttons on some Fujitsu Lifebook laptops.
> These buttons are read via the SMBus, for more details see:
>        http://apanel.sourceforge.net/tech.php
> The buttons are handled as by the regular input system.
> Two models are detected now, but other Fujitsu laptop's have
> keys that may work similarly.
>
> It is based on the earlier apanel driver done by Jochen Eisenger, but
> with many changes.  The original driver used ioctl's and a separate
> user space program; this version hooks into the input subsystem so
> that the normal Gnome/KDE shortcuts work without any userspace
> changes.
>

Thank you very much for updating the patch. I have a couple of requests though:

1. LEDs shoud use the generic led subsystem instead of input layer. I
do not have plans of adding any more LED_XXX constants and I think
that adding any LEDs not directly relating to keyboard state was a
mistake.

2. It would be nice if driver supported changing its keymaps now that
we allow overriding default getkeycode() and setkeycode().

3. Do not aaccess input_dev->private directly. input_set_drvdata() and
input+_getdrvdata shoudl be used.

> +static int apanel_event(struct input_dev *dev, unsigned int type,
> +                       unsigned int code, int value)
> +{
> +       struct apanel *ap = dev->private;

Also I don't think the above is correct. I think you need the following here:

   struct input_polled_dev *polldev = input_get_drvdata(dev);
   struct apanal *ap = polldev->private;

4:
> +       ipdev->input->cdev.dev = &ap->client.dev;

Please change to "ipdev->input->dev.parent = &ap->client.dev;"

5:
> +       ipdev->input->private = ap;

polledev uses input->private for its own purposed, you need to use
ipdev->private.

Thank you.

-- 
Dmitry

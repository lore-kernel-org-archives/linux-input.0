From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH try #3] Input/Joystick Driver: add support AD7142 joystick driver
Date: Mon, 15 Oct 2007 11:48:17 -0400
Message-ID: <d120d5000710150848t1993b0aavbbc0cd7971e3ef3e@mail.gmail.com>
References: <1192459625.6215.17.camel@roc-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1192459625.6215.17.camel@roc-laptop>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: bryan.wu@analog.com
Cc: Andrey Panin <pazke@donpac.ru>, Roel Kluin <12o3l@tiscali.nl>, "Ahmed S. Darwish" <darwish.07@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Jean Delvare <khali@linux-fr.org>
List-Id: linux-input@vger.kernel.org

Hi Bryan,

On 10/15/07, Bryan Wu <bryan.wu@analog.com> wrote:
> +
> +static int ad7142_thread(void *nothing)
> +{
> +       do {
> +               wait_for_completion(&ad7142_completion);
> +               ad7142_decode();
> +               enable_irq(CONFIG_BFIN_JOYSTICK_IRQ_PFX);
> +       } while (!kthread_should_stop());
> +

No, this is not going to work well:
- you at least need to reinitialize the completion before enabling
IRQ, otherwise you will spin in a very tight loop
- if noone would touch the joystick ad7142_clsoe would() block
infinitely because noone would signal the completion and
ad7142_thread() would never stop.

Completion is just not a good abstraction here... Please use work
abstraction and possibly a separate workqueue.

> +
> +       ad7142_task = kthread_run(ad7142_thread, NULL, "ad7142_task");
> +       if (IS_ERR(ad7142_task)) {
> +               printk(KERN_ERR "serio: Failed to start kseriod\n");

kseriod?

> +               return PTR_ERR(ad7142_task);
> +       }
> +       return 0;
> +}
> +
> +static void ad7142_close(struct input_dev *dev)
> +{

Don't you need to write something over i2c to tell the device to shut
down? As it is now I expect the device to continue raising its IRQ
until kernel decides that it is unhandled and should be ignored.

> +       free_irq(CONFIG_BFIN_JOYSTICK_IRQ_PFX, ad7142_interrupt);

Ok, so you freeing IRQ here, but it is allocated in ad7142_probe().
What happen if you try to open device after it was closed?

> +       kthread_stop(ad7142_task);
> +}
> +
> +static int __init ad7142_init(void)
> +{
> +       return i2c_add_driver(&ad7142_driver);
> +}
> +
> +static void __exit ad7142_exit(void)
> +{
> +       i2c_del_driver(&ad7142_driver);
> +       input_unregister_device(ad7142_dev);

input_unregister_device() should be in ad7142_detach_client? I am not
sure i2c - there seems to be 2 interface styles and you probably need
to use the new one. I am CC-inj Jean on this.

> +}
> +
> +module_init(ad7142_init);
> +module_exit(ad7142_exit);
> --
> 1.5.3.4
>


-- 
Dmitry

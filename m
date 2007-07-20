From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HP Jornada 7xx keyboard support
Date: Fri, 20 Jul 2007 14:54:14 -0400
Message-ID: <d120d5000707201154r4c95d365u7d9dd1189fbc4a29@mail.gmail.com>
References: <20070718163259.2565fb8c.Kristoffer.Ericson@Gmail.com>
	 <d120d5000707180800k5e4d6538p7df9be9e134609fc@mail.gmail.com>
	 <20070718191119.18bf1e9c.Kristoffer.Ericson@Gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070718191119.18bf1e9c.Kristoffer.Ericson@Gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

Hi Kristoffer,

On 7/18/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> Try #2
>
> Thanks for feedback, Ive tried a different approach to get it better handled.
>

Thank you for making the changes I requested, however there is still an issue:

> +
> +       ret = request_irq(IRQ_GPIO0,
> +                       jornada720_kbd_interrupt,
> +                       IRQF_DISABLED | IRQF_TRIGGER_FALLING,
> +                       "jornadakbd", input_dev);
> +       if (ret) {
> +               printk(KERN_WARNING "jornadakbd : Unable to grab IRQ\n");
> +               goto failed;
> +       }
> +
> +       err = input_register_device(jornadakbd->input);
> +       if (err)
> +               goto failed;
> +

Here if input_register_device() fails you free the memory but forget
to free IRQ.

-- 
Dmitry

From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [HP7XX/PATCH] - HP720 Jornada Touchscreen (Updated, please use this one)
Date: Wed, 19 Sep 2007 16:46:52 -0400
Message-ID: <d120d5000709191346w3fc0778ftb0db42d539146eb8@mail.gmail.com>
References: <20070919204926.b29e3884.Kristoffer.ericson@gmail.com>
	 <d120d5000709191219u46aca089u5a00107b848fff30@mail.gmail.com>
	 <20070919223138.1f0b79d1.Kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070919223138.1f0b79d1.Kristoffer.ericson@gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 9/20/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> +       if (jornada_ssp_inout(GETTOUCHSAMPLES == TXDUMMY)) {

Are you sure? Looks like paren is pisplaced.

> +
> +       ret = request_irq(IRQ_GPIO9,
> +                       jornada720_ts_interrupt,
> +                       IRQF_DISABLED | IRQF_TRIGGER_RISING,
> +                       "HP7XX Touchscreen driver", jornada_ts);
> +       if (ret) {
> +               printk(KERN_INFO "HP7XX TS : Unable to aquire irq!\n");
> +               goto failed2;
> +       }
> +
> +       if (input_register_device(input_dev))
> +           goto failed2;

You will leak IRQ_GPIO9 if input_register_device fails.

Please do not forget adding Signed-off-by: to all of your patches so I
don;t have to hunt for them through old e-mails. Thanks!

-- 
Dmitry

From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HP Jornada 7xx keyboard support
Date: Fri, 20 Jul 2007 15:29:08 -0400
Message-ID: <d120d5000707201229m45088b66wd7474ad06d16e813@mail.gmail.com>
References: <20070718163259.2565fb8c.Kristoffer.Ericson@Gmail.com>
	 <d120d5000707180800k5e4d6538p7df9be9e134609fc@mail.gmail.com>
	 <20070718191119.18bf1e9c.Kristoffer.Ericson@Gmail.com>
	 <d120d5000707201154r4c95d365u7d9dd1189fbc4a29@mail.gmail.com>
	 <20070720212549.ca0e38f4.Kristoffer.Ericson@Gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070720212549.ca0e38f4.Kristoffer.Ericson@Gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

On 7/21/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> Greetings,
>
> Ive added it to free IRQ as you said, a minor change is also that jornada720.h defines are set in CAPS (just changed that for Russell).
> Ive also added the Kconfig and Makefile.
>
> Btw, do you keep patchtracker (like Russell) or drag from mail (like Paul)?

Get from the mail.

> +
> +failed:
> +       free_irq(IRQ_GPIO0, input_dev);

Still not quire right - you may get to failed: when memory allocation
fails or request_irq fails. We should not free IRQ that we did not
get. Please split into 2 labels and jump accordingly.

-- 
Dmitry

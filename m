From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH] Touch screen driver for the SuperH MigoR board
Date: Tue, 1 Jul 2008 20:22:56 +0900
Message-ID: <aec7e5c30807010422m4ea7dcdqae2efe5caf93efb2@mail.gmail.com>
References: <486A07E7.1070906@mpc-data.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <486A07E7.1070906@mpc-data.co.uk>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
To: Nicholas Beck <nbeck@mpc-data.co.uk>
Cc: linux-sh@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Nicholas,

Thanks for your email!

On Tue, Jul 1, 2008 at 7:33 PM, Nicholas Beck <nbeck@mpc-data.co.uk> wrote:
> Hi Magnus,
>
> Firstly, thanks for the great work. I have one issue with the touch
> screen driver for the MigoR board though.
>
> I don't get any BTN_TOUCH release events using the touch screen driver
> for the MigoR board. Do you experience the same problem?

This problem has been fixed by Dmitry Torokhov. The linux-input
archives seem gone though.

The updated patch below did not make it into 2.6.26, but it should be
included in 2.6.27.

http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=885c316d776b64728b4ed30e3af60d23c9e46825

> I have a patch that adds a timer to perform the BTN_TOUCH release event
> (kind of like a WDT), that I can submit if this is of any interest?

Does Dmitrys patch above solve your problem? If not, please post your
patch and I'll have a look.

Thank you!

/ magnus

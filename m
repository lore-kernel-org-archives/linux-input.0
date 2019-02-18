From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: Re: [PATCH] Input: uinput - Allow uinput_request to be interrupted
Date: Mon, 18 Feb 2019 15:21:10 +0100
Message-ID: <20190218142110.GA23087@casa>
References: <20190218004305.339758-1-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190218004305.339758-1-marcos.souza.org@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rodrigorivascosta@gmail.com, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Martin Kepplinger <martink@posteo.de>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Feb 17, 2019 at 09:42:52PM -0300, Marcos Paulo de Souza wrote:
> -	if (!wait_for_completion_timeout(&request->done, 30 * HZ)) {
> +	if (!wait_for_completion_interruptible_timeout(&request->done,
> +							30 * HZ)) {
>  		retval = -ETIMEDOUT;
>  		goto out;
>  	}

Now this function can succeed or fail because of ETIMEDOUT or an
interrupt. I think you should return -EINTR or maybe -ESYSRESTART if
interrupted.

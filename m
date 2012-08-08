From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH] Input: omap4-keypad - don't leak in
 omap4_keypad_probe()
Date: Wed, 8 Aug 2012 21:36:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1208082135410.10061@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1208072014140.3227@swampdragon.chaosbits.net> <CAK9yfHxS=VvZ8Cuhd4LAUG+JnOK0g6=xCEoX45mtuVwj-+8D_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK9yfHxS=VvZ8Cuhd4LAUG+JnOK0g6=xCEoX45mtuVwj-+8D_g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sourav Poddar <sourav.poddar@ti.com>, Felipe Balbi <balbi@ti.com>, JJ Ding <dgdunix@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Abraham Arce <x0066660@ti.com>, Syed Rafiuddin <rafiuddin.syed@ti.com>
List-Id: linux-input@vger.kernel.org

On Wed, 8 Aug 2012, Sachin Kamat wrote:

> On 7 August 2012 23:46, Jesper Juhl <jj@chaosbits.net> wrote:
> > If omap4_keypad_parse_dt() does not return 0 (zero) in
> > omap4_keypad_probe() we will leak the memory we allocated for
> > 'keypad_data' with kzalloc() when we return and the variable goes out
> > of scope.
> 
> How about using devm_kzalloc() instead which will take care of freeing
> the memory on detach?
> 
Perhaps. I'm not (yet) familiar with how that function works, so I had 
not considered it. I'll look into it.

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
